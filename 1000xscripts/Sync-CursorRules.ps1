<#
.SYNOPSIS
    Synchronizes content from 1000xbrain markdown files to Cursor Project Rules.

.DESCRIPTION
    This script synchronizes content from 1000xbrain markdown files to their
    corresponding Cursor Project Rules (.mdc files), preserving existing
    frontmatter in the .mdc files.
    
    Key features:
    - Preserves all frontmatter in .mdc files (including rule types)
    - Only updates the content portion of files
    - Explicitly excludes README.md files
    - Uses strict path matching to preserve directory structure
    - Can detect and optionally remove orphaned rules (mdc files without corresponding md files)

.PARAMETER RootPath
    The root path of the 1000xbrain directory. Defaults to "./1000xbrain" relative to the script location.

.PARAMETER CursorRulesPath
    The path to the Cursor Rules directory. Defaults to "./.cursor/rules" relative to the script location.

.PARAMETER ReportPath
    The path where reports will be saved. Defaults to "./sync-reports".

.PARAMETER DryRun
    If specified, the script will only report what would be changed without making actual changes.

.PARAMETER DetectOrphans
    If specified, the script will detect orphaned mdc files (those without corresponding md files).

.PARAMETER RemoveOrphans
    If specified, the script will remove orphaned mdc files.
    This parameter implies -DetectOrphans.

.EXAMPLE
    .\Sync-CursorRules.ps1 -DryRun

.EXAMPLE
    .\Sync-CursorRules.ps1 -DetectOrphans

.EXAMPLE
    .\Sync-CursorRules.ps1 -RemoveOrphans

.NOTES
    Author: 1000xdev
    Version: 1.1
#>

param(
    [string]$RootPath = (Join-Path (Split-Path $PSScriptRoot -Parent) "1000xbrain"),
    [string]$CursorRulesPath = (Join-Path (Join-Path (Split-Path $PSScriptRoot -Parent) ".cursor") "rules"),
    [string]$ReportPath = (Join-Path $PSScriptRoot "sync-reports"),
    [switch]$DryRun,
    [switch]$DetectOrphans,
    [switch]$RemoveOrphans
)

# If RemoveOrphans is specified, DetectOrphans is implied
if ($RemoveOrphans) {
    $DetectOrphans = $true
}

# Import required module
$moduleFile = Join-Path (Join-Path $PSScriptRoot "rules-scripts") "CursorRules.psm1"
if (Test-Path $moduleFile) {
    Import-Module $moduleFile -Force
} else {
    Write-Error "Required module not found: $moduleFile"
    exit 1
}

# Create report directory if it doesn't exist
if (-not (Test-Path $ReportPath)) {
    New-Item -ItemType Directory -Path $ReportPath -Force | Out-Null
    Write-Host "Created report directory: $ReportPath" -ForegroundColor Green
}

# Display banner
Write-Host "==============================================="
Write-Host "Cursor Rules Synchronization Tool"
Write-Host "==============================================="
Write-Host ""
Write-Host "Options:"
Write-Host "- Root Path: $RootPath"
Write-Host "- Cursor Rules Path: $CursorRulesPath"
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

