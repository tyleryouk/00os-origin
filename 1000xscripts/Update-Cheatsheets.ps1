<#
.SYNOPSIS
    Wrapper script to update all workflow cheatsheets.

.DESCRIPTION
    This script serves as a wrapper for the Update-WorkflowCheatsheets.ps1 script
    in the report-scripts directory. It handles the new folder structure in 
    1000xbrain/parameters/rules/ where files are now organized in subfolders.

.NOTES
    File Name : Update-Cheatsheets.ps1
    Author    : 1000xdev
    Updated   : Current Date
#>

# Get the current script directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$workspaceRoot = $scriptPath
$reportScriptsDir = Join-Path $workspaceRoot "report-scripts"
$cheatsheetScript = Join-Path $reportScriptsDir "Update-WorkflowCheatsheets.ps1"

Write-Host "=== Workflow Cheatsheet Update ==="
Write-Host "Starting cheatsheet update process..."
Write-Host "Script location: $cheatsheetScript"

# Check if the script exists
if (-not (Test-Path $cheatsheetScript)) {
    Write-Error "ERROR: Cheatsheet script not found at expected location: $cheatsheetScript"
    exit 1
}

# Execute the script
try {
    & $cheatsheetScript
    
    if ($LASTEXITCODE -ne 0) {
        Write-Error "ERROR: Cheatsheet script returned exit code $LASTEXITCODE"
        exit $LASTEXITCODE
    }
    
    Write-Host "Cheatsheet update completed successfully!"
} catch {
    Write-Error "ERROR: An exception occurred while running the cheatsheet script: $_"
    exit 1
}

Write-Host "=== Cheatsheet update process complete ===" 