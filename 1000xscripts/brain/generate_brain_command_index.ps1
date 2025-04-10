# PowerShell Script: generate_brain_command_index.ps1

# Verification function for terminal commands (returns status, reasons, and whether correction was attempted/successful)
function Verify-And-Correct-TerminalCommand {
    param(
        [string]$CommandString,
        [string]$FullFilePath 
    )
    
    $status = "Verified" 
    $reasons = @()
    $correctionAttempted = $false
    $correctionSuccessful = $false
    $originalCommandString = $CommandString # Keep original for comparison/logging

    # Check 1: Incorrect command chaining (&& instead of ;)
    if ($CommandString -match '&&') {
        $status = "Failed"
        $reasons += "Uses '&&' for command chaining instead of ';'."
        Write-Host "Attempting correction: Replacing '&&' with ';' in '$FullFilePath'" -ForegroundColor Yellow
        $correctionAttempted = $true
        try {
            $currentContent = Get-Content -Path $FullFilePath -Raw
            # More specific replacement to target only within the run_terminal_cmd's command="..."
            $patternToFind = [regex]'(?s)(run_terminal_cmd\(.*?command\s*=\s*")(.*?)(")'
            $match = $patternToFind.Match($currentContent)
            if ($match.Success) {
                $cmdContent = $match.Groups[2].Value
                $correctedCmdContent = $cmdContent -replace '&&', ';'
                $newContent = $currentContent.Substring(0, $match.Groups[2].Index) + $correctedCmdContent + $currentContent.Substring($match.Groups[2].Index + $match.Groups[2].Length)
                
                # Write corrected content back to file
                Set-Content -Path $FullFilePath -Value $newContent -Force
                $correctionSuccessful = $true
                $reasons += "Auto-corrected '&&' to ';'."
                $status = "Verified" # Mark as verified if corrected
                Write-Host "Correction successful for '&&' in '$FullFilePath'" -ForegroundColor Green
            } else {
                 throw "Could not find command string within run_terminal_cmd using regex."
            }
        } catch {
            Write-Host "Correction failed for '&&' in '$FullFilePath': $($_.Exception.Message)" -ForegroundColor Red
            $correctionSuccessful = $false
             $reasons += "Auto-correction FAILED for '&&'."
             # Status remains "Failed"
        }
    }

    # Check 2: Commands potentially needing '| cat' (Only check if not already failed or if correction failed)
    if (($status -eq "Verified" -or $status -eq "NeedsReview") -and !$correctionAttempted) { # Avoid checking if already corrected '&&' in this pass
        $pagerCommands = @('git diff', 'git log', 'git show', 'less', 'more', 'head', 'tail') 
        foreach ($pagerCmd in $pagerCommands) {
            if (($CommandString.Trim() -like "$pagerCmd*") -and ($CommandString.Trim() -notlike '*| cat')) {
                if ($status -ne "Failed") { $status = "NeedsReview" } 
                $reasons += "Command '$pagerCmd' might need '| cat' appended."
                 Write-Host "Attempting correction: Appending '| cat' in '$FullFilePath'" -ForegroundColor Yellow
                 $correctionAttempted = $true
                 try {
                    $currentContent = Get-Content -Path $FullFilePath -Raw
                    $patternToFind = [regex]'(?s)(run_terminal_cmd\(.*?command\s*=\s*")(.*?)(")'
                    $match = $patternToFind.Match($currentContent)
                    if ($match.Success) {
                        $cmdContent = $match.Groups[2].Value
                        if (($cmdContent.Trim() -like "$pagerCmd*") -and ($cmdContent.Trim() -notlike '*| cat')) { # Double check the found command
                            $correctedCmdContent = $cmdContent + " | cat"
                            $newContent = $currentContent.Substring(0, $match.Groups[2].Index) + $correctedCmdContent + $currentContent.Substring($match.Groups[2].Index + $match.Groups[2].Length)
                            Set-Content -Path $FullFilePath -Value $newContent -Force
                            $correctionSuccessful = $true
                            $reasons += "Auto-appended '| cat'."
                            $status = "Verified" # Mark as verified if corrected
                            Write-Host "Correction successful for '| cat' in '$FullFilePath'" -ForegroundColor Green
                        } else {
                             # The specific command within run_terminal_cmd didn't match the pager command, skip correction
                             Write-Host "Skipping '| cat' correction for '$FullFilePath', command '$cmdContent' did not match '$pagerCmd*'" -ForegroundColor Cyan
                        }
                    } else {
                        throw "Could not find command string within run_terminal_cmd using regex."
                    }

                 } catch {
                    Write-Host "Correction failed for '| cat' in '$FullFilePath': $($_.Exception.Message)" -ForegroundColor Red
                    $correctionSuccessful = $false
                    $reasons += "Auto-correction FAILED for '| cat'."
                    if ($status -ne "Failed") { $status = "NeedsReview" } # Keep NeedsReview status
                 }
                 break 
            }
        }
    }
    
    # Add more checks here as needed...

    return @{ 
        Status = $status; 
        Reasons = $reasons; 
        CorrectionAttempted = $correctionAttempted; 
        CorrectionSuccessful = $correctionSuccessful 
    }
}