# Function to find corresponding mdc file for a markdown file
function Find-CorrespondingMdcFile {
    param(
        [string]$markdownFile
    )
    
    # Get relative path from 1000xbrain root
    $relativePath = $markdownFile.Replace($RootPath, "").TrimStart("\", "/")
    
    # Create the expected mdc file path, preserving the directory structure
    $directoryPath = [System.IO.Path]::GetDirectoryName($relativePath)
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($relativePath) + ".mdc"
    $expectedMdcPath = Join-Path $CursorRulesPath (Join-Path $directoryPath $fileName)
    
    # Check if the file exists at the expected path
    if (Test-Path $expectedMdcPath) {
        return $expectedMdcPath
    }
    
    # Return null to indicate no matching file was found
    return $null
}

# Function to identify orphaned mdc files
function Get-OrphanedMdcFiles {
    param(
        [string]$cursorRulesPath,
        [array]$matchedFiles
    )
    
    # Get all mdc files in Cursor Rules directory
    $allMdcFiles = Get-ChildItem -Path $cursorRulesPath -Filter "*.mdc" -Recurse -File | ForEach-Object { $_.FullName }
    
    # Find mdc files that aren't in the matched files list
    $orphanedFiles = $allMdcFiles | Where-Object { $_ -notin $matchedFiles }
    
    return $orphanedFiles
}

# Function to safely remove orphaned mdc files
function Remove-OrphanedMdcFile {
    param(
        [string]$mdcFile,
        [switch]$WhatIf
    )
    
    try {
        if (-not $WhatIf) {
            # Remove the file directly without creating backup
            Remove-Item -Path $mdcFile -Force
            Write-Host "  Removed orphaned file: $mdcFile" -ForegroundColor Yellow
            return $true
        } else {
            Write-Host "  Would remove orphaned file: $mdcFile" -ForegroundColor Yellow
            return $true
        }
    } catch {
        Write-Host "  Error removing file: $_" -ForegroundColor Red
        return $false
    }
}

# Get all markdown files in 1000xbrain
# Explicitly exclude README.md files as they are not meant to be synchronized.
# README.md files in 1000xbrain serve as directory navigation and documentation, not as Cursor Rules.
Write-Host "Finding markdown files in 1000xbrain directory..."
$mdFiles = Get-ChildItem -Path $RootPath -Filter "*.md" -Recurse -File -Exclude "README.md"
Write-Host "Found $($mdFiles.Count) markdown files to process." -ForegroundColor Green

# Process each markdown file
foreach ($mdFile in $mdFiles) {
    $mdFilePath = $mdFile.FullName
    $relativePath = $mdFilePath.Replace($RootPath, "").TrimStart("\", "/")
    
    # Skip README.md files
    if ($mdFile.Name -eq "README.md") {
        Write-Host "Skipping README.md file: $relativePath (README.md files are not synchronized)" -ForegroundColor Yellow
        $skippedFiles += "README.md: $relativePath"
        continue
    }
    
    Write-Host "Processing: $relativePath" -ForegroundColor Cyan
    
    # Find corresponding mdc file
    $mdcFilePath = Find-CorrespondingMdcFile -markdownFile $mdFilePath
    
    if ($mdcFilePath) {
        # Corresponding mdc file exists
        
        # Add to matched files list
        $matchedMdcFiles += $mdcFilePath
        
        # Update mdc file
        try {
            $updated = Update-MdcFile -mdcFile $mdcFilePath -mdFile $mdFilePath -WhatIf:$DryRun
            
            if ($updated) {
                if ($DryRun) {
                    Write-Host "  Would update: $mdcFilePath" -ForegroundColor Yellow
                } else {
                    Write-Host "  Updated: $mdcFilePath" -ForegroundColor Green
                }
                $updatedFiles += "Updated: $relativePath -> $($mdcFilePath.Replace($CursorRulesPath, ''))"
            } else {
                Write-Host "  No changes needed: $mdcFilePath" -ForegroundColor Gray
                $skippedFiles += "No changes needed: $relativePath"
            }
        } catch {
            Write-Host "  Error updating file: $_" -ForegroundColor Red
            $errorFiles += "Error updating $relativePath`: $_"
        }
    } else {
        # No corresponding mdc file, need to create one
        
        # Get target directory path
        $relativeDirPath = [System.IO.Path]::GetDirectoryName($relativePath)
        $targetDirPath = Join-Path $CursorRulesPath $relativeDirPath
        
        # Create directory if it doesn't exist
        if (-not (Test-Path $targetDirPath)) {
            if (-not $DryRun) {
                Write-Host "  Creating directory: $targetDirPath" -ForegroundColor Yellow
                New-Item -ItemType Directory -Path $targetDirPath -Force | Out-Null
            } else {
                Write-Host "  Would create directory: $targetDirPath" -ForegroundColor Yellow
            }
        }
        
        # Create new mdc file
        try {
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($mdFile.Name) + ".mdc"
            $newMdcPath = Join-Path $targetDirPath $fileName
            
            if ($DryRun) {
                Write-Host "  Would create new file: $newMdcPath" -ForegroundColor Yellow
                $createdFiles += "Would create: $relativePath -> $newMdcPath"
            } else {
                # Get content without frontmatter
                $content = Get-ContentWithoutFrontmatter -filePath $mdFilePath
                
                # Create new file with content only (no frontmatter)
                Set-Content -Path $newMdcPath -Value $content -NoNewline
                Write-Host "  Created new file: $newMdcPath" -ForegroundColor Green
                $createdFiles += "Created: $relativePath -> $($newMdcPath.Replace($CursorRulesPath, ''))"
            }
        } catch {
            Write-Host "  Error creating file: $_" -ForegroundColor Red
            $errorFiles += "Error creating $relativePath`: $_"
        }
    }
}

# Process orphaned rules if enabled
if ($DetectOrphans) {
    Write-Host ""
    Write-Host "Checking for orphaned Cursor Rules files..." -ForegroundColor Cyan
    
    # Get orphaned mdc files
    $orphanedMdcFiles = Get-OrphanedMdcFiles -cursorRulesPath $CursorRulesPath -matchedFiles $matchedMdcFiles
    
    # Report on orphaned files
    if ($orphanedMdcFiles.Count -gt 0) {
        Write-Host "Found $($orphanedMdcFiles.Count) orphaned mdc files (no corresponding markdown file)." -ForegroundColor Yellow
        
        # Process removal if enabled
        if ($RemoveOrphans) {
            Write-Host "Removing orphaned files..." -ForegroundColor Yellow
            
            foreach ($orphanFile in $orphanedMdcFiles) {
                $removed = Remove-OrphanedMdcFile -mdcFile $orphanFile -WhatIf:$DryRun
                
                if ($removed) {
                    $removedOrphanFiles += $orphanFile
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
$reportFile = Join-Path $ReportPath "sync-results-$timestamp.md"

$report = @"
# Cursor Rules Synchronization Report

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
$(if ($orphanedMdcFiles.Count -gt 0) { ($orphanedMdcFiles | ForEach-Object { "- $($_ -replace [regex]::Escape($CursorRulesPath), '.cursor/rules')" }) -join "`n" } else { "None" })

$(if ($RemoveOrphans) {
@"
### Removed Orphaned Files
$(if ($removedOrphanFiles.Count -gt 0) { ($removedOrphanFiles | ForEach-Object { "- $($_ -replace [regex]::Escape($CursorRulesPath), '.cursor/rules')" }) -join "`n" } else { "None" })
"@
})
"@
})

## Important Notes

- README.md files are explicitly excluded from synchronization
- Frontmatter in .mdc files is always preserved during synchronization
- Rule types must be managed through the Cursor UI
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

# Return results object
return @{
    ProcessedCount = $mdFiles.Count
    UpdatedCount = $updatedFiles.Count
    CreatedCount = $createdFiles.Count
    SkippedCount = $skippedFiles.Count
    ErrorCount = $errorFiles.Count
    ReportFile = $reportFile
} 