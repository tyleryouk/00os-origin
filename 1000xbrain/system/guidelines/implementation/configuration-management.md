# Configuration Management Guidelines

## Overview

This document defines the standards for configuration management across all 1000xsystems to ensure project-agnostic operation. A centralized configuration approach allows the systems to work in any project folder structure as long as the 1000xsystems maintain their relative positions.

## Core Principles

1. **Centralized Configuration**: Use a single source of truth for all configuration settings.
2. **Project Agnosticism**: Ensure all configurations are independent of specific project names or absolute paths.
3. **Domain Configuration**: Use logical domain references that map to physical paths.
4. **Dynamic Resolution**: Implement runtime configuration resolution where necessary.

## Implementation Requirements

### Centralized Configuration System

1. **Configuration Location**:
   * Store all central configurations in `1000xbrain/system/configuration/project-config.md`.
   * Use this as the authoritative source for all configuration settings.

2. **Configuration Structure**:
   * Organize configuration in clear sections:
     ```markdown
     # Project Configuration

     ## Project Information
     project_name: [dynamic]
     project_root: [dynamic]

     ## Domain Mappings
     frontend_domain: front-end/
     backend_domain: back-end/

     ## System Paths
     brain_path: 1000xbrain/
     rules_path: 1000xrules/
     commands_path: 1000xcommands/
     scripts_path: 1000xscripts/
     plans_path: 1000xplans/

     ## Project-Specific Settings
     [Additional project-specific settings as needed]
     ```

3. **Configuration Access**:
   * Read the configuration file at the beginning of significant operations.
   * Cache configuration values when appropriate for performance.

### Domain Configuration

1. **Logical Domains**:
   * Define logical domains that abstract physical paths:
     * `system_domain`: System management and configuration.
     * `frontend_domain`: Front-end application code.
     * `backend_domain`: Back-end application code.
     * `brain_domain`: 1000xbrain cognitive architecture.
     * `rules_domain`: 1000xrules core identity rules.
     * `commands_domain`: 1000xcommands command definitions.
     * `scripts_domain`: 1000xscripts utility scripts.
     * `plans_domain`: 1000xplans planning documents.

2. **Domain Resolution**:
   * Use domain prefixes for file references:
     * `system/path/to/file` resolves to the system domain.
     * `frontend/path/to/file` resolves to the frontend domain.
     * `backend/path/to/file` resolves to the backend domain.

3. **Domain Mapping**:
   * Map logical domains to physical paths in the configuration.
   * Update mappings when project structure changes.

### Project-Specific Settings

1. **Setting Types**:
   * **Core Settings**: Essential for 1000xsystems operation (non-negotiable).
   * **Project Settings**: Specific to the current project (configurable).
   * **Environment Settings**: Vary based on the environment (dynamic).

2. **Setting Management**:
   * Store all settings in the central configuration file.
   * Document the purpose and impact of each setting.

3. **Default Values**:
   * Provide sensible defaults for all settings.
   * Document the rationale for default values.

### Configuration Updates

1. **Manual Updates**:
   * Update configuration through direct edits to `project-config.md`.
   * Document all changes in the configuration file.

2. **Automated Updates**:
   * Use initialization scripts to update project-specific settings.
   * Validate configuration after automated updates.

## Special Considerations

1. **Configuration Validation**:
   * Implement validation for critical configuration settings.
   * Log warnings for potential configuration issues.

2. **Cross-Platform Compatibility**:
   * Ensure configuration works across different operating systems.
   * Handle platform-specific configurations separately.

3. **Documentation**:
   * Document the configuration system thoroughly.
   * Provide examples of configuration usage.

## Migration Strategy

1. **Audit Existing Configurations**:
   * Identify all configuration-like settings across 1000xsystems.
   * Consolidate into the central configuration system.

2. **Update References**:
   * Update all hardcoded references to use the configuration system.
   * Implement domain resolution for file references.

3. **Testing**:
   * Test the configuration system in different project structures.
   * Verify functionality after configuration updates. 