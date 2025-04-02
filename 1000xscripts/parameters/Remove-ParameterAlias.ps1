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

# Check if Update-AliasReferences.ps1 exists
$updateRefsScript = "$PSScriptRoot\Update-AliasReferences.ps1"
if (Test-Path $updateRefsScript) {
    # Update references
    & $updateRefsScript -Workflow $Workflow -Name $Name -Action "remove"
} else {
    Write-Warning "Reference update script not found. You may need to manually update any references to this alias."
}

# Check if Update-AliasDocumentation.ps1 exists
$updateDocsScript = "$PSScriptRoot\Update-AliasDocumentation.ps1"
if (Test-Path $updateDocsScript) {
    # Update documentation
    & $updateDocsScript -Workflow $Workflow
} else {
    Write-Warning "Documentation update script not found. Skipping documentation generation."
}

Write-Output "Alias '$Name' removed successfully from workflow '$Workflow'." 