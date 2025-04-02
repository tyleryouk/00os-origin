<#
.SYNOPSIS
    Detects and resolves name conflicts between 1000xbrain files and Cursor Rules.

.DESCRIPTION
    This script identifies files with the same name in different directories that might cause
    synchronization issues, and helps resolve these conflicts by ensuring proper directory
    structure matching.

.PARAMETER RootPath
    The root path of the 1000xbrain directory. Defaults to "../1000xbrain" relative to the script location.

.PARAMETER CursorRulesPath
    The path to the Cursor Rules directory. Defaults to "../.cursor/rules" relative to the script location.

.PARAMETER ReportPath
    The path where reports will be saved. Defaults to the current directory.

.PARAMETER WhatIf
    If specified, the script will only show what would happen without making any changes.

.PARAMETER Force
    If specified, the script will not prompt for confirmation before making changes.

.PARAMETER SkipBackups
    If specified, the script will not create backups before making changes.

.EXAMPLE
    .\Resolve-NameConflicts.ps1 -WhatIf

.EXAMPLE
    .\Resolve-NameConflicts.ps1 -Force

.NOTES
    Author: 1000xdev
    Version: 1.0
    This script helps maintain proper synchronization between 1000xbrain files and Cursor Rules
    by ensuring that files with the same name in different directories are correctly mapped.
#>

param(
    [string]$RootPath = (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) "1000xbrain"),
    [string]$CursorRulesPath = (Join-Path (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) ".cursor") "rules"),
    [string]$ReportPath = $PSScriptRoot,
    [switch]$WhatIf,
    [switch]$Force,
    [switch]$SkipBackups
)

# Script initialization
$startTime = Get-Date
$scriptDir = $PSScriptRoot
$projectRoot = (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent)

Write-Host "==============================================="
Write-Host "Name Conflict Resolution Tool"
Write-Host "==============================================="
Write-Host ""
Write-Host "Options:"
Write-Host "- Root Path: $RootPath" 
Write-Host "- Cursor Rules Path: $CursorRulesPath"
Write-Host "- Report Path: $ReportPath"
Write-Host "- WhatIf: $($WhatIf.ToString())"
Write-Host "- Force: $($Force.ToString())"
Write-Host "- Skip Backups: $($SkipBackups.ToString())"
Write-Host ""

# Ensure the reports directory exists
if (-not (Test-Path $ReportPath)) {
    New-Item -ItemType Directory -Path $ReportPath -Force | Out-Null
    Write-Host "Created reports directory: $ReportPath"
}

# Function to create a backup of a file
function Backup-File {
    param([string]$filePath)
    
    try {
        $backupPath = "$filePath.backup"
        Copy-Item -Path $filePath -Destination $backupPath -Force
        return $backupPath
    }
    catch {
        Write-Error "Failed to backup $filePath. Error: $_"
        return $null
    }
}

# Initialize collections
$allMarkdownFiles = @()
$allMdcFiles = @()
$nameConflicts = @()
$incorrectMappings = @()
$fixedMappings = @()
$failedFixMappings = @()

# Get all markdown files in 1000xbrain
$mdFiles = Get-ChildItem -Path $RootPath -Filter "*.md" -Recurse -File
$allMarkdownFiles = $mdFiles | ForEach-Object { $_.FullName }

# Get all mdc files in .cursor/rules
$mdcFiles = Get-ChildItem -Path $CursorRulesPath -Filter "*.mdc" -Recurse -File
$allMdcFiles = $mdcFiles | ForEach-Object { $_.FullName }

Write-Host "Found $($allMarkdownFiles.Count) 1000xbrain markdown files and $($allMdcFiles.Count) Cursor Project Rules."

# Detect name conflicts in markdown files
$mdFilesByName = @{}
foreach ($mdFile in $allMarkdownFiles) {
    $fileName = [System.IO.Path]::GetFileName($mdFile)
    if (-not $mdFilesByName.ContainsKey($fileName)) {
        $mdFilesByName[$fileName] = @()
    }
    $mdFilesByName[$fileName] += $mdFile
}

# Find files with the same name in different directories
$conflictingFiles = $mdFilesByName.GetEnumerator() | Where-Object { $_.Value.Count -gt 1 }
foreach ($conflict in $conflictingFiles) {
    $nameConflicts += @{
        FileName = $conflict.Key
        Paths = $conflict.Value
    }
}

Write-Host "Detected $($nameConflicts.Count) files with name conflicts:"
foreach ($conflict in $nameConflicts) {
    Write-Host "- $($conflict.FileName)" -ForegroundColor Yellow
    foreach ($path in $conflict.Paths) {
        $relativePath = $path.Replace($RootPath, "1000xbrain")
        Write-Host "  - $relativePath" -ForegroundColor Gray
    }
}

