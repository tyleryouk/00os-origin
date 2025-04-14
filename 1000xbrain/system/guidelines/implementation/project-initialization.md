# Project Initialization Guidelines

## Overview

This document defines the guidelines for initializing 1000xsystems in a new project environment. These guidelines ensure that the 1000xsystems can be properly configured and integrated with any project while maintaining project-agnostic operation.

## Core Principles

1. **Automated Initialization**: Use scripts to automate the initialization process.
2. **Configuration-Driven**: Use a centralized configuration system to manage project-specific settings.
3. **Domain Abstraction**: Abstract physical paths into logical domains.
4. **Project Independence**: Ensure all components function independently of specific project names or structures.

## Implementation Requirements

### Initialization Script

1. **Script Location**:
   * Place the initialization script at `1000xscripts/init-project.ps1`.
   * Ensure the script is accessible from the project root.

2. **Script Functionality**:
   * Detect the project root directory.
   * Identify the project name and type.
   * Update the central configuration.
   * Configure domain mappings.
   * Set up project-specific settings.
   * Verify all 1000xsystems components.

3. **Error Handling**:
   * Implement robust error handling in the initialization script.
   * Provide clear error messages for common issues.
   * Include recovery options for failed initialization.

### Configuration Setup

1. **Central Configuration File**:
   * Use `1000xbrain/system/configuration/project-config.md` as the central configuration file.
   * Structure the configuration with clear sections:
     * Project Information
     * Domain Mappings
     * System Paths
     * Project-Specific Settings

2. **Project Information**:
   * Capture basic project details:
     ```
     project_name: [Project Name]
     project_root: [Project Root Path]
     ```

3. **Domain Mappings**:
   * Map logical domains to physical paths:
     ```
     frontend_domain: front-end/
     backend_domain: back-end/
     system_domain: system/
     ```

4. **System Paths**:
   * Define paths to 1000xsystems components:
     ```
     system_brain_path: 1000xbrain/
     system_rules_path: 1000xrules/
     system_commands_path: 1000xcommands/
     system_scripts_path: 1000xscripts/
     system_plans_path: 1000xplans/
     ```

5. **Project-Specific Settings**:
   * Include settings specific to the project:
     ```
     app_name: [Project App Name]
     api_base_url: [Project API Base URL]
     ```

### Initialization Process

1. **Project Detection**:
   * Use the presence of core 1000xsystems directories to detect the project root.
   * Determine the project name from the directory name or project files.
   * Identify the project type from project files (e.g., package.json for Node.js).

2. **Configuration Update**:
   * Update the central configuration file with detected project information.
   * Configure domain mappings based on the project structure.
   * Set default values for project-specific settings.

3. **Verification**:
   * Verify that all required 1000xsystems components are present.
   * Validate the configuration against the actual project structure.
   * Check for any conflicts or issues.

### Initialization Commands

1. **Standard Command**:
   * Define a standard command for initialization:
     ```
     run command:system/init-project
     ```

2. **Command Implementation**:
   * The command should invoke the initialization script.
   * Provide options for forced initialization or specific configurations.

3. **Interactive Mode**:
   * Include an interactive mode for guided initialization.
   * Allow users to input project-specific settings during initialization.

## Special Considerations

1. **Existing Projects**:
   * Handle initialization in projects that already have partial 1000xsystems components.
   * Provide options for merging or replacing existing components.

2. **Custom Project Structures**:
   * Support non-standard project structures through configuration options.
   * Allow customization of domain mappings and system paths.

3. **Multiple Environments**:
   * Support different configurations for development, staging, and production environments.
   * Allow environment-specific settings in the configuration.

4. **Initialization Logging**:
   * Log the initialization process for troubleshooting.
   * Include timestamps and detailed information in the logs.

## Migration Strategy

1. **Preparing for Transfer**:
   * Ensure all file paths are relative before transfer.
   * Remove any project-specific references from all 1000xsystems.
   * Document any customizations or project-specific configurations.

2. **Testing**:
   * Test the initialization script in different project environments.
   * Verify that all components function correctly after initialization.
   * Ensure domain resolution works as expected.

## Example Implementation

### Initialization Script (PowerShell)

