# PowerShell Script: generate_brain_command_index.ps1
# Renamed Context: Should probably be generate_system_command_index.ps1 and located in 1000xscripts/system/

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
$ProjectRoot = Join-Path -Path $ScriptDirectory -ChildPath "../../" -Resolve
$CommandsRoot = Join-Path -Path $ProjectRoot -ChildPath "1000xcommands" -Resolve

# Define relative paths based on project root
$CommandsDirRelative = "1000xcommands/system"
$IndexFileRelative = "1000xplans/system/commands-index.md"

# Construct absolute paths
$CommandsDir = Join-Path -Path $ProjectRoot -ChildPath $CommandsDirRelative -Resolve
$IndexFile = Join-Path -Path $ProjectRoot -ChildPath $IndexFileRelative -Resolve

# Get current timestamp
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Initialize Markdown content array
$MarkdownContent = @()
$MarkdownContent += "# System Domain Command Index"
$MarkdownContent += ""
$MarkdownContent += "*Generated by `1000xscripts\system\generate_brain_command_index.ps1` on $Timestamp*"
$MarkdownContent += "*Run the wrapper script .\list.ps1 from the `1000xscripts/` directory to update.*" # TODO: Update path/command ref
$MarkdownContent += ""
$MarkdownContent += "## Status Legend"
$MarkdownContent += "- `[a]` Auto-Verified: Passed all automated checks."
$MarkdownContent += "- `[?]` Needs Review: Passed basic checks but contains elements requiring manual review (see notes)."
$MarkdownContent += "- `[!]` Failed Auto-Check: Failed one or more automated checks (see notes)."
$MarkdownContent += "- `[n/a]` No Terminal Cmd: No `run_terminal_cmd` calls found in the command file."
$MarkdownContent += ""
# $MarkdownContent += "## Commands & Verification Status"
# $MarkdownContent += ""

# Regex to find run_terminal_cmd calls and extract the command parameter
$runCmdRegex = [regex]'(?s)run_terminal_cmd\(.*?command\s*=\s*"(?<command>.*?)"'

# Find all .md files in the commands directory recursively, excluding .gitkeep
$commandFiles = Get-ChildItem -Path $CommandsDir -Filter *.md -Recurse | Where-Object { $_.Name -ne ".gitkeep" }

if ($commandFiles.Count -eq 0) {
    $MarkdownContent += "*No commands found in '$($CommandsDirRelative)'.*"
} else {
    $correctionSummary = @{ Attempted = 0; Successful = 0; Failed = 0 }
    
    # Group files by directory
    $groupedFiles = @{}
    $rootFiles = @()
    
    foreach ($file in $commandFiles) {
        $CommandName = $file.BaseName
        $FilePath = $file.FullName
        # Calculate relative path from $CommandsRoot for the run command syntax
        $RelativePath = $FilePath.Substring($CommandsRoot.Length).TrimStart('\','/')
        $CommandRunPath = $RelativePath -replace '\.md$', '' -replace '\\', '/' # Remove .md and normalize slashes
        
        # Get parent folder path relative to the system commands folder
        $parentPath = Split-Path -Parent $RelativePath
        
        if ($parentPath -eq "system") {
            # This is a root level command
            $rootFiles += @{
                Name = $CommandName
                Path = $FilePath
                RelativePath = $RelativePath
                RunPath = $CommandRunPath
            }
        } else {
            # Get the subfolder name
            $subfolder = $parentPath -replace '^system[/\\]', ''
            
            if (-not $groupedFiles.ContainsKey($subfolder)) {
                $groupedFiles[$subfolder] = @()
            }
            
            $groupedFiles[$subfolder] += @{
                Name = $CommandName
                Path = $FilePath
                RelativePath = $RelativePath
                RunPath = $CommandRunPath
            }
        }
    }
    
    # First add root commands section
    if ($rootFiles.Count -gt 0) {
        $MarkdownContent += "## Root Commands"
        $MarkdownContent += ""
        
        # Sort root files by name
        $sortedRootFiles = $rootFiles | Sort-Object { $_.Name }
        
        foreach ($file in $sortedRootFiles) {
            $CommandName = $file.Name
            $FilePath = $file.Path
            $CommandRunPath = $file.RunPath
            
            $FileContent = Get-Content -Path $FilePath -Raw
            
            $matches = $runCmdRegex.Matches($FileContent)
            
            $fileStatus = "Verified" # Overall status for the file
            $fileReasons = @()      # Combined reasons for the file
            $hasTerminalCmd = $false
            $fileCorrectionAttempted = $false
            $fileCorrectionSuccessful = $false 

            if ($matches.Count -gt 0) {
                $hasTerminalCmd = $true
                # Process the command verification same as before
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
                    } else {
                        $correctionSummary.Failed++
                    }
                }
            }

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
            $outputLine = "- $statusMarker $CommandName - ``run command:$CommandRunPath``"
            if ($fileReasons.Count -gt 0) {
                $outputLine += " # Notes: " + ($fileReasons -join '; ')
            }

            $MarkdownContent += $outputLine
        }
    }
    
    # Now process each subfolder group
    foreach ($subfolder in ($groupedFiles.Keys | Sort-Object)) {
        $MarkdownContent += ""
        $MarkdownContent += "## $($subfolder.Substring(0,1).ToUpper() + $subfolder.Substring(1)) Commands"
        $MarkdownContent += ""
        
        # Sort files within each subfolder
        $sortedFiles = $groupedFiles[$subfolder] | Sort-Object { $_.Name }
        
        foreach ($file in $sortedFiles) {
            $CommandName = $file.Name
            $FilePath = $file.Path
            $CommandRunPath = $file.RunPath
            
            $FileContent = Get-Content -Path $FilePath -Raw
            
            $matches = $runCmdRegex.Matches($FileContent)
            
            $fileStatus = "Verified" # Overall status for the file
            $fileReasons = @()      # Combined reasons for the file
            $hasTerminalCmd = $false
            $fileCorrectionAttempted = $false
            $fileCorrectionSuccessful = $false 

            if ($matches.Count -gt 0) {
                $hasTerminalCmd = $true
                # Process the command verification same as before
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
                    } else {
                        $correctionSummary.Failed++
                    }
                }
            }

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
            $outputLine = "- $statusMarker $CommandName - ``run command:$CommandRunPath``"
            if ($fileReasons.Count -gt 0) {
                $outputLine += " # Notes: " + ($fileReasons -join '; ')
            }

            $MarkdownContent += $outputLine
        }
    }
}

# Write the content to the index file, overwriting existing content
Set-Content -Path $IndexFile -Value ($MarkdownContent -join [Environment]::NewLine)

Write-Host "Successfully generated command index with automated verification/correction at '$($IndexFileRelative)'"
Write-Host "Corrections Summary: Attempted=$($correctionSummary.Attempted), Successful=$($correctionSummary.Successful), Failed=$($correctionSummary.Failed)"
Write-Host "Review commands marked '[?]' or '[!]' in the index file, especially those where correction failed." 