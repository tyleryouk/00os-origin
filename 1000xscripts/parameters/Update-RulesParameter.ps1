[CmdletBinding()]
param(
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
    [string]$StandardParameters,
    
    [Parameter(Mandatory=$false)]
    [string]$UsageExamples,
    
    [Parameter(Mandatory=$false)]
    [string]$RelatedParameters,
    
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

# Convert comma-separated strings to arrays if provided
if ($StandardParameters) {
    $StandardParametersArray = $StandardParameters -split ',' | ForEach-Object { $_.Trim() }
} else {
    $StandardParametersArray = $null
}

if ($UsageExamples) {
    $UsageExamplesArray = $UsageExamples -split ',' | ForEach-Object { $_.Trim() }
} else {
    $UsageExamplesArray = $null
}

if ($RelatedParameters) {
    $RelatedParametersArray = $RelatedParameters -split ',' | ForEach-Object { $_.Trim() }
} else {
    $RelatedParametersArray = $null
}

# Call the unified parameter management script
$params = @{
    Operation = "update"
    Workflow = "rules-workflow"
    Name = $Name
}

# Add optional parameters if provided
if ($Description) { $params.Description = $Description }
if ($Path) { $params.Path = $Path }
if ($Category) { $params.Category = $Category }
if ($MessageCommand) { $params.MessageCommand = $MessageCommand }
if ($StandardParametersArray) { $params.StandardParameters = $StandardParametersArray }
if ($UsageExamplesArray) { $params.UsageExamples = $UsageExamplesArray }
if ($RelatedParametersArray) { $params.RelatedParameters = $RelatedParametersArray }

# Check if parameter exists before attempting update
if (Test-Path $RegistryPath) {
    $registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json
    
    if (-not ($registry.parameters.workflows.PSObject.Properties.Name -contains "rules-workflow")) {
        Write-Error "Workflow 'rules-workflow' not found in registry."
        exit 1
    }
    
    if (-not ($registry.parameters.workflows."rules-workflow".parameters.PSObject.Properties.Name -contains $Name)) {
        Write-Error "Parameter '$Name' not found in rules-workflow."
        exit 1
    }
    
    # Get current parameter info for reference updating
    $oldParam = $registry.parameters.workflows."rules-workflow".parameters.$Name
    
    # If path is being updated, check if we need to update file content
    if ($Path -and $Path -ne $oldParam.path) {
        # Check if old file exists
        if (Test-Path $oldParam.path) {
            # Check if new file exists
            if (-not (Test-Path $Path)) {
                # Ensure directory exists
                $directory = [System.IO.Path]::GetDirectoryName($Path)
                if (-not (Test-Path $directory)) {
                    New-Item -Path $directory -ItemType Directory -Force | Out-Null
                    Write-Log "Created directory: $directory" "INFO"
                }
                
                # Copy content from old file to new file
                Copy-Item -Path $oldParam.path -Destination $Path
                Write-Log "Copied content from $($oldParam.path) to $Path" "INFO"
            } else {
                Write-Log "New path $Path already exists, not overwriting" "WARN"
            }
        }
    }
    
    # Execute the parameter management script
    & "$PSScriptRoot\Manage-UnifiedParameters.ps1" @params
    
    # Check if we need to update references to this parameter
    if ($Path -and $Path -ne $oldParam.path) {
        Write-Log "Path updated from $($oldParam.path) to $Path. Checking for references..." "INFO"
        
        # Define search patterns for the old path
        $oldMdcPath = $oldParam.path -replace "\.md$", ".mdc"
        $patterns = @(
            "(@parameters/rules/.+/$Name\.mdc)",
            "(@alias:rules:$Name)"
        )
        
        $refsFound = 0
        
        foreach ($pattern in $patterns) {
            Write-Log "Searching for pattern: $pattern" "INFO"
            
            # Use PowerShell to find references
            $refs = Get-ChildItem -Path "parameters", "1000xbrain" -Recurse -File -Include "*.md" | 
                    Select-String -Pattern $pattern
            
            foreach ($ref in $refs) {
                Write-Log "Found reference in: $($ref.Path)" "INFO"
                $refsFound++
                
                # Path reference updates are typically done through the alias system
                # This is just informational
            }
        }
        
        Write-Log "Reference scan complete. Found $refsFound references." "INFO"
        if ($refsFound -gt 0) {
            Write-Log "References will be automatically resolved through the alias system." "INFO"
        }
    }
    
    Write-Log "Parameter '$Name' updated in rules-workflow successfully" "INFO"
} else {
    Write-Error "Registry file not found: $RegistryPath"
    exit 1
} 