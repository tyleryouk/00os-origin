<#
.SYNOPSIS
    Wrapper script to update the master workflow cheatsheet.

.DESCRIPTION
    This script serves as a wrapper for the Update-WorkflowCheatsheets.ps1 script
    in the report-scripts directory. It now extracts pathway information from 
    parameter file headers with the format:
    # workflow: [workflow-type] | pathway: [pathway-name] | message-command: [message-command] | 
    standard-parameter(s): [standard-parameter] | project-rule-parameter-filepath: [project-rule-parameter-filepath]
    
    The script now only generates the master cheatsheet (cs.md) and groups parameters by pathway.

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

Write-Host "=== Master Workflow Cheatsheet Update ==="
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
    
    Write-Host "Master cheatsheet update completed successfully!"
} catch {
    Write-Error "ERROR: An exception occurred while running the cheatsheet script: $_"
    exit 1
}

Write-Host "=== Cheatsheet update process complete ===" 