# Enhancement: Rule Type Configuration Sync Fix

## Metadata
- **ID**: 011
- **Date**: 2025-04-14
- **Status**: Proposed
- **Author**: System
- **Priority**: High
- **Estimated Effort**: Medium

## Background

The 00OS system uses `.cursor/rules` directory to store MDC files that control how the AI interacts with commands and components. These MDC files need specific frontmatter configurations to function correctly:

- Core system files should be "Always Apply" rules (`alwaysApply: true`)
- Process files should be "Agent Requested" rules (`alwaysApply: false` with descriptive "USE WHEN" trigger phrases)
- Configuration files should be "Always Apply" rules (`alwaysApply: true`) 

We've recently enhanced the synchronization script (`1000xscripts/Sync-00OS.ps1`) to automatically set these frontmatter configurations based on the directory structure. While the script correctly generates the expected frontmatter in the MDC files, some process files are still appearing as "Manual" rule types in the Cursor UI, indicating an issue with how the rules are being synchronized or interpreted.

## Problem Statement

The automated rule type configuration system is not functioning as expected:

1. Process files in the `.cursor/rules/processes/` directory are showing as "Manual" rule type in the Cursor UI's rule editor
2. This happens despite the `.mdc` files having the correct frontmatter with appropriate descriptions and `alwaysApply: false` setting
3. The inconsistency means process files are not being automatically included when relevant, reducing the effectiveness of the 00OS terminal interface
4. The issue persists even after successful synchronization with no reported errors

Specific example: `reaper-sync.mdc` and other process files in `.cursor/rules/processes/system/` directory are showing as "Manual" rule type in the UI, with the warning message "This rule needs to be mentioned to be included."

## Proposed Solution

1. **Investigation Phase**:
   - Compare frontmatter structure between working and non-working MDC files
   - Verify exact format requirements for each rule type in Cursor's UI
   - Check for hidden characters, duplicate frontmatter, or other formatting issues
   - Examine how Cursor UI reads and interprets the MDC files

2. **Implementation Phase**:
   - Update the `Get-OSOSFrontmatter` function in `1000xscripts/Sync-00OS.ps1` to match Cursor's expected format exactly
   - Add validation step to verify frontmatter structure in target files
   - Create testing process to verify rule types are applied correctly
   - Consider adding a "repair mode" to fix existing MDC files with incorrect configurations

3. **Integration Phase**:
   - Update all existing process files
   - Document correct format for future enhancements
   - Update the synchronization report to include rule type status

## Implementation Steps

1. Create a detailed analysis of working vs. non-working rule files
2. Examine Cursor UI's handling of MDC files through Cursor settings and cached files
3. Update `Sync-00OS.ps1` with enhanced frontmatter generation:
   ```powershell
   # Enhanced frontmatter for process files
   $frontmatter = @"
---
description: $description
globs: 
alwaysApply: false
---

"@
   ```
4. Add validation function to check if rule type is applied correctly
5. Create a direct repair tool to fix existing rule type configurations
6. Document findings and update `mdc-file-guide.md` with precise format requirements

## Acceptance Criteria

1. All process files show as "Agent Requested" rule type in Cursor UI
2. All core system files show as "Always Apply" rule type in Cursor UI
3. All configuration files show as "Always Apply" rule type in Cursor UI
4. Synchronization process automatically applies correct rule types for new files
5. Warning messages about rules needing to be mentioned are eliminated
6. Documentation is updated with correct formatting guidelines

## Dependencies

- Current synchronization scripts in `1000xscripts/`
- Cursor UI handling of MDC files
- Structure of existing process, core, and configuration files

## Related Files

- `1000xscripts/Sync-00OS.ps1`
- `.cursor/rules/processes/system/reaper-sync.mdc` (example affected file)
- `.cursor/rules/processes/system/echo.mdc`
- `.cursor/rules/core/command-handler.mdc` (working example)
- `00reaper/mdc-file-guide.md`

## Notes

The issue might be related to:
- Cursor's cache of MDC files
- Hidden format requirements not visible in raw files
- Incompatibilities between manual UI edits and script-generated files
- Updates to Cursor that changed how rule types are determined

Fixing this issue is critical for making the 00OS terminal interface more effective since process files are currently not being automatically included when they should be. 