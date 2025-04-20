# Sync-00OS-Complete.ps1
<#
.SYNOPSIS
    Performs complete 00OS to Cursor Rules synchronization with rule type updates.

.DESCRIPTION
    This script runs the Sync-00OS process to sync content from 00os markdown files
    to Cursor Project Rules (.mdc files), then runs the Update-MdcRuleTypes script
    to ensure all rule types are properly set.

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
    .\Sync-00OS-Complete.ps1 -DryRun

.EXAMPLE
    .\Sync-00OS-Complete.ps1 -RemoveOrphans

.NOTES
    Author: 00reaper
    Version: 1.0
#>

param(
    [string]$RootPath = (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) "00os"),
    [switch]$DryRun,
    [switch]$DetectOrphans,
    [switch]$RemoveOrphans
)

# Get correct paths
$scriptDir = $PSScriptRoot
$rootDir = Split-Path -Parent $scriptDir # This is 00reaper
$parentDir = Split-Path -Parent $rootDir # This is the project root
$cursorRulesPath = Join-Path $parentDir ".cursor\rules"
$ruleTypesScript = Join-Path (Join-Path $scriptDir "rules-scripts") "Update-MdcRuleTypes.ps1"

# Ensure the rule types script exists
if (-not (Test-Path $ruleTypesScript)) {
    Write-Error "Rule types update script not found: $ruleTypesScript"
    exit 1
}

# Display banner
Write-Host "==============================================="
Write-Host "00OS to Cursor Rules Complete Synchronization"
Write-Host "==============================================="
Write-Host ""
Write-Host "Options:"
Write-Host "- Source Directory: $RootPath"
Write-Host "- Cursor Rules Path: $cursorRulesPath"
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

# Step 1: Run Sync-00OS
Write-Host "Step 1: Running 00OS content synchronization..." -ForegroundColor Cyan
$syncParams = @{
    RootPath = $RootPath
    DryRun = $DryRun
    DetectOrphans = $DetectOrphans
    RemoveOrphans = $RemoveOrphans
}

$syncScript = Join-Path $PSScriptRoot "Sync-00OS.ps1"
if (-not (Test-Path $syncScript)) {
    Write-Error "Sync script not found: $syncScript"
    exit 1
}

$syncResults = & $syncScript @syncParams

# Step 2: Run Update-MdcRuleTypes
Write-Host ""
Write-Host "Step 2: Updating rule types for all .mdc files..." -ForegroundColor Cyan

$ruleTypeParams = @{
    CursorRulesPath = $cursorRulesPath
    WhatIf = $DryRun
    Force = $true  # Skip confirmation prompt
}

$updateResults = & $ruleTypesScript @ruleTypeParams

# Generate final summary
Write-Host ""
Write-Host "Complete Synchronization Summary" -ForegroundColor Green
Write-Host "================================="
Write-Host "Content Synchronization:"
Write-Host "- Files processed: $($syncResults.ProcessedCount)"
Write-Host "- Files updated: $($syncResults.UpdatedCount)"
Write-Host "- Files created: $($syncResults.CreatedCount)"
Write-Host "- Files skipped: $($syncResults.SkippedCount)"
Write-Host "- Errors: $($syncResults.ErrorCount)"

Write-Host ""
Write-Host "Rule Type Updates:"
Write-Host "- Files processed: $($updateResults.ProcessedCount)"
Write-Host "- Files updated: $($updateResults.UpdatedCount)"
Write-Host "- Files unchanged: $($updateResults.UnchangedCount)"
Write-Host "- Errors: $($updateResults.ErrorCount)"

Write-Host ""
Write-Host "Sync report: $($syncResults.ReportFile)"

# Final status message
if ($DryRun) {
    Write-Host "`nDry run completed. No changes were made." -ForegroundColor Yellow
} else {
    Write-Host "`nComplete synchronization finished successfully!" -ForegroundColor Green
} 