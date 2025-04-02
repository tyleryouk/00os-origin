[CmdletBinding()]
param(
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

# Build conversion map
$conversionMap = @{}

foreach ($workflow in $registry.aliases.PSObject.Properties.Name) {
    foreach ($alias in $registry.aliases.$workflow.PSObject.Properties.Name) {
        $mdcPath = "@$($registry.aliases.$workflow.$alias.mdcPath)"
        $aliasRef = "@alias:$workflow:$alias"
        $conversionMap[$mdcPath] = $aliasRef
    }
}

# Find all markdown files
$files = Get-ChildItem -Path $ScanPath -Recurse -Include "*.md" | 
         Where-Object { $_.FullName -notlike "*\node_modules\*" }

$updatedCount = 0

# Process each file
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $updatedContent = $content
    
    foreach ($oldRef in $conversionMap.Keys) {
        $newRef = $conversionMap[$oldRef]
        $updatedContent = $updatedContent -replace [regex]::Escape($oldRef), $newRef
    }
    
    if ($content -ne $updatedContent) {
        Set-Content -Path $file.FullName -Value $updatedContent
        $updatedCount++
        Write-Verbose "Updated references in file: $($file.FullName)"
    }
}

Write-Output "Converted references in $updatedCount files." 