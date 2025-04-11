# Process: Implementation

# Defines the steps for implementing the planned changes based on the implementation plan.

## Goal: Execute the implementation plan to fulfill the requirements defined in the current cycle.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`.
    *   Verify that planning has been completed.
    *   **(Error Handling)**: If planning is not complete, log error and suggest creating a plan.

2.  **Load Implementation Plan**:
    *   Use `read_file` to read `1000xbrain/system/cycle-manager/operational_feedback/implementation_plan.md`.
    *   **(Error Handling)**: If plan doesn't exist, log error and stop.
    *   Parse the tasks and phases defined in the plan.
    *   Extract success criteria for verification.

3.  **Initialize Implementation Log**:
    *   Use `edit_file` to create `1000xbrain/system/cycle-manager/operational_feedback/implementation_log.md`:
        ```markdown
        # Implementation Log

        **Date**: [current-date]
        **Plan Reference**: [implementation plan title]
        **Mode**: [USER_DIRECTED/AUTONOMOUS]

        ## Execution Summary

        [Will be populated during implementation]

        ## Task Execution

        [Will be populated during implementation]

        ## Issues Encountered

        [Will be populated during implementation]

        ## Overall Status

        In Progress
        ```
    *   **(Error Handling)**: If file creation fails, retry with simplified format.

4.  **Execute Implementation Phases**:
    *   For each phase in the implementation plan:
        *   Log the start of the phase in the implementation log.
        *   Execute each task in the phase sequentially.
        *   Handle dependencies between tasks.
        *   Log completion of the phase.
    *   **(Error Handling)**: If a phase fails, document issues but attempt to continue with subsequent phases if possible.

5.  **Execute Individual Tasks**:
    *   For each task:
        *   Log the start of the task.
        *   Perform the necessary operations:
            *   Use `read_file` for analysis
            *   Use `edit_file` for modifications
            *   Use `codebase_search`/`grep_search` to locate relevant code
            *   Use other appropriate tools as needed
        *   Document the implementation details.
        *   Log the completion of the task.
    *   **(Error Handling)**: Handle errors for each task independently to prevent cascading failures.

6.  **Create or Modify Components**:
    *   Create or modify files as specified in the implementation plan:
        *   Command files (1.md through 7.md)
        *   Process files
        *   Knowledge files
        *   Operational feedback structure
        *   Other components as needed
    *   **(Error Handling)**: If file creation/modification fails, retry with alternative approaches.

7.  **Test Implementation**:
    *   For each component created or modified:
        *   Verify basic functional integrity
        *   Check for syntax or structural errors
        *   Ensure consistency with requirements
    *   **(Error Handling)**: Document any testing issues for refinement.

8.  **Update Implementation Log**:
    *   Use `edit_file` to update `1000xbrain/system/cycle-manager/operational_feedback/implementation_log.md`:
        ```markdown
        # Implementation Log

        **Date**: [current-date]
        **Plan Reference**: [implementation plan title]
        **Mode**: [USER_DIRECTED/AUTONOMOUS]

        ## Execution Summary

        [Summary of the implementation execution]

        ## Task Execution

        ### Phase 1: [Phase Name]

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

        [Additional tasks and phases as executed]

        ## Issues Encountered

        * [Issue 1]: [Description and resolution if applicable]
        * [Issue 2]: [Description and resolution if applicable]

        ## Overall Status

        [Complete/Partial/Failed] - [Summary of implementation status]
        ```
    *   **(Error Handling)**: If update fails, ensure at least minimal status is logged.

9.  **Update Cycle Status**:
    *   Use `edit_file` to update `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`:
        *   Update Status to "Implementation Completed" or "Implementation Partially Completed"
        *   Update Current Phase to indicate implementation is complete
        *   Add reference to the implementation log
    *   **(Error Handling)**: If update fails, log error but proceed.

10. **Signal Completion**:
    *   Indicate that implementation is complete.
    *   Summarize what was implemented and any notable issues.
    *   Note that the next step is to verify the changes using `run command:system/cycle-manager/5`.

## Implementation Strategies

### Component Creation

When creating new components:

1. **Command Files**:
   * Follow the standard 7-step format
   * Include proper dynamic execution markers
   * Reference appropriate process files
   * Include next step information

2. **Process Files**:
   * Include clear goal statement
   * Define specific steps
   * Include error handling for each step
   * Follow consistent formatting

3. **Knowledge Files**:
   * Organize content logically
   * Include comprehensive information
   * Follow standard knowledge file structure
   * Ensure clarity and accessibility

4. **Operational Feedback**:
   * Create appropriate tracking structures
   * Include templates for consistency
   * Ensure proper status tracking
   * Follow standard formats

### Component Modification

When modifying existing components:

1. **Preserving Structure**:
   * Maintain existing structure
   * Follow established patterns
   * Preserve key sections

2. **Incremental Changes**:
   * Make changes incrementally
   * Test after each significant change
   * Document all modifications

3. **Error Prevention**:
   * Back up files before modification
   * Validate syntax and structure
   * Ensure consistency

## Special Considerations

1. **Performance Optimization**:
   * Implement changes efficiently
   * Minimize unnecessary file operations
   * Use appropriate tools for each task

2. **Error Recovery**:
   * Design implementation to be resilient
   * Handle errors gracefully
   * Document recovery steps

3. **Comprehensive Documentation**:
   * Document all implementation details
   * Track all files modified
   * Note any deviations from the plan

4. **Partial Implementation Handling**:
   * If full implementation isn't possible, complete what can be done
   * Clearly document limitations
   * Prepare for refinement phase 