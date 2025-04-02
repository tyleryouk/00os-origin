[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$true)]
    [string]$Category,
    
    [Parameter(Mandatory=$true)]
    [string]$MessageCommand,
    
    [Parameter(Mandatory=$false)]
    [string]$Description,
    
    [Parameter(Mandatory=$false)]
    [string]$Path,
    
    [Parameter(Mandatory=$false)]
    [string[]]$StandardParameters,
    
    [Parameter(Mandatory=$false)]
    [string[]]$UsageExamples,
    
    [Parameter(Mandatory=$false)]
    [string[]]$RelatedParameters,
    
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\parameter-registry-unified.json"
)

function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] [$Level] $Message"
}

# Determine default values if not provided
if (-not $Description) {
    $Description = "Parameter for $MessageCommand in the rules-workflow"
}

if (-not $Path) {
    $Path = "parameters/rules/$Category/$Name.md"
}

if (-not $StandardParameters) {
    $StandardParameters = @()
}

if (-not $UsageExamples) {
    $cmdExample = "$MessageCommand"
    if ($cmdExample -notmatch ":$") {
        $cmdExample += ":"
    }
    $cmdExample += " @parameters/rules/$Category/$Name.mdc"
    
    $UsageExamples = @(
        $cmdExample
    )
}

# Call the unified parameter management script
$params = @{
    Operation = "add"
    Workflow = "rules-workflow"
    Name = $Name
    Path = $Path
    Description = $Description
    Category = $Category
    MessageCommand = $MessageCommand
}

if ($StandardParameters) { $params.StandardParameters = $StandardParameters }
if ($UsageExamples) { $params.UsageExamples = $UsageExamples }
if ($RelatedParameters) { $params.RelatedParameters = $RelatedParameters }

# Check if path exists, create a templated file if it doesn't
if (-not (Test-Path $Path)) {
    Write-Log "Parameter file not found at: $Path. Creating template file." "INFO"
    
    # Ensure directory exists
    $directory = [System.IO.Path]::GetDirectoryName($Path)
    if (-not (Test-Path $directory)) {
        New-Item -Path $directory -ItemType Directory -Force | Out-Null
        Write-Log "Created directory: $directory" "INFO"
    }
    
    # Create basic template file
    $cmdExample = "$MessageCommand"
    if ($cmdExample -notmatch ":$") {
        $cmdExample += ":"
    }
    $cmdExample += " @parameters/rules/$Category/$Name.mdc"
    
    $templateContent = @"
# $Name

## File Purpose and Relationship

$Description

## Usage as Project-Rule-Parameter

```
$cmdExample
```

## Implementation Guidelines

[Implementation details]

## Examples

[Usage examples]

## File Standard Notice

This file follows the standard project-rule-parameter format with appropriate sections for usage documentation. USE WHEN [usage context].
"@
    
    Set-Content -Path $Path -Value $templateContent
    Write-Log "Created template file at: $Path" "INFO"
}

# Execute the parameter management script
& "$PSScriptRoot\Manage-UnifiedParameters.ps1" @params

Write-Log "Parameter '$Name' added to rules-workflow successfully" "INFO" 