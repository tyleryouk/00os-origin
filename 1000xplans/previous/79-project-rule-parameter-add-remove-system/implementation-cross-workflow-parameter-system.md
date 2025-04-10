# Implementation Plan: Alias-Based Parameter Management System

## Overview

This implementation plan outlines a redesigned parameter management system that eliminates the need to manually update file paths in project-rule-parameter references. Instead of directly referencing file paths, the system will use parameter aliases that are automatically resolved to their current paths.

## Design Principles

1. **Path Independence**: References should be resilient to path changes
2. **Workflow Isolation**: Parameters from different workflows should be properly isolated
3. **Automatic Reference Handling**: Adding, removing, or moving parameters should automatically update all references
4. **Central Registry**: A single source of truth for all parameter information
5. **Simple Reference Syntax**: Easy-to-use reference format that's concise and clear

## 1. Alias-Based Reference System

### 1.1 Alias Format Design

Instead of using direct file paths for references, we'll introduce an alias system with workflow namespacing:

```
@alias:workflow:parameter-name
```

For example:
```
@alias:rules:template-basic
@alias:front-end:template-basic
```

This format:
- Eliminates path dependencies
- Provides clear workflow isolation
- Is shorter and easier to type
- Maintains backward compatibility through automatic translation

### 1.2 Central Alias Registry

Create a central registry file at `1000xscripts/parameters/alias-registry.json` with the following structure:

```json
{
  "schemaVersion": "1.0",
  "lastUpdated": "2023-04-01T12:00:00Z",
  "aliases": {
    "rules": {
      "template-basic": {
        "path": "parameters/rules/plan-mode/template-basic.md",
        "mdcPath": "parameters/rules/plan-mode/template-basic.mdc",
        "description": "Basic template for rules workflow planning",
        "category": "plan-mode",
        "messageCommand": "plan-mode",
        "standardParameters": ["workflow-type"],
        "usageExamples": [
          "plan-mode: rules-workflow @alias:rules:template-basic"
        ],
        "relatedParameters": ["template-advanced"]
      },
      "template-advanced": {
        "path": "parameters/rules/plan-mode/template-advanced.md",
        "mdcPath": "parameters/rules/plan-mode/template-advanced.mdc",
        "description": "Advanced template for rules workflow planning",
        "category": "plan-mode",
        "messageCommand": "plan-mode",
        "standardParameters": ["workflow-type"],
        "usageExamples": [
          "plan-mode: rules-workflow @alias:rules:template-advanced"
        ],
        "relatedParameters": ["template-basic"]
      }
    },
    "front-end": {
      "template-basic": {
        "path": "parameters/front-end/plan-mode/template-basic.md",
        "mdcPath": "parameters/front-end/plan-mode/template-basic.mdc",
        "description": "Basic template for front-end workflow planning",
        "category": "plan-mode",
        "messageCommand": "plan-mode",
        "standardParameters": ["workflow-type"],
        "usageExamples": [
          "plan-mode: front-end-workflow @alias:front-end:template-basic"
        ],
        "relatedParameters": ["template-advanced"]
      }
    }
    // Additional workflows and aliases...
  }
}
```

### 1.3 Alias Resolution System

Create a parameter resolution system that:

1. Intercepts all references to `@alias:workflow:parameter-name`
2. Resolves them to the actual file path from the registry
3. Provides backward compatibility for existing references

## 2. Management Scripts

### 2.1 Alias Registration Script