```powershell
# Project Initialization Script
# Location: 1000xscripts/init-project.ps1

# Function to detect project root
function Find-ProjectRoot {
    $currentDir = Get-Location
    while (-not (Test-Path "$currentDir\1000xbrain" -PathType Container)) {
        $parent = Split-Path -Path $currentDir -Parent
        if ($parent -eq $null -or $parent -eq $currentDir) {
            Write-Error "Could not find project root (1000xbrain directory not found in parent hierarchy)"
            return $null
        }
        $currentDir = $parent
    }
    return $currentDir
}

# Function to detect project name
function Get-ProjectName {
    param([string]$projectRoot)
    
    # Try to get from directory name
    $projectName = Split-Path -Path $projectRoot -Leaf
    
    # Try to get from package.json if exists
    if (Test-Path "$projectRoot\package.json") {
        $packageJson = Get-Content "$projectRoot\package.json" -Raw | ConvertFrom-Json
        if ($packageJson.name) {
            $projectName = $packageJson.name
        }
    }
    
    return $projectName
}

# Function to update configuration
function Update-Configuration {
    param(
        [string]$projectRoot,
        [string]$projectName
    )
    
    $configPath = "$projectRoot\1000xbrain\system\configuration\project-config.md"
    
    # Create configuration directory if it doesn't exist
    $configDir = Split-Path -Path $configPath -Parent
    if (-not (Test-Path $configDir -PathType Container)) {
        New-Item -Path $configDir -ItemType Directory -Force | Out-Null
    }
    
    # Generate configuration content
    $configContent = @"
# Project Configuration

## Project Information
project_name: $projectName
project_root: [Detected at Runtime]

## Domain Mappings
front-end_domain: front-end/
back-end_domain: back-end/
system_domain: system/

## System Paths
system_brain_path: 1000xbrain/
system_rules_path: 1000xrules/
system_commands_path: 1000xcommands/
system_scripts_path: 1000xscripts/
system_plans_path: 1000xplans/

## Project-Specific Settings
app_name: $projectName
api_base_url: [Project API Base URL]

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
"@
    
    # Write configuration to file
    Set-Content -Path $configPath -Value $configContent
    
    Write-Host "Configuration updated at $configPath"
}

# Function to verify system components
function Verify-SystemComponents {
    param([string]$projectRoot)
    
    $components = @(
        "1000xbrain",
        "1000xrules",
        "1000xcommands",
        "1000xscripts"
    )
    
    $missingComponents = @()
    
    foreach ($component in $components) {
        if (-not (Test-Path "$projectRoot\$component" -PathType Container)) {
            $missingComponents += $component
        }
    }
    
    if ($missingComponents.Count -gt 0) {
        Write-Warning "Missing components: $($missingComponents -join ", ")"
        return $false
    }
    
    return $true
}

# Main initialization process
function Initialize-Project {
    Write-Host "Starting project initialization..."
    
    # Detect project root
    $projectRoot = Find-ProjectRoot
    if (-not $projectRoot) {
        return
    }
    
    Write-Host "Project root detected: $projectRoot"
    
    # Get project name
    $projectName = Get-ProjectName -projectRoot $projectRoot
    Write-Host "Project name: $projectName"
    
    # Update configuration
    Update-Configuration -projectRoot $projectRoot -projectName $projectName
    
    # Verify system components
    $componentsVerified = Verify-SystemComponents -projectRoot $projectRoot
    if ($componentsVerified) {
        Write-Host "All system components verified."
    }
    
    Write-Host "Project initialization completed successfully."
}

# Run initialization
Initialize-Project
```

### Initialization Command

```markdown
# Command: Initialize Project | system/init-project

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/system/initialization/init-project-process.md
# Knowledge: 1000xbrain/system/knowledge/project-initialization.md
# --- END DYNAMIC EXECUTION ---

# This command initializes the 1000xsystems for a new project environment.
# It detects the project root, updates configuration, and verifies system components.

# Usage: run command:system/init-project
```

## Related References

* Path Handling Guidelines: `1000xbrain/system/guidelines/implementation/path-handling.md`
* Configuration Management Guidelines: `1000xbrain/system/guidelines/implementation/configuration-management.md`
* Domain Reference Guidelines: `1000xbrain/system/guidelines/implementation/domain-references.md`
* Project Transfer Documentation: `1000xbrain/system/knowledge/project-transfer.md` 