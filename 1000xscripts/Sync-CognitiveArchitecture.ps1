<#
.SYNOPSIS
    Master synchronization script for 1000xbrain cognitive architecture and Cursor Project Rules.

.DESCRIPTION
    This script performs synchronization between 1000xbrain files and Cursor Project Rules, 
    focusing exclusively on content synchronization.

    The script executes the following processes:
    1. Analyzes differences between 1000xbrain files and Cursor Project Rules
    2. Updates Cursor Project Rules with content from 1000xbrain files
    3. Generates comprehensive reports for all processes

.PARAMETER RootPath
    The root path of the 1000xbrain directory. Defaults to "./1000xbrain" relative to the script location.

.PARAMETER CursorRulesPath
    The path to the Cursor Rules directory. Defaults to "./.cursor/rules" relative to the script location.

.PARAMETER ReportPath
    The path where reports will be saved. Defaults to "./sync-reports".

.PARAMETER DryRun
    If specified, the script will only show what would happen without making any changes.

.PARAMETER SkipCursorRulesSync
    If specified, the script will skip the Cursor Rules synchronization process.

.PARAMETER Force
    If specified, the script will not prompt for confirmation before making changes.

.EXAMPLE
    .\Sync-CognitiveArchitecture.ps1 -DryRun

.EXAMPLE
    .\Sync-CognitiveArchitecture.ps1 -Force

.NOTES
    Author: 1000xdev
    Version: 2.0
#>

param(
    [string]$RootPath = (Join-Path $PSScriptRoot "../1000xbrain"),
    [string]$CursorRulesPath = (Join-Path $PSScriptRoot "../.cursor/rules"),
    [string]$ReportPath = (Join-Path $PSScriptRoot "sync-reports"),
    [switch]$DryRun,
    [switch]$SkipCursorRulesSync,
    [switch]$Force,
    [switch]$Verbose
)

# Script initialization
$startTime = Get-Date
$scriptDir = $PSScriptRoot
$masterReportFile = "cognitive-architecture-sync-report.md"
$syncReportContent = "# 1000xbrain Cognitive Architecture Synchronization Report`n`n"
$syncReportContent += "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`n`n"
$syncReportContent += "## Summary`n`n"
$syncReportContent += "This report summarizes the synchronization process for the 1000xbrain cognitive architecture.`n`n"

Write-Host "==============================================="
Write-Host "1000xbrain Cognitive Architecture Synchronization Tool"
Write-Host "==============================================="
Write-Host ""
Write-Host "Options:"
Write-Host "- Dry Run: $($DryRun.ToString())"
Write-Host "- Skip Cursor Rules Sync: $($SkipCursorRulesSync.ToString())"
Write-Host "- Force: $($Force.ToString())"
Write-Host "- Verbose: $($Verbose.ToString())"
Write-Host "==============================================="
Write-Host ""

# Ensure the reports directory exists
if (-not (Test-Path $ReportPath)) {
    New-Item -ItemType Directory -Path $ReportPath -Force | Out-Null
    Write-Host "Created reports directory: $ReportPath"
}

# Function to run a script and track its status
function Run-Script {
    param (
        [string]$ScriptPath,
        [string]$Description,
        [hashtable]$Parameters
    )
    
    Write-Host "`n==============================================="
    Write-Host "Running: $(Split-Path $ScriptPath -Leaf)"
    Write-Host "Description: $Description"
    Write-Host "Parameters: $($Parameters.Keys -join ', ')"
    Write-Host "===============================================`n"
    
    try {
        # Run the script with splatting
        & $ScriptPath @Parameters
        
        Write-Host "`nScript execution completed successfully."
        return @{
            Status = "Success"
            ScriptName = (Split-Path $ScriptPath -Leaf)
        }
    } catch {
        Write-Host "Error running $(Split-Path $ScriptPath -Leaf): $_" -ForegroundColor Red
        return @{
            Status = "Error"
            ScriptName = (Split-Path $ScriptPath -Leaf)
            Error = $_
        }
    }
}

# Track the execution results
$execResults = @()

# 1. Analyze differences between 1000xbrain files and Cursor Project Rules
$syncParams = @{
    RootPath = $RootPath
    CursorRulesPath = $CursorRulesPath
    ReportPath = $ReportPath
}

$syncResult = Run-Script -ScriptPath "$scriptDir/rules-scripts/Sync-1000xbrainToCursor.ps1" `
                        -Description "Analyzing differences between 1000xbrain files and Cursor Project Rules" `
                        -Parameters $syncParams