```powershell
# 1000xscripts/parameters/Register-ParameterAlias.ps1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Workflow,
    
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$true)]
    [string]$Path,
    
    [Parameter(Mandatory=$true)]
    [string]$Description,
    
    [Parameter(Mandatory=$true)]
    [string]$Category,
    
    [Parameter(Mandatory=$true)]
    [string]$MessageCommand,
    
    [Parameter(Mandatory=$false)]
    [string[]]$StandardParameters = @(),
    
    [Parameter(Mandatory=$false)]
    [string[]]$UsageExamples = @(),
    
    [Parameter(Mandatory=$false)]
    [string[]]$RelatedParameters = @(),
    
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\alias-registry.json"
)

# Create registry if it doesn't exist
if (-not (Test-Path $RegistryPath)) {
    $initialRegistry = @{
        schemaVersion = "1.0"
        lastUpdated = (Get-Date).ToString("o")
        aliases = @{}
    }
    
    $initialRegistry | ConvertTo-Json -Depth 10 | Set-Content -Path $RegistryPath
    Write-Host "Created new alias registry at $RegistryPath"
}

# Load registry
$registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json

# Create workflow section if it doesn't exist
if (-not ($registry.aliases.PSObject.Properties.Name -contains $Workflow)) {
    $registry.aliases | Add-Member -MemberType NoteProperty -Name $Workflow -Value @{}
}

# Check if alias already exists in this workflow
if ($registry.aliases.$Workflow.PSObject.Properties.Name -contains $Name) {
    Write-Error "Alias '$Name' already exists in workflow '$Workflow'."
    exit 1
}

# Verify the path exists
if (-not (Test-Path (Join-Path "$PSScriptRoot\..\.." "1000xbrain\$Path"))) {
    Write-Warning "Path '$Path' does not exist. Creating new parameter file."
}

# Create MDC path from MD path
$mdcPath = $Path -replace "\.md$", ".mdc"

# Add new alias
$newAlias = @{
    path = $Path
    mdcPath = $mdcPath
    description = $Description
    category = $Category
    messageCommand = $MessageCommand
    standardParameters = $StandardParameters
    usageExamples = $UsageExamples -replace "@parameters/.*\.mdc", "@alias:$Workflow:$Name"
    relatedParameters = $RelatedParameters
}

# Add to registry
if ($registry.aliases.$Workflow -eq $null) {
    $registry.aliases.$Workflow = @{}
}

$workflowSection = $registry.aliases.$Workflow
$workflowSection | Add-Member -MemberType NoteProperty -Name $Name -Value $newAlias -Force
$registry.lastUpdated = (Get-Date).ToString("o")

# Save registry
$registry | ConvertTo-Json -Depth 10 | Set-Content -Path $RegistryPath

# Update all usage examples in other aliases to use this alias format
foreach ($wf in $registry.aliases.PSObject.Properties.Name) {
    foreach ($alias in $registry.aliases.$wf.PSObject.Properties.Name) {
        $aliasObj = $registry.aliases.$wf.$alias
        
        if ($aliasObj.usageExamples) {
            $updated = $false
            $newExamples = @()
            
            foreach ($example in $aliasObj.usageExamples) {
                # Replace old file path references with alias references
                $pattern = "@parameters/$Workflow/.*/$Name\.mdc"
                if ($example -match $pattern) {
                    $newExample = $example -replace $pattern, "@alias:$Workflow:$Name"
                    $newExamples += $newExample
                    $updated = $true
                } else {
                    $newExamples += $example
                }
            }
            
            if ($updated) {
                $aliasObj.usageExamples = $newExamples
            }
        }
    }
}

# Save registry again after updating usage examples
$registry | ConvertTo-Json -Depth 10 | Set-Content -Path $RegistryPath

# Generate template parameter file if it doesn't exist
$parameterFilePath = Join-Path "$PSScriptRoot\..\.." "1000xbrain\$Path"
if (-not (Test-Path $parameterFilePath)) {
    $templateContent = @"
# $Name

## File Purpose and Relationship

This file serves as a project-rule-parameter for $Description. It can be referenced using the alias: `@alias:$Workflow:$Name`.

## Usage as Project-Rule-Parameter

```
$($UsageExamples -join "`n")
```

## Implementation Guidelines

[Implementation details...]

## File Standard Notice

This file follows the standard project-rule-parameter format with appropriate sections for usage documentation. 
"@

    # Create directory if it doesn't exist
    $parameterDirectory = Split-Path $parameterFilePath -Parent
    if (-not (Test-Path $parameterDirectory)) {
        New-Item -Path $parameterDirectory -ItemType Directory -Force
    }

    # Create the parameter file
    $templateContent | Set-Content -Path $parameterFilePath
    Write-Host "Created parameter file at $parameterFilePath"
}

# Update documentation
& "$PSScriptRoot\Update-AliasDocumentation.ps1" -Workflow $Workflow

Write-Output "Alias '$Name' registered successfully for workflow '$Workflow'."
```

### 2.2 Alias Removal Script

```powershell
# 1000xscripts/parameters/Remove-ParameterAlias.ps1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Workflow,
    
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$false)]
    [switch]$DeleteFile,
    
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\alias-registry.json"
)

# Verify registry exists
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Alias registry not found at: $RegistryPath"
    exit 1
}

# Load registry
$registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json

# Check if workflow exists
if (-not ($registry.aliases.PSObject.Properties.Name -contains $Workflow)) {
    Write-Error "Workflow '$Workflow' does not exist in the registry."
    exit 1
}

# Check if alias exists
if (-not ($registry.aliases.$Workflow.PSObject.Properties.Name -contains $Name)) {
    Write-Error "Alias '$Name' does not exist in workflow '$Workflow'."
    exit 1
}

# Store file path for potential deletion
$filePath = $registry.aliases.$Workflow.$Name.path
$fullFilePath = Join-Path "$PSScriptRoot\..\.." "1000xbrain\$filePath"

# Remove the alias
$tempWorkflow = $registry.aliases.$Workflow
$tempWorkflow.PSObject.Properties.Remove($Name)
$registry.aliases.$Workflow = $tempWorkflow
$registry.lastUpdated = (Get-Date).ToString("o")

# Save registry
$registry | ConvertTo-Json -Depth 10 | Set-Content -Path $RegistryPath

# Delete the file if requested
if ($DeleteFile -and (Test-Path $fullFilePath)) {
    Remove-Item -Path $fullFilePath -Force
    Write-Host "Deleted parameter file at $fullFilePath"
}

# Update all references to this alias
& "$PSScriptRoot\Update-AliasReferences.ps1" -Workflow $Workflow -Name $Name -Action "remove"

# Update documentation
& "$PSScriptRoot\Update-AliasDocumentation.ps1" -Workflow $Workflow

Write-Output "Alias '$Name' removed successfully from workflow '$Workflow'."
```

### 2.3 Alias Update Script

