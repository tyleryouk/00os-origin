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

# Check if Update-AliasReferences.ps1 exists and Path was changed
if ($Path -and (Test-Path "$PSScriptRoot\Update-AliasReferences.ps1")) {
    # Update references
    & "$PSScriptRoot\Update-AliasReferences.ps1" -Workflow $Workflow -Name $Name -Action "update"
}

# Check if Update-AliasDocumentation.ps1 exists
$updateDocsScript = "$PSScriptRoot\Update-AliasDocumentation.ps1"
if (Test-Path $updateDocsScript) {
    # Update documentation
    & $updateDocsScript -Workflow $Workflow
} else {
    Write-Warning "Documentation update script not found. Skipping documentation generation."
}

Write-Output "Alias '$Name' updated successfully in workflow '$Workflow'." 