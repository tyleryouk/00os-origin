<#
.SYNOPSIS
    Removes all index.md files from the 1000xbrain directory.

.DESCRIPTION
    This script finds and removes all index.md files in the 1000xbrain directory
    and all its subdirectories. This is useful for cleaning up before selectively
    generating index files only where they are truly needed.

.PARAMETER TargetPath
    The target path where to find and remove index.md files.
    Default is the 1000xbrain directory.

.PARAMETER DryRun
    If specified, the script will only report which files would be deleted
    without actually deleting them.

.EXAMPLE
    .\Remove-AllIndexFiles.ps1
    
.EXAMPLE
    .\Remove-AllIndexFiles.ps1 -DryRun
#>

param(
    [string]$TargetPath = (Join-Path (Split-Path $PSScriptRoot -Parent) "1000xbrain"),
    [switch]$DryRun
)

Write-Host "=========================================="
Write-Host "Index.md File Removal Tool"
Write-Host "=========================================="
Write-Host "Target Path: $TargetPath"
Write-Host "Dry Run: $DryRun"
Write-Host "=========================================="
Write-Host ""

# Find all index.md files
$indexFiles = Get-ChildItem -Path $TargetPath -Filter "index.md" -Recurse -File

Write-Host "Found $($indexFiles.Count) index.md files in $TargetPath"

# Track results
$deleted = 0
$failed = 0

# Process each file
foreach ($file in $indexFiles) {
    if ($DryRun) {
        Write-Host "Would delete: $($file.FullName)" -ForegroundColor Yellow
    } else {
        try {
            Remove-Item -Path $file.FullName -Force
            Write-Host "Deleted: $($file.FullName)" -ForegroundColor Green
            $deleted++
        } catch {
            Write-Host "Failed to delete: $($file.FullName) - $_" -ForegroundColor Red
            $failed++
        }
    }
}

# Summary
Write-Host ""
Write-Host "Removal Operation Complete"
Write-Host "------------------------"
if ($DryRun) {
    Write-Host "Would delete: $($indexFiles.Count) files" -ForegroundColor Yellow
} else {
    Write-Host "Successfully deleted: $deleted files" -ForegroundColor Green
    if ($failed -gt 0) {
        Write-Host "Failed to delete: $failed files" -ForegroundColor Red
    }
} 