```powershell
# 1000xscripts/parameters/Update-ParameterAlias.ps1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Workflow,
    
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$false)]
    [string]$Description,
    
    [Parameter(Mandatory=$false)]
    [string]$Path,
    
    [Parameter(Mandatory=$false)]
    [string]$Category,
    
    [Parameter(Mandatory=$false)]
    [string]$MessageCommand,
    
    [Parameter(Mandatory=$false)]
    [string[]]$StandardParameters,
    
    [Parameter(Mandatory=$false)]
    [string[]]$UsageExamples,
    
    [Parameter(Mandatory=$false)]
    [string[]]$RelatedParameters,
    
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\alias-registry.json"
)

# Verify registry exists
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Alias registry not found at: $RegistryPath"
    exit 1
}

# Load registry
$registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json

# Check if workflow exists
if (-not ($registry.aliases.PSObject.Properties.Name -contains $Workflow)) {
    Write-Error "Workflow '$Workflow' does not exist in the registry."
    exit 1
}

# Check if alias exists
if (-not ($registry.aliases.$Workflow.PSObject.Properties.Name -contains $Name)) {
    Write-Error "Alias '$Name' does not exist in workflow '$Workflow'."
    exit 1
}

# Store old path for reference updates if path is changing
$oldPath = $registry.aliases.$Workflow.$Name.path

# Update alias properties
if ($Description) { $registry.aliases.$Workflow.$Name.description = $Description }
if ($Category) { $registry.aliases.$Workflow.$Name.category = $Category }
if ($MessageCommand) { $registry.aliases.$Workflow.$Name.messageCommand = $MessageCommand }
if ($StandardParameters) { $registry.aliases.$Workflow.$Name.standardParameters = $StandardParameters }
if ($UsageExamples) { $registry.aliases.$Workflow.$Name.usageExamples = $UsageExamples }
if ($RelatedParameters) { $registry.aliases.$Workflow.$Name.relatedParameters = $RelatedParameters }

# Update path and mdcPath if Path is provided
if ($Path) {
    $registry.aliases.$Workflow.$Name.path = $Path
    $registry.aliases.$Workflow.$Name.mdcPath = $Path -replace "\.md$", ".mdc"
    
    # Handle file movement if needed
    $oldFullPath = Join-Path "$PSScriptRoot\..\.." "1000xbrain\$oldPath"
    $newFullPath = Join-Path "$PSScriptRoot\..\.." "1000xbrain\$Path"
    
    if ((Test-Path $oldFullPath) -and ($oldFullPath -ne $newFullPath)) {
        # Create directory if it doesn't exist
        $newDirectory = Split-Path $newFullPath -Parent
        if (-not (Test-Path $newDirectory)) {
            New-Item -Path $newDirectory -ItemType Directory -Force
        }
        
        # Move the file
        Move-Item -Path $oldFullPath -Destination $newFullPath -Force
        Write-Host "Moved parameter file from $oldFullPath to $newFullPath"
    }
}

$registry.lastUpdated = (Get-Date).ToString("o")

# Save registry
$registry | ConvertTo-Json -Depth 10 | Set-Content -Path $RegistryPath

# Update documentation
& "$PSScriptRoot\Update-AliasDocumentation.ps1" -Workflow $Workflow

Write-Output "Alias '$Name' updated successfully in workflow '$Workflow'."
```

### 2.4 Reference Update Script

```powershell
# 1000xscripts/parameters/Update-AliasReferences.ps1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Workflow,
    
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet("add", "remove", "update")]
    [string]$Action,
    
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\alias-registry.json",
    
    [Parameter(Mandatory=$false)]
    [string]$ScanPath = "$PSScriptRoot\..\..\1000xbrain"
)

# Load registry
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Alias registry not found at: $RegistryPath"
    exit 1
}

$registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json

# Find all markdown files
$files = Get-ChildItem -Path $ScanPath -Recurse -Include "*.md" | 
         Where-Object { $_.FullName -notlike "*\node_modules\*" }

$updatedCount = 0

# Process based on action
switch ($Action) {
    "add" {
        # Nothing to do for add - new aliases don't have existing references
    }
    "remove" {
        # For remove, find and flag any references to the removed alias
        foreach ($file in $files) {
            $content = Get-Content -Path $file.FullName -Raw
            $aliasRef = "@alias:$Workflow:$Name"
            
            if ($content -match [regex]::Escape($aliasRef)) {
                Write-Warning "Found reference to removed alias in file: $($file.FullName)"
                Write-Warning "  Reference: $aliasRef"
                Write-Warning "  This reference will be broken. Please update the file."
            }
        }
    }
    "update" {
        # For update, update any filepath references to use the alias format
        $aliasValue = $registry.aliases.$Workflow.$Name
        $mdcPath = "@$($aliasValue.mdcPath)"
        $aliasRef = "@alias:$Workflow:$Name"
        
        foreach ($file in $files) {
            $content = Get-Content -Path $file.FullName -Raw
            $updatedContent = $content -replace [regex]::Escape($mdcPath), $aliasRef
            
            if ($content -ne $updatedContent) {
                Set-Content -Path $file.FullName -Value $updatedContent
                $updatedCount++
            }
        }
    }
}

if ($updatedCount -gt 0) {
    Write-Output "Updated references in $updatedCount files."
} else {
    Write-Output "No references needed updating."
}
```

### 2.5 Alias Conversion Script

```powershell
# 1000xscripts/parameters/Convert-ToAliasReferences.ps1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\alias-registry.json",
    
    [Parameter(Mandatory=$false)]
    [string]$ScanPath = "$PSScriptRoot\..\..\1000xbrain"
)

# Load registry
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Alias registry not found at: $RegistryPath"
    exit 1
}

$registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json

# Build conversion map
$conversionMap = @{}

foreach ($workflow in $registry.aliases.PSObject.Properties.Name) {
    foreach ($alias in $registry.aliases.$workflow.PSObject.Properties.Name) {
        $mdcPath = "@$($registry.aliases.$workflow.$alias.mdcPath)"
        $aliasRef = "@alias:$workflow:$alias"
        $conversionMap[$mdcPath] = $aliasRef
    }
}

# Find all markdown files
$files = Get-ChildItem -Path $ScanPath -Recurse -Include "*.md" | 
         Where-Object { $_.FullName -notlike "*\node_modules\*" }

$updatedCount = 0

# Process each file
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $updatedContent = $content
    
    foreach ($oldRef in $conversionMap.Keys) {
        $newRef = $conversionMap[$oldRef]
        $updatedContent = $updatedContent -replace [regex]::Escape($oldRef), $newRef
    }
    
    if ($content -ne $updatedContent) {
        Set-Content -Path $file.FullName -Value $updatedContent
        $updatedCount++
    }
}

Write-Output "Converted references in $updatedCount files."
```

