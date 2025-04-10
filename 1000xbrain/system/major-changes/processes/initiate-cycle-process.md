# Process: Initiate Explicit Change Cycle

# Defines the steps for initiating a new explicit change cycle in the major-changes workflow.

## Goal: Initialize a new cycle for implementing explicit changes requested by Tyler Youk.

## Steps:

1.  **Check Operational Feedback Directory**:
    *   Use `list_dir` to check `1000xbrain/system/major-changes/operational_feedback/`.
    *   **(Error Handling)**: If directory doesn't exist, create it using terminal command.

2.  **Create/Update User Request Template in Notes**:
    *   Use `read_file` to read the current `1000xplans/system/notes.md`.
    *   Extract and preserve the Tyler Youk section (between `## Tyler Youk` and `## end`).
    *   Use `edit_file` to update notes.md with a structured format that includes:
        *   The preserved Tyler Youk section
        *   A new USER REQUEST SECTION template for the user to fill out
        *   The 1000XDEV NOTES section with implementation details
    *   The template should clearly instruct the user to:
        *   Fill out the request details
        *   Run `run command:system/major-changes/2` after completing the template

3.  **Create or Update Cycle Log**:
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
        
        *Waiting for user to fill out request in 1000xplans/system/notes.md*
        
        ## Current Phase
        
        Initiation completed. Template created in notes.md. Waiting for user to fill out request and run command 2.
        ```

4.  **Create Empty Change Request Document**:
    *   Create `1000xbrain/system/major-changes/operational_feedback/change_request.md`
    *   Use `edit_file` to initialize with structure:
        ```
        # Change Request Details
        
        **Date Requested**: [current-date]
        **Requestor**: Tyler Youk
        **Status**: Awaiting User Input
        
        ## Request Description
        
        *Waiting for user to fill out request in 1000xplans/system/notes.md*
        
        ## Requirements
        
        *Waiting for user to fill out request in 1000xplans/system/notes.md*
        
        ## Scope
        
        *To be determined after user provides request details*
        
        ## Success Criteria
        
        *To be determined after user provides request details*
        ```

5.  **Signal Completion**:
    *   Indicate that the cycle has been successfully initiated.
    *   Clearly instruct the user to:
        *   Fill out the USER REQUEST SECTION in `1000xplans/system/notes.md`
        *   Run `run command:system/major-changes/2` after completing the request details. 