# Process: Implement Changes

# Defines the steps for implementing the planned changes for the explicit change request.

## Goal: Execute the implementation plan to fulfill the explicit change request.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`.
    *   Verify that planning has been completed.
    *   **(Error Handling)**: If planning is not complete, log error and suggest creating a plan.

2.  **Load Implementation Plan**:
    *   Use `read_file` to read `1000xbrain/system/major-changes/operational_feedback/implementation_plan.md`.
    *   **(Error Handling)**: If plan doesn't exist, log error and stop.
    *   Parse the tasks and phases defined in the plan.

3.  **Execute Implementation Tasks**:
    *   For each task/phase in the plan:
        *   Perform the necessary file operations:
            *   Use `read_file` for analysis
            *   Use `edit_file` for modifications
            *   Use `delete_file` if needed
            *   Use `codebase_search`/`grep_search` to locate relevant code
        *   Handle dependencies and sequencing as specified in the plan
        *   Apply appropriate error handling for each operation
        *   Document progress and issues encountered

4.  **Create Implementation Log**:
    *   Use `edit_file` to create/update `1000xbrain/system/major-changes/operational_feedback/implementation_log.md`:
        ```
        # Implementation Log
        
        **Date**: [current-date]
        **Plan Reference**: [implementation plan title]
        
        ## Executed Tasks
        
        ### Phase 1
        
        1. **[Task 1]**:
           * Completed: [Yes/No]
           * Files Modified: 
             * [file path 1]
             * [file path 2]
           * Notes: [Any relevant details]
        
        2. **[Task 2]**:
           * Completed: [Yes/No]
           * Files Modified:
             * [file path]
           * Notes: [Any relevant details]
        
        [Additional tasks as executed]
        
        ## Issues Encountered
        
        * [Issue 1]: [Description and resolution if applicable]
        * [Issue 2]: [Description and resolution if applicable]
        
        ## Overall Status
        
        [Summary of implementation status - complete, partial, issues]
        ```

5.  **Update Cycle Log**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`:
        *   Update Status to "Implementation Completed"
        *   Update Current Phase to indicate implementation is complete
        *   Add reference to the implementation log

6.  **Signal Completion**:
    *   Indicate that implementation is complete.
    *   Summarize what was implemented and any notable issues.
    *   Note that the next step is to verify the changes using `run command:system/major-changes/5`. 