### 2.6 Alias Resolution Script

```powershell
# 1000xscripts/parameters/Resolve-AliasReference.ps1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$AliasReference,
    
    [Parameter(Mandatory=$false)]
    [switch]$ReturnMdcPath,
    
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\alias-registry.json"
)

# Load registry
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Alias registry not found at: $RegistryPath"
    exit 1
}

$registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json

# Parse alias reference (format: @alias:workflow:name)
if ($AliasReference -match '@alias:([^:]+):(.+)') {
    $workflow = $matches[1]
    $name = $matches[2]
    
    # Check if workflow exists
    if (-not ($registry.aliases.PSObject.Properties.Name -contains $workflow)) {
        Write-Error "Workflow '$workflow' does not exist in the registry."
        exit 1
    }
    
    # Check if alias exists
    if (-not ($registry.aliases.$workflow.PSObject.Properties.Name -contains $name)) {
        Write-Error "Alias '$name' does not exist in workflow '$workflow'."
        exit 1
    }
    
    # Return the resolved path
    if ($ReturnMdcPath) {
        return $registry.aliases.$workflow.$name.mdcPath
    } else {
        return $registry.aliases.$workflow.$name.path
    }
} else {
    Write-Error "Invalid alias reference format: $AliasReference. Expected format: @alias:workflow:name"
    exit 1
}
```

## 3. Documentation Generation

### 3.1 Alias Documentation Generator

```powershell
# 1000xscripts/parameters/Update-AliasDocumentation.ps1
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Workflow,
    
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\alias-registry.json",
    
    [Parameter(Mandatory=$false)]
    [string]$OutputDir = "$PSScriptRoot\..\..\1000xbrain\workflows\$Workflow\parameter-documentation"
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

# Create output directory if it doesn't exist
if (-not (Test-Path $OutputDir)) {
    New-Item -Path $OutputDir -ItemType Directory -Force
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
    }
}

# Generate documentation for each category
foreach ($category in $categorizedAliases.Keys) {
    $outputFile = Join-Path $OutputDir "$category-parameters.md"
    
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
    }
    
    # Save the documentation file
    $content | Set-Content -Path $outputFile
    Write-Host "Generated documentation for $category parameters in $Workflow workflow."
}

# Generate cheatsheet
$cheatsheetFile = "$PSScriptRoot\..\..\1000xbrain\workflows\$Workflow\parameter-cheatsheet.md"
$cheatsheetContent = @"
# $Workflow Parameter Cheatsheet

This cheatsheet provides a quick reference for all parameters in the $Workflow workflow, organized by category.

## Parameters by Category

"@

foreach ($category in $categorizedAliases.Keys | Sort-Object) {
    $cheatsheetContent += @"

### $category Parameters

| Alias | Path | Message Command | Standard Parameters |
|-------|------|----------------|---------------------|
"@
    
    foreach ($param in $categorizedAliases[$category] | Sort-Object -Property Name) {
        $standardParams = if ($param.StandardParameters.Count -gt 0) { $param.StandardParameters -join ", " } else { "none" }
        $cheatsheetContent += @"
| `@alias:$Workflow:$($param.Name)` | `$($param.Path)` | $($param.MessageCommand) | $standardParams |
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

# Save the cheatsheet file
$cheatsheetContent | Set-Content -Path $cheatsheetFile
Write-Host "Generated parameter cheatsheet for $Workflow workflow."
```

## 4. Cross-Workflow Parameter Manager

### 4.1 Parameter Manager Implementation

