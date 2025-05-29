# Reset-Cycle.ps1
# 1000xdev Cycle Reset Script (Step 6 Automation)
#
# Moves the current active-request.md and 1000xdev/cycle-status.md to a timestamped archive folder,
# then copies fresh templates to reset the cycle for the next iteration.
#
# Usage: Run from the root of the GigaSwap workspace.
#
# Author: 1000xdev

param()

# Set paths
$Root = "$PSScriptRoot/../.." | Resolve-Path
$Planning = Join-Path $Root '1000xdev/planning'
$Templates = Join-Path $Planning 'templates'
$Archive = Join-Path $Planning 'archive'
$DevRoot = Join-Path $Root '1000xdev'

# Timestamp for archive folder
$Timestamp = Get-Date -Format 'yyyy-MM-dd-HHmmss'
$ArchiveFolder = Join-Path $Archive $Timestamp

# Files to move and reset
$ActiveRequest = Join-Path $Planning 'active-request.md'
$CycleStatus = Join-Path $DevRoot 'cycle-status.md'
$TODO = Join-Path $DevRoot 'TODO.md'
$ActiveRequestTemplate = Join-Path $Templates 'active-request-template.md'
$CycleStatusTemplate = Join-Path $Templates 'cycle-status-template.md'
$TODOTemplate = Join-Path $Templates 'TODO-template.md'

# Create archive folder if it doesn't exist
if (!(Test-Path $Archive)) {
    New-Item -ItemType Directory -Path $Archive | Out-Null
    Write-Host "Created archive directory: $Archive"
}

# Create timestamped archive folder
if (!(Test-Path $ArchiveFolder)) {
    New-Item -ItemType Directory -Path $ArchiveFolder | Out-Null
    Write-Host "Created archive folder: $ArchiveFolder"
}

# Move current files to archive with error handling
try {
    if (Test-Path $ActiveRequest) {
        Copy-Item $ActiveRequest (Join-Path $ArchiveFolder 'active-request.md') -ErrorAction Stop
        Write-Host "Copied active-request.md to $ArchiveFolder"
    } else {
        Write-Host "WARNING: active-request.md not found at $ActiveRequest"
    }
} catch {
    Write-Host "ERROR: Failed to copy active-request.md: $_"
}

try {
    if (Test-Path $CycleStatus) {
        Copy-Item $CycleStatus (Join-Path $ArchiveFolder 'cycle-status.md') -ErrorAction Stop
        Write-Host "Copied cycle-status.md to $ArchiveFolder"
    } else {
        Write-Host "WARNING: cycle-status.md not found at $CycleStatus"
    }
} catch {
    Write-Host "ERROR: Failed to copy cycle-status.md: $_"
}

try {
    if (Test-Path $TODO) {
        Copy-Item $TODO (Join-Path $ArchiveFolder 'TODO.md') -ErrorAction Stop
        Write-Host "Copied TODO.md to $ArchiveFolder"
    } else {
        Write-Host "WARNING: TODO.md not found at $TODO"
    }
} catch {
    Write-Host "ERROR: Failed to copy TODO.md: $_"
}

# Copy templates to reset files
try {
    if (Test-Path $ActiveRequestTemplate) {
        Copy-Item $ActiveRequestTemplate $ActiveRequest -Force
        Write-Host "Copied active-request-template.md to active-request.md"
    } else {
        Write-Host "ERROR: Template not found at $ActiveRequestTemplate"
    }
} catch {
    Write-Host "ERROR: Failed to reset active-request.md: $_"
}

try {
    if (Test-Path $CycleStatusTemplate) {
        Copy-Item $CycleStatusTemplate $CycleStatus -Force
        Write-Host "Copied cycle-status-template.md to 1000xdev/cycle-status.md"
    } else {
        Write-Host "ERROR: Template not found at $CycleStatusTemplate"
    }
} catch {
    Write-Host "ERROR: Failed to reset cycle-status.md: $_"
}

try {
    if (Test-Path $TODOTemplate) {
        Copy-Item $TODOTemplate $TODO -Force
        Write-Host "Copied TODO-template.md to 1000xdev/TODO.md"
    } else {
        Write-Host "ERROR: Template not found at $TODOTemplate"
    }
} catch {
    Write-Host "ERROR: Failed to reset TODO.md: $_"
}

Write-Host "Cycle reset complete. Ready for the next cycle." 