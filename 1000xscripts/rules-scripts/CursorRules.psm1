<#
.SYNOPSIS
    PowerShell module for managing Cursor Project Rules.

.DESCRIPTION
    This module provides functions for managing Cursor Project Rules,
    including synchronizing content from 1000xbrain markdown files,
    updating .mdc files directly, and editing individual .mdc files
    with Visual Studio Code.

.NOTES
    Author: 1000xdev
    Version: 1.0
#>

# Function to extract frontmatter from a file
function Get-Frontmatter {
    param([string]$filePath)
    
    $content = Get-Content -Path $filePath -Raw
    
    # Check for multiple frontmatter blocks
    if ($content -match "(?s)^(---\s*\r?\n.*?\r?\n---\s*\r?\n)+(---\s*\r?\n.*?\r?\n---\s*\r?\n)") {
        Write-Warning "Multiple frontmatter blocks detected in $filePath - will extract first valid block only"
    }
    
    if ($content -match "(?s)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n") {
        return $Matches[1]
    }
    
    return ""
}

# Function to extract content without frontmatter
function Get-ContentWithoutFrontmatter {
    param([string]$filePath)
    
    $content = Get-Content -Path $filePath -Raw
    
    # Remove all frontmatter blocks
    while ($content -match "(?s)^---\s*\r?\n.*?\r?\n---\s*\r?\n") {
        $content = $content -replace "(?s)^---\s*\r?\n.*?\r?\n---\s*\r?\n", ""
    }
    
    return $content.Trim()
}

# Function to standardize frontmatter format
function Format-Frontmatter {
    param(
        [hashtable]$FrontmatterHash
    )
    
    # Ensure key frontmatter fields exist with proper values
    if (-not $FrontmatterHash.ContainsKey("description")) {
        $FrontmatterHash["description"] = ""
    }
    
    # Handle globs field - empty string instead of "none"
    if ($FrontmatterHash.ContainsKey("globs") -and $FrontmatterHash["globs"] -eq "none") {
        $FrontmatterHash["globs"] = ""
    }
    
    # ALWAYS preserve existing rule type settings
    # Do not modify type or alwaysApply fields
    
    return $FrontmatterHash
}

# Function to convert frontmatter string to hashtable
function ConvertFrom-Frontmatter {
    param([string]$Frontmatter)
    
    $result = @{}
    
    if ([string]::IsNullOrWhiteSpace($Frontmatter)) {
        return $result
    }
    
    $lines = $Frontmatter -split "\r?\n"
    foreach ($line in $lines) {
        if ($line -match "^\s*([\w-]+)\s*:\s*(.*)$") {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim()
            $result[$key] = $value
        }
    }
    
    return $result
}

# Function to convert frontmatter hashtable to string
function ConvertTo-Frontmatter {
    <#
    .SYNOPSIS
        Converts a hashtable to a frontmatter string.
    
    .DESCRIPTION
        This function converts a hashtable to a frontmatter string that can be included at the top of a markdown file.
        It ensures the correct formatting of the frontmatter while always preserving rule types.
    
    .PARAMETER FrontmatterHash
        A hashtable containing the frontmatter fields and their values.
    
    .EXAMPLE
        ConvertTo-Frontmatter -FrontmatterHash @{title = "My Document"; author = "John Doe"}
    
    .NOTES
        This function ALWAYS preserves rule types (type and alwaysApply fields).
    #>
    param(
        [hashtable]$FrontmatterHash
    )
    
    $frontmatterLines = @()
    
    # Add description first if it exists
    if ($FrontmatterHash.ContainsKey("description")) {
        $frontmatterLines += "description`: $($FrontmatterHash["description"])"
    }
    
    # Add globs second if it exists
    if ($FrontmatterHash.ContainsKey("globs")) {
        $frontmatterLines += "globs`: $($FrontmatterHash["globs"])"
    }
    
    # Add alwaysApply third if it exists
    if ($FrontmatterHash.ContainsKey("alwaysApply")) {
        $frontmatterLines += "alwaysApply`: $($FrontmatterHash["alwaysApply"])"
    }
    
    # Add type fourth if it exists
    if ($FrontmatterHash.ContainsKey("type")) {
        $frontmatterLines += "type`: $($FrontmatterHash["type"])"
    }
    
    # Add remaining fields in alphabetical order
    $remainingFields = $FrontmatterHash.Keys | 
                      Where-Object { $_ -notin @("description", "globs", "alwaysApply", "type") } |
                      Sort-Object
    
    foreach ($key in $remainingFields) {
        $frontmatterLines += "$key`: $($FrontmatterHash[$key])"
    }
    
    return $frontmatterLines -join "`n"
}

