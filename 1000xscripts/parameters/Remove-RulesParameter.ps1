[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$false)]
    [switch]$DeleteFile,
    
    [Parameter(Mandatory=$false)]
    [switch]$UpdateReferences,
    
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

# Call the unified parameter management script
$params = @{
    Operation = "remove"
    Workflow = "rules-workflow"
    Name = $Name
}

if ($DeleteFile) {
    $params.DeleteFile = $true
}

# Check if parameter exists before attempting removal
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
    
    # Get parameter path for later reference scanning
    $paramPath = $registry.parameters.workflows."rules-workflow".parameters.$Name.path
    $mdcPath = $registry.parameters.workflows."rules-workflow".parameters.$Name.mdcPath
    
    # Execute the parameter management script
    & "$PSScriptRoot\Manage-UnifiedParameters.ps1" @params
    
    # Handle references if requested
    if ($UpdateReferences) {
        Write-Log "Scanning for references to '$Name' parameter..." "INFO"
        
        # Define search patterns
        $patterns = @(
            "@parameters/rules/.+/$Name\.mdc",
            "@alias:rules:$Name"
        )
        
        $refsFound = 0
        
        foreach ($pattern in $patterns) {
            Write-Log "Searching for pattern: $pattern" "INFO"
            
            # Use PowerShell to find references (alternatively could use grep or similar tool)
            $refs = Get-ChildItem -Path "parameters", "1000xbrain" -Recurse -File -Include "*.md" | 
                    Select-String -Pattern $pattern
            
            foreach ($ref in $refs) {
                Write-Log "Found reference in: $($ref.Path)" "INFO"
                $refsFound++
                
                # Add deprecated comment to the reference
                $content = Get-Content -Path $ref.Path
                $lineNumber = $ref.LineNumber - 1 # 0-based index
                
                if ($content[$lineNumber] -notmatch "#\s*DEPRECATED") {
                    $content[$lineNumber] = "$($content[$lineNumber]) # DEPRECATED: Parameter '$Name' has been removed"
                    Set-Content -Path $ref.Path -Value $content
                    Write-Log "Added deprecation notice to: $($ref.Path)" "INFO"
                }
            }
        }
        
        Write-Log "Reference scan complete. Found $refsFound references." "INFO"
    }
    
    Write-Log "Parameter '$Name' removed from rules-workflow successfully" "INFO"
} else {
    Write-Error "Registry file not found: $RegistryPath"
    exit 1
} 