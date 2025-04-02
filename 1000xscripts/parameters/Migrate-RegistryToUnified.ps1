[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$ParameterRegistryPath = "$PSScriptRoot\parameter-registry.json",
    
    [Parameter(Mandatory=$false)]
    [string]$AliasRegistryPath = "$PSScriptRoot\alias-registry.json",
    
    [Parameter(Mandatory=$false)]
    [string]$UnifiedRegistryPath = "$PSScriptRoot\parameter-registry-unified.json",
    
    [Parameter(Mandatory=$false)]
    [switch]$Force
)

function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] [$Level] $Message"
}

function Backup-File {
    param(
        [string]$FilePath
    )
    
    $backupFolder = "$PSScriptRoot\backup"
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $fileName = [System.IO.Path]::GetFileName($FilePath)
    $backupFile = "$backupFolder\$fileName.$timestamp.bak"
    
    if (-not (Test-Path $backupFolder)) {
        New-Item -Path $backupFolder -ItemType Directory -Force | Out-Null
    }
    
    Copy-Item -Path $FilePath -Destination $backupFile -Force
    Write-Log "Backed up $FilePath to $backupFile" "INFO"
}

# Check if unified registry already exists
if (Test-Path $UnifiedRegistryPath) {
    if (-not $Force) {
        Write-Log "Unified registry already exists at: $UnifiedRegistryPath" "ERROR"
        Write-Log "Use -Force to overwrite the existing file" "ERROR"
        exit 1
    } else {
        Write-Log "Force flag set. Backing up existing unified registry..." "WARN"
        Backup-File -FilePath $UnifiedRegistryPath
    }
}

# Ensure source registries exist
if (-not (Test-Path $ParameterRegistryPath)) {
    Write-Log "Parameter registry not found at: $ParameterRegistryPath" "ERROR"
    exit 1
}

if (-not (Test-Path $AliasRegistryPath)) {
    Write-Log "Alias registry not found at: $AliasRegistryPath" "ERROR"
    exit 1
}

# Load existing registries
Write-Log "Loading parameter registry from $ParameterRegistryPath..."
$paramRegistry = Get-Content -Path $ParameterRegistryPath -Raw | ConvertFrom-Json

Write-Log "Loading alias registry from $AliasRegistryPath..."
$aliasRegistry = Get-Content -Path $AliasRegistryPath -Raw | ConvertFrom-Json

# Create unified registry schema
$unifiedRegistry = @{
    schemaVersion = "2.0"
    lastUpdated = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
    parameters = @{
        workflows = @{}
    }
}

# Process standard parameter registry
Write-Log "Processing parameter registry entries..."
foreach ($paramName in $paramRegistry.parameters.PSObject.Properties.Name) {
    $param = $paramRegistry.parameters.$paramName
    
    # Assuming all parameters without workflow specification are for rules-workflow
    if (-not $unifiedRegistry.parameters.workflows.ContainsKey("rules-workflow")) {
        $unifiedRegistry.parameters.workflows["rules-workflow"] = @{
            parameters = @{}
        }
    }
    
    $unifiedRegistry.parameters.workflows["rules-workflow"].parameters[$paramName] = @{
        path = $param.path
        mdcPath = $param.path -replace "\.md$", ".mdc"
        description = $param.description
        category = $param.category
        messageCommand = if ($param.path -match "dev-mode") { "dev-mode" } else { "plan-mode" }
        standardParameters = @("workflow-type")
        usageExamples = $param.usageExamples
        relatedParameters = $param.relatedParameters
    }
    
    Write-Log "Migrated parameter: $paramName" "INFO"
}

# Process alias registry
Write-Log "Processing alias registry entries..."
foreach ($workflowName in $aliasRegistry.aliases.PSObject.Properties.Name) {
    if (-not $unifiedRegistry.parameters.workflows.ContainsKey($workflowName)) {
        $unifiedRegistry.parameters.workflows[$workflowName] = @{
            parameters = @{}
        }
    }
    
    foreach ($aliasName in $aliasRegistry.aliases.$workflowName.PSObject.Properties.Name) {
        $alias = $aliasRegistry.aliases.$workflowName.$aliasName
        
        # Skip if already added from parameter registry
        if ($workflowName -eq "rules-workflow" -and $unifiedRegistry.parameters.workflows["rules-workflow"].parameters.ContainsKey($aliasName)) {
            Write-Log "Skipping alias already added from parameter registry: $aliasName" "WARN"
            continue
        }
        
        $unifiedRegistry.parameters.workflows[$workflowName].parameters[$aliasName] = @{
            path = $alias.path
            mdcPath = $alias.mdcPath
            description = $alias.description
            category = $alias.category
            messageCommand = $alias.messageCommand
            standardParameters = $alias.standardParameters
            usageExamples = $alias.usageExamples
            relatedParameters = $alias.relatedParameters
        }
        
        Write-Log "Migrated alias: $workflowName/$aliasName" "INFO"
    }
}

# Convert to JSON and save to file
$jsonOutput = $unifiedRegistry | ConvertTo-Json -Depth 10
Set-Content -Path $UnifiedRegistryPath -Value $jsonOutput

Write-Log "Migration completed. Unified registry saved to: $UnifiedRegistryPath" "INFO"
Write-Log "Total parameters migrated: $($unifiedRegistry.parameters.workflows | ForEach-Object { $_.parameters.Count })" "INFO"

# Output workflow statistics
foreach ($workflowName in $unifiedRegistry.parameters.workflows.Keys) {
    $paramCount = $unifiedRegistry.parameters.workflows[$workflowName].parameters.Count
    Write-Log "Workflow '$workflowName': $paramCount parameters" "INFO"
}

Write-Log "Registry migration completed successfully." "INFO" 