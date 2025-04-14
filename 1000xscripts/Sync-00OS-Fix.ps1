<#
.SYNOPSIS
    Fixes frontmatter for specific MDC files in the .cursor/rules directory.

.DESCRIPTION
    This script applies custom frontmatter to specific .mdc files that need
    special handling that the main sync script doesn't support.
    
    Run this script after Sync-00OS.ps1 to ensure proper frontmatter is applied.

.PARAMETER RootPath
    The root path of the repository. Defaults to the parent directory of the script location.

.PARAMETER DryRun
    If specified, the script will only report what would be changed without making actual changes.

.EXAMPLE
    .\Sync-00OS-Fix.ps1

.EXAMPLE
    .\Sync-00OS-Fix.ps1 -DryRun

.NOTES
    Author: 00reaper
    Version: 1.0
#>

param(
    [string]$RootPath = (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent),
    [switch]$DryRun
)

# Get correct paths regardless of the current directory
$scriptDir = $PSScriptRoot
$rootDir = $RootPath
$sourceDir = Join-Path $rootDir "00os"
$targetDir = Join-Path $rootDir ".cursor\rules"
$reportDir = Join-Path $scriptDir "sync-reports"

# Initialize tracking variables
$updatedFiles = @()
$errorFiles = @()

# Ensure directories exist
if (-not (Test-Path $targetDir)) {
    Write-Error "Target directory not found: $targetDir"
    exit 1
}

if (-not (Test-Path $reportDir)) {
    New-Item -ItemType Directory -Path $reportDir -Force | Out-Null
    Write-Host "Created report directory: $reportDir" -ForegroundColor Green
}

# Display banner
Write-Host "==============================================="
Write-Host "00OS to Cursor Rules Frontmatter Fix"
Write-Host "==============================================="
Write-Host ""
Write-Host "Options:"
Write-Host "- Source Directory: $sourceDir"
Write-Host "- Cursor Rules Path: $targetDir"
Write-Host "- Dry Run: $($DryRun.ToString())"
Write-Host "==============================================="
Write-Host ""

# Function to fix a specific MDC file with custom frontmatter
function Fix-MdcFrontmatter {
    param(
        [string]$mdcFilePath,
        [string]$frontmatterFilePath
    )
    
    try {
        # Check if both files exist
        if (-not (Test-Path $mdcFilePath)) {
            Write-Host "  Error: MDC file does not exist: $mdcFilePath" -ForegroundColor Red
            return $false
        }
        
        if (-not (Test-Path $frontmatterFilePath)) {
            Write-Host "  Error: Frontmatter file does not exist: $frontmatterFilePath" -ForegroundColor Red
            return $false
        }
        
        # Get the custom frontmatter
        $customFrontmatter = Get-Content -Path $frontmatterFilePath -Raw
        
        # Get the MDC file content without frontmatter
        $mdcContent = Get-Content -Path $mdcFilePath -Raw
        
        # Remove existing frontmatter
        $mdcContentWithoutFrontmatter = $mdcContent -replace "(?s)^---\r?\n.*?\r?\n---\r?\n", ""
        
        # Combine new frontmatter with content
        $newContent = $customFrontmatter + "`n" + $mdcContentWithoutFrontmatter
        
        # Apply changes
        if (-not $DryRun) {
            Set-Content -Path $mdcFilePath -Value $newContent -NoNewline
            Write-Host "  Updated frontmatter: $mdcFilePath" -ForegroundColor Green
            return $true
        } else {
            Write-Host "  Would update frontmatter: $mdcFilePath" -ForegroundColor Yellow
            return $true
        }
    } catch {
        Write-Host "  Error updating frontmatter: $_" -ForegroundColor Red
        return $false
    }
}

# List of special files to fix
$filesToFix = @(
    @{
        MDCFile = Join-Path $targetDir "00reaper.mdc"
        FrontmatterFile = Join-Path $sourceDir "00reaper.md.frontmatter"
    }
    # Add more files here as needed
)

# Process each file
Write-Host "Processing special frontmatter fixes..." -ForegroundColor Cyan
foreach ($file in $filesToFix) {
    Write-Host "Fixing frontmatter for: $($file.MDCFile)" -ForegroundColor Cyan
    
    $success = Fix-MdcFrontmatter -mdcFilePath $file.MDCFile -frontmatterFilePath $file.FrontmatterFile
    
    if ($success) {
        $updatedFiles += $file.MDCFile
    } else {
        $errorFiles += $file.MDCFile
    }
}

# Generate summary report
$timestamp = Get-Date -Format "yyyy-MM-dd-HHmmss"
$reportFile = Join-Path $reportDir "00os-frontmatter-fix-$timestamp.md"

$report = @"
# 00OS Frontmatter Fix Report

Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Summary
- Mode: $(if ($DryRun) { "Dry Run (no changes made)" } else { "Live Run (changes applied)" })
- Total files processed: $($filesToFix.Count)
- Files updated: $($updatedFiles.Count)
- Errors: $($errorFiles.Count)

## Details

### Updated Files
$(if ($updatedFiles.Count -gt 0) { $updatedFiles -join "`n" } else { "None" })

### Errors
$(if ($errorFiles.Count -gt 0) { $errorFiles -join "`n" } else { "None" })
"@

Set-Content -Path $reportFile -Value $report

# Print summary to console
Write-Host ""
Write-Host "Frontmatter Fix Complete!"
Write-Host "=========================="
Write-Host "Total files processed: $($filesToFix.Count)"
Write-Host "Files updated: $($updatedFiles.Count)" -ForegroundColor $(if ($updatedFiles.Count -gt 0) { "Green" } else { "Gray" })
Write-Host "Errors: $($errorFiles.Count)" -ForegroundColor $(if ($errorFiles.Count -gt 0) { "Red" } else { "Gray" })
Write-Host ""
Write-Host "Report saved to: $reportFile" -ForegroundColor Cyan

# Return results object
return @{
    ProcessedCount = $filesToFix.Count
    UpdatedCount = $updatedFiles.Count
    ErrorCount = $errorFiles.Count
    ReportFile = $reportFile
} 