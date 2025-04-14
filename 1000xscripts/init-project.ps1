<#
.SYNOPSIS
    Initializes the 1000xsystems in a new project environment.

.DESCRIPTION
    This script sets up and configures the 1000xsystems (1000xbrain, 1000xrules, 1000xcommands, 1000xscripts)
    to work in a new project environment. It creates necessary directories, configures domain mappings,
    and sets up project-specific settings.

.PARAMETER Verbose
    Displays detailed information during execution.

.EXAMPLE
    ./init-project.ps1 -Verbose
#>

param (
    [switch]$Verbose
)

# Function to log messages
function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "INFO"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"
    
    if ($Level -eq "ERROR") {
        Write-Host $logMessage -ForegroundColor Red
    }
    elseif ($Level -eq "WARNING") {
        Write-Host $logMessage -ForegroundColor Yellow
    }
    elseif ($Level -eq "SUCCESS") {
        Write-Host $logMessage -ForegroundColor Green
    }
    else {
        Write-Host $logMessage
    }
    
    if ($Verbose) {
        Add-Content -Path "$ProjectRoot/1000xscripts/init-log.txt" -Value $logMessage
    }
}

# Function to detect the project root
function Get-ProjectRoot {
    $currentPath = $PSScriptRoot
    
    # If we're in the scripts directory, go up one level
    if ($currentPath -match ".*\\1000xscripts$") {
        $currentPath = Split-Path $currentPath -Parent
    }
    
    # Verify this is a valid project root by checking for key directories
    $requiredDirs = @("1000xbrain", "1000xrules", "1000xcommands", "1000xscripts")
    foreach ($dir in $requiredDirs) {
        if (-not (Test-Path "$currentPath\$dir")) {
            Write-Log "Missing required directory: $dir" "ERROR"
            Write-Log "This doesn't appear to be a valid project root." "ERROR"
            return $null
        }
    }
    
    return $currentPath
}

# Function to detect project information
function Get-ProjectInfo {
    param (
        [string]$ProjectRoot
    )
    
    # Get project name from directory name
    $projectName = Split-Path $ProjectRoot -Leaf
    
    # Try to detect project type
    $projectType = "Unknown"
    
    # Check for package.json (Node.js/JavaScript project)
    if (Test-Path "$ProjectRoot\package.json") {
        $projectType = "JavaScript/Node.js"
    }
    # Check for .csproj files (C# project)
    elseif (Get-ChildItem -Path $ProjectRoot -Filter "*.csproj" -Recurse) {
        $projectType = "C#/.NET"
    }
    # Check for pom.xml (Java/Maven project)
    elseif (Test-Path "$ProjectRoot\pom.xml") {
        $projectType = "Java/Maven"
    }
    # Check for requirements.txt or setup.py (Python project)
    elseif ((Test-Path "$ProjectRoot\requirements.txt") -or (Test-Path "$ProjectRoot\setup.py")) {
        $projectType = "Python"
    }
    
    return @{
        Name = $projectName
        Type = $projectType
        Root = $ProjectRoot
    }
}

# Function to ensure required directories exist
function Ensure-Directories {
    param (
        [string]$ProjectRoot
    )
    
    $directories = @(
        "1000xbrain",
        "1000xbrain\system",
        "1000xbrain\system\configuration",
        "1000xbrain\system\knowledge",
        "1000xrules",
        "1000xcommands",
        "1000xscripts",
        "1000xplans"
    )
    
    foreach ($dir in $directories) {
        $path = Join-Path -Path $ProjectRoot -ChildPath $dir
        if (-not (Test-Path $path)) {
            Write-Log "Creating directory: $dir" "INFO"
            New-Item -Path $path -ItemType Directory -Force | Out-Null
        }
    }
}

