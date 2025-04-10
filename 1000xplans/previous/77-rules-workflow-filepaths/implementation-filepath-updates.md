# Implementation Plan: Project-Rule-Parameter Filepath Updates and Missing Enhancements

## Overview

This document outlines the implementation plan for updating all project-rule-parameter filepaths across the codebase and creating missing files identified in the requirements. The implementation will follow a phased approach to systematically implement all required changes.

## Phases

### Phase 1: Core Communication Files Update

**Target Files:**
- `1000xbrain/core/communication/syntax-standards.md`
- `1000xbrain/core/communication/message-command-list.md`
- `1000xbrain/core/communication/symbol-guidelines.md`
- `1000xbrain/core/communication/message-commands.md`

**Implementation Steps:**
1. For each file:
   - Read and scan for all `@parameters/rules/` references
   - Map each reference to its new location based on the file migration mapping
   - Update the reference with proper backtick wrapping
   - Verify all examples use correct extension (.mdc)
   - Check for unwrapped @ symbols and ensure they're properly wrapped
2. Verify all updates in each file

### Phase 2: Mode Transitions Files Update

**Target Files:**
- `1000xbrain/core/modes/transitions/mode-transitions-handlers.md`

**Implementation Steps:**
1. Read and scan for all `@parameters/rules/` references
2. Map each reference to its new location
3. Update references with proper backtick wrapping
4. Verify correct extension usage

### Phase 3: Workflow Files Update

**Target Files:**
- `1000xbrain/workflows/rules-workflow.md`
- `1000xbrain/workflows/README.md`
- `1000xbrain/workflows/rules-workflow/message-commands-reference.md`
- `1000xbrain/workflows/rules-workflow/README.md`
- `1000xbrain/workflows/rules-workflow/rules-workflow-cheatsheet.md`

**Implementation Steps:**
1. For each file:
   - Read and scan for all `@parameters/rules/` references
   - Map each reference to its new location
   - Update references with proper backtick wrapping
   - Pay special attention to tables and code blocks
2. Verify all updates in each file
3. Update the rules-workflow-cheatsheet.md with the new complete structure including missing files

### Phase 4: Parameters README Update

**Target Files:**
- `1000xbrain/parameters/rules/README.md`

**Implementation Steps:**
1. Update the README to reflect the new directory structure
2. Document the organization and purpose of each subdirectory
3. Provide guidance on where to find specific types of project-rule-parameters
4. Include information about new front-end enhancement and no-planning-folder files

### Phase 5: Create Missing Front-End Enhancement Files

**Target Files to Create:**
- `1000xbrain/parameters/rules/plan-mode/continue-planning-front-end-enhancement.md`
- `1000xbrain/parameters/rules/dev-mode/dev-mode-front-end-enhancement.md`
- `1000xbrain/parameters/rules/dev-mode/continue-implementation-front-end-enhancement.md`

**Implementation Steps:**
1. Read and analyze existing front-end enhancement file (`plan-mode-front-end-enhancement.md`)
2. Create `dev-mode-front-end-enhancement.md`:
   - Follow the same pattern as other dev-mode files
   - Include necessary tool call sequences for front-end file access
   - Define clear boundaries and implementation guidelines
3. Create `continue-planning-front-end-enhancement.md`:
   - Follow the same pattern as continue-planning.md
   - Adapt for front-end enhancement workflow
   - Include relevant tool call sequences
4. Create `continue-implementation-front-end-enhancement.md`:
   - Follow the same pattern as continue-implementation.md
   - Adapt for front-end enhancement workflow
   - Include relevant tool call sequences
5. Ensure consistency across all front-end enhancement files
6. Verify proper file locations within subdirectories

### Phase 6: Create Missing No-Planning-Folder Files

