# Major Changes Workflow Implementation Plan

**Plan Type**: Feature Enhancement
**Date**: 2025-06-12
**Priority**: High
**Status**: Implementation Phase

## Overview

This plan outlines the implementation of a new sequential command structure for handling major changes requested explicitly by Tyler Youk. The structure will parallel the existing autonomous workflow but will focus on user-directed significant changes rather than AI-initiated optimizations.

## Goal

Create a complete sequential command structure in `1000xcommands/system/major-changes/` for handling explicit change requests, reusing existing processes and knowledge where appropriate while maintaining clear separation from the autonomous workflow.

## Implementation Phases

### Phase 1: Directory Structure Setup

*   Create the base directory structure for the major-changes workflow:
    *   `1000xcommands/system/major-changes/` - For the sequential command files
    *   `1000xbrain/system/major-changes/operational_feedback/` - For storing state and feedback

### Phase 2: Command File Creation

*   Create basic command files for the sequential workflow:
    *   `1.md` (initiate-explicit-cycle) - Starts a new cycle for explicitly requested changes
    *   `2.md` (assess-change-request) - Analyzes and scopes the explicit change request
    *   `3.md` (plan-implementation) - Creates a detailed implementation plan
    *   `4.md` (implement-changes) - Executes the planned changes
    *   `5.md` (verify-changes) - Verifies the changes meet requirements
    *   `6.md` (refine-changes) - Optional refinement step for addressing issues
    *   `7.md` (complete-change-cycle) - Finalizes the change cycle

### Phase 3: Process Integration

*   Link new command files to existing processes where appropriate:
    *   Reuse `verification-process.md` for verification steps
    *   Reuse `refinement-process.md` for refinement steps
    *   Create new process for change request assessment

### Phase 4: Documentation and Integration

*   Update system documentation to reflect the new workflow:
    *   Modify relevant parts of implementation-progress.md
    *   Document the relationship between autonomous and major-changes workflows
    *   Create a transition plan for moving between workflows

### Phase 5: Testing and Validation

*   Perform initial testing of the complete workflow:
    *   Test the command sequence on a sample change request
    *   Validate proper state management between commands
    *   Ensure proper integration with existing system components

## Future Enhancement: Guidelines Integration

Based on verification and refinement during this implementation cycle, a future enhancement is needed to address the following issues:

1. **Guidelines Integration in Workflows**:
   * Update both autonomous and major-changes commands to explicitly read relevant guidelines
   * Ensure every workflow cycle references the latest system guidelines
   * Maintain alignment between workflows and guidelines as they evolve

2. **README Standardization**:
   * Establish clear policy on when README.md files should be used
   * Standardize documentation patterns across system components
   * Implement consistent documentation approach

3. **Specialized Knowledge Development**:
   * Create additional knowledge files for specific change types
   * Develop comprehensive change scoping and validation standards
   * Document common change patterns and best practices

This enhancement should be planned after the completion of the current implementation cycle.

## Detailed Task Breakdown

### Phase 1: Directory Structure Setup

1. **Create base major-changes directory**:
   * Create `1000xcommands/system/major-changes/` directory
   * Create `1000xbrain/system/major-changes/operational_feedback/` directory
   * Set up initial README.md file explaining purpose

### Phase 2: Command File Creation

1. **Create command file: 1.md (initiate-explicit-cycle)**:
   * Pattern after `1000xcommands/system/autonomous/1.md`
   * Modify to handle explicit change requests
   * Use dynamic execution pattern referencing existing cycle initiation process

2. **Create command file: 2.md (assess-change-request)**:
   * Create new command focused on analyzing change request scope
   * Add parameters for change request details
   * Link to appropriate knowledge sources for assessment criteria

3. **Create command file: 3.md (plan-implementation)**:
   * Pattern after `1000xcommands/system/autonomous/3.md`
   * Modify to focus on explicit change planning
   * Use dynamic execution referencing planning process

4. **Create command file: 4.md (implement-changes)**:
   * Pattern after `1000xcommands/system/autonomous/4.md`
   * Adapt for explicit change implementation
   * Use dynamic execution referencing implementation process

5. **Create command file: 5.md (verify-changes)**:
   * Pattern after `1000xcommands/system/autonomous/5.md`
   * Include operational feedback directory checks
   * Link to verification process and principles