# Function to detect frontend and backend directories
function Get-DomainPaths {
    param (
        [string]$ProjectRoot
    )
    
    # Start with default domains
    $domains = @{
        "frontend_domain" = "front-end/"
        "backend_domain" = "back-end/"
    }
    
    # Look for common frontend directories
    $frontendDirs = @("frontend", "front-end", "client", "app", "ui", "web")
    foreach ($dir in $frontendDirs) {
        if (Test-Path "$ProjectRoot\$dir") {
            $domains["frontend_domain"] = "$dir/"
            break
        }
    }
    
    # Look for common backend directories
    $backendDirs = @("backend", "back-end", "server", "api", "services")
    foreach ($dir in $backendDirs) {
        if (Test-Path "$ProjectRoot\$dir") {
            $domains["backend_domain"] = "$dir/"
            break
        }
    }
    
    # Look for additional project-specific domains
    # Scan for directories that might be custom domains (exclude standard dirs and 1000x dirs)
    $standardDirs = @("node_modules", ".git", ".github", ".vscode", "dist", "build") + $frontendDirs + $backendDirs + @("1000xbrain", "1000xrules", "1000xcommands", "1000xscripts", "1000xplans")
    
    $potentialDomains = Get-ChildItem -Path $ProjectRoot -Directory | Where-Object { $standardDirs -notcontains $_.Name }
    
    foreach ($dir in $potentialDomains) {
        $domainName = $dir.Name.ToLower().Replace("-", "_") + "_domain"
        $domains[$domainName] = "$($dir.Name)/"
        Write-Log "Detected potential custom domain: $($dir.Name)" "INFO"
    }
    
    return $domains
}

