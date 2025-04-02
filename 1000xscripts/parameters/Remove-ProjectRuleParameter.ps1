[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
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

# Store parameter details for reporting
$paramDetails = $registry.parameters.$Name

# Create a new parameters object without the removed parameter
$newParams = [PSCustomObject]@{}
foreach ($paramName in $registry.parameters.PSObject.Properties.Name) {
    if ($paramName -ne $Name) {
        $newParams | Add-Member -MemberType NoteProperty -Name $paramName -Value $registry.parameters.$paramName
    }
}

# Update the registry
$registry.parameters = $newParams
$registry.lastUpdated = Get-Date -Format "yyyy-MM-dd"

# Save registry
$registry | ConvertTo-Json -Depth 5 | Set-Content -Path $RegistryPath

Write-Host "Parameter '$Name' removed from registry successfully."
Write-Host "Path was: $($paramDetails.path)"
Write-Host "Note: The actual parameter file was not deleted. If needed, manually delete: $($paramDetails.path)"

# Return the removed parameter details
return $paramDetails 