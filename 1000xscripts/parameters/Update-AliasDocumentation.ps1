[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Workflow,
    
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\alias-registry.json",
    
    [Parameter(Mandatory=$false)]
    [switch]$GenerateCheatsheet,
    
    [Parameter(Mandatory=$false)]
    [switch]$GenerateParameterDocs,
    
    [Parameter(Mandatory=$false)]
    [string]$ConfigPath = "$PSScriptRoot\parameter-config.json"
)

# Load registry
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Alias registry not found at: $RegistryPath"
    exit 1
}

$registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json

# Check if workflow exists
if (-not ($registry.aliases.PSObject.Properties.Name -contains $Workflow)) {
    Write-Error "Workflow '$Workflow' does not exist in the registry."
    exit 1
}

# Load config if it exists
$config = $null
if (Test-Path $ConfigPath) {
    $config = Get-Content -Path $ConfigPath -Raw | ConvertFrom-Json
}

# Determine output directory
$outputDir = "$PSScriptRoot\..\..\1000xbrain\workflows\$Workflow\parameter-documentation"
$cheatsheetPath = "$PSScriptRoot\..\..\1000xbrain\workflows\$Workflow\parameter-cheatsheet.md"

# Use config if available
if ($config -and $config.workflows.$Workflow) {
    $outputDir = "$PSScriptRoot\..\..\1000xbrain\$($config.workflows.$Workflow.outputPath)"
    $cheatsheetPath = "$PSScriptRoot\..\..\1000xbrain\$($config.workflows.$Workflow.cheatsheetPath)"
}

# Create output directory if it doesn't exist
if (-not (Test-Path $outputDir)) {
    New-Item -Path $outputDir -ItemType Directory -Force
}

# Group aliases by category
$categorizedAliases = @{}

foreach ($alias in $registry.aliases.$Workflow.PSObject.Properties.Name) {
    $category = $registry.aliases.$Workflow.$alias.category
    
    if (-not $categorizedAliases.ContainsKey($category)) {
        $categorizedAliases[$category] = @()
    }
    
    $categorizedAliases[$category] += [PSCustomObject]@{
        Name = $alias
        Path = $registry.aliases.$Workflow.$alias.path
        MdcPath = $registry.aliases.$Workflow.$alias.mdcPath
        Description = $registry.aliases.$Workflow.$alias.description
        MessageCommand = $registry.aliases.$Workflow.$alias.messageCommand
        StandardParameters = $registry.aliases.$Workflow.$alias.standardParameters
        UsageExamples = $registry.aliases.$Workflow.$alias.usageExamples
        RelatedParameters = $registry.aliases.$Workflow.$alias.relatedParameters
        ComponentAssociation = $registry.aliases.$Workflow.$alias.componentAssociation
        UiPattern = $registry.aliases.$Workflow.$alias.uiPattern
        Framework = $registry.aliases.$Workflow.$alias.framework
    }
}

# Generate parameter documentation if requested
if ($GenerateParameterDocs -or (!$GenerateCheatsheet -and !$GenerateParameterDocs)) {
    # Generate documentation for each category
    foreach ($category in $categorizedAliases.Keys) {
        $outputFile = Join-Path $outputDir "$category-parameters.md"
        
        $content = @"
# $Workflow: $category Parameters

This file provides documentation for all $category parameters in the $Workflow workflow.

## Parameters

"@
        
        # Add each parameter
        foreach ($param in $categorizedAliases[$category] | Sort-Object -Property Name) {
            $content += @"

### $($param.Name)

- **Alias**: `@alias:$Workflow:$($param.Name)`
- **Path**: `$($param.Path)`
- **Description**: $($param.Description)
- **Message Command**: `$($param.MessageCommand)`
"@
            
            if ($param.StandardParameters -and $param.StandardParameters.Count -gt 0) {
                $content += @"

- **Standard Parameters**: $($param.StandardParameters -join ", ")
"@
            }
            
            if ($param.UsageExamples -and $param.UsageExamples.Count -gt 0) {
                $content += @"

- **Usage Examples**:
"@
                foreach ($example in $param.UsageExamples) {
                    $content += @"
  - ``$example``
"@
                }
            }
            
            if ($param.RelatedParameters -and $param.RelatedParameters.Count -gt 0) {
                $content += @"

- **Related Parameters**: $($param.RelatedParameters -join ", ")
"@
            }
            
            # Add front-end specific metadata if available
            if ($Workflow -eq "front-end") {
                if ($param.ComponentAssociation) {
                    $content += @"

- **Component Association**: $($param.ComponentAssociation)
"@
                }
                
                if ($param.UiPattern) {
                    $content += @"

- **UI Pattern**: $($param.UiPattern)
"@
                }
                
                if ($param.Framework) {
                    $content += @"

- **Framework**: $($param.Framework)
"@
                }
            }
        }
        
        # Save the documentation file
        $content | Set-Content -Path $outputFile
        Write-Host "Generated documentation for $category parameters in $Workflow workflow."
    }
}

