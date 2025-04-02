[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$true)]
    [string]$Path,
    
    [Parameter(Mandatory=$true)]
    [string]$Description,
    
    [Parameter(Mandatory=$true)]
    [string]$Category,
    
    [Parameter(Mandatory=$false)]
    [string[]]$UsageExamples = @(),
    
    [Parameter(Mandatory=$false)]
    [string[]]$RelatedParameters = @(),
    
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\parameter-registry.json"
)

# Load registry
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Parameter registry not found at: $RegistryPath"
    exit 1
}

$registry = Get-Content -Path $RegistryPath | ConvertFrom-Json

# Check if parameter already exists
if ($registry.parameters.PSObject.Properties.Name -contains $Name) {
    Write-Error "Parameter '$Name' already exists in the registry."
    exit 1
}

# Add new parameter
$newParam = [PSCustomObject]@{
    path = $Path
    description = $Description
    category = $Category
    usageExamples = $UsageExamples
    relatedParameters = $RelatedParameters
}

# Create a temporary object for adding the new property
$tempParams = $registry.parameters
$tempParams | Add-Member -MemberType NoteProperty -Name $Name -Value $newParam
$registry.parameters = $tempParams
$registry.lastUpdated = Get-Date -Format "yyyy-MM-dd"

# Save registry
$registry | ConvertTo-Json -Depth 5 | Set-Content -Path $RegistryPath

Write-Host "Parameter '$Name' added to registry successfully."

# Check if the parameter file exists
$fullPath = Join-Path (Split-Path $PSScriptRoot -Parent) -ChildPath "..\1000xbrain\$Path"
if (-not (Test-Path $fullPath)) {
    Write-Warning "Parameter file does not exist at: $fullPath"
    Write-Warning "Make sure to create the parameter file or verify the path is correct."
}

# Return the added parameter
return $newParam 