# Function to compare content of files
function Compare-FileContent {
    param([string]$file1, [string]$file2)
    
    $content1 = Get-ContentWithoutFrontmatter -filePath $file1
    $content2 = Get-ContentWithoutFrontmatter -filePath $file2
    
    # Normalize line endings before comparison
    $content1 = $content1 -replace "\r\n", "`n"
    $content2 = $content2 -replace "\r\n", "`n"
    
    return $content1 -eq $content2
}

# Function to create a backup of a file
function Backup-File {
    param([string]$filePath)
    
    try {
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $backupPath = "$filePath.backup-$timestamp"
        Copy-Item -Path $filePath -Destination $backupPath -Force
        return $backupPath
    }
    catch {
        Write-Error "Failed to backup $filePath. Error: $_"
        return $null
    }
}

# Function to find corresponding mdc file for a markdown file
function Find-CorrespondingMdcFile {
    param(
        [string]$markdownFile,
        [string]$rootPath,
        [string]$cursorRulesPath
    )
    
    # Get the relative path from 1000xbrain root
    $relativePath = $markdownFile.Replace($rootPath, "").TrimStart("\", "/")
    
    # Create the expected mdc file path, preserving the directory structure
    $directoryPath = [System.IO.Path]::GetDirectoryName($relativePath)
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($relativePath) + ".mdc"
    $expectedMdcPath = Join-Path $cursorRulesPath (Join-Path $directoryPath $fileName)
    
    # Check if the file exists at the expected path
    if (Test-Path $expectedMdcPath) {
        Write-Host "Found matching file at $expectedMdcPath" -ForegroundColor Green
        return $expectedMdcPath
    }
    
    # Special case handling for workflows directory
    # Some files might be in a workflows/{workflow-type} subdirectory in 1000xbrain
    # but directly in workflows in Cursor Rules
    if ($directoryPath -match "workflows[/\\][^/\\]+") {
        $alternativePath = $directoryPath -replace "workflows[/\\][^/\\]+", "workflows"
        $alternativeMdcPath = Join-Path $cursorRulesPath (Join-Path $alternativePath $fileName)
        
        if (Test-Path $alternativeMdcPath) {
            Write-Host "Found matching file at $alternativeMdcPath (alternative workflows path)" -ForegroundColor Yellow
            return $alternativeMdcPath
        }
    }
    
    # Log warning for missing file
    Write-Host "Warning: No matching file found at $expectedMdcPath" -ForegroundColor Yellow
    
    # Return null to indicate no matching file was found
    # This will trigger creation of a new file in the correct location
    return $null
}

# Function to update the content of an mdc file with content from a markdown file
function Update-MdcFile {
    param(
        [string]$mdcFile,
        [string]$mdFile,
        [switch]$WhatIf
    )
    
    try {
        # Read content of both files
        $mdcContent = Get-Content -Path $mdcFile -Raw
        $mdContent = Get-Content -Path $mdFile -Raw
        
        # Extract frontmatter from .mdc file - ALWAYS PRESERVE THIS
        $mdcFrontmatterFull = ""
        $mdcFrontmatterHash = @{}
        if ($mdcContent -match "(?sm)^---\r?\n(.*?)\r?\n---\r?\n") {
            $mdcFrontmatterFull = $matches[0]
            $mdcFrontmatterRaw = $matches[1]
            $mdcFrontmatterHash = ConvertFrom-Frontmatter -Frontmatter $mdcFrontmatterRaw
        }
        
        # Extract content from .md file (removing its frontmatter)
        $mdContentNoFrontmatter = $mdContent
        $mdFrontmatterHash = @{}
        if ($mdContent -match "(?sm)^---\r?\n(.*?)\r?\n---\r?\n") {
            $mdContentNoFrontmatter = $mdContent.Substring($matches[0].Length)
            $mdFrontmatterRaw = $matches[1]
            $mdFrontmatterHash = ConvertFrom-Frontmatter -Frontmatter $mdFrontmatterRaw
        }
        
        # IMPORTANT: Always preserve the existing rule type if present
        if (-not $mdcFrontmatterHash.ContainsKey("type") -and 
            $mdFrontmatterHash.ContainsKey("alwaysApply")) {
            # Determine type based on alwaysApply and description/globs
            if ($mdFrontmatterHash["alwaysApply"] -eq "true") {
                $mdcFrontmatterHash["type"] = "always"
            }
            elseif ($mdFrontmatterHash.ContainsKey("description") -and -not [string]::IsNullOrWhiteSpace($mdFrontmatterHash["description"])) {
                $mdcFrontmatterHash["type"] = "agent"
            }
            elseif ($mdFrontmatterHash.ContainsKey("globs") -and -not [string]::IsNullOrWhiteSpace($mdFrontmatterHash["globs"])) {
                $mdcFrontmatterHash["type"] = "auto"
            }
            else {
                $mdcFrontmatterHash["type"] = "manual"
            }
        }
        
        # Reconstruct frontmatter with preserved type
        $frontmatter = ConvertTo-Frontmatter -FrontmatterHash $mdcFrontmatterHash
        $newMdcFrontmatter = "---`n$frontmatter`n---`n"
        
        # Combine new frontmatter with .md content
        $newMdcContent = $newMdcFrontmatter + $mdContentNoFrontmatter
        
        # Update the file if it's different
        if ($newMdcContent -ne $mdcContent) {
            if (-not $WhatIf) {
                Set-Content -Path $mdcFile -Value $newMdcContent -NoNewline
            }
            return $true
        }
        
        return $false
    }
    catch {
        Write-Error "Failed to update $mdcFile with content from $mdFile. Error: $_"
        return $false
    }
}

# Function to create a new mdc file with content from a markdown file
function New-MdcFile {
    param(
        [string]$mdFile,
        [string]$targetDir,
        [switch]$WhatIf,
        [string]$RelativePath = $null
    )
    
    try {
        # Extract filename without extension
        $fileNameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($mdFile)
        
        # If RelativePath is provided, use it to create the target path
        # This preserves the directory structure from 1000xbrain
        if ($RelativePath) {
            $dirPath = [System.IO.Path]::GetDirectoryName($RelativePath)
            $fullTargetDir = Join-Path $targetDir $dirPath
            $targetPath = Join-Path $fullTargetDir "$fileNameWithoutExt.mdc"
        } else {
            # Create target path directly in targetDir
            $targetPath = Join-Path $targetDir "$fileNameWithoutExt.mdc"
        }
        
        # Get the content from the markdown file
        $content = Get-ContentWithoutFrontmatter -filePath $mdFile
        
        # Normalize line endings in content
        $content = $content -replace "\r\n", "`n"
        $content = $content -replace "\n", "`r`n"
        
        # Get the frontmatter from the markdown file
        $mdFrontmatterRaw = Get-Frontmatter -filePath $mdFile
        $mdFrontmatterHash = ConvertFrom-Frontmatter -Frontmatter $mdFrontmatterRaw
        
        # Apply standardization
        $mdFrontmatterHash = Format-Frontmatter -FrontmatterHash $mdFrontmatterHash
        
        # Set proper rule type based on frontmatter
        if ($mdFrontmatterHash.ContainsKey("alwaysApply")) {
            if ($mdFrontmatterHash["alwaysApply"] -eq "true") {
                # Always Apply rule type
                $mdFrontmatterHash["type"] = "always"
            } 
            elseif ($mdFrontmatterHash.ContainsKey("description") -and -not [string]::IsNullOrWhiteSpace($mdFrontmatterHash["description"])) {
                # Agent Requested rule type - has description but not always apply
                $mdFrontmatterHash["type"] = "agent"
            }
            elseif ($mdFrontmatterHash.ContainsKey("globs") -and -not [string]::IsNullOrWhiteSpace($mdFrontmatterHash["globs"])) {
                # Auto Attached rule type - has globs but not always apply
                $mdFrontmatterHash["type"] = "auto"
            }
            else {
                # Default to manual if no special conditions met
                $mdFrontmatterHash["type"] = "manual"
            }
        } 
        else {
            # Check for description or globs to determine type
            if ($mdFrontmatterHash.ContainsKey("description") -and -not [string]::IsNullOrWhiteSpace($mdFrontmatterHash["description"])) {
                # Agent Requested rule type
                $mdFrontmatterHash["type"] = "agent"
            }
            elseif ($mdFrontmatterHash.ContainsKey("globs") -and -not [string]::IsNullOrWhiteSpace($mdFrontmatterHash["globs"])) {
                # Auto Attached rule type
                $mdFrontmatterHash["type"] = "auto"
            }
            else {
                # Default to manual
                $mdFrontmatterHash["type"] = "manual"
            }
        }
        
        # Convert to frontmatter string
        $frontmatter = ConvertTo-Frontmatter -FrontmatterHash $mdFrontmatterHash
        
        # Construct the new content
        $newContent = @"
---
$frontmatter
---

$content
"@
        
        if ($WhatIf) {
            Write-Host "Would create: $targetPath" -ForegroundColor Green
            return $true
        }
        
        # Ensure the target directory exists
        $targetDirPath = Split-Path $targetPath -Parent
        if (-not (Test-Path $targetDirPath)) {
            Write-Host "Creating directory: $targetDirPath" -ForegroundColor Yellow
            New-Item -ItemType Directory -Path $targetDirPath -Force | Out-Null
        }
        
        # Write the new content to the mdc file
        Set-Content -Path $targetPath -Value $newContent -Force -NoNewline
        Write-Host "Created: $targetPath" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Error "Failed to create mdc file from $mdFile. Error: $_"
        return $false
    }
}

function Sync-CursorRules {
    <#
    .SYNOPSIS
        Analyzes differences between 1000xbrain markdown files and Cursor Project Rules.
    
    .DESCRIPTION
        This function analyzes differences between 1000xbrain markdown files and their
        corresponding Cursor Project Rules (.mdc files), generating a report of files
        that need to be synchronized.
    
    .PARAMETER RootPath
        The root path of the 1000xbrain directory. 
    
    .PARAMETER CursorRulesPath
        The path to the Cursor Rules directory.
    
    .PARAMETER ReportPath
        The path where reports will be saved.
    
    .EXAMPLE
        Sync-CursorRules -RootPath "C:\path\to\1000xbrain" -CursorRulesPath "C:\path\to\.cursor\rules" -ReportPath "C:\path\to\reports"
    
    .NOTES
        This function only generates a report and does not modify any files.
    #>
    
    param(
        [string]$RootPath = (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) "1000xbrain"),
        [string]$CursorRulesPath = (Join-Path (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) ".cursor") "rules"),
        [string]$ReportPath = $PSScriptRoot
    )
    
    # Ensure the reports directory exists
    if (-not (Test-Path $ReportPath)) {
        New-Item -ItemType Directory -Path $ReportPath -Force | Out-Null
        Write-Host "Created reports directory: $ReportPath"
    }
    
    # Initialize arrays for tracking files
    $allMarkdownFiles = @()
    $matchingMdcFiles = @()
    $unmatchedMarkdownFiles = @()
    $unmatchedMdcFiles = @()
    $outdatedMdcFiles = @()
    
    # Get all markdown files in 1000xbrain
    # Explicitly exclude README.md files as they are not meant to be synchronized.
    # README.md files in 1000xbrain serve as directory navigation and documentation, not as Cursor Rules.
    $mdFiles = Get-ChildItem -Path $RootPath -Filter "*.md" -Recurse -File -Exclude "README.md"
    $allMarkdownFiles = $mdFiles | ForEach-Object { $_.FullName }
    
    # Get all mdc files in .cursor/rules
    $mdcFiles = Get-ChildItem -Path $CursorRulesPath -Filter "*.mdc" -Recurse -File
    $allMdcFiles = $mdcFiles | ForEach-Object { $_.FullName }
    
    # Process each markdown file
    foreach ($mdFile in $allMarkdownFiles) {
        $correspondingMdcFile = Find-CorrespondingMdcFile -markdownFile $mdFile -rootPath $RootPath -cursorRulesPath $CursorRulesPath
        
        if ($correspondingMdcFile) {
            $matchingMdcFiles += $correspondingMdcFile
            
            # Check if content is different
            if (-not (Compare-FileContent -file1 $mdFile -file2 $correspondingMdcFile)) {
                $outdatedMdcFiles += @{
                    MarkdownFile = $mdFile
                    MdcFile = $correspondingMdcFile
                }
            }
        }
        else {
            $unmatchedMarkdownFiles += $mdFile
        }
    }
    
    # Find mdc files without corresponding markdown files
    $unmatchedMdcFiles = $allMdcFiles | Where-Object { $_ -notin $matchingMdcFiles }
    
    # Generate the report
    $timestamp = Get-Date -Format "yyyy-MM-dd-HHmmss"
    $reportFile = Join-Path $ReportPath "1000xbrain-cursor-sync-report-$timestamp.md"
    
    $report = @"
