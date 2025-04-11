# PowerShell script to list available 1000x command cycles

param(
    [string]$CommandsRoot = "$PSScriptRoot/../../1000xcommands" # Assuming script is in 1000xscripts/system
)

# Resolve the absolute path for the commands root
$CommandsRootPath = Resolve-Path $CommandsRoot -ErrorAction SilentlyContinue

if (-not $CommandsRootPath) {
    Write-Error "Error: Could not find the 1000xcommands directory at '$CommandsRoot'. Please ensure the path is correct or provide it as a parameter."
    exit 1
}

Write-Host "Available 1000x Cycles (domain/cycle-name):"
Write-Host "---------------------------------------------"

# Define the domains to check
$domains = @("system", "frontend", "backend")

$foundCycles = $false

foreach ($domain in $domains) {
    $domainPath = Join-Path -Path $CommandsRootPath -ChildPath $domain
    
    if (Test-Path $domainPath -PathType Container) {
        # Get subdirectories (cycles) within the domain folder
        $cycles = Get-ChildItem -Path $domainPath -Directory -ErrorAction SilentlyContinue
        
        if ($cycles) {
            foreach ($cycle in $cycles) {
                Write-Host "$domain/$($cycle.Name)"
                $foundCycles = $true
            }
        }
    }
}

if (-not $foundCycles) {
    Write-Host "No cycles found in the specified domains."
}