# Get the directory of the current script
$ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define relative paths
$CommandsDirRelative = "../../1000xcommands/brain"
$IndexFileRelative = "../../1000xplans/brain/commands-index.md"

# Construct absolute paths
$CommandsDir = Join-Path -Path $ScriptDirectory -ChildPath $CommandsDirRelative -Resolve
$IndexFile = Join-Path -Path $ScriptDirectory -ChildPath $IndexFileRelative -Resolve

# Get current timestamp
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Initialize Markdown content array
$MarkdownContent = @()
$MarkdownContent += "# Brain Domain Command Index"
$MarkdownContent += ""
$MarkdownContent += "*Generated by `1000xscripts/brain/generate_brain_command_index.ps1` on $Timestamp*"
# $MarkdownContent += "*Run ``run command:scripts/generate-brain-command-index`` to update this list.*" # Command to run this doesn't exist yet
$MarkdownContent += "*Run this script (`./generate_brain_command_index.ps1`) from the `1000xscripts/brain/` directory to update.*"
$MarkdownContent += ""
$MarkdownContent += "## Status Legend"
$MarkdownContent += "- `[a]` Auto-Verified: Passed all automated checks."
$MarkdownContent += "- `[?]` Needs Review: Passed basic checks but contains elements requiring manual review (see notes)."
$MarkdownContent += "- `[!]` Failed Auto-Check: Failed one or more automated checks (see notes)."
$MarkdownContent += "- `[n/a]` No Terminal Cmd: No `run_terminal_cmd` calls found in the command file."
$MarkdownContent += ""
$MarkdownContent += "## Commands & Verification Status"
$MarkdownContent += ""

# Regex to find run_terminal_cmd calls and extract the command parameter
$runCmdRegex = [regex]'(?s)run_terminal_cmd\(.*?command\s*=\s*"(?<command>.*?)"'

# Find all .md files in the commands directory, excluding .gitkeep
$commandFiles = Get-ChildItem -Path $CommandsDir -Filter *.md | Where-Object { $_.Name -ne ".gitkeep" }

if ($commandFiles.Count -eq 0) {
    $MarkdownContent += "*No commands found in '$($CommandsDirRelative)'.*"
} else {
    $correctionSummary = @{ Attempted = 0; Successful = 0; Failed = 0 }
    foreach ($file in $commandFiles) {
        $CommandName = $file.BaseName
        $FilePath = $file.FullName
        $FileContent = Get-Content -Path $FilePath -Raw
        
        $matches = $runCmdRegex.Matches($FileContent)
        
        $fileStatus = "Verified" # Overall status for the file
        $fileReasons = @()      # Combined reasons for the file
        $hasTerminalCmd = $false
        $fileCorrectionAttempted = $false
        $fileCorrectionSuccessful = $false 

        if ($matches.Count -gt 0) {
            $hasTerminalCmd = $true
            # Note: This assumes only one run_terminal_cmd per file for simplicity of correction logic. 
            # If multiple exist, only the first match will be corrected by this script.
            $match = $matches[0] 
            $commandString = $match.Groups["command"].Value
            
            # Perform verification and attempt correction
            $verificationResult = Verify-And-Correct-TerminalCommand -CommandString $commandString -FullFilePath $FilePath
            
            $fileStatus = $verificationResult.Status
            $fileReasons = $verificationResult.Reasons
            if ($verificationResult.CorrectionAttempted) {
                $fileCorrectionAttempted = $true
                $correctionSummary.Attempted++
                if ($verificationResult.CorrectionSuccessful) {
                    $fileCorrectionSuccessful = $true
                    $correctionSummary.Successful++
                    # If correction was successful, re-read the file content to get the updated command string for any further checks (if added later)
                    # $FileContent = Get-Content -Path $FilePath -Raw 
                } else {
                    $correctionSummary.Failed++
                }
            }
            
            # Aggregate status logic (already handled within Verify-And-Correct-TerminalCommand)
            
        } # End if ($matches.Count -gt 0)

        # Determine final status marker
        $statusMarker = "[n/a]"
        if ($hasTerminalCmd) {
            switch ($fileStatus) {
                "Verified"    { $statusMarker = "[a]" }
                "NeedsReview" { $statusMarker = "[?]" }
                "Failed"      { $statusMarker = "[!]" }
            }
        }
        
        # Format output line
        $outputLine = "- $statusMarker $CommandName - ``run command:brain/$CommandName``"
        if ($fileReasons.Count -gt 0) {
             $outputLine += " # Notes: " + ($fileReasons -join '; ')
        }

        $MarkdownContent += $outputLine
    } # End foreach ($file in $commandFiles)
}

# Write the content to the index file, overwriting existing content
Set-Content -Path $IndexFile -Value ($MarkdownContent -join [Environment]::NewLine)

Write-Host "Successfully generated command index with automated verification/correction at '$($IndexFileRelative)'"
Write-Host "Corrections Summary: Attempted=$($correctionSummary.Attempted), Successful=$($correctionSummary.Successful), Failed=$($correctionSummary.Failed)"
Write-Host "Review commands marked '[?]' or '[!]' in the index file, especially those where correction failed." 