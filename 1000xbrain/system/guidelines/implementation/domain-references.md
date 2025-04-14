# Domain Reference Guidelines

## Overview

This document defines the standards for domain references across all 1000xsystems to ensure project-agnostic operation. Domain references abstract physical paths, allowing code to function regardless of the specific project structure.

## Core Principles

1. **Logical Domains**: Use logical domain names that abstract physical paths.
2. **Centralized Mapping**: Maintain mappings between logical domains and physical paths in a central configuration.
3. **Consistent Usage**: Apply domain references consistently across all 1000xsystems.
4. **Project Independence**: Ensure domain references function independently of specific project names or structures.

## Implementation Requirements

### Domain Naming and Structure

1. **Primary Domains**:
   * `system`: System-level components encompassing brain (master system), rules, commands, scripts, and plans (subsystems)
   * `front-end`: Front-end application code
   * `back-end`: Back-end application code

2. **Subdomain Structure**:
   * Use consistent subdomain naming across all domain references.
   * System subdomains follow the pattern `system/[subsystem]/[component]`
     * `system/brain`: Master system components (configuration, knowledge, processes, etc.)
     * `system/rules`: Rules subsystem components
     * `system/commands`: Commands subsystem components
     * `system/scripts`: Scripts subsystem components
     * `system/plans`: Plans subsystem components
   * Application subdomains follow the pattern `[domain]/[component]`
     * `front-end/components`, `front-end/pages`, etc.
     * `back-end/api`, `back-end/services`, etc.

3. **Domain Resolution**:
   * Each domain resolves to a physical base path defined in the central configuration.
   * Example: `front-end` might resolve to `front-end/` or another project-specific directory.

### Reference Formats

1. **Command References**:
   * Standard Format: `run command:system/commands/[command-name]`
   * Example: `run command:system/commands/brain/analyze-structure`
   * Domain represents a subdirectory under the system domain

2. **File Path References**:
   * Use the domain as a prefix for the relative path.
   * Examples:
     * `system/brain/knowledge/file.md` (refers to `1000xbrain/system/knowledge/file.md`)
     * `system/rules/core/identity/file.md` (refers to `1000xrules/core/identity/file.md`)
     * `system/commands/brain/analyze.md` (refers to `1000xcommands/system/brain/analyze.md`)

3. **Documentation References**:
   * Use backticks (`` ` ``) around path references for clarity.
   * Example: `` `system/brain/knowledge/file.md` ``

### Domain Usage in 1000xsystems

1. **Command File Organization**:
   * Organize command files under the system domain:
     * `1000xcommands/system/brain/analyze.md`
     * `1000xcommands/system/front-end/init-component.md`
     * `1000xcommands/system/back-end/create-api.md`

2. **Brain Knowledge Organization**:
   * Organize knowledge files under the system/brain subdomain:
     * `1000xbrain/system/knowledge/architecture.md`
     * `1000xbrain/front-end/knowledge/react-patterns.md`
     * `1000xbrain/back-end/knowledge/api-standards.md`

3. **Cross-Domain References**:
   * Use consistent notation for references between domains.
   * Example: Reference from `system/brain` to `system/rules` using domain prefixes.

### Domain Resolution Implementation

1. **Configuration-Based Resolution**:
   * Use `1000xbrain/system/configuration/project-config.md` to map domains to physical paths.
   * Update domain mappings when project structure changes.

2. **Resolution Process**:
   * When encountering a domain reference, consult the configuration to determine the physical path.
   * Combine the domain's base path with the relative path to create a full path.

3. **Default Mappings**:
   * Provide sensible default mappings for standard domains.
   * Allow custom mappings for project-specific domains.

### Domain Editing

1. **Domain Addition**:
   * Add new domains to the central configuration when needed.
   * Document the purpose and scope of new domains.

2. **Domain Modification**:
   * Update domain mappings when project structure changes.
   * Verify all references remain valid after domain changes.

## Special Considerations

1. **Command Invocation Compatibility**:
   * Ensure domain references in command invocations follow the standard format.
   * Handle backward compatibility with legacy command formats.

2. **Domain Name Conflicts**:
   * Avoid domain names that conflict with common directory names.
   * Use clear and specific domain names to prevent ambiguity.

3. **Documentation**:
   * Document the domain reference system thoroughly.
   * Provide examples of domain usage in different contexts.

## Migration Strategy

1. **Audit Existing References**:
   * Identify all references to physical paths across 1000xsystems.
   * Convert direct path references to domain-based references.

2. **Update Reference Patterns**:
   * Update patterns and templates to use domain references.
   * Create migration tools to assist with large-scale updates.

3. **Testing**:
   * Test domain resolution in different project structures.
   * Verify functionality after domain updates. 