# 1000xbrain to Cursor Sync Report - $timestamp

## Summary
- 1000xbrain markdown files: $($allMarkdownFiles.Count)
- Cursor .mdc files: $($allMdcFiles.Count)
- Matched files: $($matchingMdcFiles.Count)
- 1000xbrain files without matching Cursor rules: $($unmatchedMarkdownFiles.Count)
- Cursor rules without matching 1000xbrain files: $($unmatchedMdcFiles.Count)
- Outdated Cursor rules (content differs): $($outdatedMdcFiles.Count)

## Files That Need Manual Synchronization

### Outdated Cursor Rules
$([string]::Join("`n", ($outdatedMdcFiles | ForEach-Object { "- 1000xbrain: $($_.MarkdownFile.Replace($RootPath, "1000xbrain")) → Cursor: $($_.MdcFile.Replace($CursorRulesPath, ".cursor/rules"))" })))

### 1000xbrain Files Without Matching Cursor Rules
$([string]::Join("`n", ($unmatchedMarkdownFiles | ForEach-Object { "- $_".Replace($RootPath, "1000xbrain") })))

### Cursor Rules Without Matching 1000xbrain Files
$([string]::Join("`n", ($unmatchedMdcFiles | ForEach-Object { "- $_".Replace($CursorRulesPath, ".cursor/rules") })))

