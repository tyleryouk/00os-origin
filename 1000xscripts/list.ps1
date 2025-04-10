<#
.SYNOPSIS
    Wrapper script to execute the system command index generation script.
.DESCRIPTION
    This script provides a convenient way to run the command index generation
    located in the 'system' subdirectory. It simply calls the target script,
    passing along any arguments.
#>
param() # No parameters defined for the wrapper itself

# Get the directory where this wrapper script resides
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Construct the full path to the target script
$TargetScriptPath = Join-Path -Path $ScriptRoot -ChildPath "system/generate_brain_command_index.ps1"

# Check if the target script exists
if (-not (Test-Path -Path $TargetScriptPath -PathType Leaf)) {
    Write-Error "Target script not found at '$TargetScriptPath'. Ensure the script exists and the path is correct."
    exit 1
}

# Execute the target script, passing along any arguments provided to the wrapper
try {
    Write-Host "Executing: $TargetScriptPath" -ForegroundColor Cyan
    & $TargetScriptPath @args
    Write-Host "Target script finished." -ForegroundColor Green
} catch {
    Write-Error "Error executing target script '$TargetScriptPath': $_"
    exit 1
} 