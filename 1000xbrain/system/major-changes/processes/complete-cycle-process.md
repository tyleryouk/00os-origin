# Process: Complete Change Cycle

# Defines the steps for completing and finalizing an explicit change cycle.

## Goal: Finalize the change cycle, ensuring proper documentation and closure.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`.
    *   Verify that verification has passed or refinement has been completed successfully.
    *   **(Error Handling)**: If verification hasn't passed or refinement is incomplete, log status and suggest appropriate previous step.

2.  **Gather Cycle Documentation**:
    *   Use `read_file` to collect details from:
        *   Change request document
        *   Implementation plan
        *   Implementation log
        *   Verification report
        *   Refinement log (if applicable)
    *   Extract key information for the final summary.

3.  **Create Cycle Summary**:
    *   Use `edit_file` to create `1000xbrain/system/major-changes/operational_feedback/cycle_summary_[timestamp].md`:
        ```
        # Explicit Change Cycle Summary
        
        **Cycle ID**: [from current_cycle.md]
        **Date Started**: [from current_cycle.md]
        **Date Completed**: [current-date]
        **Status**: Completed
        
        ## Change Request Summary
        
        [Brief summary of the change request]
        
        ## Implementation Summary
        
        * **Phases Completed**: [List of completed phases]
        * **Files Modified**: [Count and key files]
        * **Key Changes**: [Brief summary of main changes]
        
        ## Verification Results
        
        * **Initial Verification**: [Pass/Fail]
        * **Refinement Required**: [Yes/No]
        * **Final Verification**: [Pass/Only if refinement was needed]
        
        ## Documentation References
        
        * Change Request: `1000xbrain/system/major-changes/operational_feedback/change_request.md`
        * Implementation Plan: `1000xbrain/system/major-changes/operational_feedback/implementation_plan.md`
        * Implementation Log: `1000xbrain/system/major-changes/operational_feedback/implementation_log.md`
        * Verification Report: `1000xbrain/system/major-changes/operational_feedback/verification_report.md`
        * Refinement Log: `1000xbrain/system/major-changes/operational_feedback/refinement_log.md` [if applicable]
        
        ## Lessons Learned
        
        * [Insight 1]: [Description of something learned/improved]
        * [Insight 2]: [Description of something learned/improved]
        
        ## Future Considerations
        
        * [Consideration 1]: [Description of potential follow-up work]
        * [Consideration 2]: [Description of potential follow-up work]
        ```

4.  **Update Cycle History**:
    *   Check if `1000xbrain/system/major-changes/operational_feedback/cycle_history.md` exists
    *   If it doesn't exist, create it with initial content.
    *   If it exists, use `read_file` to read it, then use `edit_file` to append the new cycle.
    *   Template:
        ```
        # Major Changes Cycle History
        
        This document tracks the history of completed explicit change cycles.
        
        ## Cycle: [Cycle ID]
        
        * **Date**: [Completion Date]
        * **Summary**: [Brief description]
        * **Status**: Completed
        * **Reference**: [Link to cycle summary]
        
        [Previous cycles...]
        ```

5.  **Update Current Cycle Log**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`:
        *   Update Status to "Completed"
        *   Update Current Phase to "Cycle Finished"
        *   Add reference to the cycle summary document
        *   Add completion date

6.  **Update Command Index (Optional)**:
    *   If a command index file exists (e.g., `1000xplans/system/commands-index.md`), update it to reflect the usage of the major-changes workflow.

7.  **Update Implementation Progress**:
    *   Use `read_file` to check `1000xplans/system/implementation-progress.md`
    *   Use `edit_file` to update relevant sections related to the major-changes workflow.

8.  **Signal Completion**:
    *   Indicate that the change cycle has been successfully completed.
    *   Provide a brief summary of the overall cycle.
    *   Note that a new cycle can be initiated with `run command:system/major-changes/1` if needed. 