## Recommended Actions

1. Update outdated Cursor rules with content from corresponding 1000xbrain files
2. Create new Cursor rules for 1000xbrain files without matching rules
3. Review Cursor rules without matching 1000xbrain files (they may be obsolete)

**Note**: You can use Update-CursorRules to automatically update these files,
or use Edit-CursorRule to edit individual files with VS Code.
"@
    
    Set-Content -Path $reportFile -Value $report
    
    # Create a symlink to the latest report
    $latestReportFile = Join-Path $ReportPath "1000xbrain-cursor-sync-report.md"
    Set-Content -Path $latestReportFile -Value $report
    
    # Output results to console
    Write-Host "`nSync Report Summary:"
    Write-Host "- 1000xbrain markdown files: $($allMarkdownFiles.Count)"
    Write-Host "- Cursor .mdc files: $($allMdcFiles.Count)"
    Write-Host "- Matched files: $($matchingMdcFiles.Count)" -ForegroundColor Green
    Write-Host "- 1000xbrain files without matching Cursor rules: $($unmatchedMarkdownFiles.Count)" -ForegroundColor $(if ($unmatchedMarkdownFiles.Count -gt 0) { "Yellow" } else { "Green" })
    Write-Host "- Cursor rules without matching 1000xbrain files: $($unmatchedMdcFiles.Count)" -ForegroundColor $(if ($unmatchedMdcFiles.Count -gt 0) { "Yellow" } else { "Green" })
    Write-Host "- Outdated Cursor rules (content differs): $($outdatedMdcFiles.Count)" -ForegroundColor $(if ($outdatedMdcFiles.Count -gt 0) { "Red" } else { "Green" })
    Write-Host "`nDetailed sync report written to: $reportFile"
    Write-Host "Latest report symlink: $latestReportFile"
    
    # Return the report data for programmatic use
    return @{
        AllMarkdownFiles = $allMarkdownFiles
        AllMdcFiles = $allMdcFiles
        MatchingMdcFiles = $matchingMdcFiles
        UnmatchedMarkdownFiles = $unmatchedMarkdownFiles
        UnmatchedMdcFiles = $unmatchedMdcFiles
        OutdatedMdcFiles = $outdatedMdcFiles
        ReportFile = $reportFile
    }
}

