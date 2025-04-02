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