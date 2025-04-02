[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("add", "remove", "update", "verify", "list")]
    [string]$Operation,
    
    [Parameter(Mandatory=$false)]
    [string]$Workflow,
    
    [Parameter(Mandatory=$false)]
    [string]$Name,
    
    [Parameter(Mandatory=$false)]
    [string]$Path,
    
    [Parameter(Mandatory=$false)]
    [string]$Description,
    
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
    [switch]$DeleteFile,
    
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

function Backup-Registry {
    param(
        [string]$RegistryPath
    )
    
    $backupFolder = "$PSScriptRoot\backup"
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $fileName = [System.IO.Path]::GetFileName($RegistryPath)
    $backupFile = "$backupFolder\$fileName.$timestamp.bak"
    
    if (-not (Test-Path $backupFolder)) {
        New-Item -Path $backupFolder -ItemType Directory -Force | Out-Null
    }
    
    Copy-Item -Path $RegistryPath -Destination $backupFile -Force
    Write-Log "Backed up registry to $backupFile" "INFO"
    
    return $backupFile
}

# Validate operation-specific parameters
switch ($Operation) {
    "add" {
        if (-not $Workflow -or -not $Name -or -not $Path -or -not $Description -or -not $Category -or -not $MessageCommand) {
            Write-Error "For 'add' operation, Workflow, Name, Path, Description, Category, and MessageCommand are required."
            exit 1
        }
    }
    "remove" {
        if (-not $Workflow -or -not $Name) {
            Write-Error "For 'remove' operation, Workflow and Name are required."
            exit 1
        }
    }
    "update" {
        if (-not $Workflow -or -not $Name) {
            Write-Error "For 'update' operation, Workflow and Name are required."
            exit 1
        }
    }
}

# Check if registry exists
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Unified registry not found at: $RegistryPath. Run migration script first."
    exit 1
}

# Load registry
$registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json

