[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$RegistryPath = "$PSScriptRoot\parameter-registry.json",
    
    [Parameter(Mandatory=$false)]
    [string]$ScanPath = "$PSScriptRoot\..\..\1000xbrain"
)

# Load registry
if (-not (Test-Path $RegistryPath)) {
    Write-Error "Parameter registry not found at: $RegistryPath"
    exit 1
}

$registry = Get-Content -Path $RegistryPath | ConvertFrom-Json
$paramPaths = @{}

foreach ($paramName in $registry.parameters.PSObject.Properties.Name) {
    $paramPaths[$paramName] = $registry.parameters.$paramName.path
}

# Verify the scan path exists
if (-not (Test-Path $ScanPath)) {
    Write-Error "Scan path not found: $ScanPath"
    exit 1
}

# Find all markdown files
Write-Host "Scanning for markdown files in $ScanPath..."
$filesWithReferences = Get-ChildItem -Path $ScanPath -Recurse -Include "*.md" | 
                      Where-Object { $_.FullName -notlike "*\node_modules\*" }

Write-Host "Found $($filesWithReferences.Count) markdown files."

$references = @()
$inconsistencies = @()
$brokenReferences = @()

# Define regex pattern for parameter references
$refPattern = '@parameters/rules/[^`\s"\)]+\.mdc'

# Process each file
foreach ($file in $filesWithReferences) {
    Write-Verbose "Processing file: $($file.FullName)"
    
    # Read file content
    $content = Get-Content -Path $file.FullName -Raw -ErrorAction SilentlyContinue
    if (-not $content) {
        Write-Warning "Could not read content from file: $($file.FullName)"
        continue
    }
    
    # Find parameter references
    $matches = [regex]::Matches($content, $refPattern)
    
    foreach ($match in $matches) {
        $reference = $match.Value
        $mdPath = $reference -replace '\.mdc$', '.md'
        $fullPath = Join-Path "$PSScriptRoot\..\.." $mdPath.Substring(1)
        $exists = Test-Path $fullPath
        
        $references += [PSCustomObject]@{
            File = $file.FullName
            Reference = $reference
            Exists = $exists
        }
        
        if (-not $exists) {
            $brokenReferences += [PSCustomObject]@{
                File = $file.FullName
                Reference = $reference
            }
        }
    }
    
    # Check for inconsistent references
    foreach ($paramName in $paramPaths.Keys) {
        $expectedPath = "parameters/rules/$($paramPaths[$paramName].Replace('parameters/rules/', ''))"
        $expectedPathMdc = $expectedPath.Replace(".md", ".mdc")
        $pattern = "@parameters/rules/[^`\s\"\)]*$paramName\.mdc"
        
        $matches = [regex]::Matches($content, $pattern)
        foreach ($match in $matches) {
            $actualPath = $match.Value
            $expectedRef = "@$expectedPathMdc"
            
            if ($actualPath -ne $expectedRef) {
                $inconsistencies += [PSCustomObject]@{
                    File = $file.FullName
                    Parameter = $paramName
                    ActualPath = $actualPath
                    ExpectedPath = $expectedRef
                }
            }
        }
    }
}

# Output results
Write-Host "Found $($references.Count) total parameter references."
Write-Host "Found $($brokenReferences.Count) broken references."
Write-Host "Found $($inconsistencies.Count) inconsistent references."

if ($brokenReferences.Count -gt 0) {
    Write-Host "`nBroken References:"
    $brokenReferences | Format-Table File, Reference
}

if ($inconsistencies.Count -gt 0) {
    Write-Host "`nInconsistent References:"
    $inconsistencies | Format-Table File, Parameter, ActualPath, ExpectedPath
}

# Return reference data for further processing
return @{
    References = $references
    BrokenReferences = $brokenReferences
    Inconsistencies = $inconsistencies
} 