$execResults += @{
    Phase = "Cursor Rules Analysis"
    Status = $syncResult.Status
    ScriptName = $syncResult.ScriptName
    Error = $syncResult.Error
}

# 2. Update Cursor Project Rules if not skipped
if (-not $SkipCursorRulesSync) {
    # Prompt for confirmation if not forced or dry run
    if (-not $Force -and -not $DryRun) {
        Write-Host "`nWARNING: This will directly update Cursor Project Rules (.mdc files)." -ForegroundColor Yellow
        Write-Host "These files are typically edited through the Cursor Settings UI." -ForegroundColor Yellow
        $confirm = Read-Host "Are you sure you want to continue? (Y/N)"
        
        if ($confirm -ne "Y" -and $confirm -ne "y") {
            Write-Host "Cursor Rules update cancelled." -ForegroundColor Yellow
            $execResults += @{
                Phase = "Cursor Rules Update"
                Status = "Skipped (User Cancelled)"
                ScriptName = "Update-CursorRules.ps1"
                Error = $null
            }
        } else {
            $updateRulesParams = @{
                RootPath = $RootPath
                CursorRulesPath = $CursorRulesPath
                ReportPath = $ReportPath
                WhatIf = $DryRun
                Force = $Force
            }
            
            $updateRulesResult = Run-Script -ScriptPath "$scriptDir/rules-scripts/Update-CursorRules.ps1" `
                                          -Description "Updating Cursor Project Rules with content from 1000xbrain files" `
                                          -Parameters $updateRulesParams
            
            $execResults += @{
                Phase = "Cursor Rules Update"
                Status = $updateRulesResult.Status
                ScriptName = $updateRulesResult.ScriptName
                Error = $updateRulesResult.Error
            }
        }
    } else {
        $updateRulesParams = @{
            RootPath = $RootPath
            CursorRulesPath = $CursorRulesPath
            ReportPath = $ReportPath
            WhatIf = $DryRun
            Force = $Force
        }
        
        $updateRulesResult = Run-Script -ScriptPath "$scriptDir/rules-scripts/Update-CursorRules.ps1" `
                                      -Description "Updating Cursor Project Rules with content from 1000xbrain files" `
                                      -Parameters $updateRulesParams
        
        $execResults += @{
            Phase = "Cursor Rules Update"
            Status = $updateRulesResult.Status
            ScriptName = $updateRulesResult.ScriptName
            Error = $updateRulesResult.Error
        }
    }
}

# 3. Generate comprehensive sync report
$syncReportContent += "| Phase | Status | Script |\n"
$syncReportContent += "|-------|--------|--------|\n"

foreach ($result in $execResults) {
    $status = if ($result.Status -eq "Success") { "✅ Success" } else { "❌ Error" }
    $syncReportContent += "| $($result.Phase) | $status | $($result.ScriptName) |\n"
}

$syncReportContent += "`n## Execution Information`n`n"
$syncReportContent += "- Start time: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))`n"
$syncReportContent += "- End time: $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))`n"
$syncReportContent += "- Total duration: $([math]::Round(((Get-Date) - $startTime).TotalSeconds, 2)) seconds`n"
$syncReportContent += "- Dry run: $($DryRun.ToString())`n"
$syncReportContent += "- Skip Cursor rules sync: $($SkipCursorRulesSync.ToString())`n"

# Generate report path
$masterReportPath = Join-Path $ReportPath $masterReportFile

# Save the report
$syncReportContent | Out-File -FilePath $masterReportPath -Encoding utf8

Write-Host "`n==============================================="
Write-Host "Cognitive Architecture Synchronization Complete!"
Write-Host "==============================================="
Write-Host ""
Write-Host "Execution Summary:"

foreach ($result in $execResults) {
    $statusColor = if ($result.Status -eq "Success") { "Green" } else { "Red" }
    Write-Host "- $($result.Phase): " -NoNewline
    Write-Host "$($result.Status)" -ForegroundColor $statusColor
}

Write-Host ""
Write-Host "Start time: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))"
Write-Host "End time: $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))"
Write-Host "Total duration: $([math]::Round(((Get-Date) - $startTime).TotalSeconds, 2)) seconds"
Write-Host ""
Write-Host "Master synchronization report saved to: $masterReportPath"
Write-Host ""
Write-Host "Cognitive Architecture synchronization process complete!" 