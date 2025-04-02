[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$false)]
    [string]$Path,
    
    [Parameter(Mandatory=$false)]
    [string]$Description,
    
    [Parameter(Mandatory=$false)]
    [string]$Category,
    
    [Parameter(Mandatory=$false)]
    [string[]]$UsageExamples,
    
    [Parameter(Mandatory=$false)]
    [string[]]$RelatedParameters,
    
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\parameter-registry.json"
)

# Load registry
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Parameter registry not found at: $RegistryPath"
    exit 1
}

$registry = Get-Content -Path $RegistryPath | ConvertFrom-Json

# Check if parameter exists
if (-not ($registry.parameters.PSObject.Properties.Name -contains $Name)) {
    Write-Error "Parameter '$Name' does not exist in the registry."
    exit 1
}

# Store original parameter for comparison
$originalParam = $registry.parameters.$Name

# Create updated parameter
$updatedParam = [PSCustomObject]@{
    path = $Path ?? $originalParam.path
    description = $Description ?? $originalParam.description
    category = $Category ?? $originalParam.category
    usageExamples = $UsageExamples ?? $originalParam.usageExamples
    relatedParameters = $RelatedParameters ?? $originalParam.relatedParameters
}

# Update registry
$registry.parameters.$Name = $updatedParam
$registry.lastUpdated = Get-Date -Format "yyyy-MM-dd"

# Save registry
$registry | ConvertTo-Json -Depth 5 | Set-Content -Path $RegistryPath

Write-Host "Parameter '$Name' updated successfully."

# Report changes
if ($Path -and $Path -ne $originalParam.path) {
    Write-Host "Path changed: $($originalParam.path) -> $Path"
    
    # Check if the new parameter file exists
    $fullPath = Join-Path (Split-Path $PSScriptRoot -Parent) -ChildPath "..\1000xbrain\$Path"
    if (-not (Test-Path $fullPath)) {
        Write-Warning "New parameter file does not exist at: $fullPath"
        Write-Warning "Make sure to create the parameter file or verify the path is correct."
    }
}

if ($Description -and $Description -ne $originalParam.description) {
    Write-Host "Description changed."
}

if ($Category -and $Category -ne $originalParam.category) {
    Write-Host "Category changed: $($originalParam.category) -> $Category"
}

# Return update information
return @{
    Name = $Name
    Original = $originalParam
    Updated = $updatedParam
} 