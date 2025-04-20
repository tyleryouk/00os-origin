<#
.SYNOPSIS
    Synchronizes content from 00os markdown files to Cursor Project Rules.

.DESCRIPTION
    This script synchronizes markdown files from the 00os directory to their
    corresponding Cursor Project Rules (.mdc files) in .cursor/rules directory,
    preserving existing frontmatter in the .mdc files.
    
    It's a dedicated script for the 00OS synchronization that ensures proper
    handling of paths and special 00OS file types.

.PARAMETER RootPath
    The root path of the source directory. Defaults to "../00os" relative to the script location.

.PARAMETER DryRun
    If specified, the script will only report what would be changed without making actual changes.

.PARAMETER DetectOrphans
    If specified, the script will detect orphaned mdc files (those without corresponding md files).

.PARAMETER RemoveOrphans
    If specified, the script will remove orphaned mdc files.
    This parameter implies -DetectOrphans.

.EXAMPLE
    .\Sync-00OS.ps1 -RootPath "../00os" -DryRun

.EXAMPLE
    .\Sync-00OS.ps1 -RootPath "../00os" -DetectOrphans

.EXAMPLE
    .\Sync-00OS.ps1 -RootPath "../00os" -RemoveOrphans

.NOTES
    Author: 00reaper
    Version: 1.0
#>

param(
    [string]$RootPath = (Join-Path (Split-Path $PSScriptRoot -Parent) "00os"),
    [switch]$DryRun,
    [switch]$DetectOrphans,
    [switch]$RemoveOrphans
)

# If RemoveOrphans is specified, DetectOrphans is implied
if ($RemoveOrphans) {
    $DetectOrphans = $true
}

# Get correct paths regardless of the current directory
$scriptDir = $PSScriptRoot
$rootDir = Split-Path -Parent $scriptDir
$sourceDir = $RootPath
$targetDir = Join-Path $rootDir ".cursor\rules"
$reportDir = Join-Path $scriptDir "sync-reports"

# Ensure source directory exists
if (-not (Test-Path $sourceDir)) {
    Write-Error "Source directory not found: $sourceDir"
    exit 1
}

# Ensure report directory exists
if (-not (Test-Path $reportDir)) {
    New-Item -ItemType Directory -Path $reportDir -Force | Out-Null
    Write-Host "Created report directory: $reportDir" -ForegroundColor Green
}

# Import required module
$moduleFile = Join-Path (Join-Path $scriptDir "rules-scripts") "CursorRules.psm1"
if (Test-Path $moduleFile) {
    Import-Module $moduleFile -Force
} else {
    Write-Error "Required module not found: $moduleFile"
    exit 1
}

# Display banner
Write-Host "==============================================="
Write-Host "00OS to Cursor Rules Synchronization Tool"
Write-Host "==============================================="
Write-Host ""
Write-Host "Options:"
Write-Host "- Source Directory: $sourceDir"
Write-Host "- Cursor Rules Path: $targetDir"
Write-Host "- Dry Run: $($DryRun.ToString())"
if ($DetectOrphans) {
    Write-Host "- Detect Orphaned Rules: True"
    if ($RemoveOrphans) {
        Write-Host "- Remove Orphaned Rules: True"
    } else {
        Write-Host "- Remove Orphaned Rules: False"
    }
}
Write-Host "==============================================="
Write-Host ""

# Initialize tracking variables
$updatedFiles = @()
$createdFiles = @()
$skippedFiles = @()
$errorFiles = @()
$matchedMdcFiles = @()
$orphanedMdcFiles = @()
$removedOrphanFiles = @()