# Check if mdc files are mapped correctly
foreach ($conflict in $nameConflicts) {
    foreach ($mdPath in $conflict.Paths) {
        $relativePath = $mdPath.Replace($RootPath, "").TrimStart("\", "/")
        $directoryPath = [System.IO.Path]::GetDirectoryName($relativePath)
        $fileName = [System.IO.Path]::GetFileNameWithoutExtension($relativePath) + ".mdc"
        
        # Handle empty directory path case
        $expectedMdcPath = if ([string]::IsNullOrEmpty($directoryPath)) {
            Join-Path $CursorRulesPath $fileName
        } else {
            Join-Path $CursorRulesPath (Join-Path $directoryPath $fileName)
        }
        
        if (-not (Test-Path $expectedMdcPath)) {
            # The file doesn't exist at the expected path
            $incorrectMappings += @{
                MarkdownFile = $mdPath
                ExpectedMdcPath = $expectedMdcPath
                ActualMdcPath = $null
            }
            
            # Try to find if it exists somewhere else
            $mdcFileName = [System.IO.Path]::GetFileName($expectedMdcPath)
            $foundMdcFiles = Get-ChildItem -Path $CursorRulesPath -Filter $mdcFileName -Recurse -File
            
            if ($foundMdcFiles.Count -gt 0) {
                $incorrectMappings[-1].ActualMdcPath = $foundMdcFiles[0].FullName
            }
        }
    }
}

Write-Host "Detected $($incorrectMappings.Count) incorrect mappings:"
foreach ($mapping in $incorrectMappings) {
    $relativeMarkdownFile = $mapping.MarkdownFile.Replace($RootPath, "1000xbrain")
    $relativeExpectedMdcPath = $mapping.ExpectedMdcPath.Replace($CursorRulesPath, ".cursor/rules")
    
    Write-Host "- Markdown file: $relativeMarkdownFile" -ForegroundColor Yellow
    Write-Host "  - Expected MDC path: $relativeExpectedMdcPath" -ForegroundColor Gray
    
    if ($mapping.ActualMdcPath) {
        $relativeActualMdcPath = $mapping.ActualMdcPath.Replace($CursorRulesPath, ".cursor/rules")
        Write-Host "  - Actual MDC path: $relativeActualMdcPath" -ForegroundColor Red
    } else {
        Write-Host "  - No MDC file found with matching name" -ForegroundColor Red
    }
}

# Fix mappings if needed
if (-not $WhatIf) {
    foreach ($incorrectMapping in $incorrectMappings) {
        try {
            # Get the expected directory path
            $directoryPath = [System.IO.Path]::GetDirectoryName($incorrectMapping.ExpectedMdcPath)

            # Create the directory if it doesn't exist
            if (-not (Test-Path $directoryPath)) {
                New-Item -Path $directoryPath -ItemType Directory -Force | Out-Null
            }

            # Create a backup if not disabled
            if (-not $SkipBackups) {
                $backupPath = "$($incorrectMapping.ActualMdcPath).backup"
                Copy-Item -Path $incorrectMapping.ActualMdcPath -Destination $backupPath -Force
                Write-Host "Created backup: $backupPath"
            }

            # Copy the file to the correct location
            Copy-Item -Path $incorrectMapping.ActualMdcPath -Destination $incorrectMapping.ExpectedMdcPath -Force
            Write-Host "Copied file to: $($incorrectMapping.ExpectedMdcPath)"
            $fixedMappings += @{
                MarkdownFile = $incorrectMapping.MarkdownFile
                ExpectedMdcPath = $incorrectMapping.ExpectedMdcPath
                SourceMdcPath = $incorrectMapping.ActualMdcPath
            }
        } catch {
            Write-Host "Failed to fix mapping for $($incorrectMapping.MarkdownFile): $_" -ForegroundColor Red
            $failedFixMappings += @{
                MarkdownFile = $incorrectMapping.MarkdownFile
                ExpectedMdcPath = $incorrectMapping.ExpectedMdcPath
                SourceMdcPath = $incorrectMapping.ActualMdcPath
                Error = $_
            }
        }
    }
}

# Generate report
$timestamp = Get-Date -Format "yyyy-MM-dd-HHmmss"
$reportFile = Join-Path $ReportPath "name-conflicts-report-$timestamp.md"

$report = @"
# Name Conflicts Report - $timestamp

## Summary
- 1000xbrain markdown files: $($allMarkdownFiles.Count)
- Cursor .mdc files: $($allMdcFiles.Count)
- Files with name conflicts: $($nameConflicts.Count)
- Incorrect mappings: $($incorrectMappings.Count)
- Fixed mappings: $($fixedMappings.Count)
- Failed fix attempts: $($failedFixMappings.Count)

## Name Conflicts
$(
    if ($nameConflicts.Count -gt 0) {
        $conflictDetails = ""
        foreach ($conflict in $nameConflicts) {
            $conflictDetails += "### $($conflict.FileName)`n`n"
            foreach ($path in $conflict.Paths) {
                $relativePath = $path.Replace($RootPath, "1000xbrain")
                $conflictDetails += "- $relativePath`n"
            }
            $conflictDetails += "`n"
        }
        $conflictDetails
    } else {
        "None"
    }
)

## Incorrect Mappings
$(
    if ($incorrectMappings.Count -gt 0) {
        $mappingDetails = ""
        foreach ($mapping in $incorrectMappings) {
            $relativeMarkdownFile = $mapping.MarkdownFile.Replace($RootPath, "1000xbrain")
            $relativeExpectedMdcPath = $mapping.ExpectedMdcPath.Replace($CursorRulesPath, ".cursor/rules")
            
            $mappingDetails += "### $relativeMarkdownFile`n`n"
            $mappingDetails += "- Expected MDC path: $relativeExpectedMdcPath`n"
            
            if ($mapping.ActualMdcPath) {
                $relativeActualMdcPath = $mapping.ActualMdcPath.Replace($CursorRulesPath, ".cursor/rules")
                $mappingDetails += "- Actual MDC path: $relativeActualMdcPath`n"
            } else {
                $mappingDetails += "- No MDC file found with matching name`n"
            }
            $mappingDetails += "`n"
        }
        $mappingDetails
    } else {
        "None"
    }
)

## Fixed Mappings
$(
    if ($fixedMappings.Count -gt 0) {
        $fixedDetails = ""
        foreach ($fixed in $fixedMappings) {
            $relativeMarkdownFile = $fixed.MarkdownFile.Replace($RootPath, "1000xbrain")
            $relativeExpectedMdcPath = $fixed.ExpectedMdcPath.Replace($CursorRulesPath, ".cursor/rules")
            $relativeSourceMdcPath = $fixed.SourceMdcPath.Replace($CursorRulesPath, ".cursor/rules")
            
            $fixedDetails += "### $relativeMarkdownFile`n`n"
            $fixedDetails += "- Source MDC path: $relativeSourceMdcPath`n"
            $fixedDetails += "- Destination MDC path: $relativeExpectedMdcPath`n"
            $fixedDetails += "- Status: Fixed`n`n"
        }
        $fixedDetails
    } else {
        "None"
    }
)

## Failed Fix Attempts
$(
    if ($failedFixMappings.Count -gt 0) {
        $failedDetails = ""
        foreach ($failed in $failedFixMappings) {
            $relativeMarkdownFile = $failed.MarkdownFile.Replace($RootPath, "1000xbrain")
            $relativeExpectedMdcPath = $failed.ExpectedMdcPath.Replace($CursorRulesPath, ".cursor/rules")
            
            $failedDetails += "### $relativeMarkdownFile`n`n"
            $failedDetails += "- Expected MDC path: $relativeExpectedMdcPath`n"
            
            if ($failed.SourceMdcPath) {
                $relativeSourceMdcPath = $failed.SourceMdcPath.Replace($CursorRulesPath, ".cursor/rules")
                $failedDetails += "- Source MDC path: $relativeSourceMdcPath`n"
            }
            
            $failedDetails += "- Error: $($failed.Error)`n`n"
        }
        $failedDetails
    } else {
        "None"
    }
)

## Recommendations

1. For each name conflict, ensure that the correct content is in the correct location
2. Use the `Sync-FrontmatterAndContent.ps1` script with the `-StrictPathMatching` parameter
3. Review the fixed mappings to ensure they are correct
4. Manually address any failed fix attempts

## Execution Information
- Start time: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))
- End time: $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))
- Duration: $([math]::Round(((Get-Date) - $startTime).TotalSeconds, 2)) seconds
- WhatIf mode: $($WhatIf.ToString())
"@

