# PowerShell script to list available 1000x command cycles
# Usage: .\list-cycles.ps1 [optional: specific domain to list]

param(
    [string]$Domain = "", # Optional parameter to filter by domain
    [string]$CommandsRoot = "$PSScriptRoot/../../1000xcommands" # Assuming script is in 1000xscripts/system
)

# Resolve the absolute path for the commands root
$CommandsRootPath = Resolve-Path $CommandsRoot -ErrorAction SilentlyContinue

if (-not $CommandsRootPath) {
    Write-Error "Error: Could not find the 1000xcommands directory at '$CommandsRoot'. Please ensure the path is correct or provide it as a parameter."
    exit 1
}

# Header for output
Write-Host "Available 1000x Cycles (domain/cycle-name):"
Write-Host "---------------------------------------------"

# Define the domains to check
$domains = @("system", "frontend", "backend")

# Filter domains if a specific one was provided
if ($Domain -ne "") {
    if ($domains -contains $Domain.ToLower()) {
        $domains = @($Domain.ToLower())
    }
    else {
        Write-Error "Error: Invalid domain '$Domain'. Valid domains are: system, frontend, backend."
        exit 1
    }
}

$foundCycles = $false
$cycleCount = 0

foreach ($domain in $domains) {
    $domainPath = Join-Path -Path $CommandsRootPath -ChildPath $domain
    
    if (Test-Path $domainPath -PathType Container) {
        # Get subdirectories (cycles) within the domain folder
        $cycles = Get-ChildItem -Path $domainPath -Directory -ErrorAction SilentlyContinue
        
        if ($cycles) {
            if ($Domain -eq "") {
                # Only show domain headers when listing all domains
                Write-Host "`n$domain domain:" -ForegroundColor Cyan
            }
            
            foreach ($cycle in $cycles) {
                # Check if the directory contains numbered command files (1.md through 7.md)
                $hasCommandFiles = $true
                $commandCount = 0
                
                for ($i = 1; $i -le 7; $i++) {
                    $commandFile = Join-Path -Path $cycle.FullName -ChildPath "$i.md"
                    if (Test-Path $commandFile -PathType Leaf) {
                        $commandCount++
                    }
                }
                
                # Only list as a valid cycle if it has at least one command file
                if ($commandCount -gt 0) {
                    Write-Host "  $domain/$($cycle.Name)" -ForegroundColor Green
                    Write-Host "    Commands: $commandCount/7" -ForegroundColor Gray
                    $foundCycles = $true
                    $cycleCount++
                }
            }
        }
    }
}

if (-not $foundCycles) {
    Write-Host "No cycles found in the specified domains."
}
else {
    Write-Host "`nTotal cycles found: $cycleCount" -ForegroundColor Yellow
    
    if ($Domain -eq "") {
        Write-Host "`nTo list cycles in a specific domain:" -ForegroundColor Gray
        Write-Host "  .\list-cycles.ps1 -Domain system" -ForegroundColor Gray
    }
    
    Write-Host "`nUse in Directive format:" -ForegroundColor Gray
    Write-Host "  # Directive: Enhancement" -ForegroundColor Gray
    Write-Host "  # Target Cycle: domain/cycle-name" -ForegroundColor Gray
}