**Target Files to Create:**
- `1000xbrain/parameters/rules/no-planning-folder/no-planning-folder-front-end-enhancement.md`
- `1000xbrain/parameters/rules/no-planning-folder/no-planning-folder-subsystem.md`
- `1000xbrain/parameters/rules/no-planning-folder/no-planning-folder-system-wide.md`

**Implementation Steps:**
1. Analyze the no-planning-folder mode requirements
2. Create `no-planning-folder-subsystem.md`:
   - Define clear purpose and usage pattern
   - Include tool call sequences for subsystem access
   - Document prompt handling and research process
3. Create `no-planning-folder-system-wide.md`:
   - Define clear purpose and usage pattern
   - Include tool call sequences for system-wide changes
   - Document prompt handling and research process
4. Create `no-planning-folder-front-end-enhancement.md`:
   - Define clear purpose and usage pattern
   - Include tool call sequences for front-end access
   - Document prompt handling and research process
5. Update the README.md in the no-planning-folder directory
6. Ensure consistency across all no-planning-folder files

### Phase 7: Verification and Testing

**Implementation Steps:**
1. Comprehensive grep search for any remaining legacy references
2. Verify all missing files are created in the correct locations
3. Select key project-rule-parameters to test functionality:
   - One from each subdirectory (plan-mode, dev-mode, helpers, no-planning-folder)
   - Test front-end enhancement files
   - Test no-planning-folder mode files
4. Check for any inconsistencies in format or wrapping
5. Create a verification report

## Implementation Guidelines

### Search and Replace Pattern

For each reference type, use the following pattern:

1. **Plan-Mode Files**
   - Find: `@parameters/rules/plan-mode-{name}.mdc`
   - Replace: `@parameters/rules/plan-mode/plan-mode-{name}.mdc`
   - Find: `@parameters/rules/continue-planning.mdc`
   - Replace: `@parameters/rules/plan-mode/continue-planning.mdc`
   - Find: `@parameters/rules/template-{name}.mdc`
   - Replace: `@parameters/rules/plan-mode/template-{name}.mdc`

2. **Dev-Mode Files**
   - Find: `@parameters/rules/dev-mode-{name}.mdc`
   - Replace: `@parameters/rules/dev-mode/dev-mode-{name}.mdc`
   - Find: `@parameters/rules/continue-implementation{suffix}.mdc`
   - Replace: `@parameters/rules/dev-mode/continue-implementation{suffix}.mdc`

3. **Helper Files**
   - Use the specific mappings from the context document for each helper type

### New File Creation Pattern

When creating new files, follow these patterns:

1. **Front-End Enhancement Files**
   - Base structure on existing front-end enhancement file
   - Match naming and content structure to peer files
   - Include proper tool call sequences
   - Follow clear boundary enforcement guidelines

2. **No-Planning-Folder Mode Files**
   - Focus on direct implementation without planning
   - Include detailed research-implement iterative process
   - Ensure consistent pattern across all no-planning-folder files
   - Document prompt handling and interpretation

### Backtick Wrapping Rules

- Always wrap the entire reference in backticks: `` `@parameters/rules/...` ``
- In code blocks, only add backticks if they're part of the regular text, not the code example
- In tables, maintain the existing backtick wrapping style

### Extension Rules

- Use `.mdc` for project-rule-parameters in message-command examples
- Use `.md` when discussing the actual files on disk in the 1000xbrain directory

## Test Verification Strategy

1. **Syntax Verification**
   - Check if the updated reference syntax is correct
   - Verify proper backtick wrapping
   - Ensure correct extensions (.mdc vs .md)

2. **Functionality Testing**
   - Verify that example message-commands reflect the new structure
   - Check any cross-references between files
   - Ensure README files provide accurate guidance
   - Test new front-end enhancement files for consistency
   - Verify no-planning-folder mode documentation and examples

3. **Completeness Check**
   - Run a final grep search to ensure no legacy references remain
   - Verify all files in the target list have been updated
   - Check that all missing files have been created
   - Ensure all references in the migration mapping are accounted for 