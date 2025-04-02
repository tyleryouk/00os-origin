<#
.SYNOPSIS
    Automatically updates workflow cheatsheets based on project-rule-parameters.

.DESCRIPTION
    This script scans the 1000xbrain/parameters directory to find project-rule-parameters
    and updates the workflow cheatsheets with this information.
    It focuses on front-end-workflow and rules-workflow cheatsheets.

.NOTES
    File Name      : Update-WorkflowCheatsheets.ps1
    Author         : 1000xdev
#>

# Script Configuration
$scriptRoot = $PSScriptRoot
$workspaceRoot = Split-Path -Parent (Split-Path -Parent $scriptRoot)
$rootDirectory = Join-Path $workspaceRoot "1000xbrain"
$planningDirectory = Join-Path $workspaceRoot "planning"
$workflowsDirectory = Join-Path $rootDirectory "workflows"
$parametersDirectory = Join-Path $rootDirectory "parameters"

$frontEndWorkflowCheatsheetPath = Join-Path $workflowsDirectory "front-end-workflow\front-end-workflow-cheatsheet.md"
$rulesWorkflowCheatsheetPath = Join-Path $workflowsDirectory "rules-workflow\rules-workflow-cheatsheet.md"
$completeCheatsheetPath = Join-Path $planningDirectory "cs.md"

$frontEndParametersPath = Join-Path $parametersDirectory "front-end"
$rulesParametersPath = Join-Path $parametersDirectory "rules"

Write-Host "Root directory: $rootDirectory"
Write-Host "Parameters directory: $parametersDirectory"

# Function to extract the title from a markdown file
function Get-MarkdownTitle {
    param (
        [string]$FilePath
    )
    
    $content = Get-Content -Path $FilePath -Raw -ErrorAction SilentlyContinue
    
    if ($content -match "^#\s+(.+?)[\r\n]") {
        return $matches[1].Trim()
    }
    
    return [System.IO.Path]::GetFileNameWithoutExtension($FilePath)
}

# Function to get message command from a parameter file
function Get-MessageCommand {
    param (
        [string]$FilePath
    )
    
    <#
    .SYNOPSIS
        Extracts the message-command and standard parameters from a parameter file
    
    .DESCRIPTION
        This function analyzes a parameter file to determine which message-command it is 
        "loyal to" - meaning which message-command should be used with this parameter.
        
        The function uses several methods to determine the message-command, in order of priority:
        1. Explicit "Loyal to:" statement in the file
        2. "Message-Command:" section in the file
        3. Command format examples in code blocks
        4. File name inference (based on naming conventions)
        
        This process ensures each parameter is correctly associated with its intended
        message-command for accurate cheatsheet generation.
    
    .PARAMETER FilePath
        The path to the parameter file to analyze
    
    .RETURNS
        A hashtable with Command and Parameters properties
    #>
    
    $msgCmd = ""
    $stdParams = @()
    
    try {
        $content = Get-Content -Path $FilePath -Raw -ErrorAction SilentlyContinue
        
        # Try to find loyalty section - most accurate way to determine message-command
        if ($content -match "Loyal to:\s*([a-z0-9\-]+)(?::|\s)") {
            $msgCmd = $matches[1].Trim()
        }
        # Try to find Call Pattern section with explicit Message-Command
        elseif ($content -match "Message-Command:\s*([a-z0-9\-]+)") {
            $msgCmd = $matches[1].Trim()
        }
        # Try to find command format examples
        elseif ($content -match "`([a-z0-9\-]+):\s+\w+\s+@[\w/\-]+\.mdc") {
            $msgCmd = $matches[1].Trim()
        }
        # Look for more examples in formatted code blocks
        elseif ($content -match "```(?:\w+)?\n([a-z0-9\-]+):\s+") {
            $msgCmd = $matches[1].Trim()
        }
        
        # Try to find standard parameters
        if ($content -match "Standard-Parameters:\s*(.+?)[\r\n]") {
            $paramString = $matches[1].Trim()
            if ($paramString -ne "none") {
                $stdParams = $paramString -split ",\s*" | ForEach-Object { $_.Trim() }
            }
        }
        
        # Special case for template-past-chat-hallucination
        if ($FilePath -match "template-past-chat-hallucination") {
            $stdParams = @("workflow-type", "folder-type", "project-rule-parameter")
        }
        
        # If not found, infer from filename
        if ([string]::IsNullOrEmpty($msgCmd)) {
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($FilePath)
            
            if ($fileName -match "^template-") {
                $msgCmd = "create-template"
                if (-not $stdParams -or $stdParams.Count -eq 0) {
                    $stdParams = @("workflow-type")
                }
            }
            elseif ($fileName -match "^plan-mode") {
                $msgCmd = "plan-mode"
                if (-not $stdParams -or $stdParams.Count -eq 0) {
                    $stdParams = @("workflow-type")
                }
            }
            elseif ($fileName -match "^dev-mode") {
                $msgCmd = "dev-mode"
                if (-not $stdParams -or $stdParams.Count -eq 0) {
                    $stdParams = @("workflow-type")
                }
            }
            elseif ($fileName -match "^direct-mode") {
                $msgCmd = "direct-mode"
                if (-not $stdParams -or $stdParams.Count -eq 0) {
                    $stdParams = @("workflow-type")
                }
            }
            elseif ($fileName -match "^continue-planning") {
                $msgCmd = "continue-planning"
            }
            elseif ($fileName -match "^continue-implementation") {
                $msgCmd = "continue-implementation"
            }
            elseif ($fileName -match "^enhance-") {
                # Handle enhance-* files in continuation directories
                if ($FilePath -match "continuation") {
                    if ($fileName -match "enhance-requirements") {
                        $msgCmd = "continue-planning"
                    }
                    elseif ($fileName -match "enhance-planning") {
                        $msgCmd = "continue-planning"
                    }
                    else {
                        $msgCmd = "continue-planning"
                    }
                }
                else {
                    $msgCmd = $fileName
                }
            }
            else {
                # Default to filename as command name if nothing else works
                $msgCmd = $fileName
            }
        }
    }
    catch {
        Write-Warning "Error extracting message command from $FilePath : $_"
    }
    
    return @{
        Command = $msgCmd
        Parameters = $stdParams
    }
}