```markdown
# Cross-Workflow Parameter Manager

## File Purpose and Relationship

This file serves as a project-rule-parameter for managing project-rule-parameters across all workflows in the cognitive architecture. It provides a structured approach to adding, removing, updating, and verifying parameters through the alias-based parameter management system.

## Usage as Project-Rule-Parameter

```
manage-parameters: add workflow="workflow-type" name="parameter-name" path="parameters/workflow/category/parameter-name.md" description="Parameter description" category="category" message-command="message-command" standard-parameters="param1,param2"
manage-parameters: remove workflow="workflow-type" name="parameter-name"
manage-parameters: update workflow="workflow-type" name="parameter-name" description="Updated description"
manage-parameters: verify workflow="workflow-type"
manage-parameters: convert-refs
```

## Workflow Requirements

**⚠️ CRITICAL: All parameter management MUST use this automated system rather than manual file editing to ensure consistency across all references.**

### Automation Process

When a `manage-parameters` message-command is received, the AI assistant should follow these steps:

1. Identify the operation (add, remove, update, verify, convert-refs)
2. Execute the appropriate PowerShell script from the `1000xscripts/parameters/` directory
3. Report the results back to the user

### Available Operations

#### Add Parameter

```
manage-parameters: add workflow="workflow-type" name="parameter-name" path="parameters/workflow/category/parameter-name.md" description="Parameter description" category="category" message-command="message-command" standard-parameters="param1,param2"
```

Optional parameters:
- `usage-examples`: Comma-separated list of usage examples
- `related-parameters`: Comma-separated list of related parameter names

Executes:
```powershell
./1000xscripts/parameters/Register-ParameterAlias.ps1 -Workflow "workflow-type" -Name "parameter-name" -Path "parameters/workflow/category/parameter-name.md" -Description "Parameter description" -Category "category" -MessageCommand "message-command" -StandardParameters "param1","param2"
```

#### Remove Parameter

```
manage-parameters: remove workflow="workflow-type" name="parameter-name"
```

Executes:
```powershell
./1000xscripts/parameters/Remove-ParameterAlias.ps1 -Workflow "workflow-type" -Name "parameter-name"
```

#### Update Parameter

```
manage-parameters: update workflow="workflow-type" name="parameter-name" [property="value"]
```

Updateable properties:
- `description`: Parameter description
- `path`: Parameter file path
- `category`: Parameter category
- `message-command`: Associated message command
- `standard-parameters`: Comma-separated list of standard parameters
- `usage-examples`: Comma-separated list of usage examples
- `related-parameters`: Comma-separated list of related parameter names

Executes:
```powershell
./1000xscripts/parameters/Update-ParameterAlias.ps1 -Workflow "workflow-type" -Name "parameter-name" -Description "Updated description"
```

#### Verify Parameters

```
manage-parameters: verify workflow="workflow-type"
```

Executes:
```powershell
./1000xscripts/parameters/Verify-AliasReferences.ps1 -Workflow "workflow-type"
```

#### Convert References

```
manage-parameters: convert-refs
```

Converts all filepath-based references to alias format:

Executes:
```powershell
./1000xscripts/parameters/Convert-ToAliasReferences.ps1
```

## Implementation Guidelines

1. The registry file is located at `1000xscripts/parameters/alias-registry.json`
2. All script calls should be made from the project root directory
3. When adding a new parameter, always check that the parameter file exists
4. When updating a parameter path, verify that the new path exists
5. Run the verification tool periodically to ensure consistency

## Error Handling

If an error occurs during script execution:

1. Clearly report the error to the user
2. Suggest possible solutions based on the error
3. Offer to retry the operation with corrected parameters if appropriate

## Workflow-Specific Considerations

### rules-workflow

- Parameters are typically stored in `parameters/rules/` directory
- Used primarily for cognitive architecture management
- Usually integrates with knowledge components

### front-end-workflow

- Parameters are typically stored in `parameters/front-end/` directory
- Used primarily for UI component implementation
- Often references React/NextJS patterns

### back-end-workflow

- Parameters are typically stored in `parameters/back-end/` directory
- Used primarily for API implementation
- Often references FastAPI patterns

## Examples

### Adding a New Parameter

```
manage-parameters: add workflow="rules-workflow" name="template-advanced" path="parameters/rules/plan-mode/template-advanced.md" description="Advanced template for rules workflow planning" category="plan-mode" message-command="plan-mode" standard-parameters="workflow-type"
```

### Removing a Parameter

```
manage-parameters: remove workflow="rules-workflow" name="template-advanced"
```

### Updating a Parameter

```
manage-parameters: update workflow="rules-workflow" name="template-advanced" description="Updated description for advanced template"
```

### Verifying Parameters

```
manage-parameters: verify workflow="rules-workflow"
```

### Converting Old References

```
manage-parameters: convert-refs
```

## Advantages of the Alias System

### 1. Path Independence

References use aliases instead of file paths:
- `@alias:rules:template-basic` instead of `@parameters/rules/plan-mode/template-basic.mdc`
- Even if the file moves, the alias remains valid

### 2. Workflow Isolation

Clear workflow namespacing prevents confusion between parameters with the same name:
- `@alias:rules:template-basic` vs `@alias:front-end:template-basic`
- Makes it obvious which workflow a parameter belongs to

### 3. Automatic Reference Management

When parameters are updated:
- Aliases are automatically resolved to current paths
- References are automatically updated across all files
- No manual grep/search needed to update references

### 4. Migration Path

The system provides a smooth migration path:
- Automatic conversion of old references to new alias format
- Backward compatibility with existing file paths
- Gradual adoption without breaking existing code

## File Standard Notice

This file follows the standard project-rule-parameter format with appropriate sections for usage documentation. USE WHEN implementing cross-workflow parameter management operations, automating parameter registry updates, or verifying parameter references throughout the codebase.
```

## 5. Implementation Plan

### Phase 1: Core Alias System Infrastructure

1. **Registry Setup**
   - Create `alias-registry.json` structure
   - Implement registry initialization logic
   - Define alias format standards

2. **Basic Script Implementation**
   - Implement `Register-ParameterAlias.ps1`
   - Implement `Remove-ParameterAlias.ps1`
   - Implement `Update-ParameterAlias.ps1`
   - Implement `Resolve-AliasReference.ps1`

3. **Testing and Verification**
   - Test alias registration
   - Verify alias resolution
   - Fix any issues in the core functionality

### Phase 2: Reference Management Implementation

1. **Reference Handling**
   - Implement `Update-AliasReferences.ps1`
   - Implement `Convert-ToAliasReferences.ps1`
   - Test reference updates across workflows

2. **Documentation Generator**
   - Implement `Update-AliasDocumentation.ps1`
   - Generate workflow-specific cheatsheets
   - Verify documentation quality

3. **Parameter Manager**
   - Implement Cross-Workflow Parameter Manager
   - Test all parameter operations
   - Verify cross-workflow functionality

### Phase 3: Migration and Integration

1. **Legacy System Migration**
   - Create script to migrate from old registry to alias registry
   - Convert existing references to alias format
   - Verify backward compatibility

2. **Integration with Existing Workflows**
   - Document integration points
   - Update workflow documentation
   - Create examples for each workflow

3. **Update Cheatsheet Generation**
   - Modify `Update-WorkflowCheatsheets.ps1` to include parameter management information
   - Ensure cheatsheet includes alias format documentation
   - Add examples for managing parameters with the new system

4. **System Testing**
   - Perform end-to-end testing
   - Verify cross-workflow functionality
   - Ensure backward compatibility

### Phase 4: Documentation and Refinement

1. **User Documentation**
   - Create detailed usage guides
   - Document advantages of alias system
   - Include migration instructions

2. **System Refinement**
   - Optimize performance
   - Enhance error handling
   - Add additional validations

