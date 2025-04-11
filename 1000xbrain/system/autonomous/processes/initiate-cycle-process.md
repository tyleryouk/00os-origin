# Process: Initiate Autonomous Enhancement Cycle

# Defines the process for initiating a new enhancement cycle

## Goal: Create a new operational state, initialize logs, and prepare for research phase.

## Steps:

1.  **Read Current Progress File**:
    *   Use `read_file` to read `1000xplans/system/implementation-progress.md`.
    *   Check if a cycle is already in progress (look for "Current Cycle Status" section).
    *   **(Error Handling)**: If a cycle is in progress and not completed, log warning but continue.

2.  **Create/Update Cycle Log**:
    *   Create or append to `1000xbrain/system/autonomous/operational_feedback/cycle_log.md`.
    *   Add entry with timestamp, cycle number, and "INITIATED" status.
    *   Use `edit_file` to update the cycle log.

3.  **Initialize USER REQUEST SECTION**:
    *   Create a standardized USER REQUEST SECTION template with the following headers:
        ```markdown
        # USER REQUEST SECTION
        
        ## Request Summary
        
        [Brief description of the requested enhancement or task]
        
        ## Constraints
        
        * [Constraint 1]
        * [Constraint 2]
        
        ## Success Criteria
        
        * [Criterion 1]
        * [Criterion 2]
        
        ## Priority
        
        [High/Medium/Low]
        
        ## Mode
        
        [USER_DIRECTED/AUTONOMOUS]
        ```
    *   Note: This template does not include a Target Cycle header, as it will be determined dynamically.
    *   If operating in USER_DIRECTED mode, preserve any existing USER REQUEST SECTION content.

4.  **Initialize Operational Feedback**:
    *   Create new directory for this cycle's feedback: `1000xbrain/system/autonomous/operational_feedback/cycle_[number]/`.
    *   Create empty files for different phases:
        *   `research_findings.md` - Will contain research results
        *   `implementation_log.md` - Will track implementation changes
        *   `verification_results.md` - Will contain verification outcomes
        *   `refinement_log.md` - Will track any refinements needed

5.  **Update Progress Tracker**:
    *   Use `edit_file` to update `1000xplans/system/implementation-progress.md`.
    *   Mark "Cycle Initiated" as completed.
    *   Add timestamp to "Last Updated" field.
    *   Set status to "Research Phase Pending".

6.  **Prepare System State**:
    *   Create `1000xbrain/system/autonomous/operational_feedback/current_state.md` with:
        *   Current cycle number and timestamp
        *   Current phase: "Research"
        *   Status: "Pending"
        *   Operation Mode: Based on USER REQUEST SECTION (default to "AUTONOMOUS" if not specified)
        *   Next command to execute: `run command:system/autonomous/2`

7.  **Signal Completion and Next Steps**:
    *   Provide summary of initialization actions taken.
    *   Explicitly mention next step: `run command:system/autonomous/2` for research phase. 