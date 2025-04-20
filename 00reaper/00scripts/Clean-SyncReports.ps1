# Clean-SyncReports.ps1
<#
.SYNOPSIS
    Cleans up old synchronization report files.

.DESCRIPTION
    This script removes old synchronization report files from the sync-reports
    directory, keeping only the most recent ones.

.PARAMETER ReportDir
    The directory containing sync reports. Defaults to "./sync-reports".

.PARAMETER MaxReports
    The maximum number of report files to keep. Defaults to 10.

.EXAMPLE
    .\Clean-SyncReports.ps1

.EXAMPLE
    .\Clean-SyncReports.ps1 -MaxReports 5

.NOTES
    Author: 00reaper
    Version: 1.0
#>

param(
    [string]$ReportDir = (Join-Path $PSScriptRoot "sync-reports"),
    [int]$MaxReports = 10
)

# Check if reports directory exists
if (-not (Test-Path $ReportDir)) {
    Write-Host "Reports directory not found: $ReportDir" -ForegroundColor Yellow
    exit 0
}

# Get all report files
$reportFiles = Get-ChildItem -Path $ReportDir -Filter "00os-sync-results-*.md" | Sort-Object LastWriteTime -Descending

# Check if we have more than the maximum
if ($reportFiles.Count -le $MaxReports) {
    Write-Host "Only $($reportFiles.Count) report files found. No cleanup needed."
    exit 0
}

# Keep the most recent files and delete the rest
$filesToDelete = $reportFiles | Select-Object -Skip $MaxReports

Write-Host "Cleaning up old sync reports..."
Write-Host "Keeping $MaxReports most recent reports"
Write-Host "Deleting $($filesToDelete.Count) old reports"

foreach ($file in $filesToDelete) {
    Write-Host "  Removing: $($file.Name)" -ForegroundColor Gray
    Remove-Item $file.FullName -Force
}

Write-Host "Cleanup completed." 