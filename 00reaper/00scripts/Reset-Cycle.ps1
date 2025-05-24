# Reset-Cycle.ps1
# 00reaper Cycle Reset Script (Step 6 Automation)
#
# Moves the current active-request.md and 00reaper/cycle-status.md to a timestamped archive folder,
# then copies fresh templates to reset the cycle for the next iteration.
#
# Usage: Run from the root of the GigaSwap workspace.
#
# Author: 00reaper

param()

# Set paths
$Root = "$PSScriptRoot/../.." | Resolve-Path
$Planning = Join-Path $Root '00reaper/planning'
$Templates = Join-Path $Planning 'templates'
$Archive = Join-Path $Planning 'archive'
$Reaper = Join-Path $Root '00reaper'

# Timestamp for archive folder
$Timestamp = Get-Date -Format 'yyyy-MM-dd-HHmmss'
$ArchiveFolder = Join-Path $Archive $Timestamp

# Files to move and reset
$ActiveRequest = Join-Path $Planning 'active-request.md'
$CycleStatus = Join-Path $Reaper 'cycle-status.md'
$ActiveRequestTemplate = Join-Path $Templates 'active-request-template.md'
$CycleStatusTemplate = Join-Path $Templates 'cycle-status-template.md'

# Create archive folder
if (!(Test-Path $ArchiveFolder)) {
    New-Item -ItemType Directory -Path $ArchiveFolder | Out-Null
}

# Move current files to archive with error handling
try {
    if (Test-Path $ActiveRequest) {
        Move-Item $ActiveRequest (Join-Path $ArchiveFolder 'active-request.md') -ErrorAction Stop
        Write-Host "Moved active-request.md to $ArchiveFolder"
    }
} catch {
    Write-Host "ERROR: Failed to move active-request.md: $_"
}

try {
    if (Test-Path $CycleStatus) {
        Move-Item $CycleStatus (Join-Path $ArchiveFolder 'cycle-status.md') -ErrorAction Stop
        Write-Host "Moved cycle-status.md to $ArchiveFolder"
        if (Test-Path $CycleStatus) {
            Write-Host "ERROR: cycle-status.md still exists in 00reaper/ after move. Check for file lock or permissions."
        }
    }
} catch {
    Write-Host "ERROR: Failed to move cycle-status.md: $_"
}

# Copy templates to reset files
Copy-Item $ActiveRequestTemplate $ActiveRequest
Write-Host "Copied active-request-template.md to active-request.md"
Copy-Item $CycleStatusTemplate $CycleStatus
Write-Host "Copied cycle-status-template.md to 00reaper/cycle-status.md"

Write-Host "Cycle reset complete. Ready for the next cycle." 