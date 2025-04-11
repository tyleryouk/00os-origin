# Change Request Details

**Date Requested**: 2024-05-30
**Requestor**: Tyler Youk
**Status**: Analysis Completed
**Directive**: Enhancement
**Target Cycle**: system/major-changes
**Enhancement Name**: Project Agnostic 1000xsystems
**Priority**: High

## Request Description

Create a project-agnostic configuration for all 1000xsystems (1000xbrain, 1000xcommands, 1000xplans, 1000xrules, 1000xscripts) to ensure they can be transferred to any project while maintaining full functionality. The system should work in any project folder structure as long as the 1000xsystems maintain their relative positions. This enables Tyler and 1000xdev to work on any project together by transferring the 1000xsystems without requiring project-specific modifications.

## Requirements

1. **Path Handling Requirements**:
   * Ensure all filepaths in the 1000xsystems are relative, never absolute
   * Implement a system to set and detect the project root path
   * Replace any hardcoded references to "GigaSwap" with project-agnostic alternatives
   * Create a configuration system to handle project-specific settings

2. **Domain Configuration Requirements**:
   * Centralize domain definitions (front-end, back-end, system) to allow easy updates when moving to a new project
   * Create a configuration or initialization system that defines project-specific domains
   * Ensure domain references are dynamic rather than hardcoded

3. **System Structure Requirements**:
   * Maintain consistent directory structure for 1000xsystems regardless of project
   * Ensure scripts can operate correctly in any project environment
   * Create documentation for the standard project folder structure

4. **Initialization Requirements**:
   * Create a system initialization process for when 1000xsystems are first moved to a new project
   * Include domain configuration as part of the initialization
   * Provide guidance for updating project-specific references

## Scope

* **Configuration/Root Files**: 
  * Root configuration system for project-agnostic operation
  * Project initialization scripts/processes
  * Domain definition and configuration files

* **1000xbrain Components**:
  * System knowledge and processes for project-agnostic operation
  * Guidelines updates for relative paths and domain references
  * Configuration management components

* **1000xscripts Components**:
  * Updates to scripts that may contain path-specific or project-specific references
  * Create or update initialization scripts
  * Update list-cycles.ps1 and other system scripts for project-agnostic operation

* **1000xcommands Components**:
  * Updates to ensure all commands use relative paths
  * Updates to centralize domain references

* **1000xrules Components**:
  * Updates to ensure all rules use relative paths
  * Updates to centralize domain references

## Success Criteria

1. All file paths in 1000xsystems are relative, not absolute
2. A root configuration system exists to define project-specific settings
3. Domain references are centralized and easily configurable
4. Scripts operate correctly regardless of project context
5. Documentation clearly explains how to transfer 1000xsystems to a new project
6. A initialization process exists for setting up 1000xsystems in a new project
7. No hardcoded references to "GigaSwap" exist in the 1000xsystems
8. The system works in multiple project structures as long as the 1000xsystems maintain their relative positions

## Special Considerations

1. This enhancement primarily affects the system domain, as front-end and back-end domain configurations are not yet fully developed
2. The project folder structure will always include the five 1000xsystems folders plus project-specific folders
3. The solution should minimize the work required when transferring to a new project
4. Absolute paths in PowerShell scripts require special attention
5. Guidelines should be updated before modifying the rest of the systems to ensure consistency 