# Execute the requested operation
switch ($Operation) {
    "add" {
        # Create workflow if it doesn't exist
        if (-not ($registry.parameters.workflows.PSObject.Properties.Name -contains $Workflow)) {
            $workflowObj = [PSCustomObject]@{
                parameters = [PSCustomObject]@{}
            }
            
            $registry.parameters.workflows | Add-Member -MemberType NoteProperty -Name $Workflow -Value $workflowObj
            Write-Log "Created new workflow: $Workflow" "INFO"
        }
        
        # Check if parameter already exists
        if ($registry.parameters.workflows.$Workflow.parameters.PSObject.Properties.Name -contains $Name) {
            Write-Error "Parameter '$Name' already exists in workflow '$Workflow'."
            exit 1
        }
        
        # Calculate MDC path
        $mdcPath = $Path -replace "\.md$", ".mdc"
        
        # Create parameter object
        $paramObj = [PSCustomObject]@{
            path = $Path
            mdcPath = $mdcPath
            description = $Description
            category = $Category
            messageCommand = $MessageCommand
            standardParameters = $StandardParameters
            usageExamples = $UsageExamples
            relatedParameters = $RelatedParameters
        }
        
        # Add parameter to registry
        $registry.parameters.workflows.$Workflow.parameters | Add-Member -MemberType NoteProperty -Name $Name -Value $paramObj
        
        # Update registry
        $registry.lastUpdated = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
        $jsonOutput = $registry | ConvertTo-Json -Depth 10
        Set-Content -Path $RegistryPath -Value $jsonOutput
        
        Write-Log "Added parameter '$Name' to workflow '$Workflow'" "INFO"
    }
    "remove" {
        # Check if workflow exists
        if (-not ($registry.parameters.workflows.PSObject.Properties.Name -contains $Workflow)) {
            Write-Error "Workflow '$Workflow' not found in registry."
            exit 1
        }
        
        # Check if parameter exists
        if (-not ($registry.parameters.workflows.$Workflow.parameters.PSObject.Properties.Name -contains $Name)) {
            Write-Error "Parameter '$Name' not found in workflow '$Workflow'."
            exit 1
        }
        
        # Store path for potential file deletion
        $paramPath = $registry.parameters.workflows.$Workflow.parameters.$Name.path
        
        # Create a new PSCustomObject without the parameter
        $updatedParams = [PSCustomObject]@{}
        foreach ($param in $registry.parameters.workflows.$Workflow.parameters.PSObject.Properties) {
            if ($param.Name -ne $Name) {
                $updatedParams | Add-Member -MemberType NoteProperty -Name $param.Name -Value $param.Value
            }
        }
        
        # Replace parameters
        $registry.parameters.workflows.$Workflow.parameters = $updatedParams
        
        # Update registry
        $registry.lastUpdated = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
        $jsonOutput = $registry | ConvertTo-Json -Depth 10
        Set-Content -Path $RegistryPath -Value $jsonOutput
        
        Write-Log "Removed parameter '$Name' from workflow '$Workflow'" "INFO"
        
        # Delete file if requested
        if ($DeleteFile -and $paramPath -and (Test-Path $paramPath)) {
            Remove-Item -Path $paramPath -Force
            Write-Log "Deleted parameter file: $paramPath" "INFO"
        }
    }
    "update" {
        # Check if workflow exists
        if (-not ($registry.parameters.workflows.PSObject.Properties.Name -contains $Workflow)) {
            Write-Error "Workflow '$Workflow' not found in registry."
            exit 1
        }
        
        # Check if parameter exists
        if (-not ($registry.parameters.workflows.$Workflow.parameters.PSObject.Properties.Name -contains $Name)) {
            Write-Error "Parameter '$Name' not found in workflow '$Workflow'."
            exit 1
        }
        
        # Get parameter object
        $param = $registry.parameters.workflows.$Workflow.parameters.$Name
        
        # Update properties if provided
        if ($Path) {
            $param.path = $Path
            $param.mdcPath = $Path -replace "\.md$", ".mdc"
        }
        
        if ($Description) { $param.description = $Description }
        if ($Category) { $param.category = $Category }
        if ($MessageCommand) { $param.messageCommand = $MessageCommand }
        if ($StandardParameters) { $param.standardParameters = $StandardParameters }
        if ($UsageExamples) { $param.usageExamples = $UsageExamples }
        if ($RelatedParameters) { $param.relatedParameters = $RelatedParameters }
        
        # Update registry
        $registry.lastUpdated = (Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")
        $jsonOutput = $registry | ConvertTo-Json -Depth 10
        Set-Content -Path $RegistryPath -Value $jsonOutput
        
        Write-Log "Updated parameter '$Name' in workflow '$Workflow'" "INFO"
    }
    "verify" {
        # Filter workflows
        $workflows = $registry.parameters.workflows.PSObject.Properties.Name
        if ($Workflow) {
            $workflows = $workflows | Where-Object { $_ -eq $Workflow }
        }
        
        $errors = 0
        $warnings = 0
        $verified = 0
        
        foreach ($wf in $workflows) {
            Write-Log "Verifying workflow: $wf" "INFO"
            
            foreach ($paramName in $registry.parameters.workflows.$wf.parameters.PSObject.Properties.Name) {
                $param = $registry.parameters.workflows.$wf.parameters.$paramName
                
                # Verify file exists
                if (-not (Test-Path $param.path)) {
                    Write-Log "ERROR: Parameter file not found: $($param.path) for $wf/$paramName" "ERROR"
                    $errors++
                    continue
                }
                
                $verified++
                Write-Log "Verified parameter: $wf/$paramName" "INFO"
            }
        }
        
        Write-Log "Verification complete: $verified parameters verified, $warnings warnings, $errors errors" "INFO"
    }
    "list" {
        # Display all workflows and their parameters
        Write-Host "`nUnified Parameter Registry"
        Write-Host "========================"
        
        # Filter by workflow if specified
        $workflows = $registry.parameters.workflows.PSObject.Properties.Name
        if ($Workflow) {
            $workflows = $workflows | Where-Object { $_ -eq $Workflow }
        }
        
        foreach ($wf in $workflows) {
            Write-Host "`nWorkflow: $wf"
            Write-Host "-------------------"
            
            # Group by category
            $categories = @{}
            
            foreach ($paramName in $registry.parameters.workflows.$wf.parameters.PSObject.Properties.Name) {
                # Filter by name if specified
                if ($Name -and $paramName -ne $Name) {
                    continue
                }
                
                $param = $registry.parameters.workflows.$wf.parameters.$paramName
                $category = $param.category
                
                if (-not $categories.ContainsKey($category)) {
                    $categories[$category] = @()
                }
                
                $categories[$category] += [PSCustomObject]@{
                    Name = $paramName
                    Description = $param.description
                }
            }
            
            if ($categories.Count -eq 0) {
                Write-Host "  No parameters found"
                continue
            }
            
            foreach ($category in $categories.Keys | Sort-Object) {
                Write-Host "`n[$category]"
                foreach ($param in $categories[$category] | Sort-Object -Property Name) {
                    Write-Host "  - $($param.Name): $($param.Description)"
                }
            }
        }
    }
} 