Set-Content -Path $reportFile -Value $report

# Create a symlink to the latest report
$latestReportFile = Join-Path $ReportPath "name-conflicts-report.md"
Set-Content -Path $latestReportFile -Value $report

# Output final summary
Write-Host "`nName Conflict Resolution Results:"
Write-Host "- Files with name conflicts: $($nameConflicts.Count)" -ForegroundColor $(if ($nameConflicts.Count -gt 0) { "Yellow" } else { "Green" })
Write-Host "- Incorrect mappings: $($incorrectMappings.Count)" -ForegroundColor $(if ($incorrectMappings.Count -gt 0) { "Yellow" } else { "Green" })
Write-Host "- Fixed mappings: $($fixedMappings.Count)" -ForegroundColor $(if ($fixedMappings.Count -gt 0) { "Green" } else { "Gray" })
Write-Host "- Failed fix attempts: $($failedFixMappings.Count)" -ForegroundColor $(if ($failedFixMappings.Count -gt 0) { "Red" } else { "Green" })
Write-Host "`nDetailed report written to: $reportFile"
Write-Host "Latest report symlink: $latestReportFile" 

if ($WhatIf) {
    Write-Host "`nThis was a DRY RUN. No files were actually modified." -ForegroundColor Yellow
    Write-Host "To apply changes, run the script without the -WhatIf parameter." -ForegroundColor Yellow
} elseif ($fixedMappings.Count -gt 0) {
    Write-Host "`nMappings have been fixed. You may need to restart Cursor for changes to take effect." -ForegroundColor Green
} 