# Function to determine the correct mdc file path based on the md file path
function Get-MdcFilePath {
    param(
        [string]$mdFilePath,
        [string]$sourceDirPath,
        [string]$targetDirPath
    )
    
    try {
        # Get absolute paths to ensure correct path comparison
        $absSourcePath = (Resolve-Path $sourceDirPath).Path
        $absFilePath = (Resolve-Path $mdFilePath).Path
        
        # Check if the file is actually in the source directory
        if (-not $absFilePath.StartsWith($absSourcePath, [StringComparison]::OrdinalIgnoreCase)) {
            Write-Host "  Warning: File $mdFilePath is not within the source directory $sourceDirPath." -ForegroundColor Yellow
            return $null
        }
        
        # Get the relative path from source to the file
        $relPath = $absFilePath.Substring($absSourcePath.Length).TrimStart('\', '/')
        
        # Extract directory and filename parts
        $fileNameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($relPath)
        $relDir = [System.IO.Path]::GetDirectoryName($relPath)
        
        # Construct target path
        if ([string]::IsNullOrEmpty($relDir)) {
            # File is directly in the source root
            return Join-Path $targetDirPath "$fileNameWithoutExt.mdc"
        } else {
            # File is in a subdirectory
            return Join-Path (Join-Path $targetDirPath $relDir) "$fileNameWithoutExt.mdc"
        }
    } catch {
        Write-Host "  Error getting mdc file path: $_" -ForegroundColor Red
        return $null
    }
}

# Function to generate special frontmatter for 00OS files if needed
function Get-OSOSFrontmatter {
    param(
        [string]$filePath,
        [string]$sourceDirPath
    )
    
    try {
        # Get absolute paths to ensure correct path comparison
        $absSourcePath = (Resolve-Path $sourceDirPath).Path
        $absFilePath = (Resolve-Path $filePath).Path
        
        # Check if the file is actually in the source directory
        if (-not $absFilePath.StartsWith($absSourcePath, [StringComparison]::OrdinalIgnoreCase)) {
            Write-Host "  Warning: File $filePath is not within the source directory $sourceDirPath." -ForegroundColor Yellow
            return ""
        }
        
        # Get the relative path from source to the file
        $relativePath = $absFilePath.Substring($absSourcePath.Length).TrimStart('\', '/')
        
        # Initialize empty frontmatter
        $frontmatter = ""
        
        # Generate special frontmatter for process files
        if ($relativePath -match "processes/") {
            $processName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
            $processCategory = "system" # Default category
            
            # Try to extract category from the path
            if ($relativePath -match "processes/([^/]+)/") {
                $processCategory = $matches[1]
            }
            
            # Read the file content to check for an explicit Process, Title or USE WHEN section
            $fileContent = Get-Content -Path $filePath
            
            # Default description
            $description = "USE WHEN you want to use the $processName process"
            
            # Check for Process title
            $processTitle = $fileContent | Where-Object { $_ -match "^# Process: (.+)$" }
            if ($processTitle) {
                $processNameFromTitle = ($processTitle -split "Process: ")[1].Trim()
                $description = "USE WHEN you want to use the $processNameFromTitle process"
            }
            
            # Look for explicit USE WHEN section which takes precedence
            $useWhenLine = $fileContent | Where-Object { $_ -match "## USE WHEN" -or $_ -match "USE WHEN:" }
            if ($useWhenLine) {
                $useWhenIndex = [array]::IndexOf($fileContent, $useWhenLine)
                if ($useWhenIndex -ge 0 -and $useWhenIndex -lt $fileContent.Length - 1) {
                    # Get the next non-empty line after USE WHEN
                    for ($i = $useWhenIndex + 1; $i -lt $fileContent.Length; $i++) {
                        $nextLine = $fileContent[$i].Trim()
                        if ($nextLine -and -not [string]::IsNullOrWhiteSpace($nextLine)) {
                            # If the line starts with a hyphen (list item), format appropriately
                            if ($nextLine -match "^\s*-\s*(.+)$") {
                                $description = "USE WHEN " + $matches[1].Trim()
                            } else {
                                # Otherwise use the whole line
                                if ($nextLine.StartsWith("USE WHEN")) {
                                    $description = $nextLine
                                } else {
                                    $description = "USE WHEN $nextLine"
                                }
                            }
                            break
                        }
                    }
                }
            }
            
            # For process files: Agent Requested rule type (descriptive with no alwaysApply)
            $frontmatter = @"
---
description: $description
globs: 
alwaysApply: false
type: agent
---

"@
        }
        # Generate special frontmatter for core files
        elseif ($relativePath -match "core/") {
            $componentName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
            
            # For core files: Always Apply rule type
            $frontmatter = @"
---
description: Core system component - $componentName
globs: 
alwaysApply: true
type: always
---

"@
        }
        # Generate special frontmatter for config files
        elseif ($relativePath -match "config/") {
            $configName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
            
            # For config files: Always Apply rule type
            $frontmatter = @"
---
description: System configuration - $configName
globs: 
alwaysApply: true
type: always
---

"@
        }
        # Default frontmatter for other directories (like root files)
        else {
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
            
            # Special case for main system file (00reaper)
            if ($fileName -eq "00reaper") {
                $frontmatter = @"
---
description: 00reaper is the system administrator and architect for the 00OS command-line operating system
globs: *
alwaysApply: true
type: always
---

"@
            }
            else {
                # Default for other files: Always Apply
                $frontmatter = @"
---
description: System component - $fileName
globs: 
alwaysApply: true
type: always
---

"@
            }
        }
        
        return $frontmatter
    } catch {
        Write-Host "  Error generating frontmatter: $_" -ForegroundColor Red
        return ""
    }
}

# Get all markdown files in the 00os directory
# Explicitly exclude README.md files as they are not meant to be synchronized
Write-Host "Finding markdown files in $sourceDir directory..."
$mdFiles = Get-ChildItem -Path $sourceDir -Filter "*.md" -Recurse -File -Exclude "README.md"
Write-Host "Found $($mdFiles.Count) markdown files to process." -ForegroundColor Green

# Process each markdown file
foreach ($mdFile in $mdFiles) {
    $mdFilePath = $mdFile.FullName
    
    # Skip README.md files
    if ($mdFile.Name -eq "README.md") {
        Write-Host "Skipping README.md file: $($mdFile.Name) (README.md files are not synchronized)" -ForegroundColor Yellow
        $skippedFiles += "README.md: $($mdFile.Name)"
        continue
    }
    
    Write-Host "Processing: $($mdFile.Name)" -ForegroundColor Cyan
    
    # Get the corresponding mdc file path
    $mdcFilePath = Get-MdcFilePath -mdFilePath $mdFilePath -sourceDirPath $sourceDir -targetDirPath $targetDir
    
    if (-not $mdcFilePath) {
        $errorFiles += "Error determining mdc path for: $($mdFile.Name)"
        continue
    }
    
    # Check if the mdc file exists
    if (Test-Path $mdcFilePath) {
        # Corresponding mdc file exists
        $matchedMdcFiles += $mdcFilePath
        
        # Update mdc file content
        try {
            $updated = Update-MdcFile -mdcFile $mdcFilePath -mdFile $mdFilePath -WhatIf:$DryRun
            
            if ($updated) {
                if ($DryRun) {
                    Write-Host "  Would update: $mdcFilePath" -ForegroundColor Yellow
                } else {
                    Write-Host "  Updated: $mdcFilePath" -ForegroundColor Green
                }
                $updatedFiles += "Updated: $($mdFile.Name) -> $($mdcFilePath.Replace($targetDir, '.cursor/rules'))"
            } else {
                Write-Host "  No changes needed: $mdcFilePath" -ForegroundColor Gray
                $skippedFiles += "No changes needed: $($mdFile.Name)"
            }
        } catch {
            Write-Host "  Error updating file: $_" -ForegroundColor Red
            $errorFiles += "Error updating $($mdFile.Name): $_"
        }
    } else {
        # No corresponding mdc file, need to create one
        $mdcDirectory = [System.IO.Path]::GetDirectoryName($mdcFilePath)
        
        # Create directory if it doesn't exist
        if (-not (Test-Path $mdcDirectory)) {
            if (-not $DryRun) {
                Write-Host "  Creating directory: $mdcDirectory" -ForegroundColor Yellow
                New-Item -ItemType Directory -Path $mdcDirectory -Force | Out-Null
            } else {
                Write-Host "  Would create directory: $mdcDirectory" -ForegroundColor Yellow
            }
        }
        
        # Create new mdc file
        try {
            if ($DryRun) {
                Write-Host "  Would create new file: $mdcFilePath" -ForegroundColor Yellow
                $createdFiles += "Would create: $($mdFile.Name) -> $($mdcFilePath.Replace($targetDir, '.cursor/rules'))"
            } else {
                # Get content without frontmatter
                $content = Get-ContentWithoutFrontmatter -filePath $mdFilePath
                
                # Check if special 00OS frontmatter is needed
                $osFrontmatter = Get-OSOSFrontmatter -filePath $mdFilePath -sourceDirPath $sourceDir
                if ($osFrontmatter) {
                    $content = $osFrontmatter + $content
                }
                
                # Create new file with content
                Set-Content -Path $mdcFilePath -Value $content -NoNewline
                Write-Host "  Created new file: $mdcFilePath" -ForegroundColor Green
                $createdFiles += "Created: $($mdFile.Name) -> $($mdcFilePath.Replace($targetDir, '.cursor/rules'))"
            }
        } catch {
            Write-Host "  Error creating file: $_" -ForegroundColor Red
            $errorFiles += "Error creating $($mdFile.Name): $_"
        }
    }
}

# Process orphaned rules if enabled
if ($DetectOrphans) {
    Write-Host ""
    Write-Host "Checking for orphaned Cursor Rules files..." -ForegroundColor Cyan
    
    # Get all mdc files in the target directory
    $allMdcFiles = Get-ChildItem -Path $targetDir -Filter "*.mdc" -Recurse -File | ForEach-Object { $_.FullName }
    
    # Build a list of expected mdc files based on the md files we processed
    $expectedMdcFiles = @()
    
    foreach ($mdFile in $mdFiles) {
        $mdcPath = Get-MdcFilePath -mdFilePath $mdFile.FullName -sourceDirPath $sourceDir -targetDirPath $targetDir
        if ($mdcPath) {
            $expectedMdcFiles += $mdcPath
        }
    }
    
    # Find orphaned mdc files (those not in the expected list)
    $orphanedMdcFiles = $allMdcFiles | Where-Object { $_ -notin $expectedMdcFiles }
    
    # Report on orphaned files
    if ($orphanedMdcFiles.Count -gt 0) {
        Write-Host "Found $($orphanedMdcFiles.Count) orphaned mdc files (no corresponding markdown file):" -ForegroundColor Yellow
        
        foreach ($orphanFile in $orphanedMdcFiles) {
            $relativePath = $orphanFile.Replace($targetDir, '.cursor/rules')
            Write-Host "  - $relativePath" -ForegroundColor Yellow
        }
        
        # Process removal if enabled
        if ($RemoveOrphans) {
            Write-Host "Removing orphaned files..." -ForegroundColor Yellow
            
            foreach ($orphanFile in $orphanedMdcFiles) {
                try {
                    if (-not $DryRun) {
                        Remove-Item -Path $orphanFile -Force
                        Write-Host "  Removed orphaned file: $orphanFile" -ForegroundColor Yellow
                    } else {
                        Write-Host "  Would remove orphaned file: $orphanFile" -ForegroundColor Yellow
                    }
                    $removedOrphanFiles += $orphanFile
                } catch {
                    Write-Host "  Error removing file: $_" -ForegroundColor Red
                }
            }
            
            Write-Host "Removed $($removedOrphanFiles.Count) orphaned files." -ForegroundColor Green
        } else {
            Write-Host "Orphaned files detection only. Use -RemoveOrphans to remove these files." -ForegroundColor Yellow
        }
    } else {
        Write-Host "No orphaned mdc files found." -ForegroundColor Green
    }
}

# Generate summary report
$timestamp = Get-Date -Format "yyyy-MM-dd-HHmmss"
$reportFile = Join-Path $reportDir "00os-sync-results-$timestamp.md"

$report = @"
# 00OS to Cursor Rules Synchronization Report

Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Summary
- Mode: $(if ($DryRun) { "Dry Run (no changes made)" } else { "Live Run (changes applied)" })
- Total files processed: $($mdFiles.Count)
- Files updated: $($updatedFiles.Count)
- Files created: $($createdFiles.Count)
- Files skipped: $($skippedFiles.Count)
- Errors: $($errorFiles.Count)
$(if ($DetectOrphans) { "- Orphaned files detected: $($orphanedMdcFiles.Count)" })
$(if ($RemoveOrphans) { "- Orphaned files removed: $($removedOrphanFiles.Count)" })

## Details

### Updated Files
$(if ($updatedFiles.Count -gt 0) { $updatedFiles -join "`n" } else { "None" })

### Created Files
$(if ($createdFiles.Count -gt 0) { $createdFiles -join "`n" } else { "None" })

### Skipped Files
$(if ($skippedFiles.Count -gt 0) { $skippedFiles -join "`n" } else { "None" })

### Errors
$(if ($errorFiles.Count -gt 0) { $errorFiles -join "`n" } else { "None" })

$(if ($DetectOrphans) {
@"
### Orphaned Files
$(if ($orphanedMdcFiles.Count -gt 0) { ($orphanedMdcFiles | ForEach-Object { "- $($_ -replace [regex]::Escape($targetDir), '.cursor/rules')" }) -join "`n" } else { "None" })

$(if ($RemoveOrphans) {
@"
### Removed Orphaned Files
$(if ($removedOrphanFiles.Count -gt 0) { ($removedOrphanFiles | ForEach-Object { "- $($_ -replace [regex]::Escape($targetDir), '.cursor/rules')" }) -join "`n" } else { "None" })
"@
})
"@
})

## Frontmatter Configuration

Files are automatically configured with appropriate frontmatter based on their directory:

1. **Core System Files** (`/core/` directory)
   - Set as "Always Apply" rules (alwaysApply: true)
   - Description: "Core system component - [component name]"
   - Purpose: Ensures critical system components are always available

2. **Process Files** (`/processes/` directory)
   - Set as "Agent Requested" rules (alwaysApply: false)
   - Description: "USE WHEN [clear action description]"
   - Extracted from file content (Process title or USE WHEN section)
   - Purpose: Makes processes available on demand when relevant

3. **Configuration Files** (`/config/` directory)
   - Set as "Always Apply" rules (alwaysApply: true)
   - Description: "System configuration - [config name]"
   - Purpose: Ensures system settings are always available

4. **Root 00reaper File**
   - Special case with "Always Apply" and global matching
   - Description: "00reaper is the system administrator and architect for the 00OS command-line operating system"
   - globs: *
   - Purpose: Makes the main system identity available in all contexts

## Important Notes

- README.md files are explicitly excluded from synchronization
- Frontmatter in .mdc files is always preserved during synchronization
- The synchronization automatically extracts appropriate descriptions from process files
- When creating a new process file, consider adding a "## USE WHEN" section for better descriptions
"@

Set-Content -Path $reportFile -Value $report

# Print summary to console
Write-Host ""
Write-Host "Synchronization Complete!"
Write-Host "=========================="
Write-Host "Total files processed: $($mdFiles.Count)"
Write-Host "Files updated: $($updatedFiles.Count)" -ForegroundColor $(if ($updatedFiles.Count -gt 0) { "Green" } else { "Gray" })
Write-Host "Files created: $($createdFiles.Count)" -ForegroundColor $(if ($createdFiles.Count -gt 0) { "Green" } else { "Gray" })
Write-Host "Files skipped: $($skippedFiles.Count)" -ForegroundColor $(if ($skippedFiles.Count -gt 0) { "Yellow" } else { "Gray" })
Write-Host "Errors: $($errorFiles.Count)" -ForegroundColor $(if ($errorFiles.Count -gt 0) { "Red" } else { "Gray" })

if ($DetectOrphans) {
    Write-Host "Orphaned files detected: $($orphanedMdcFiles.Count)" -ForegroundColor $(if ($orphanedMdcFiles.Count -gt 0) { "Yellow" } else { "Green" })
    
    if ($RemoveOrphans) {
        Write-Host "Orphaned files removed: $($removedOrphanFiles.Count)" -ForegroundColor $(if ($removedOrphanFiles.Count -gt 0) { "Yellow" } else { "Gray" })
    }
}

Write-Host ""
Write-Host "Report saved to: $reportFile" -ForegroundColor Cyan

# Clean up old reports
Write-Host "Running sync report cleanup..."
& (Join-Path $scriptDir "Clean-SyncReports.ps1")

# Return results object
return @{
    ProcessedCount = $mdFiles.Count
    UpdatedCount = $updatedFiles.Count
    CreatedCount = $createdFiles.Count
    SkippedCount = $skippedFiles.Count
    ErrorCount = $errorFiles.Count
    ReportFile = $reportFile
} 