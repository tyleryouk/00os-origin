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
    [string]$ComponentAssociation,
    
    [Parameter(Mandatory=$false)]
    [string]$UiPattern,
    
    [Parameter(Mandatory=$false)]
    [string]$Framework,
    
    [Parameter(Mandatory=$false)]
    [hashtable]$AdditionalMetadata = @{},
    
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
    usageExamples = $UsageExamples -replace '@parameters/.*\.mdc', "@alias:$($Workflow):$($Name)"
    relatedParameters = $RelatedParameters
}

# Add front-end specific metadata if applicable
if ($Workflow -eq "front-end") {
    if ($ComponentAssociation) {
        $newAlias["componentAssociation"] = $ComponentAssociation
    }
    
    if ($UiPattern) {
        $newAlias["uiPattern"] = $UiPattern
    }
    
    if ($Framework) {
        $newAlias["framework"] = $Framework
    }
}

# Add any additional metadata
if ($AdditionalMetadata.Count -gt 0) {
    foreach ($key in $AdditionalMetadata.Keys) {
        $newAlias[$key] = $AdditionalMetadata[$key]
    }
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
                    $newExample = $example -replace $pattern, "@alias:$($Workflow):$($Name)"
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

This file serves as a project-rule-parameter for $Description. It can be referenced using the alias: `@alias:$($Workflow):$($Name)`.

## Usage as Project-Rule-Parameter

```
$($UsageExamples -join "`n")
```

## Implementation Guidelines

[Implementation details...]

## File Standard Notice

This file follows the standard project-rule-parameter format with appropriate sections for usage documentation. 
"@

    # Additional front-end specific content
    if ($Workflow -eq "front-end") {
        $frontEndContent = @"

## Component Association

$($ComponentAssociation ?? "This parameter is not associated with a specific component.")

## UI Pattern

$($UiPattern ?? "This parameter is not associated with a specific UI pattern.")

## Framework

$($Framework ?? "This parameter is not associated with a specific framework.")
"@
        $templateContent += $frontEndContent
    }

    # Create directory if it doesn't exist
    $parameterDirectory = Split-Path $parameterFilePath -Parent
    if (-not (Test-Path $parameterDirectory)) {
        New-Item -Path $parameterDirectory -ItemType Directory -Force
    }

    # Create the parameter file
    $templateContent | Set-Content -Path $parameterFilePath
    Write-Host "Created parameter file at $parameterFilePath"
}

# Check if Update-AliasDocumentation.ps1 exists
$updateDocsScript = "$PSScriptRoot\Update-AliasDocumentation.ps1"
if (Test-Path $updateDocsScript) {
    # Update documentation
    & $updateDocsScript -Workflow $Workflow
} else {
    Write-Warning "Documentation update script not found. Skipping documentation generation."
}

Write-Output "Alias '$Name' registered successfully for workflow '$Workflow'." 