3. **Future Extensions**
   - Document extension points
   - Plan for additional workflows
   - Create roadmap for enhancements

## 6. Success Criteria

The implementation will be considered successful when:

1. All parameter references use the alias format instead of direct file paths
2. Parameters can be moved without breaking references
3. Adding and removing parameters automatically updates all references
4. Documentation is automatically generated and kept current
5. Parameters with the same name in different workflows are properly isolated
6. The system works seamlessly across all workflows

## 7. Testing Strategy and Verification

A comprehensive testing strategy will ensure the parameter management system functions correctly and reliably across all workflows.

### 7.1. Unit Testing for Management Scripts

Each management script will have dedicated unit tests to verify its functionality:

```powershell
# 1000xscripts/tests/Test-ParameterManager.ps1

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$TestRegistry = "$PSScriptRoot\..\parameters\test-alias-registry.json"
)

# Setup test environment
function Setup-TestEnvironment {
    # Create test registry
    $initialRegistry = @{
        schemaVersion = "1.0"
        lastUpdated = (Get-Date).ToString("o")
        aliases = @{}
    }
    
    $initialRegistry | ConvertTo-Json -Depth 10 | Set-Content -Path $TestRegistry
    
    # Create test directories
    $testDirs = @(
        "parameters/rules/plan-mode",
        "parameters/rules/dev-mode",
        "parameters/front-end/plan-mode",
        "parameters/front-end/dev-mode"
    )
    
    foreach ($dir in $testDirs) {
        $testDir = Join-Path "$PSScriptRoot\..\..\1000xbrain\test" $dir
        if (-not (Test-Path $testDir)) {
            New-Item -Path $testDir -ItemType Directory -Force | Out-Null
        }
    }
}

# Clean up test environment
function Cleanup-TestEnvironment {
    if (Test-Path $TestRegistry) {
        Remove-Item -Path $TestRegistry -Force
    }
    
    $testRoot = "$PSScriptRoot\..\..\1000xbrain\test"
    if (Test-Path $testRoot) {
        Remove-Item -Path $testRoot -Recurse -Force
    }
}

# Test: Register-ParameterAlias
function Test-RegisterParameterAlias {
    # Setup
    Setup-TestEnvironment
    
    # Test registration
    $result = & "$PSScriptRoot\..\parameters\Register-ParameterAlias.ps1" `
              -Workflow "rules" `
              -Name "test-parameter" `
              -Path "parameters/rules/plan-mode/test-parameter.md" `
              -Description "Test parameter" `
              -Category "plan-mode" `
              -MessageCommand "plan-mode" `
              -StandardParameters @("workflow-type") `
              -RegistryPath $TestRegistry
    
    # Verify
    $registry = Get-Content -Path $TestRegistry -Raw | ConvertFrom-Json
    $success = $registry.aliases.rules.'test-parameter' -ne $null
    
    # Cleanup
    Cleanup-TestEnvironment
    
    return $success
}

# Test: Remove-ParameterAlias
function Test-RemoveParameterAlias {
    # Setup
    Setup-TestEnvironment
    
    # Add a parameter
    & "$PSScriptRoot\..\parameters\Register-ParameterAlias.ps1" `
      -Workflow "rules" `
      -Name "test-parameter" `
      -Path "parameters/rules/plan-mode/test-parameter.md" `
      -Description "Test parameter" `
      -Category "plan-mode" `
      -MessageCommand "plan-mode" `
      -StandardParameters @("workflow-type") `
      -RegistryPath $TestRegistry
    
    # Test removal
    $result = & "$PSScriptRoot\..\parameters\Remove-ParameterAlias.ps1" `
              -Workflow "rules" `
              -Name "test-parameter" `
              -RegistryPath $TestRegistry
    
    # Verify
    $registry = Get-Content -Path $TestRegistry -Raw | ConvertFrom-Json
    $success = (-not ($registry.aliases.rules.PSObject.Properties.Name -contains "test-parameter"))
    
    # Cleanup
    Cleanup-TestEnvironment
    
    return $success
}

# Test: Update-ParameterAlias
function Test-UpdateParameterAlias {
    # Setup
    Setup-TestEnvironment
    
    # Add a parameter
    & "$PSScriptRoot\..\parameters\Register-ParameterAlias.ps1" `
      -Workflow "rules" `
      -Name "test-parameter" `
      -Path "parameters/rules/plan-mode/test-parameter.md" `
      -Description "Test parameter" `
      -Category "plan-mode" `
      -MessageCommand "plan-mode" `
      -StandardParameters @("workflow-type") `
      -RegistryPath $TestRegistry
    
    # Test update
    $result = & "$PSScriptRoot\..\parameters\Update-ParameterAlias.ps1" `
              -Workflow "rules" `
              -Name "test-parameter" `
              -Description "Updated description" `
              -RegistryPath $TestRegistry
    
    # Verify
    $registry = Get-Content -Path $TestRegistry -Raw | ConvertFrom-Json
    $success = $registry.aliases.rules.'test-parameter'.description -eq "Updated description"
    
    # Cleanup
    Cleanup-TestEnvironment
    
    return $success
}

# Test: Resolve-AliasReference
function Test-ResolveAliasReference {
    # Setup
    Setup-TestEnvironment
    
    # Add a parameter
    & "$PSScriptRoot\..\parameters\Register-ParameterAlias.ps1" `
      -Workflow "rules" `
      -Name "test-parameter" `
      -Path "parameters/rules/plan-mode/test-parameter.md" `
      -Description "Test parameter" `
      -Category "plan-mode" `
      -MessageCommand "plan-mode" `
      -StandardParameters @("workflow-type") `
      -RegistryPath $TestRegistry
    
    # Test resolution
    $result = & "$PSScriptRoot\..\parameters\Resolve-AliasReference.ps1" `
              -AliasReference "@alias:rules:test-parameter" `
              -RegistryPath $TestRegistry
    
    # Verify
    $success = $result -eq "parameters/rules/plan-mode/test-parameter.md"
    
    # Cleanup
    Cleanup-TestEnvironment
    
    return $success
}