function Update-CursorRules {
    <#
    .SYNOPSIS
        Updates Cursor Project Rules (.mdc files) directly with content from 1000xbrain markdown files.
    
    .DESCRIPTION
        This function directly updates Cursor Project Rules (.mdc files) with content from corresponding
        1000xbrain markdown files. It preserves the frontmatter from the existing .mdc files and updates
        only the content portion. It also generates a report of all actions taken.
    
    .PARAMETER RootPath
        The root path of the 1000xbrain directory.
    
    .PARAMETER CursorRulesPath
        The path to the Cursor Rules directory.
    
    .PARAMETER ReportPath
        The path where reports will be saved.
    
    .PARAMETER WhatIf
        If specified, the function will only show what would happen without making any changes.
    
    .PARAMETER Force
        If specified, the function will not prompt for confirmation before making changes.
    
    .PARAMETER StrictPathMatching
        If specified, the function will use strict path matching for finding corresponding mdc files.
        This is now always enabled internally.
    
    .PARAMETER SkipBackups
        If specified, the function will not create backups before making changes.
        This is now always enabled internally.
    
    .PARAMETER PreserveRuleType
        If specified, the function will preserve the rule type settings from the existing .mdc files.
        This is enabled by default.
    
    .EXAMPLE
        Update-CursorRules -WhatIf
    
    .EXAMPLE
        Update-CursorRules -Force
    
    .NOTES
        This function directly modifies .mdc files, which are typically edited through the Cursor UI.
        Use with caution and always make backups before running.
    #>
    
    param(
        [string]$RootPath = (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) "1000xbrain"),
        [string]$CursorRulesPath = (Join-Path (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) ".cursor") "rules"),
        [string]$ReportPath = $PSScriptRoot,
        [switch]$WhatIf,
        [switch]$Force,
        [switch]$StrictPathMatching = $true,
        [switch]$SkipBackups = $true,
        [switch]$PreserveRuleType = $true
    )
    
    # Important note: StrictPathMatching and SkipBackups are always enabled internally
    # regardless of the parameter values passed to ensure proper path-based matching
    # and to prevent issues with backup files
    $StrictPathMatching = $true
    $SkipBackups = $true
    
    # Ensure the reports directory exists
    if (-not (Test-Path $ReportPath)) {
        New-Item -ItemType Directory -Path $ReportPath -Force | Out-Null
        Write-Host "Created reports directory: $ReportPath"
    }
    
    # Check if we need to prompt for confirmation
    if (-not $Force -and -not $WhatIf) {
        Write-Host "`nWARNING: This will directly update Cursor Project Rules (.mdc files)." -ForegroundColor Yellow
        Write-Host "These files are typically edited through the Cursor Settings UI." -ForegroundColor Yellow
        $confirm = Read-Host "Are you sure you want to continue? (Y/N)"
        
        if ($confirm -ne "Y" -and $confirm -ne "y") {
            Write-Host "Update canceled." -ForegroundColor Yellow
            return
        }
    }
    
    # Get all markdown files in 1000xbrain
    $mdFiles = Get-ChildItem -Path $RootPath -Filter "*.md" -Recurse -File -Exclude "README.md"
    
    # Initialize arrays for tracking the update process
    $updatedFiles = @()
    $unchangedFiles = @()
    $newFiles = @()
    $errorFiles = @()
    
    # Process each markdown file
    foreach ($mdFile in $mdFiles) {
        $mdcFile = Find-CorrespondingMdcFile -markdownFile $mdFile.FullName -rootPath $RootPath -cursorRulesPath $CursorRulesPath
        
        if ($mdcFile) {
            # Existing mdc file found - check if it needs updating
            if (-not (Compare-FileContent -file1 $mdFile.FullName -file2 $mdcFile)) {
                Write-Host "Content differs for $($mdFile.FullName) - updating $mdcFile"
                
                # Create backup if backups are enabled
                if (-not $SkipBackups) {
                    $backupPath = Backup-File -filePath $mdcFile
                    if ($backupPath) {
                        Write-Host "  Created backup: $backupPath" -ForegroundColor Cyan
                    }
                }
                
                # Update the mdc file
                $updateParams = @{
                    mdcFile = $mdcFile
                    mdFile = $mdFile.FullName
                    WhatIf = $WhatIf
                }
                
                $updateResult = Update-MdcFile @updateParams
                
                if ($updateResult) {
                    $updatedFiles += @{
                        MarkdownFile = $mdFile.FullName
                        MdcFile = $mdcFile
                    }
                }
                else {
                    $errorFiles += @{
                        MarkdownFile = $mdFile.FullName
                        MdcFile = $mdcFile
                        Error = "Failed to update file"
                    }
                }
            }
            else {
                Write-Host "Content is identical for $($mdFile.FullName) - skipping" -ForegroundColor Gray
                $unchangedFiles += @{
                    MarkdownFile = $mdFile.FullName
                    MdcFile = $mdcFile
                }
            }
        }
        else {
            # No corresponding mdc file found - create a new one
            Write-Host "No corresponding mdc file found for $($mdFile.FullName) - creating new file"
            
            # Get the relative path from 1000xbrain root
            $relativePath = $mdFile.FullName.Replace($RootPath, "").TrimStart("\", "/")
            $dirPath = [System.IO.Path]::GetDirectoryName($relativePath)
            $targetDir = Join-Path $CursorRulesPath $dirPath
            
            # Create new mdc file
            $newParams = @{
                mdFile = $mdFile.FullName
                targetDir = $CursorRulesPath
                WhatIf = $WhatIf
                RelativePath = $relativePath
            }
            
            $newResult = New-MdcFile @newParams
            
            if ($newResult) {
                $newFiles += @{
                    MarkdownFile = $mdFile.FullName
                    RelativePath = $relativePath
                }
            }
            else {
                $errorFiles += @{
                    MarkdownFile = $mdFile.FullName
                    Error = "Failed to create new file"
                }
            }
        }
    }
    
    # Generate the report
    $timestamp = Get-Date -Format "yyyy-MM-dd-HHmmss"
    $reportFile = Join-Path $ReportPath "cursor-rules-update-report-$timestamp.md"
    
    $report = @"
# Cursor Rules Update Report - $timestamp

## Summary
- Files updated: $($updatedFiles.Count)
- Files unchanged (content identical): $($unchangedFiles.Count)
- New files created: $($newFiles.Count)
- Errors: $($errorFiles.Count)

## Updated Files
$([string]::Join("`n", ($updatedFiles | ForEach-Object { "- 1000xbrain: $($_.MarkdownFile.Replace($RootPath, "1000xbrain")) → Cursor: $($_.MdcFile.Replace($CursorRulesPath, ".cursor/rules"))" })))

## New Files Created
$([string]::Join("`n", ($newFiles | ForEach-Object { "- 1000xbrain: $($_.MarkdownFile.Replace($RootPath, "1000xbrain")) → Cursor: .cursor/rules/$($_.RelativePath.Replace(".md", ".mdc"))" })))

## Errors
$([string]::Join("`n", ($errorFiles | ForEach-Object { "- 1000xbrain: $($_.MarkdownFile.Replace($RootPath, "1000xbrain")) - Error: $($_.Error)" })))

## Notes
- StrictPathMatching: Always Enabled (ensures proper directory structure)
- SkipBackups: Always Enabled (prevents backup files from being synced)
- PreserveRuleType: $PreserveRuleType (determines whether rule types are preserved)
"@
    
    Set-Content -Path $reportFile -Value $report
    
    # Create a symlink to the latest report
    $latestReportFile = Join-Path $ReportPath "cursor-rules-update-report.md"
    Set-Content -Path $latestReportFile -Value $report
    
    # Output results to console
    Write-Host "`nUpdate Report Summary:"
    Write-Host "- Files updated: $($updatedFiles.Count)" -ForegroundColor $(if ($updatedFiles.Count -gt 0) { "Green" } else { "Gray" })
    Write-Host "- Files unchanged (content identical): $($unchangedFiles.Count)" -ForegroundColor Gray
    Write-Host "- New files created: $($newFiles.Count)" -ForegroundColor $(if ($newFiles.Count -gt 0) { "Green" } else { "Gray" })
    Write-Host "- Errors: $($errorFiles.Count)" -ForegroundColor $(if ($errorFiles.Count -gt 0) { "Red" } else { "Green" })
    Write-Host "`nDetailed update report written to: $reportFile"
    Write-Host "Latest report symlink: $latestReportFile"
    
    # Return the report data for programmatic use
    return @{
        UpdatedFiles = $updatedFiles
        UnchangedFiles = $unchangedFiles
        NewFiles = $newFiles
        ErrorFiles = $errorFiles
        ReportFile = $reportFile
    }
}