# Function to update project configuration
function Update-ProjectConfig {
    param (
        [hashtable]$ProjectInfo,
        [hashtable]$Domains
    )
    
    $configPath = Join-Path -Path $ProjectInfo.Root -ChildPath "1000xbrain\system\configuration\project-config.md"
    
    # Read existing config if it exists
    $existingConfig = if (Test-Path $configPath) {
        Get-Content -Path $configPath -Raw
    } else {
        $null
    }
    
    # Create a new config file with updated content
    $newConfig = "# Project Configuration`n`n"
    
    # Project Information section
    $newConfig += "## Project Information`n"
    $newConfig += "project_name: $($ProjectInfo.Name)`n"
    $newConfig += "project_root: [Detected at Runtime]`n"
    $newConfig += "project_type: $($ProjectInfo.Type)`n`n"
    
    # Domain Mappings section
    $newConfig += "## Domain Mappings`n"
    foreach ($domain in $Domains.Keys | Sort-Object) {
        $newConfig += "$domain: $($Domains[$domain])`n"
    }
    $newConfig += "system_domain: system/`n`n"
    
    # System Paths section
    $newConfig += "## System Paths`n"
    $newConfig += "system_brain_path: 1000xbrain/`n"
    $newConfig += "system_rules_path: 1000xrules/`n"
    $newConfig += "system_commands_path: 1000xcommands/`n"
    $newConfig += "system_scripts_path: 1000xscripts/`n"
    $newConfig += "system_plans_path: 1000xplans/`n`n"
    
    # Project-Specific Settings section
    $newConfig += "## Project-Specific Settings`n"
    $newConfig += "app_name: $($ProjectInfo.Name)`n"
    $newConfig += "api_base_url: [Project API Base URL]`n`n"
    
    # If existing config exists, preserve any additional sections or custom settings
    if ($existingConfig) {
        # Extract any additional sections not covered by our standard sections
        $standardSections = @("Project Information", "Domain Mappings", "System Paths", "Project-Specific Settings")
        $existingLines = $existingConfig -split "`n"
        $inCustomSection = $false
        $currentSection = ""
        $customSections = @{}
        
        foreach ($line in $existingLines) {
            if ($line -match "^## (.+)$") {
                $currentSection = $matches[1]
                if ($standardSections -notcontains $currentSection) {
                    $inCustomSection = $true
                    $customSections[$currentSection] = @()
                } else {
                    $inCustomSection = $false
                }
            }
            elseif ($inCustomSection) {
                $customSections[$currentSection] += $line
            }
        }
        
        # Add any custom sections to the new config
        foreach ($section in $customSections.Keys) {
            $newConfig += "## $section`n"
            $newConfig += $customSections[$section] -join "`n"
            $newConfig += "`n`n"
        }
        
        # Add the configuration notes section if it exists in the old config
        if ($existingConfig -match "## Configuration Notes") {
            $configNotesMatch = [regex]::Match($existingConfig, "## Configuration Notes(.+?)(?=^##|\z)", [System.Text.RegularExpressions.RegexOptions]::Singleline)
            if ($configNotesMatch.Success) {
                $newConfig += "## Configuration Notes" + $configNotesMatch.Groups[1].Value + "`n"
            }
        }
    }
    
    # If no Configuration Notes section was found or preserved, add the default one
    if ($newConfig -notmatch "## Configuration Notes") {
        $newConfig += @"
## Configuration Notes

This configuration file serves as the central source of truth for all 1000xsystems path and domain references. It enables project-agnostic operation by abstracting physical paths into logical domains.

### Usage Guidelines

1. **Domain References**:
   * Use domain prefixes for file references (e.g., `system/brain/knowledge/file.md`).
   * Reference this configuration file to resolve domains to physical paths.

2. **Path Resolution**:
   * For tools requiring physical paths, resolve domains using this configuration.
   * Example: `system_brain_path + "system/knowledge/file.md"` resolves to `1000xbrain/system/knowledge/file.md`.

3. **Project Detection**:
   * The project root and name are detected at runtime by initialization scripts.
   * These values can be manually updated when needed.

4. **Custom Domains**:
   * Add project-specific domains under the Domain Mappings section.
   * Document any custom domains thoroughly.

### Domain Structure

The system uses a flexible domain structure:

1. **System Domain** (`system/`): 
   * Contains all system components including:
     * Brain (Master System): `system/brain/` → `1000xbrain/`
     * Rules (Subsystem): `system/rules/` → `1000xrules/`
     * Commands (Subsystem): `system/commands/` → `1000xcommands/`
     * Scripts (Subsystem): `system/scripts/` → `1000xscripts/`
     * Plans (Subsystem): `system/plans/` → `1000xplans/`

2. **Project Domains**:
   * Default domains:
     * **Front-End Domain** (`front-end/`): Contains all front-end application code.
     * **Back-End Domain** (`back-end/`): Contains all back-end application code.
   * These can be modified, removed, or replaced with new domains based on project needs.

### Domain Flexibility Guidelines

The system is designed to be domain-agnostic, allowing for easy adaptation to different project structures:

1. **Adding New Domains**:
   * Add a new entry to the Domain Mappings section (e.g., `new_domain: path/to/new/domain/`).
   * Create the corresponding directory structure if it doesn't exist.
   * Update any cross-domain references if needed.

2. **Removing Domains**:
   * If a domain is no longer needed, comment it out or remove it from Domain Mappings.
   * Ensure no 1000xsystems components have dependencies on the removed domain.

3. **Replacing Domains**:
   * Update the domain path in Domain Mappings (e.g., changing `front-end_domain: front-end/` to `front-end_domain: ui/`).
   * Ensure directory structure matches the updated path.

4. **Complete Domain Restructure**:
   * For major changes (e.g., replacing front-end/back-end with a new structure like `llm_backed_terminal`):
     * Add the new domains to Domain Mappings.
     * Create corresponding 1000xbrain subdirectories for domain-specific knowledge/processes.
     * Update the implementation guides as needed.

### Updating Configuration

This configuration can be updated through:
1. Manual edits to this file.
2. Running the initialization script (`1000xscripts/init-project.ps1`).
3. Using configuration management commands.

Always verify system functionality after configuration changes.
"@
    }
    
    # Save the updated config
    Set-Content -Path $configPath -Value $newConfig
    
    Write-Log "Updated project configuration at $configPath" "SUCCESS"
    
    if ($Verbose) {
        Write-Log "Detected domains:" "INFO"
        foreach ($domain in $Domains.Keys | Sort-Object) {
            Write-Log "  $domain: $($Domains[$domain])" "INFO"
        }
    }
}

# Function to verify configuration
function Verify-Configuration {
    param (
        [string]$ProjectRoot
    )
    
    $configPath = Join-Path -Path $ProjectRoot -ChildPath "1000xbrain\system\configuration\project-config.md"
    
    if (-not (Test-Path $configPath)) {
        Write-Log "Configuration file not found: $configPath" "ERROR"
        return $false
    }
    
    # Read the configuration
    $config = Get-Content -Path $configPath -Raw
    
    # Check for required sections
    $requiredSections = @(
        "## Project Information",
        "## Domain Mappings",
        "## System Paths"
    )
    
    foreach ($section in $requiredSections) {
        if ($config -notmatch [regex]::Escape($section)) {
            Write-Log "Missing required section in configuration: $section" "ERROR"
            return $false
        }
    }
    
    # Check for key settings
    $requiredSettings = @(
        "project_name:",
        "frontend_domain:",
        "backend_domain:",
        "brain_path:"
    )
    
    foreach ($setting in $requiredSettings) {
        if ($config -notmatch [regex]::Escape($setting)) {
            Write-Log "Missing required setting in configuration: $setting" "ERROR"
            return $false
        }
    }
    
    Write-Log "Configuration verification passed" "SUCCESS"
    return $true
}