# Generate cheatsheet if requested
if ($GenerateCheatsheet -or (!$GenerateCheatsheet -and !$GenerateParameterDocs)) {
    $cheatsheetContent = @"
# $Workflow Parameter Cheatsheet

This cheatsheet provides a quick reference for all parameters in the $Workflow workflow, organized by category.

## Parameters by Category

"@

    foreach ($category in $categorizedAliases.Keys | Sort-Object) {
        $cheatsheetContent += @"

### $category Parameters

| Alias | Path | Message Command | Description |
|-------|------|----------------|-------------|
"@
        
        foreach ($param in $categorizedAliases[$category] | Sort-Object -Property Name) {
            $cheatsheetContent += @"
| `@alias:$Workflow:$($param.Name)` | `$($param.Path)` | $($param.MessageCommand) | $($param.Description) |
"@
        }
    }

    # Add usage instructions
    $cheatsheetContent += @"

## Usage Instructions

Parameters can be referenced using their alias format:

```
message-command: workflow-type @alias:$Workflow:parameter-name
```

For example:
```
plan-mode: $Workflow @alias:$Workflow:template-basic
```

## Advantages of Alias Format

- **Path Independence**: References remain valid even if files move
- **Workflow Isolation**: Clear separation between parameters in different workflows
- **Automatic Resolution**: Aliases are automatically resolved to current paths
- **Concise Syntax**: Shorter and more readable than full paths
"@

    # Add front-end specific sections if applicable
    if ($Workflow -eq "front-end") {
        # Extract component associations
        $componentAssociations = @()
        foreach ($category in $categorizedAliases.Keys) {
            foreach ($param in $categorizedAliases[$category]) {
                if ($param.ComponentAssociation) {
                    $componentAssociations += "- `$($param.Name)` → $($param.ComponentAssociation)"
                }
            }
        }
        
        if ($componentAssociations.Count -gt 0) {
            $cheatsheetContent += @"

## Component Association

Many front-end parameters are associated with specific UI components:

$($componentAssociations -join "`n")
"@
        }
        
        # Extract UI patterns
        $uiPatterns = @()
        $patternCategories = @{}
        
        foreach ($category in $categorizedAliases.Keys) {
            foreach ($param in $categorizedAliases[$category]) {
                if ($param.UiPattern -and (-not $patternCategories.ContainsKey($param.UiPattern))) {
                    $patternCategories[$param.UiPattern] = $true
                    $uiPatterns += "- **$($param.UiPattern.Substring(0,1).ToUpper() + $param.UiPattern.Substring(1))**: $($param.UiPattern)-related patterns"
                }
            }
        }
        
        if ($uiPatterns.Count -gt 0) {
            $cheatsheetContent += @"

## UI Pattern Categories

Front-end parameters are categorized by UI pattern type:

$($uiPatterns -join "`n")
"@
        }
    }

    # Save the cheatsheet file
    $cheatsheetContent | Set-Content -Path $cheatsheetPath
    Write-Host "Generated parameter cheatsheet for $Workflow workflow."
}

# Generate README if it doesn't exist
$readmePath = Join-Path $outputDir "README.md"
if (-not (Test-Path $readmePath)) {
    $readmeContent = @"
# $Workflow Parameter Documentation

## Overview

This directory contains documentation for all $Workflow parameters. These parameters use the alias-based reference system for path independence and workflow isolation.

## Reference Format

Parameters can be referenced using the alias format:

```
@alias:$Workflow:parameter-name
```

For example:

```
plan-mode: $Workflow @alias:$Workflow:template-basic
```

## Parameter Categories

"@

    foreach ($category in $categorizedAliases.Keys | Sort-Object) {
        $categoryDesc = switch ($category) {
            "plan-mode" { "Parameters for planning" }
            "dev-mode" { "Parameters for implementation" }
            "direct-mode" { "Parameters for direct implementation" }
            "helpers" { "Helper parameters for common tasks" }
            default { "Parameters in the $category category" }
        }
        
        $readmeContent += @"
- **$($category.Substring(0,1).ToUpper() + $category.Substring(1))**: $categoryDesc
"@
    }

    # Add workflow-specific content
    if ($Workflow -eq "front-end") {
        $readmeContent += @"

## Component Association

Many front-end parameters are associated with specific UI components. This association is documented in the parameter metadata and can be used to discover parameters related to specific components.

## UI Patterns

Front-end parameters are categorized by UI pattern type, making it easier to discover parameters related to specific UI patterns like forms, layouts, or data visualization.
"@
    }

    $readmeContent += @"

## Available Parameters

See the [$($Workflow.Substring(0,1).ToUpper() + $Workflow.Substring(1)) Parameter Cheatsheet](../parameter-cheatsheet.md) for a complete list of available parameters.

## Parameter Management

Parameters are managed through the alias-based parameter system, which provides:

- **Path Independence**: Parameters remain valid even if files are moved or renamed
- **Workflow Isolation**: Clear separation between parameters in different workflows
- **Automated Reference Management**: References update automatically when parameters change
- **Enhanced Documentation**: Automatically generated documentation and cheatsheets
"@

    # Save the README file
    $readmeContent | Set-Content -Path $readmePath
    Write-Host "Generated README for $Workflow parameter documentation."
} 