<#
.SYNOPSIS
    Removes old synchronization report files.

.DESCRIPTION
    This script removes all .md files from the sync-reports directory,
    keeping only a specified number of the most recent reports.

.PARAMETER ReportPath
    The path to the sync reports directory. Defaults to "./sync-reports".

.PARAMETER KeepCount
    The number of most recent reports to keep. Defaults to 5.

.EXAMPLE
    .\Clean-SyncReports.ps1

.EXAMPLE
    .\Clean-SyncReports.ps1 -KeepCount 10

.NOTES
    Author: 1000xdev
    Version: 1.0
#>
param(
    [string]$ReportPath = (Join-Path $PSScriptRoot "sync-reports"),
    [int]$KeepCount = 5
)

Write-Host "Cleaning synchronization reports in: $ReportPath"
Write-Host "Keeping the $KeepCount most recent reports."

# Check if the report path exists
if (-not (Test-Path $ReportPath)) {
    Write-Host "Report directory not found: $ReportPath" -ForegroundColor Yellow
    exit 0
}

# Get all report files, sort by creation time descending
$reportFiles = Get-ChildItem -Path $ReportPath -Filter "sync-results-*.md" | Sort-Object CreationTime -Descending

$totalFiles = $reportFiles.Count
Write-Host "Found $totalFiles report files."

# Determine files to delete
$filesToDelete = $reportFiles | Select-Object -Skip $KeepCount

$deleteCount = $filesToDelete.Count

if ($deleteCount -gt 0) {
    Write-Host "Deleting $deleteCount old reports..." -ForegroundColor Yellow
    foreach ($file in $filesToDelete) {
        try {
            Remove-Item -Path $file.FullName -Force -ErrorAction Stop
            Write-Host "  Deleted: $($file.Name)" -ForegroundColor Gray
        } catch {
            Write-Host "  Error deleting $($file.Name): $_" -ForegroundColor Red
        }
    }
    Write-Host "Finished deleting $deleteCount reports." -ForegroundColor Green
} else {
    Write-Host "No old reports found to delete." -ForegroundColor Green
}

Write-Host "Cleanup complete." 