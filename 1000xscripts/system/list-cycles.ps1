# PowerShell script to list available 1000x command cycles
# Usage: .\list-cycles.ps1 [optional: specific domain to list] [optional: output file path]

param(
    [string]$Domain = "", # Optional parameter to filter by domain
    [string]$CommandsRoot = "$PSScriptRoot/../../1000xcommands", # Assuming script is in 1000xscripts/system
    [string]$OutputFile = "" # Optional parameter to write output to a file
)

# Resolve the absolute path for the commands root
$CommandsRootPath = Resolve-Path $CommandsRoot -ErrorAction SilentlyContinue

if (-not $CommandsRootPath) {
    Write-Error "Error: Could not find the 1000xcommands directory at '$CommandsRoot'. Please ensure the path is correct or provide it as a parameter."
    exit 1
}

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

# Initialize arrays and counters
$outputLines = @()
$foundCycles = $false
$cycleCount = 0
$domainCycles = @{}

# Clear the output file first if specified, to prevent duplicate content
if ($OutputFile -ne "") {
    try {
        # Check if the file exists and clear it
        if (Test-Path $OutputFile) {
            Clear-Content -Path $OutputFile -ErrorAction Stop
            Write-Host "Cleared existing output file: $OutputFile" -ForegroundColor Gray
        }
    }
    catch {
        Write-Error "Error clearing output file: $_"
    }
}

# Add header to output array if writing to file
if ($OutputFile -ne "") {
    $outputLines += '# Available 1000x Cycles'
    $outputLines += ''
    $outputLines += 'This file maintains a list of all available cycles in the system. It is used by the cycle-manager for validation and reference.'
    $outputLines += ''
    $outputLines += '## Current Cycles (domain/cycle-name)'
    $outputLines += ''
}

# Header for console output
Write-Host "Available 1000x Cycles (domain/cycle-name):"
Write-Host "---------------------------------------------"

# Process each domain
foreach ($domain in $domains) {
    $domainPath = Join-Path -Path $CommandsRootPath -ChildPath $domain
    
    if (Test-Path $domainPath -PathType Container) {
        # Get subdirectories (cycles) within the domain folder
        $cycles = Get-ChildItem -Path $domainPath -Directory -ErrorAction SilentlyContinue
        
        if ($null -ne $cycles -and $cycles.Count -gt 0) {
            $domainHasCycles = $false
            $domainCycles[$domain] = @()
            
            # Add domain header for all domains mode
            if ($Domain -eq "") {
                Write-Host "`n$domain domain:" -ForegroundColor Cyan
                
                if ($OutputFile -ne "") {
                    $domainHeader = "### " + $domain.Substring(0,1).ToUpper() + $domain.Substring(1) + " Domain"
                    $outputLines += $domainHeader
                }
            }
            
            # Process each potential cycle directory
            foreach ($cycle in $cycles) {
                $commandCount = 0
                
                # Check if the directory contains numbered command files (1.md through 7.md)
                for ($i = 1; $i -le 7; $i++) {
                    $commandFile = Join-Path -Path $cycle.FullName -ChildPath "$i.md"
                    if (Test-Path $commandFile -PathType Leaf) {
                        $commandCount++
                    }
                }
                
                # Only list as a valid cycle if it has at least one command file
                if ($commandCount -gt 0) {
                    $cycleName = "$domain/$($cycle.Name)"
                    Write-Host "  $cycleName" -ForegroundColor Green
                    Write-Host "    Commands: $commandCount/7" -ForegroundColor Gray
                    $foundCycles = $true
                    $domainHasCycles = $true
                    $cycleCount++
                    $domainCycles[$domain] += $cycleName
                    
                    if ($OutputFile -ne "") {
                        $outputLines += "- $cycleName"
                    }
                }
            }
            
            # Add extra line break after domain listing if there were cycles
            if ($domainHasCycles -and $OutputFile -ne "") {
                $outputLines += ""
            } else {
                # No cycles in this domain
                if ($OutputFile -ne "") {
                    $outputLines += "No cycles currently available"
                    $outputLines += ""
                }
            }
        } else {
            # No cycles in this domain
            if ($Domain -eq "" -and $OutputFile -ne "") {
                $domainHeader = "### " + $domain.Substring(0,1).ToUpper() + $domain.Substring(1) + " Domain"
                $outputLines += $domainHeader
                $outputLines += "No cycles currently available"
                $outputLines += ""
            }
        }
    }
}

# Add summary and footer
if (-not $foundCycles) {
    Write-Host "No cycles found in the specified domains."
    
    if ($OutputFile -ne "") {
        $outputLines += "No cycles found in the specified domains."
    }
} else {
    Write-Host "`nTotal cycles found: $cycleCount" -ForegroundColor Yellow
    
    if ($OutputFile -ne "") {
        $outputLines += "## Total cycles: $cycleCount"
        $outputLines += ""
        $outputLines += '## Usage in Directive Format'
        $outputLines += '```'
        $outputLines += '# Directive: Enhancement'
        $outputLines += '# Target Cycle: domain/cycle-name'
        $outputLines += '```'
        $outputLines += ""
        $outputLines += 'Note: This list is automatically generated by 1000xscripts/system/list-cycles.ps1'
    }
    
    if ($Domain -eq "") {
        Write-Host "`nTo list cycles in a specific domain:" -ForegroundColor Gray
        Write-Host "  .\list-cycles.ps1 -Domain system" -ForegroundColor Gray
    }
    
    Write-Host "`nUse in Directive format:" -ForegroundColor Gray
    Write-Host "  # Directive: Enhancement" -ForegroundColor Gray
    Write-Host "  # Target Cycle: domain/cycle-name" -ForegroundColor Gray
}

# Write to output file if specified
if ($OutputFile -ne "") {
    try {
        Set-Content -Path $OutputFile -Value $outputLines
        Write-Host "`nOutput written to: $OutputFile" -ForegroundColor Cyan
    }
    catch {
        Write-Error "Error writing to output file: $_"
    }
}