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
$qualityWorkflowCheatsheetPath = Join-Path $workflowsDirectory "quality\quality-workflow-cheatsheet.md"
$completeCheatsheetPath = Join-Path $planningDirectory "cs.md"

$frontEndParametersPath = Join-Path $parametersDirectory "front-end"
$rulesParametersPath = Join-Path $parametersDirectory "rules"
$qualityParametersPath = Join-Path $parametersDirectory "quality"

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
        Extracts the message-command, standard parameters, and pathway from a parameter file
    
    .DESCRIPTION
        This function analyzes a parameter file to determine which message-command it is 
        "loyal to" - meaning which message-command should be used with this parameter.
        
        The function uses several methods to determine the message-command, in order of priority:
        1. New header format: "# mode: [mode] | workflow: [workflow] | pathway: [pathway] | filepath: [filepath] | optional-standard-parameter(s): [params]"
        2. Explicit "Loyal to:" statement in the file
        3. "Message-Command:" section in the file
        4. Old header format: "# workflow: [workflow-type] | pathway: [pathway-name] | message-command: [message-command] | ..."
        5. Command format examples in code blocks
        6. File name inference (based on naming conventions)
        
        This function is updated to handle both the old and new header formats, with priority
        given to the new format.
    
    .PARAMETER FilePath
        The path to the parameter file to analyze
    
    .RETURNS
        A hashtable with Command, Parameters, and Pathway properties
    #>
    
    $msgCmd = ""
    $stdParams = @()
    $pathway = ""
    
    try {
        $content = Get-Content -Path $FilePath -Raw -ErrorAction SilentlyContinue
        
        # Extract from new header format (highest priority)
        # Format: # mode: [mode] | workflow: [workflow] | pathway: [pathway] | filepath: [filepath] | optional-standard-parameter(s): [params]
        if ($content -match "^#\s+mode:\s*([^|]+?)\s*\|") {
            $msgCmd = $matches[1].Trim()
            
            # Extract pathway from the new header format
            if ($content -match "\|\s*pathway:\s*([^|]+?)\s*\|") {
                $pathway = $matches[1].Trim()
            }
            
            # Extract standard parameters from the new header format
            if ($content -match "\|\s*optional-standard-parameter\(s\):\s*([^|]+?)(\s*\||$)") {
                $paramString = $matches[1].Trim()
                if ($paramString -ne "none") {
                    $stdParams = $paramString -split ",\s*" | ForEach-Object { $_.Trim() }
                }
            }
        }
        # If new header format not found, try the older methods
        else {
            # Extract pathway from the old header format
            if ($content -match "#\s+workflow:.+?\|\s*pathway:\s*([^|]+?)\s*\|") {
                $pathway = $matches[1].Trim()
            }
            
            # Try to find loyalty section - most accurate way to determine message-command
            if ($content -match "Loyal to:\s*([a-z0-9\-]+)(?::|\s)") {
                $msgCmd = $matches[1].Trim()
            }
            # Try to find Call Pattern section with explicit Message-Command
            elseif ($content -match "Message-Command:\s*([a-z0-9\-]+)") {
                $msgCmd = $matches[1].Trim()
            }
            # Extract from old header format
            elseif ($content -match "#\s+workflow:.+?\|\s*message-command:\s*([^|]+?)\s*\|") {
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
            
            # Try to find standard parameters from old formats
            if ($content -match "Standard-Parameters:\s*(.+?)[\r\n]") {
                $paramString = $matches[1].Trim()
                if ($paramString -ne "none") {
                    $stdParams = $paramString -split ",\s*" | ForEach-Object { $_.Trim() }
                }
            }
            # Extract from old header format
            elseif ($content -match "#\s+workflow:.+?\|\s*standard-parameter\(s\):\s*([^|]+?)\s*\|") {
                $paramString = $matches[1].Trim()
                if ($paramString -ne "none") {
                    $stdParams = $paramString -split ",\s*" | ForEach-Object { $_.Trim() }
                }
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
                $msgCmd = "plan-mode"
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
                $msgCmd = "plan-mode"
            }
            elseif ($fileName -match "^continue-implementation") {
                $msgCmd = "dev-mode"
            }
            elseif ($fileName -match "^enhance-") {
                # Handle enhance-* files in continuation directories
                if ($FilePath -match "continuation") {
                    $msgCmd = "plan-mode"
                }
                else {
                    # Default enhance-* files to plan-mode
                    $msgCmd = "plan-mode"
                }
            }
            else {
                # For any other filenames, default to the appropriate mode based on directory structure
                if ($FilePath -match "\\plan-mode\\") {
                    $msgCmd = "plan-mode"
                } 
                elseif ($FilePath -match "\\dev-mode\\") {
                    $msgCmd = "dev-mode"
                }
                elseif ($FilePath -match "\\direct-mode\\") {
                    $msgCmd = "direct-mode"
                }
                else {
                    # If all else fails, default to plan-mode
                    $msgCmd = "plan-mode"
                }
            }
        }
        
        # Validate and normalize message command to ensure it's one of the 3 valid commands
        if ($msgCmd -notin @("plan-mode", "dev-mode", "direct-mode")) {
            # Apply mapping for legacy commands
            switch -regex ($msgCmd) {
                "create-template|continue-planning|enhance-.*|verify-.*|analyze-.*" {
                    $msgCmd = "plan-mode"
                }
                "continue-implementation|implement-.*" {
                    $msgCmd = "dev-mode"
                }
                default {
                    # Default fallback is plan-mode
                    Write-Warning "Unrecognized message command '$msgCmd' in $FilePath - defaulting to plan-mode"
                    $msgCmd = "plan-mode"
                }
            }
        }
        
        # If pathway is not found, use "default" or try to infer from directory structure
        if ([string]::IsNullOrEmpty($pathway)) {
            # Try to infer from directory structure
            $relativePath = $FilePath.Replace($PSScriptRoot, "").TrimStart('\', '/')
            if ($relativePath -match "/([^/]+)/[^/]+\.md$") {
                $pathway = $matches[1]
            } else {
                $pathway = "default"
            }
        }
    }
    catch {
        Write-Warning "Error extracting message command from $FilePath : $_"
    }
    
    return @{
        Command = $msgCmd
        Parameters = $stdParams
        Pathway = $pathway
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
                Pathway = $cmdInfo.Pathway
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
        Creates a formatted workflow cheatsheet organized by pathway categories
    
    .DESCRIPTION
        This function takes parameters and creates a consistently formatted cheatsheet 
        with each section representing a pathway category.
        The cheatsheet follows this organization pattern by grouping parameters by pathway
        as defined in their headers.
        
        This structure makes the cheatsheet more functionally organized based on the
        parameter's purpose rather than just its file location.
    
    .PARAMETER WorkflowType
        The type of workflow (e.g., "rules", "front-end")
    
    .PARAMETER Parameters
        Array of parameter objects with properties including RelativePath, MdcPath, 
        Command, Parameters, and Pathway
    #>
    
    Write-Host "Creating cheatsheet for $WorkflowType workflow"
    
    $lines = New-Object System.Collections.ArrayList
    
    # Add header
    [void]$lines.Add("# $($WorkflowType.ToUpper())-Workflow Cheatsheet")
    [void]$lines.Add("")
    
    # First, organize parameters by their pathway
    $organizedByPathway = @{}
    
    foreach ($param in $Parameters) {
        $pathway = $param.Pathway
        if ([string]::IsNullOrEmpty($pathway)) {
            $pathway = "default"
        }
        
        if (-not $organizedByPathway.ContainsKey($pathway)) {
            $organizedByPathway[$pathway] = @()
        }
        
        $organizedByPathway[$pathway] += $param
    }
    
    # Process each pathway alphabetically
    foreach ($pathway in $organizedByPathway.Keys | Sort-Object) {
        # Add section header for the pathway
        [void]$lines.Add("## PATHWAY: $pathway")
        [void]$lines.Add("")
        
        # Create table for this pathway
        [void]$lines.Add("| project-rule-parameter | message-command | standard-parameters |")
        [void]$lines.Add("|------------------------|-----------------|---------------------|")
        
        # Sort parameters by MdcPath
        $sortedParams = $organizedByPathway[$pathway] | Sort-Object -Property MdcPath
        
        foreach ($param in $sortedParams) {
            # Get the command that this parameter is "loyal to"
            $loyalCommand = $param.Command
            
            # Extract standard parameters
            $stdParamsString = if ($param.Parameters -and $param.Parameters.Count -gt 0) {
                $param.Parameters -join ", "
            } else {
                "none"
            }
            
            # Remove mode determination and column
            [void]$lines.Add("| ``$($param.MdcPath)`` | $loyalCommand | $stdParamsString |")
        }
        
        [void]$lines.Add("")
    }
    
    # Generate the final content
    $content = $lines -join "`r`n"
    return $content
}

# Function to create complete cheatsheet
function Create-CompleteCheatsheet {
    param (
        [string]$FrontEndContent,
        [string]$RulesContent,
        [string]$QualityContent
    )
    
    $lines = New-Object System.Collections.ArrayList
    
    # Add header and TOC
    [void]$lines.Add("# GigaSwap Workflow Cheatsheets")
    [void]$lines.Add("")
    [void]$lines.Add("## Quick Navigation")
    [void]$lines.Add("- [Rules Workflow](#rules-workflow-cheatsheet)")
    [void]$lines.Add("- [Front-End Workflow](#front-end-workflow-cheatsheet)")
    [void]$lines.Add("- [Quality Workflow](#quality-workflow-cheatsheet)")
    [void]$lines.Add("- [Back-End Workflow](#back-end-workflow-cheatsheet)")
    [void]$lines.Add("- [Scripts Workflow](#scripts-workflow-cheatsheet)")
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
    
    # Add quality workflow content if available
    if (-not [string]::IsNullOrEmpty($QualityContent)) {
        [void]$lines.Add($QualityContent)
        [void]$lines.Add("")
        [void]$lines.Add("---")
        [void]$lines.Add("")
    } else {
        [void]$lines.Add("# QUALITY-Workflow Cheatsheet")
        [void]$lines.Add("")
        [void]$lines.Add("> Coming soon")
        [void]$lines.Add("")
        [void]$lines.Add("---")
        [void]$lines.Add("")
    }
    
    # Add placeholders
    [void]$lines.Add("# Back-End Workflow Cheatsheet")
    [void]$lines.Add("")
    [void]$lines.Add("> Coming soon")
    [void]$lines.Add("")
    [void]$lines.Add("---")
    [void]$lines.Add("")
    [void]$lines.Add("# Scripts Workflow Cheatsheet")
    [void]$lines.Add("")
    [void]$lines.Add("> Coming soon")
    [void]$lines.Add("")
    
    # Generate the final content
    $content = $lines -join "`r`n"
    return $content
}

# Main execution logic
try {
    Write-Host "Updating master workflow cheatsheet..."
    Write-Host "====================================="
    Write-Host ""
    
    # Process front-end workflow
    Write-Host "Processing front-end workflow..."
    if (Test-Path $frontEndParametersPath) {
        Write-Host "Front-end parameters directory exists at: $frontEndParametersPath"
        
        # Get subdirectories for logging
        $subdirs = Get-ChildItem -Path $frontEndParametersPath -Directory | Select-Object -ExpandProperty Name
        Write-Host "Found the following subdirectories in front-end parameters:"
        foreach ($dir in $subdirs) {
            Write-Host "  - $dir/"
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
    
    # Process quality workflow
    Write-Host "Processing quality workflow..."
    if (Test-Path $qualityParametersPath) {
        Write-Host "Quality parameters directory exists at: $qualityParametersPath"
        
        # Get subdirectories for logging
        $subdirs = Get-ChildItem -Path $qualityParametersPath -Directory | Select-Object -ExpandProperty Name
        Write-Host "Found the following subdirectories in quality parameters:"
        foreach ($dir in $subdirs) {
            Write-Host "  - $dir/"
        }
        
        $qualityParams = Get-Parameters -DirectoryPath $qualityParametersPath -WorkflowType "quality"
        $qualityContent = Create-WorkflowCheatsheet -WorkflowType "quality" -Parameters $qualityParams
    } else {
        Write-Warning "Quality parameters directory not found at: $qualityParametersPath"
        $qualityContent = ""
    }
    
    # Create complete cheatsheet
    Write-Host "Creating master cheatsheet..."
    $completeContent = Create-CompleteCheatsheet -FrontEndContent $frontEndContent -RulesContent $rulesContent -QualityContent $qualityContent
    
    # Ensure directory exists
    $completeDir = Split-Path -Parent $completeCheatsheetPath
    
    if (-not (Test-Path $completeDir)) { 
        Write-Host "Creating planning directory: $completeDir"
        New-Item -ItemType Directory -Path $completeDir -Force | Out-Null 
    }
    
    # Write master cheatsheet file
    Write-Host "Writing master cheatsheet file..."
    Set-Content -Path $completeCheatsheetPath -Value $completeContent -Force
    
    Write-Host "Master cheatsheet updated successfully: $completeCheatsheetPath"
    
    # Return success
    exit 0
}
catch {
    Write-Error "Error updating cheatsheets: $_"
    
    # Return error
    exit 1
} 