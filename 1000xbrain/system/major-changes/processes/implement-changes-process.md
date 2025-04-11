# Process: Implementation

# Defines the steps for implementing the planned changes based on the implementation plan.

## Goal: Execute the implementation plan using a two-phase approach that prioritizes guidelines updates before system-wide changes.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`.
    *   Verify that planning has been completed.
    *   **(Error Handling)**: If planning is not complete, log error and suggest creating a plan.

2.  **Load Implementation Plan**:
    *   Use `read_file` to read `1000xbrain/system/major-changes/operational_feedback/implementation_plan.md`.
    *   **(Error Handling)**: If plan doesn't exist, log error and stop.
    *   Parse the tasks and phases defined in the plan.
    *   Extract success criteria for verification.

3.  **Initialize Implementation Log**:
    *   Use `edit_file` to create `1000xbrain/system/major-changes/operational_feedback/implementation_log.md`:
        ```markdown
        # Implementation Log

        **Plan Reference**: [implementation plan title]
        **Mode**: [USER_DIRECTED/AUTONOMOUS]
        **Status**: In Progress

        ## Execution Summary

        [Will be populated during implementation]

        ## Task Execution

        ### Phase 1: Guidelines Updates

        [Will be populated during implementation]

        ### Phase 2: System-Wide Implementation

        [Will be populated during implementation]

        ## Issues Encountered

        [Will be populated during implementation]

        ## Overall Status

        In Progress
        ```
    *   **(Error Handling)**: If file creation fails, retry with simplified format.

4.  **Phase 1: Implement Guidelines Updates**:
    *   Log the start of the guidelines update phase:
        ```
        edit_file("1000xbrain/system/major-changes/operational_feedback/implementation_log.md", "Log start of guidelines updates", "...")
        ```
    *   For each guideline file identified in the plan:
        *   Read the current file content
        *   Make the required modifications
        *   Update the implementation log with details of the changes
    *   Verify guideline changes for consistency and correctness
    *   **(Error Handling)**: If guidelines updates fail, document issues but attempt to continue if possible.

5.  **Phase 2: Implement System-Wide Changes**:
    *   Log the start of the system-wide implementation phase:
        ```
        edit_file("1000xbrain/system/major-changes/operational_feedback/implementation_log.md", "Log start of system-wide implementation", "...")
        ```
    *   For each system component identified in the plan:
        *   Execute modifications based on the updated guidelines
        *   Update affected components in the specified sequence
        *   Handle dependencies between components
        *   Update the implementation log with details of the changes
    *   **(Error Handling)**: Handle errors for each component independently to prevent cascading failures.

6.  **Perform Integration Verification**:
    *   Verify that guideline changes and system changes work together correctly
    *   Check for consistency across all modified components
    *   Ensure all dependencies are respected
    *   Document any integration issues
    *   **(Error Handling)**: If integration issues are found, document them for the refinement phase.

7.  **Update Implementation Log**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/implementation_log.md`:
        ```markdown
        # Implementation Log

        **Plan Reference**: [implementation plan title]
        **Mode**: [USER_DIRECTED/AUTONOMOUS]
        **Status**: Completed

        ## Execution Summary

        [Summary of the implementation execution]

        ## Task Execution

        ### Phase 1: Guidelines Updates

        1. **[Task 1]**:
           * Completed: [Yes/No/Partial]
           * Files Modified: 
             * [file path 1]
             * [file path 2]
           * Notes: [Any relevant details]

        2. **[Task 2]**:
           * Completed: [Yes/No/Partial]
           * Files Modified:
             * [file path]
           * Notes: [Any relevant details]

        ### Phase 2: System-Wide Implementation

        1. **[Task 1]**:
           * Completed: [Yes/No/Partial]
           * Files Modified: 
             * [file path 1]
             * [file path 2]
           * Notes: [Any relevant details]

        2. **[Task 2]**:
           * Completed: [Yes/No/Partial]
           * Files Modified:
             * [file path]
           * Notes: [Any relevant details]

        ## Issues Encountered

        * [Issue 1]: [Description and resolution if applicable]
        * [Issue 2]: [Description and resolution if applicable]

        ## Overall Status

        [Complete/Partial/Failed] - [Summary of implementation status]
        ```
    *   **(Error Handling)**: If update fails, ensure at least minimal status is logged.

8.  **Update Cycle Status**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`:
        *   Update Status to "Implementation Completed" or "Implementation Partially Completed"
        *   Update Current Phase to indicate implementation is complete
        *   Add reference to the implementation log
    *   **(Error Handling)**: If update fails, log error but proceed.

9.  **Signal Completion**:
    *   Indicate that implementation is complete.
    *   Summarize what was implemented and any notable issues.
    *   Note that the next step is to verify the changes using `run command:system/major-changes/5`.

## Two-Phase Implementation Strategy

The implementation follows a strict two-phase approach to ensure system-wide consistency:

### Phase 1: Guidelines Updates

* Update guidelines in `1000xbrain/system/guidelines/` first
* This establishes the new standards before any other systems are modified
* Guidelines act as the source of truth for system behavior
* This phase must be completed and verified before moving to Phase 2

### Phase 2: System-Wide Implementation

* Implement changes across all affected 1000xsystems based on the updated guidelines
* Follow the dependency order specified in the implementation plan
* Ensure all systems remain compatible with the updated guidelines
* This phase builds on the foundation established in Phase 1

## Implementation Strategies

### Component Modification

When modifying components:

1. **Preserving Structure**:
   * Maintain existing structure where appropriate
   * Follow established patterns
   * Preserve key sections

2. **Incremental Changes**:
   * Make changes incrementally
   * Test after each significant change
   * Document all modifications

3. **Error Prevention**:
   * Back up content before modification if appropriate
   * Validate syntax and structure
   * Ensure consistency with guidelines

## Special Considerations

1. **Backward Compatibility**:
   * Ensure changes maintain backward compatibility where possible
   * Document any breaking changes and migration paths
   * Consider transition periods for major changes

2. **Documentation Updates**:
   * Update documentation to reflect the changes
   * Ensure consistency between guidelines and implementation
   * Document any deviations from the original plan 