# Run all tests
function Run-AllTests {
    $tests = @(
        @{Name = "Register-ParameterAlias"; Function = { Test-RegisterParameterAlias }}
        @{Name = "Remove-ParameterAlias"; Function = { Test-RemoveParameterAlias }}
        @{Name = "Update-ParameterAlias"; Function = { Test-UpdateParameterAlias }}
        @{Name = "Resolve-AliasReference"; Function = { Test-ResolveAliasReference }}
    )
    
    $results = @()
    
    foreach ($test in $tests) {
        $success = & $test.Function
        $results += [PSCustomObject]@{
            Test = $test.Name
            Result = if ($success) { "PASS" } else { "FAIL" }
        }
    }
    
    return $results
}
```

### 7.2. Integration Testing

Integration tests will verify the system works as a whole across multiple workflows:

```powershell
# 1000xscripts/tests/Test-Integration.ps1

[CmdletBinding()]
param()

# Test end-to-end workflow
function Test-EndToEndWorkflow {
    # 1. Setup test environment
    $TestRegistry = "$PSScriptRoot\..\parameters\test-integration-registry.json"
    
    # Create test registry
    $initialRegistry = @{
        schemaVersion = "1.0"
        lastUpdated = (Get-Date).ToString("o")
        aliases = @{}
    }
    
    $initialRegistry | ConvertTo-Json -Depth 10 | Set-Content -Path $TestRegistry
    
    # 2. Test alias registration across multiple workflows
    $workflows = @("rules", "front-end")
    $success = $true
    
    foreach ($workflow in $workflows) {
        # Register parameter
        & "$PSScriptRoot\..\parameters\Register-ParameterAlias.ps1" `
          -Workflow $workflow `
          -Name "test-parameter" `
          -Path "parameters/$workflow/plan-mode/test-parameter.md" `
          -Description "Test parameter for $workflow" `
          -Category "plan-mode" `
          -MessageCommand "plan-mode" `
          -StandardParameters @("workflow-type") `
          -RegistryPath $TestRegistry
        
        # Verify registration
        $registry = Get-Content -Path $TestRegistry -Raw | ConvertFrom-Json
        if ($registry.aliases.$workflow.'test-parameter' -eq $null) {
            $success = $false
            Write-Error "Failed to register parameter for workflow: $workflow"
        }
    }
    
    # 3. Test cross-workflow isolation
    $registry = Get-Content -Path $TestRegistry -Raw | ConvertFrom-Json
    
    # Verify each workflow has its own parameter with the same name
    if ($registry.aliases.rules.'test-parameter'.path -eq $registry.aliases.'front-end'.'test-parameter'.path) {
        $success = $false
        Write-Error "Workflow isolation failed: parameters have the same path"
    }
    
    # 4. Clean up
    Remove-Item -Path $TestRegistry -Force
    
    return $success
}
```

### 7.3. Verification Scripts

A comprehensive verification script will check the consistency of the parameter registry and references:

```powershell
# 1000xscripts/parameters/Verify-AliasRegistry.ps1

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\alias-registry.json",
    
    [Parameter(Mandatory=$false)]
    [string]$ScanPath = "$PSScriptRoot\..\..\1000xbrain"
)

# Load registry
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Alias registry not found at: $RegistryPath"
    exit 1
}

$registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json

# Verification results
$results = @{
    TotalParameters = 0
    ValidParameters = 0
    MissingFiles = @()
    OrphanedFiles = @()
    BrokenReferences = @()
    WorkflowStats = @{}
}

# 1. Verify all registered parameters exist
foreach ($workflow in $registry.aliases.PSObject.Properties.Name) {
    if (-not $results.WorkflowStats.ContainsKey($workflow)) {
        $results.WorkflowStats[$workflow] = @{
            Total = 0
            Valid = 0
            Invalid = 0
        }
    }
    
    foreach ($name in $registry.aliases.$workflow.PSObject.Properties.Name) {
        $results.TotalParameters++
        $results.WorkflowStats[$workflow].Total++
        
        $path = $registry.aliases.$workflow.$name.path
        $fullPath = Join-Path "$PSScriptRoot\..\..\1000xbrain" $path
        
        if (-not (Test-Path $fullPath)) {
            $results.MissingFiles += @{
                Workflow = $workflow
                Name = $name
                Path = $path
            }
            $results.WorkflowStats[$workflow].Invalid++
        } else {
            $results.ValidParameters++
            $results.WorkflowStats[$workflow].Valid++
        }
    }
}

# 2. Find all parameter files in the parameters directory
$parameterFiles = Get-ChildItem -Path "$ScanPath\parameters" -Recurse -Include "*.md" |
                  Where-Object { $_.FullName -notlike "*\node_modules\*" -and $_.Name -ne "README.md" }