function Edit-CursorRule {
    <#
    .SYNOPSIS
        Edits a single Cursor Project Rule file with VS Code.
    
    .DESCRIPTION
        This function allows you to edit a Cursor Project Rule file (.mdc) using VS Code,
        similar to how the Edit-DataMashup function works. When you save and close the file
        in VS Code, the changes will be applied to the .mdc file.
    
    .PARAMETER FilePath
        The path to the .mdc file to edit.
    
    .PARAMETER SkipBackup
        If specified, the function will not create a backup of the file before modifying it.
    
    .EXAMPLE
        Edit-CursorRule -FilePath ".cursor/rules/core/identity/global-rules.mdc"
    
    .NOTES
        Requires VS Code to be installed and in the system PATH.
    #>
    
    param (
        [Parameter(Mandatory=$True, Position=0)]
        [string]$FilePath,
        
        [switch]$SkipBackup
    )
    
    # Ensure the file exists
    if (-not (Test-Path $FilePath)) {
        Write-Error "File not found: $FilePath"
        return
    }
    
    # Create a backup unless skipped
    $backupPath = $null
    if (-not $SkipBackup) {
        $backupPath = Backup-File -filePath $FilePath
        if (-not $backupPath) {
            Write-Error "Failed to create backup of $FilePath"
            return
        }
        
        Write-Host "Backed up to: $backupPath" -ForegroundColor Cyan
    }
    
    # Create a temporary file
    $tempFile = New-TemporaryFile
    
    $successful = $false
    $editedContent = $null
    
    try {
        # Rename temp file to .md extension for proper syntax highlighting in VS Code
        $tempFile = Rename-Item $tempFile ($tempFile.Name + ".md") -PassThru -ErrorAction Stop
        
        # Get the original content
        $originalContent = Get-Content $FilePath -Raw -ErrorAction Stop
        
        # Copy content to temp file
        $originalContent | Out-File $tempFile -NoNewline -ErrorAction Stop
        
        # Try different ways to open VS Code
        $vsCodeOpened = $false
        
        # Try with 'code' command
        try {
            Start-Process "code" "-w `"$($tempFile.FullName)`"" -Wait -ErrorAction Stop
            $vsCodeOpened = $true
        } catch {
            Write-Host "Trying alternative VS Code command..." -ForegroundColor Yellow
        }
        
        # Try with 'code.exe' if the first attempt failed
        if (-not $vsCodeOpened) {
            try {
                Start-Process "code.exe" "-w `"$($tempFile.FullName)`"" -Wait -ErrorAction Stop
                $vsCodeOpened = $true
            } catch {
                Write-Host "Trying another alternative VS Code command..." -ForegroundColor Yellow
            }
        }
        
        # Try with 'code.cmd' if both previous attempts failed
        if (-not $vsCodeOpened) {
            try {
                Start-Process "code.cmd" "-w `"$($tempFile.FullName)`"" -Wait -ErrorAction Stop
                $vsCodeOpened = $true
            } catch {
                Write-Error "Failed to open VS Code. Ensure it's installed and in your PATH."
                return
            }
        }
        
        # Read edited content
        $editedContent = Get-Content $tempFile -Raw -ErrorAction Stop
        
        # Check if content was actually changed
        if ($originalContent -eq $editedContent) { 
            Write-Host "No changes were made to the file." -ForegroundColor Yellow
            $successful = $true
            return
        }
        
        # Save edited content back to original file
        Set-Content -Path $FilePath -Value $editedContent -Force
        Write-Host "Successfully updated: $FilePath" -ForegroundColor Green
        $successful = $true
    }
    catch {
        Write-Error "Failed to edit $FilePath. Error: $_"
        
        # If we have a backup and the operation failed, offer to restore
        if ($backupPath -and (Test-Path $backupPath)) {
            $restore = Read-Host "Do you want to restore from backup? (Y/N)"
            if ($restore -eq "Y" -or $restore -eq "y") {
                try {
                    Copy-Item -Path $backupPath -Destination $FilePath -Force
                    Write-Host "Successfully restored from backup." -ForegroundColor Green
                }
                catch {
                    Write-Error "Failed to restore from backup. Error: $_"
                }
            }
        }
    }
    finally {
        # Clean up temp file
        if (Test-Path $tempFile) {
            Remove-Item $tempFile -Force
        }
        
        # If not successful and no explicit error was shown, show the edited content
        if (-not $successful) {
            Write-Error "Failed to update $FilePath with edited content. Original file remains unchanged."
            if ($editedContent) {
                Write-Host "Your edited content:`n$editedContent" -ForegroundColor Yellow
            }
        }
    }
}

