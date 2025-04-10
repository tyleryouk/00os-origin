# Process: Initiate Explicit Change Cycle

# Defines the steps for initiating a new explicit change cycle in the major-changes workflow.

## Goal: Initialize a new cycle for implementing explicit changes requested by Tyler Youk.

## Steps:

1.  **Check Operational Feedback Directory**:
    *   Use `list_dir` to check `1000xbrain/system/major-changes/operational_feedback/`.
    *   **(Error Handling)**: If directory doesn't exist, create it using terminal command.

2.  **Create or Update Cycle Log**:
    *   Use `read_file` to check if `1000xbrain/system/major-changes/operational_feedback/current_cycle.md` exists.
    *   If it exists, read it to check the status of any existing cycle.
    *   If it doesn't exist or shows a completed cycle, create a new cycle log.
    *   Use `edit_file` to update with new cycle information:
        ```
        # Current Explicit Change Cycle
        
        **Cycle ID**: [timestamp]
        **Status**: Initiated
        **Date Started**: [current-date]
        **Requested By**: Tyler Youk
        
        ## Change Request
        
        *To be documented in assessment phase*
        
        ## Current Phase
        
        Initiation completed. Ready for assessment.
        ```

3.  **Create Empty Change Request Document**:
    *   Create `1000xbrain/system/major-changes/operational_feedback/change_request.md`
    *   Use `edit_file` to initialize with structure:
        ```
        # Change Request Details
        
        **Date Requested**: [current-date]
        **Requestor**: Tyler Youk
        **Status**: Awaiting Assessment
        
        ## Request Description
        
        *To be filled during assessment phase*
        
        ## Requirements
        
        *To be filled during assessment phase*
        
        ## Scope
        
        *To be filled during assessment phase*
        
        ## Success Criteria
        
        *To be filled during assessment phase*
        ```

4.  **Signal Completion**:
    *   Indicate that the cycle has been successfully initiated.
    *   Note that the next step is to assess the change request using `run command:system/major-changes/2`. 