# 3. Check for orphaned parameter files (files not in registry)
foreach ($file in $parameterFiles) {
    $relativePath = $file.FullName.Replace("$ScanPath\", "").Replace("\", "/")
    
    $found = $false
    foreach ($workflow in $registry.aliases.PSObject.Properties.Name) {
        foreach ($name in $registry.aliases.$workflow.PSObject.Properties.Name) {
            if ($registry.aliases.$workflow.$name.path -eq $relativePath) {
                $found = $true
                break
            }
        }
        if ($found) { break }
    }
    
    if (-not $found) {
        $results.OrphanedFiles += $relativePath
    }
}
```

### 7.4. Validation Checklist

Before deployment, the system must pass the following validation checks:

**Registry Validation**:
- [ ] Registry schema is valid
- [ ] All workflows have proper namespaces
- [ ] All parameters have required metadata
- [ ] No duplicate parameters within workflows

**Script Validation**:
- [ ] All management scripts execute without errors
- [ ] Scripts handle edge cases and error conditions
- [ ] Scripts validate inputs appropriately
- [ ] Scripts provide clear error messages

**Reference Validation**:
- [ ] All alias references resolve correctly
- [ ] No broken references in documentation
- [ ] Path changes do not break references
- [ ] Cross-workflow references work correctly

**Documentation Validation**:
- [ ] Generated documentation is complete and accurate
- [ ] Cheatsheets include the new alias format
- [ ] Usage examples are up to date
- [ ] Parameter categories are correctly represented

### 7.5. Testing Workflow

The testing process will follow this workflow:

1. **Unit Testing**:
   - Test each script individually
   - Verify all functions work as expected
   - Check edge cases and error handling

2. **Integration Testing**:
   - Test cross-workflow functionality
   - Verify reference management across workflows
   - Test documentation generation

3. **System Testing**:
   - Test end-to-end workflows
   - Verify all components work together
   - Test with realistic parameter sets

4. **Verification Testing**:
   - Run verification scripts
   - Generate verification reports
   - Address any issues found

5. **Performance Testing**:
   - Test with large parameter sets
   - Measure script execution times
   - Optimize for performance if needed

6. **User Acceptance Testing**:
   - Have team members use the new system
   - Gather feedback on usability
   - Make adjustments as needed

7. **Regression Testing**:
   - Ensure new system doesn't break existing functionality
   - Verify backward compatibility
   - Check all workflows still function correctly

## 8. Implementation Plan

### Phase 1: Core Alias System Infrastructure

1. **Registry Setup**
   - Create `alias-registry.json` structure
   - Implement registry initialization logic
   - Define alias format standards

2. **Basic Script Implementation**
   - Implement `Register-ParameterAlias.ps1`
   - Implement `Remove-ParameterAlias.ps1`
   - Implement `Update-ParameterAlias.ps1`
   - Implement `Resolve-AliasReference.ps1`

3. **Testing and Verification**
   - Test alias registration
   - Verify alias resolution
   - Fix any issues in the core functionality

### Phase 2: Reference Management Implementation

1. **Reference Handling**
   - Implement `Update-AliasReferences.ps1`
   - Implement `Convert-ToAliasReferences.ps1`
   - Test reference updates across workflows

2. **Documentation Generator**
   - Implement `Update-AliasDocumentation.ps1`
   - Generate workflow-specific cheatsheets
   - Verify documentation quality

3. **Parameter Manager**
   - Implement Cross-Workflow Parameter Manager
   - Test all parameter operations
   - Verify cross-workflow functionality

### Phase 3: Migration and Integration

1. **Legacy System Migration**
   - Create script to migrate from old registry to alias registry
   - Convert existing references to alias format
   - Verify backward compatibility

2. **Integration with Existing Workflows**
   - Document integration points
   - Update workflow documentation
   - Create examples for each workflow

3. **Update Cheatsheet Generation**
   - Modify `Update-WorkflowCheatsheets.ps1` to include parameter management information
   - Ensure cheatsheet includes alias format documentation
   - Add examples for managing parameters with the new system

4. **System Testing**
   - Perform end-to-end testing
   - Verify cross-workflow functionality
   - Ensure backward compatibility

### Phase 4: Documentation and Refinement

1. **User Documentation**
   - Create detailed usage guides
   - Document advantages of alias system
   - Include migration instructions

2. **System Refinement**
   - Optimize performance
   - Enhance error handling
   - Add additional validations

3. **Future Extensions**
   - Document extension points
   - Plan for additional workflows
   - Create roadmap for enhancements

## 9. Note for Future Implementation

After implementing this system, all parameter references should be gradually migrated to the alias format. This will eliminate the need to maintain path-based references and make the system more robust against future reorganizations.

## 7.1. Enhancing Workflow Cheatsheets

As part of Phase 3, we'll update the `Update-WorkflowCheatsheets.ps1` script to include a dedicated section about parameter management in all generated cheatsheets. This will help users understand how to use the alias-based parameter system correctly.

```powershell
# Add this function to 1000xscripts/report-scripts/Update-WorkflowCheatsheets.ps1

function Add-ParameterManagementSection {
    param (
        [string]$WorkflowType
    )
    
    $lines = New-Object System.Collections.ArrayList
    
    [void]$lines.Add("")
    [void]$lines.Add("## Parameter Management")
    [void]$lines.Add("")
    [void]$lines.Add("Parameters can be referenced using the alias format which provides path independence:")
    [void]$lines.Add("")
    [void]$lines.Add("```")
    [void]$lines.Add("@alias:$($WorkflowType):parameter-name")
    [void]$lines.Add("```")
    [void]$lines.Add("")
    [void]$lines.Add("### Managing Parameters")
    [void]$lines.Add("")
    [void]$lines.Add("Use the `manage-parameters` command to add, remove, update, or verify parameters:")
    [void]$lines.Add("")
    [void]$lines.Add("| Operation | Syntax | Description |")
    [void]$lines.Add("|-----------|--------|-------------|")
    [void]$lines.Add("| Add | `manage-parameters: add workflow=\"$WorkflowType\" name=\"parameter-name\" path=\"parameters/$WorkflowType/category/parameter-name.md\" description=\"Description\" category=\"category\" message-command=\"command\" standard-parameters=\"param1,param2\"` | Add a new parameter |")
    [void]$lines.Add("| Remove | `