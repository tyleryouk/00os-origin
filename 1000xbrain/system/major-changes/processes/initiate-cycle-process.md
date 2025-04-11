# Process: Initiate Cycle

# Defines the steps for initiating a new major-changes cycle.

## Goal: Initialize a new cycle for implementing system-wide changes across all 1000xsystems.

## Steps:

1.  **Check Operational Feedback Directory**:
    *   Use `list_dir` to check `1000xbrain/system/major-changes/operational_feedback/`.
    *   **(Error Handling)**: If directory doesn't exist, create it using terminal command.

2.  **Create/Update User Request Template**:
    *   Use `read_file` to check if `1000xplans/system/user_request.md` exists.
    *   If it exists, extract existing USER REQUEST SECTION if present.
    *   Use `edit_file` to update or create `1000xplans/system/user_request.md` with standardized USER REQUEST SECTION:
        ```markdown
        ## USER REQUEST SECTION

        # --- TEMPLATE START ---
        # Instructions:
        # 1. Replace bracketed placeholders with your request details.
        # 2. All directive fields are required - they help automate processing.
        # 3. Run `1000xscripts/system/list-cycles.ps1` in terminal to see all available cycles.

        # Directive: [Enhancement|Fix|Refactor|Analysis]
        # Target Cycle: [domain/cycle-name]
        # Enhancement Name: [Brief descriptive name]
        # Priority: [High|Medium|Low]

        # Enhancement Details
        [Provide a clear description of what needs to be done. Be specific about requirements.]

        # Focus Areas (Optional)
        [Specific files or components that should receive attention]

        # --- DIRECTIVE REFERENCE ---
        # Enhancement: Add new functionality or improve existing features
        # Fix: Correct problems or issues in existing functionality
        # Refactor: Restructure code without changing functionality
        # Analysis: Evaluate component(s) without making changes
        # --- TEMPLATE END ---

        ## END USER REQUEST SECTION
        ```
    *   Preserve other sections of the file if they exist.
    *   **(Error Handling)**: If template creation fails, provide clear error message.

3.  **Create or Update Cycle Log**:
    *   Use `read_file` to check if `1000xbrain/system/major-changes/operational_feedback/current_cycle.md` exists.
    *   If it exists, read it to check the status of any existing cycle.
    *   If it doesn't exist or shows a completed cycle, create a new cycle log.
    *   Use `edit_file` to update with new cycle information:
        ```
        # Current Cycle
        
        **Cycle ID**: MC-[timestamp]
        **Status**: Initialized
        **Operation Mode**: Unspecified
        
        ## Current Phase
        
        Initialization completed. Waiting for requirement analysis.
        
        ## Document References
        
        * User Request: 1000xplans/system/user_request.md
        * Change Request: 1000xbrain/system/major-changes/operational_feedback/change_request.md
        
        ## Next Steps
        
        Fill out the USER REQUEST SECTION in 1000xplans/system/user_request.md and then invoke `run command:system/major-changes/2`
        ```

4.  **Create Empty Change Request Document**:
    *   Create `1000xbrain/system/major-changes/operational_feedback/change_request.md`
    *   Use `edit_file` to initialize with structure:
        ```
        # Change Request Details
        
        **Requestor**: Tyler Youk
        **Status**: Awaiting User Input
        **Directive**: Unspecified
        **Target Cycle**: system/major-changes
        **Enhancement Name**: Unspecified
        **Priority**: Unspecified
        
        ## Request Description
        
        *Waiting for user to fill out request in 1000xplans/system/user_request.md*
        
        ## Requirements
        
        *To be determined after user provides request details*
        
        ## Scope
        
        *To be determined after user provides request details*
        
        ## Success Criteria
        
        *To be determined after user provides request details*
        ```

5.  **Signal Completion**:
    *   Indicate that the cycle has been successfully initiated.
    *   Clearly instruct the user to:
        *   Fill out the USER REQUEST SECTION in `1000xplans/system/user_request.md`
        *   Run `run command:system/major-changes/2` after completing the request details. 