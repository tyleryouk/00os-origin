[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Workflow,
    
    [Parameter(Mandatory=$true)]
    [string]$Name,
    
    [Parameter(Mandatory=$true)]
    [ValidateSet("add", "remove", "update")]
    [string]$Action,
    
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\alias-registry.json",
    
    [Parameter(Mandatory=$false)]
    [string]$ScanPath = "$PSScriptRoot\..\..\1000xbrain"
)

# Load registry
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Alias registry not found at: $RegistryPath"
    exit 1
}

$registry = Get-Content -Path $RegistryPath -Raw | ConvertFrom-Json

# Find all markdown files
$files = Get-ChildItem -Path $ScanPath -Recurse -Include "*.md" | 
         Where-Object { $_.FullName -notlike "*\node_modules\*" }

$updatedCount = 0

# Process based on action
switch ($Action) {
    "add" {
        # Nothing to do for add - new aliases don't have existing references
    }
    "remove" {
        # For remove, find and flag any references to the removed alias
        foreach ($file in $files) {
            $content = Get-Content -Path $file.FullName -Raw
            $aliasRef = "@alias:$($Workflow):$($Name)"
            
            if ($content -match [regex]::Escape($aliasRef)) {
                Write-Warning "Found reference to removed alias in file: $($file.FullName)"
                Write-Warning "  Reference: $aliasRef"
                Write-Warning "  This reference will be broken. Please update the file."
            }
        }
    }
    "update" {
        # For update, update any filepath references to use the alias format
        $aliasValue = $registry.aliases.$Workflow.$Name
        $mdcPath = "@$($aliasValue.mdcPath)"
        $aliasRef = "@alias:$($Workflow):$($Name)"
        
        foreach ($file in $files) {
            $content = Get-Content -Path $file.FullName -Raw
            $updatedContent = $content -replace [regex]::Escape($mdcPath), $aliasRef
            
            if ($content -ne $updatedContent) {
                Set-Content -Path $file.FullName -Value $updatedContent
                $updatedCount++
            }
        }
    }
}

if ($updatedCount -gt 0) {
    Write-Output "Updated references in $updatedCount files."
} else {
    Write-Output "No references needed updating."
} 