# Function to get parameters from directory
function Get-Parameters {
    param (
        [string]$DirectoryPath,
        [string]$WorkflowType
    )
    
    Write-Host "Scanning directory: $DirectoryPath"
    
    $parameters = @()
    
    # Get all MD files, including those in subdirectories
    $files = Get-ChildItem -Path $DirectoryPath -Filter "*.md" -Recurse -ErrorAction SilentlyContinue
    
    if ($null -eq $files -or $files.Count -eq 0) {
        Write-Warning "No files found in $DirectoryPath or its subdirectories"
        return $parameters
    }
    
    Write-Host "Found $($files.Count) files."
    
    foreach ($file in $files) {
        try {
            $fileName = $file.Name
            $filePath = $file.FullName
            $title = Get-MarkdownTitle -FilePath $filePath
            
            # Get relative path from the base directory
            $relativePath = $file.FullName.Substring($DirectoryPath.Length).TrimStart('\', '/')
            $directoryStructure = [System.IO.Path]::GetDirectoryName($relativePath)
            
            # Create proper MdcPath with subdirectories
            if ([string]::IsNullOrEmpty($directoryStructure)) {
                $mdcPath = "@parameters/$WorkflowType/$fileName" -replace "\.md$", ".mdc"
            } else {
                $mdcPath = "@parameters/$WorkflowType/$directoryStructure/$fileName" -replace "\.md$", ".mdc"
                $mdcPath = $mdcPath.Replace("\", "/")
            }
            
            $cmdInfo = Get-MessageCommand -FilePath $filePath
            
            Write-Host "Processing $relativePath - Command: $($cmdInfo.Command)"
            
            $parameter = [PSCustomObject]@{
                FileName = $fileName
                RelativePath = $relativePath
                Title = $title
                MdcPath = $mdcPath
                Command = $cmdInfo.Command
                Parameters = $cmdInfo.Parameters
                IsReadme = $fileName -eq "README.md"
            }
            
            # Skip README.md files
            if (!$parameter.IsReadme) {
                $parameters += $parameter
            }
        }
        catch {
            Write-Warning "Error processing $($file.Name): $_"
        }
    }
    
    return $parameters
}

# Function to create a workflow cheatsheet
function Create-WorkflowCheatsheet {
    param (
        [string]$WorkflowType,
        [array]$Parameters
    )
    
    <#
    .SYNOPSIS
        Creates a formatted workflow cheatsheet organized by subdirectory categories
    
    .DESCRIPTION
        This function takes parameters organized by subdirectories and creates a 
        consistently formatted cheatsheet with each section representing a subdirectory.
        The cheatsheet follows this organization pattern:
        1. PLAN-MODE project-rule-parameters
        2. DEV-MODE project-rule-parameters
        3. DIRECT-MODE project-rule-parameters
        4. CONTINUATION project-rule-parameters
        5. HELPERS project-rule-parameters (with subcategories)
        
        This structure directly mirrors the 1000xbrain/parameters/[workflow]/subdirectory
        organization, making the cheatsheet easy to navigate.
    
    .PARAMETER WorkflowType
        The type of workflow (e.g., "rules", "front-end")
    
    .PARAMETER Parameters
        Array of parameter objects with properties including RelativePath, MdcPath, 
        Command, and Parameters
    #>
    
    Write-Host "Creating cheatsheet for $WorkflowType workflow"
    
    $lines = New-Object System.Collections.ArrayList
    
    # Add header
    [void]$lines.Add("# $($WorkflowType.ToUpper())-Workflow Cheatsheet")
    [void]$lines.Add("")
    
    # First, organize parameters by their subdirectory category
    $organizedByCategory = @{}
    
    foreach ($param in $Parameters) {
        $relPath = $param.RelativePath
        if ([string]::IsNullOrEmpty($relPath) -or -not ($relPath -match "\\")) {
            $category = "root"
        } else {
            $category = $relPath.Split("\")[0]
        }
        
        if (-not $organizedByCategory.ContainsKey($category)) {
            $organizedByCategory[$category] = @()
        }
        
        $organizedByCategory[$category] += $param
    }
    
    # Skip ROOT items
    if ($organizedByCategory.ContainsKey("root")) {
        $organizedByCategory.Remove("root")
    }
    
    # Process each category in specific order
    $categoryOrder = @("plan-mode", "dev-mode", "direct-mode", "continuation", "helpers")
    
    foreach ($category in $categoryOrder) {
        if ($organizedByCategory.ContainsKey($category)) {
            # Add section header for the category
            [void]$lines.Add("## $($category.ToUpper()) project-rule-parameters")
            [void]$lines.Add("")
            
            if ($category -eq "plan-mode" -or $category -eq "dev-mode" -or $category -eq "direct-mode" -or $category -eq "continuation") {
                # For main mode categories and continuation, show parameters with command and standard params
                [void]$lines.Add("| project-rule-parameter | message-command | standard-parameters |")
                [void]$lines.Add("|------------------------|-----------------|---------------------|")
                
                # Sort parameters by name
                $sortedParams = $organizedByCategory[$category] | Sort-Object -Property MdcPath
                
                foreach ($param in $sortedParams) {
                    # Get the command that this parameter is "loyal to"
                    $loyalCommand = $param.Command
                    
                    # Extract standard parameters
                    $stdParamsString = if ($param.Parameters -and $param.Parameters.Count -gt 0) {
                        $param.Parameters -join ", "
                    } else {
                        "none"
                    }
                    
                    [void]$lines.Add("| ``$($param.MdcPath)`` | $loyalCommand | $stdParamsString |")
                }
            } else {
                # For helpers subcategories, group further by subdirectory
                $subDirMap = @{}
                
                foreach ($param in $organizedByCategory[$category]) {
                    $subPath = $param.RelativePath.Substring($category.Length + 1)
                    $subDir = if ([string]::IsNullOrEmpty($subPath) -or -not ($subPath -match "\\")) {
                        "root"
                    } else {
                        $subPath.Split("\")[0]
                    }
                    
                    if (-not $subDirMap.ContainsKey($subDir)) {
                        $subDirMap[$subDir] = @()
                    }
                    
                    $subDirMap[$subDir] += $param
                }
                
                # Skip root category for helpers
                if ($subDirMap.ContainsKey("root")) {
                    $subDirMap.Remove("root")
                }
                
                # Process each helpers subcategory
                foreach ($subDir in $subDirMap.Keys | Sort-Object) {
                    [void]$lines.Add("")
                    [void]$lines.Add("### $($subDir.ToUpper()) Commands")
                    [void]$lines.Add("")
                    [void]$lines.Add("| project-rule-parameter | message-command |")
                    [void]$lines.Add("|------------------------|-----------------|")
                    
                    # Sort parameters by message command
                    $sortedParams = $subDirMap[$subDir] | Sort-Object -Property Command
                    
                    foreach ($param in $sortedParams) {
                        [void]$lines.Add("| ``$($param.MdcPath)`` | $($param.Command) |")
                    }
                }
            }
            
            [void]$lines.Add("")
        }
    }
    
    # Generate the final content
    $content = $lines -join "`r`n"
    return $content
}

# Function to create complete cheatsheet
function Create-CompleteCheatsheet {
    param (
        [string]$FrontEndContent,
        [string]$RulesContent
    )
    
    $lines = New-Object System.Collections.ArrayList
    
    # Add header and TOC
    [void]$lines.Add("# GigaSwap Workflow Cheatsheets")
    [void]$lines.Add("")
    [void]$lines.Add("## Quick Navigation")
    [void]$lines.Add("- [Rules Workflow](#rules-workflow-cheatsheet)")
    [void]$lines.Add("- [Front-End Workflow](#front-end-workflow-cheatsheet)")
    [void]$lines.Add("- [Back-End Workflow](#back-end-workflow-cheatsheet)")
    [void]$lines.Add("- [Documentation Workflow](#documentation-workflow-cheatsheet)")
    [void]$lines.Add("- [Scripts Workflow](#scripts-workflow-cheatsheet)")
    [void]$lines.Add("- [Common Message-Commands](#common-message-commands-reference)")
    [void]$lines.Add("")
    [void]$lines.Add("---")
    [void]$lines.Add("")
    
    # Add workflow contents
    [void]$lines.Add($RulesContent)
    [void]$lines.Add("")
    [void]$lines.Add("---")
    [void]$lines.Add("")
    [void]$lines.Add($FrontEndContent)
    [void]$lines.Add("")
    [void]$lines.Add("---")
    [void]$lines.Add("")
    
    # Add placeholders
    [void]$lines.Add("# Back-End Workflow Cheatsheet")
    [void]$lines.Add("")
    [void]$lines.Add("> Coming soon")
    [void]$lines.Add("")
    [void]$lines.Add("---")
    [void]$lines.Add("")
    [void]$lines.Add("# Documentation Workflow Cheatsheet")
    [void]$lines.Add("")
    [void]$lines.Add("> Coming soon")
    [void]$lines.Add("")
    [void]$lines.Add("---")
    [void]$lines.Add("")
    [void]$lines.Add("# Scripts Workflow Cheatsheet")
    [void]$lines.Add("")
    [void]$lines.Add("> Coming soon")
    [void]$lines.Add("")
    [void]$lines.Add("---")
    [void]$lines.Add("")
    
    # Add common commands reference
    [void]$lines.Add("# Common Message-Commands Reference")
    [void]$lines.Add("")
    [void]$lines.Add("| Message-Command | Description | Standard-Parameters |")
    [void]$lines.Add("|-----------------|-------------|---------------------|")
    [void]$lines.Add("| `plan-mode` | Start or switch to Planning Mode | workflow-type |")
    [void]$lines.Add("| `dev-mode` | Start or switch to Developer Mode | workflow-type |")
    [void]$lines.Add("| `direct-mode` | Skip planning and directly start implementation | workflow-type |")
    [void]$lines.Add("| `continue-planning` | Continue planning with specific guidance | none |")
    [void]$lines.Add("| `continue-implementation` | Continue implementation with specific guidance | none |")
    [void]$lines.Add("| `create-template` | Create a template | workflow-type |")
    
    # Generate the final content
    $content = $lines -join "`r`n"
    return $content
}

# Main execution logic
try {
    Write-Host "Updating workflow cheatsheets..."
    Write-Host "================================="
    Write-Host ""
    
    # Process front-end workflow
    Write-Host "Processing front-end workflow..."
    if (Test-Path $frontEndParametersPath) {
        Write-Host "Front-end parameters directory exists at: $frontEndParametersPath"
        
        # Check for continuation subdirectory
        $frontEndContinuationPath = Join-Path $frontEndParametersPath "continuation"
        if (Test-Path $frontEndContinuationPath) {
            Write-Host "Found continuation subdirectory at: $frontEndContinuationPath"
        }
        
        $frontEndParams = Get-Parameters -DirectoryPath $frontEndParametersPath -WorkflowType "front-end"
        $frontEndContent = Create-WorkflowCheatsheet -WorkflowType "front-end" -Parameters $frontEndParams
    } else {
        Write-Warning "Front-end parameters directory not found at: $frontEndParametersPath"
        $frontEndContent = "# FRONT-END-Workflow Cheatsheet`n`n> No parameters found. Directory does not exist: $frontEndParametersPath"
    }
    
    # Process rules workflow
    Write-Host "Processing rules workflow..."
    if (Test-Path $rulesParametersPath) {
        Write-Host "Rules parameters directory exists at: $rulesParametersPath"
        
        # Check for continuation subdirectory
        $rulesContinuationPath = Join-Path $rulesParametersPath "continuation"
        if (Test-Path $rulesContinuationPath) {
            Write-Host "Found continuation subdirectory at: $rulesContinuationPath"
        }
        
        # Get subdirectories for logging
        $subdirs = Get-ChildItem -Path $rulesParametersPath -Directory | Select-Object -ExpandProperty Name
        Write-Host "Found the following subdirectories in rules parameters:"
        foreach ($dir in $subdirs) {
            Write-Host "  - $dir/"
        }
        
        $rulesParams = Get-Parameters -DirectoryPath $rulesParametersPath -WorkflowType "rules"
        $rulesContent = Create-WorkflowCheatsheet -WorkflowType "rules" -Parameters $rulesParams
    } else {
        Write-Warning "Rules parameters directory not found at: $rulesParametersPath"
        $rulesContent = "# RULES-Workflow Cheatsheet`n`n> No parameters found. Directory does not exist: $rulesParametersPath"
    }
    
    # Create complete cheatsheet
    Write-Host "Creating complete cheatsheet..."
    $completeContent = Create-CompleteCheatsheet -FrontEndContent $frontEndContent -RulesContent $rulesContent
    
    # Ensure directories exist
    $frontEndDir = Split-Path -Parent $frontEndWorkflowCheatsheetPath
    $rulesDir = Split-Path -Parent $rulesWorkflowCheatsheetPath
    $completeDir = Split-Path -Parent $completeCheatsheetPath
    
    if (-not (Test-Path $frontEndDir)) { 
        Write-Host "Creating front-end workflow directory: $frontEndDir"
        New-Item -ItemType Directory -Path $frontEndDir -Force | Out-Null 
    }
    if (-not (Test-Path $rulesDir)) { 
        Write-Host "Creating rules workflow directory: $rulesDir"
        New-Item -ItemType Directory -Path $rulesDir -Force | Out-Null 
    }
    if (-not (Test-Path $completeDir)) { 
        Write-Host "Creating planning directory: $completeDir"
        New-Item -ItemType Directory -Path $completeDir -Force | Out-Null 
    }
    
    # Write files
    Write-Host "Writing cheatsheet files..."
    Set-Content -Path $frontEndWorkflowCheatsheetPath -Value $frontEndContent -Force
    Set-Content -Path $rulesWorkflowCheatsheetPath -Value $rulesContent -Force
    Set-Content -Path $completeCheatsheetPath -Value $completeContent -Force
    
    Write-Host "All cheatsheets updated successfully:"
    Write-Host "  - Front-end workflow: $frontEndWorkflowCheatsheetPath"
    Write-Host "  - Rules workflow: $rulesWorkflowCheatsheetPath"
    Write-Host "  - Complete cheatsheet: $completeCheatsheetPath"
    
    # Return success
    exit 0
}
catch {
    Write-Error "Error updating cheatsheets: $_"
    
    # Return error
    exit 1
} 