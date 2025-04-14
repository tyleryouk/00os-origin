# Path Handling Guidelines

## Overview

This document defines the standards for path handling across all 1000xsystems to ensure project-agnostic operation. These guidelines apply to all file operations, including reading, editing, and referencing files within the 1000xsystems.

## Core Principles

1. **Relative Paths**: Always use relative paths when referencing files within the 1000xsystems.
2. **Project Root Detection**: Implement reliable mechanisms to detect the project root.
3. **Path Resolution**: Use consistent path resolution techniques across all systems.
4. **Configuration-Driven**: Use a centralized configuration system for path references.

## Implementation Requirements

### Using Relative Paths

1. **Base Directory References**:
   * Use directory names without leading slashes: `1000xbrain/`, `1000xrules/`, etc.
   * Example: `1000xbrain/system/knowledge/file.md` (not `/1000xbrain/system/knowledge/file.md`)

2. **Cross-System References**:
   * Maintain the same level of directory structure across all references.
   * Use parent directory notation (`../`) when necessary for cross-system references.
   * Example: `../1000xrules/core/file.md` when referencing from within `1000xbrain/`

3. **Tool Calls**:
   * Use relative paths in all tool calls (read_file, edit_file, etc.).
   * Example: `read_file("1000xbrain/system/knowledge/file.md")`

### Project Root Detection

1. **Detection Mechanism**:
   * Use the presence of core 1000xsystems directories as indicators of the project root.
   * Check for the existence of `1000xbrain/`, `1000xrules/`, etc.

2. **Workspace Structure**:
   * Maintain consistent relative positioning of 1000xsystems directories.
   * Example structure:
     ```
     project-root/
     ├── 1000xbrain/
     ├── 1000xrules/
     ├── 1000xcommands/
     ├── 1000xscripts/
     └── [project specific directories]
     ```

### Path Configuration

1. **Centralized Configuration**:
   * Store all path configurations in `1000xbrain/system/configuration/project-config.md`.
   * Reference this configuration when resolving paths.

2. **Domain Mapping**:
   * Map logical domains to physical paths in the configuration.
   * Example:
     ```
     frontend_domain: front-end/
     backend_domain: back-end/
     ```

### Path Resolution in Scripts

1. **PowerShell Scripts**:
   * Use relative paths where possible.
   * For absolute path requirements, implement runtime resolution:
     ```powershell
     $projectRoot = $PSScriptRoot
     while (-not (Test-Path "$projectRoot\1000xbrain")) {
         $projectRoot = Split-Path $projectRoot -Parent
         if ($projectRoot -eq $null) { break }
     }
     $absolutePath = Join-Path $projectRoot "1000xbrain\system\file.md"
     ```

2. **Shell Commands**:
   * Avoid hardcoded absolute paths in shell commands.
   * Use environment variables or path resolution when absolute paths are required.

## Special Considerations

1. **Cross-Platform Compatibility**:
   * Use platform-agnostic path separators (prefer `/` over `\`).
   * Handle platform-specific path issues in scripts with appropriate conversion.

2. **Error Handling**:
   * Implement robust error handling for path resolution failures.
   * Log path resolution issues with clear context.

3. **Path Documentation**:
   * Document the path structure clearly in README files.
   * Include path resolution examples in documentation.

## Migration Strategy

1. **Audit Existing References**:
   * Systematically audit all file references across 1000xsystems.
   * Identify and update absolute paths and project-specific references.

2. **Testing**:
   * Test path resolution in different project structures.
   * Verify functionality after path updates. 