# Function to check rule type consistency
function Test-RuleTypeConsistency {
    <#
    .SYNOPSIS
        Checks for rule type inconsistencies in Cursor Project Rules.
    
    .DESCRIPTION
        This function analyzes Cursor Project Rules (.mdc files) for common rule type inconsistencies,
        such as files with alwaysApply: True but type: manual, or globs: none instead of empty globs.
    
    .PARAMETER CursorRulesPath
        The path to the Cursor Rules directory.
    
    .EXAMPLE
        Test-RuleTypeConsistency -CursorRulesPath ".\.cursor\rules"
    
    .NOTES
        Author: 1000xdev
        Version: 1.0
    #>
    
    param(
        [string]$CursorRulesPath = (Join-Path (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) ".cursor") "rules")
    )
    
    $issues = @()
    
    # Get all mdc files
    $mdcFiles = Get-ChildItem -Path $CursorRulesPath -Filter "*.mdc" -Recurse -File
    
    foreach ($mdcFile in $mdcFiles) {
        $content = Get-Content -Path $mdcFile.FullName -Raw
        $frontmatter = ""
        
        if ($content -match "(?s)^---\s*\r?\n(.*?)\r?\n---\s*\r?\n") {
            $frontmatter = $Matches[1]
            
            # Check for alwaysApply vs type mismatch
            if ($frontmatter -match "alwaysApply:\s*True" -and $frontmatter -match "type:\s*manual") {
                $issues += [PSCustomObject]@{
                    FilePath = $mdcFile.FullName
                    Issue = "Mismatch between alwaysApply: True and type: manual"
                }
            }
            
            # Check for empty globs that should be truly empty
            if ($frontmatter -match "globs:\s*none") {
                $issues += [PSCustomObject]@{
                    FilePath = $mdcFile.FullName
                    Issue = "Invalid globs: none (should be empty)"
                }
            }
        }
    }
    
    return $issues
}

# Export the functions to make them available when the module is imported
Export-ModuleMember -Function Sync-CursorRules, Update-CursorRules, Edit-CursorRule, Get-Frontmatter, Get-ContentWithoutFrontmatter, Format-Frontmatter, ConvertFrom-Frontmatter, ConvertTo-Frontmatter, Compare-FileContent, Backup-File, Find-CorrespondingMdcFile, Update-MdcFile, New-MdcFile, Test-RuleTypeConsistency 