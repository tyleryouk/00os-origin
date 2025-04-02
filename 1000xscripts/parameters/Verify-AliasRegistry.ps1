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

# Verification results
$results = @{
    TotalParameters = 0
    ValidParameters = 0
    MissingFiles = @()
    OrphanedFiles = @()
    BrokenReferences = @()
    WorkflowStats = @{}
}

# 1. Verify all registered parameters exist
foreach ($workflow in $registry.aliases.PSObject.Properties.Name) {
    if (-not $results.WorkflowStats.ContainsKey($workflow)) {
        $results.WorkflowStats[$workflow] = @{
            Total = 0
            Valid = 0
            Invalid = 0
        }
    }
    
    foreach ($name in $registry.aliases.$workflow.PSObject.Properties.Name) {
        $results.TotalParameters++
        $results.WorkflowStats[$workflow].Total++
        
        $path = $registry.aliases.$workflow.$name.path
        $fullPath = Join-Path "$PSScriptRoot\..\..\1000xbrain" $path
        
        if (-not (Test-Path $fullPath)) {
            $results.MissingFiles += [PSCustomObject]@{
                Workflow = $workflow
                Name = $name
                Path = $path
            }
            $results.WorkflowStats[$workflow].Invalid++
        } else {
            $results.ValidParameters++
            $results.WorkflowStats[$workflow].Valid++
        }
    }
}

# 2. Find all parameter files in the parameters directory
$parameterFiles = Get-ChildItem -Path "$ScanPath\parameters" -Recurse -Include "*.md" |
                  Where-Object { $_.FullName -notlike "*\node_modules\*" -and $_.Name -ne "README.md" }

# 3. Check for orphaned parameter files (files not in registry)
foreach ($file in $parameterFiles) {
    $relativePath = $file.FullName.Replace("$ScanPath\", "").Replace("\", "/")
    
    $found = $false
    foreach ($workflow in $registry.aliases.PSObject.Properties.Name) {
        foreach ($name in $registry.aliases.$workflow.PSObject.Properties.Name) {
            if ($registry.aliases.$workflow.$name.path -eq $relativePath) {
                $found = $true
                break
            }
        }
        if ($found) { break }
    }
    
    if (-not $found) {
        $results.OrphanedFiles += $relativePath
    }
}

# 4. Find all markdown files for reference scanning
$markdownFiles = Get-ChildItem -Path $ScanPath -Recurse -Include "*.md" |
                Where-Object { $_.FullName -notlike "*\node_modules\*" }

# 5. Scan for broken alias references
foreach ($file in $markdownFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $aliasRefs = [regex]::Matches($content, '@alias:[^:`\s"]+:[^:`\s"]+')
    
    foreach ($ref in $aliasRefs) {
        $aliasRef = $ref.Value
        
        # Parse alias reference
        if ($aliasRef -match '@alias:([^:]+):(.+)') {
            $workflow = $matches[1]
            $name = $matches[2]
            
            # Check if workflow exists
            if (-not ($registry.aliases.PSObject.Properties.Name -contains $workflow)) {
                $results.BrokenReferences += [PSCustomObject]@{
                    File = $file.FullName
                    Reference = $aliasRef
                    Issue = "Unknown workflow '$workflow'"
                }
                continue
            }
            
            # Check if alias exists
            if (-not ($registry.aliases.$workflow.PSObject.Properties.Name -contains $name)) {
                $results.BrokenReferences += [PSCustomObject]@{
                    File = $file.FullName
                    Reference = $aliasRef
                    Issue = "Unknown alias '$name' in workflow '$workflow'"
                }
            }
        } else {
            $results.BrokenReferences += [PSCustomObject]@{
                File = $file.FullName
                Reference = $aliasRef
                Issue = "Invalid alias format"
            }
        }
    }
}

# Output verification summary
Write-Host "`nAlias Registry Verification Summary"
Write-Host "=================================="
Write-Host "Total parameters: $($results.TotalParameters)"
Write-Host "Valid parameters: $($results.ValidParameters)"
Write-Host "Invalid parameters: $($results.TotalParameters - $results.ValidParameters)"
Write-Host "Orphaned files: $($results.OrphanedFiles.Count)"
Write-Host "Broken references: $($results.BrokenReferences.Count)"

# Output workflow statistics
Write-Host "`nWorkflow Statistics"
Write-Host "-----------------"
foreach ($workflow in $results.WorkflowStats.Keys) {
    $stats = $results.WorkflowStats[$workflow]
    Write-Host "$workflow`: $($stats.Total) total, $($stats.Valid) valid, $($stats.Invalid) invalid"
}

# Output missing files
if ($results.MissingFiles.Count -gt 0) {
    Write-Host "`nMissing Files"
    Write-Host "------------"
    foreach ($item in $results.MissingFiles) {
        Write-Host "$($item.Workflow):$($item.Name) -> $($item.Path)"
    }
}

# Output orphaned files
if ($results.OrphanedFiles.Count -gt 0) {
    Write-Host "`nOrphaned Files"
    Write-Host "-------------"
    foreach ($path in $results.OrphanedFiles) {
        Write-Host $path
    }
}

# Output broken references
if ($results.BrokenReferences.Count -gt 0) {
    Write-Host "`nBroken References"
    Write-Host "---------------"
    foreach ($item in $results.BrokenReferences) {
        Write-Host "In file: $($item.File)"
        Write-Host "  Reference: $($item.Reference)"
        Write-Host "  Issue: $($item.Issue)"
    }
}

# Return verification results
return $results 