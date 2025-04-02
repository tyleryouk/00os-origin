[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("add", "remove", "update", "verify", "convert-refs", "list")]
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
    [string]$RegistryPath = "$PSScriptRoot\alias-registry.json"
)

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
    "verify" {
        # No additional parameters required
    }
    "convert-refs" {
        # No additional parameters required
    }
    "list" {
        # Optional: Name and Workflow for filtering
    }
}

# Function to list parameters
function List-Parameters {
    param(
        [string]$RegistryPath,
        [string]$WorkflowFilter,
        [string]$NameFilter
    )
    
    # Load registry
    if (-not (Test-Path $RegistryPath)) {
        Write-Error "Registry not found at: $RegistryPath"
        exit 1
    }
    
    $registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json
    
    # Display all workflows and their parameters
    Write-Host "`nParameter Registry"
    Write-Host "================="
    
    # Filter by workflow if specified
    $workflows = $registry.aliases.PSObject.Properties.Name
    if ($WorkflowFilter) {
        $workflows = $workflows | Where-Object { $_ -eq $WorkflowFilter }
        if ($workflows.Count -eq 0) {
            Write-Error "Workflow '$WorkflowFilter' not found in registry."
            exit 1
        }
    }
    
    foreach ($workflow in $workflows) {
        Write-Host "`nWorkflow: $workflow"
        Write-Host "-------------------"
        
        # Group by category
        $categories = @{}
        
        foreach ($alias in $registry.aliases.$workflow.PSObject.Properties.Name) {
            # Filter by name if specified
            if ($NameFilter -and $alias -ne $NameFilter) {
                continue
            }
            
            $category = $registry.aliases.$workflow.$alias.category
            if (-not $categories.ContainsKey($category)) {
                $categories[$category] = @()
            }
            
            $categories[$category] += [PSCustomObject]@{
                Name = $alias
                Description = $registry.aliases.$workflow.$alias.description
            }
        }
        
        if ($categories.Count -eq 0) {
            if ($NameFilter) {
                Write-Host "  No parameters found matching name '$NameFilter'"
            } else {
                Write-Host "  No parameters found"
            }
            continue
        }
        
        foreach ($category in $categories.Keys | Sort-Object) {
            Write-Host "`n[$category]"
            foreach ($param in $categories[$category] | Sort-Object -Property Name) {
                Write-Host "  - $($param.Name): $($param.Description)"
            }
        }
    }
    
    # If a specific name is requested, show detailed information
    if ($NameFilter) {
        if ($WorkflowFilter) {
            $workflows = @($WorkflowFilter)
        } else {
            $workflows = $registry.aliases.PSObject.Properties.Name
        }
        
        $found = $false
        
        foreach ($workflow in $workflows) {
            if ($registry.aliases.$workflow.PSObject.Properties.Name -contains $NameFilter) {
                $param = $registry.aliases.$workflow.$NameFilter
                
                Write-Host "`nDetails for parameter: $NameFilter (in workflow: $workflow)"
                Write-Host "  Alias: @alias:$workflow:$NameFilter"
                Write-Host "  Description: $($param.description)"
                Write-Host "  Category: $($param.category)"
                Write-Host "  Path: $($param.path)"
                Write-Host "  Message Command: $($param.messageCommand)"
                
                if ($param.standardParameters -and $param.standardParameters.Count -gt 0) {
                    Write-Host "  Standard Parameters: $($param.standardParameters -join ", ")"
                }
                
                if ($param.usageExamples -and $param.usageExamples.Count -gt 0) {
                    Write-Host "  Usage Examples:"
                    foreach ($example in $param.usageExamples) {
                        Write-Host "    - $example"
                    }
                }
                
                if ($param.relatedParameters -and $param.relatedParameters.Count -gt 0) {
                    Write-Host "  Related Parameters:"
                    foreach ($related in $param.relatedParameters) {
                        Write-Host "    - $related"
                    }
                }
                
                $found = $true
                # Only show the first match if no workflow filter was specified
                if (-not $WorkflowFilter) {
                    break
                }
            }
        }
        
        if (-not $found) {
            Write-Error "Parameter '$NameFilter' not found in registry."
        }
    }
}

# Execute the requested operation
switch ($Operation) {
    "add" {
        & "$PSScriptRoot\Register-ParameterAlias.ps1" `
          -Workflow $Workflow `
          -Name $Name `
          -Path $Path `
          -Description $Description `
          -Category $Category `
          -MessageCommand $MessageCommand `
          -StandardParameters $StandardParameters `
          -UsageExamples $UsageExamples `
          -RelatedParameters $RelatedParameters
    }
    "remove" {
        $params = @{
            Workflow = $Workflow
            Name = $Name
        }
        
        if ($DeleteFile) {
            $params.DeleteFile = $true
        }
        
        & "$PSScriptRoot\Remove-ParameterAlias.ps1" @params
    }
    "update" {
        $params = @{
            Workflow = $Workflow
            Name = $Name
        }
        
        if ($Path) { $params.Path = $Path }
        if ($Description) { $params.Description = $Description }
        if ($Category) { $params.Category = $Category }
        if ($MessageCommand) { $params.MessageCommand = $MessageCommand }
        if ($StandardParameters) { $params.StandardParameters = $StandardParameters }
        if ($UsageExamples) { $params.UsageExamples = $UsageExamples }
        if ($RelatedParameters) { $params.RelatedParameters = $RelatedParameters }
        
        & "$PSScriptRoot\Update-ParameterAlias.ps1" @params
    }
    "verify" {
        & "$PSScriptRoot\Verify-AliasRegistry.ps1"
    }
    "convert-refs" {
        & "$PSScriptRoot\Convert-ToAliasReferences.ps1"
    }
    "list" {
        List-Parameters -RegistryPath $RegistryPath -WorkflowFilter $Workflow -NameFilter $Name
    }
} 