# Function to create brain domain directories for new project domains
function Create-DomainDirectories {
    param (
        [string]$ProjectRoot,
        [hashtable]$Domains
    )
    
    # For each domain, ensure there's a corresponding directory in 1000xbrain
    # Skip system domains (they're handled differently)
    foreach ($domain in $Domains.Keys) {
        if ($domain -ne "system_domain" -and 
            -not $domain.StartsWith("system_")) {
            
            $domainName = $domain -replace "_domain$", ""
            $brainDomainPath = Join-Path -Path $ProjectRoot -ChildPath "1000xbrain\$domainName"
            
            # Create domain directory and standard subdirectories if they don't exist
            if (-not (Test-Path $brainDomainPath)) {
                Write-Log "Creating brain domain directory: $brainDomainPath" "INFO"
                New-Item -Path $brainDomainPath -ItemType Directory -Force | Out-Null
                
                # Create standard subdirectories
                $subdirs = @("knowledge", "processes", "guidelines")
                foreach ($subdir in $subdirs) {
                    $subdirPath = Join-Path -Path $brainDomainPath -ChildPath $subdir
                    New-Item -Path $subdirPath -ItemType Directory -Force | Out-Null
                }
                
                # Create a README.md file in the domain directory
                $readmePath = Join-Path -Path $brainDomainPath -ChildPath "README.md"
                $readmeContent = @"
# $domainName Domain

This directory contains knowledge, processes, and guidelines specific to the $domainName domain.

## Structure

- **knowledge/**: Contains knowledge files about $domainName concepts and implementation details.
- **processes/**: Contains process definitions for $domainName operations.
- **guidelines/**: Contains guidelines for working with the $domainName domain.
"@
                Set-Content -Path $readmePath -Value $readmeContent
                
                Write-Log "Created $domainName domain structure in 1000xbrain" "SUCCESS"
            }
        }
    }
}

# Main script execution
try {
    # Detect project root
    $ProjectRoot = Get-ProjectRoot
    if (-not $ProjectRoot) {
        exit 1
    }
    
    Write-Log "Initializing 1000xsystems in project root: $ProjectRoot" "INFO"
    
    # Create log file if verbose mode is enabled
    if ($Verbose) {
        $logPath = "$ProjectRoot/1000xscripts/init-log.txt"
        if (Test-Path $logPath) {
            Remove-Item $logPath -Force
        }
        New-Item -Path $logPath -ItemType File -Force | Out-Null
        Write-Log "Log file created at: $logPath" "INFO"
    }
    
    # Ensure required directories exist
    Ensure-Directories -ProjectRoot $ProjectRoot
    
    # Get project information
    $ProjectInfo = Get-ProjectInfo -ProjectRoot $ProjectRoot
    Write-Log "Detected project: $($ProjectInfo.Name) (Type: $($ProjectInfo.Type))" "INFO"
    
    # Detect domain paths
    $Domains = Get-DomainPaths -ProjectRoot $ProjectRoot
    Write-Log "Detected frontend domain: $($Domains["frontend_domain"])" "INFO"
    Write-Log "Detected backend domain: $($Domains["backend_domain"])" "INFO"
    
    # Update project configuration
    Update-ProjectConfig -ProjectInfo $ProjectInfo -Domains $Domains
    
    # Verify configuration
    $configValid = Verify-Configuration -ProjectRoot $ProjectRoot
    if (-not $configValid) {
        Write-Log "Configuration verification failed. Please check the configuration manually." "WARNING"
    }
    
    # Create brain domain directories for project domains
    Create-DomainDirectories -ProjectRoot $ProjectRoot -Domains $Domains
    
    Write-Log "1000xsystems initialization completed successfully" "SUCCESS"
    Write-Log "The system is now configured for project: $($ProjectInfo.Name)" "SUCCESS"
    
} catch {
    Write-Log "Error during initialization: $_" "ERROR"
    Write-Log "Stack trace: $($_.ScriptStackTrace)" "ERROR"
    exit 1
} 