6. **Create command file: 6.md (refine-changes)**:
   * Pattern after `1000xcommands/system/autonomous/6.md`
   * Modify for explicit change refinement
   * Include refinement logic for addressing verification issues

7. **Create command file: 7.md (complete-change-cycle)**:
   * Pattern after `1000xcommands/system/autonomous/7.md`
   * Adapt for explicit change cycle completion
   * Include command index update and logging

### Phase 3: Process Integration

1. **Reuse existing processes**:
   * Identify which processes can be reused from autonomous workflow
   * Link to appropriate processes in command files
   * Document any modifications needed for the explicit change context

2. **Create change assessment process**:
   * Create a new process file for change request assessment
   * Define steps for analyzing change scope and requirements
   * Include integration with existing knowledge files

### Phase 4: Documentation and Integration

1. **Update implementation progress tracking**:
   * Document the new major-changes workflow
   * Create tracking structures for major changes
   * Establish relationship with autonomous workflow

2. **Create workflow documentation**:
   * Document the purpose and usage of major-changes workflow
   * Explain when to use vs. autonomous workflow
   * Provide examples of appropriate use cases

### Phase 5: Testing and Validation

1. **Create test case**:
   * Define a sample change request
   * Document expected outcomes at each step
   * Create verification criteria

2. **Execute test workflow**:
   * Run through the complete sequence
   * Document results and any issues
   * Make adjustments as needed

## Dependencies

* Existing autonomous workflow structure
* Process and knowledge files in the brain system
* Implementation progress tracking system

## Success Criteria

* All seven command files created and functional
* Commands properly reuse existing processes where appropriate
* Workflow successfully manages state between steps
* Clear documentation explaining relationship with autonomous workflow
* Sample change request can be successfully processed through the workflow

## Next Steps

After plan approval, proceed to implementation phase by executing:
`run command:system/autonomous/4`

## Cycle Manager Enhancements Plan (Cycle CM-003)

**Goal:** Enhance the cycle-manager system to support global directives, provide dynamic cycle listing, and standardize the notes file structure across all cycles.

**Phases:**

1.  **Knowledge and Script Creation:**
    *   Create `1000xbrain/system/cycle-manager/knowledge/available-directives.md`.
        *   Define initial directive: `Analyze Cycle`.
        *   Document structure and usage.
    *   Create `1000xscripts/system/list-cycles.ps1`.
        *   Implement logic to scan `1000xcommands/` subdirectories (system, frontend, backend) for cycle patterns (e.g., directories containing numbered `[1-7].md` files).
        *   Output a formatted list of cycle names/paths.
    *   (Optional) Create `1000xcommands/system/info/list-cycles.md` to wrap the script execution.

2.  **Process Modification:**
    *   Modify `1000xbrain/system/cycle-manager/processes/initiation-process.md`:
        *   Update the `notes.md` template creation step to reflect the new `USER REQUEST SECTION` (top), `Tyler Youk notes`, `1000XDEV NOTES` structure.
        *   Add references in the template to `available-directives.md` and the cycle listing script/command.
        *   Ensure this structure is propagated when creating notes for *new* cycles managed by `cycle-manager`.
    *   Modify `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md`:
        *   Add logic to detect the `# Directive:` field.
        *   If directive is found, parse `# Target Cycle:`, `# Analysis Focus:`, and `# Directive Notes:`.
        *   Bypass standard change request parsing and prepare for direct action based on the directive.
        *   Handle cases where the directive is invalid or the target cycle doesn't exist.
    *   Modify `1000xbrain/system/cycle-manager/processes/cycle-analysis-process.md`:
        *   Add capability to accept optional `Analysis Focus` and `Directive Notes` parameters.
        *   Implement logic to tailor analysis based on focus parameter (if provided).
        *   Incorporate information from `Directive Notes` into the analysis context.
        *   Add specific checks/logic to run when the target cycle is `cycle-manager` itself.

3.  **Testing and Validation:**
    *   Test the `list-cycles.ps1` script.
    *   Test the `Analyze Cycle` directive targeting `cycle-manager` and another sample cycle.
    *   Test with and without `Analysis Focus` and `Directive Notes`.
    *   Verify the new `notes.md` structure is correctly applied during a test cycle initiation.
    *   Ensure standard change requests still function correctly.
