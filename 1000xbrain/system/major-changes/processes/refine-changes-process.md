# Process: Refine Changes

# Defines the steps for refining the implemented changes to address verification issues.

## Goal: Address issues identified during verification to ensure the change request is fully satisfied.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`.
    *   Verify that verification has been completed and identified issues.
    *   **(Error Handling)**: If verification hasn't been completed or no issues were found, log status and suggest appropriate next step.

2.  **Analyze Verification Report**:
    *   Use `read_file` to read `1000xbrain/system/major-changes/operational_feedback/verification_report.md`.
    *   Extract the issues requiring refinement.
    *   Prioritize issues based on severity and dependencies.

3.  **Group Issues by Type**:
    *   Categorize issues (e.g., missing requirements, file integrity issues, logic errors).
    *   Identify common patterns or root causes.
    *   Determine if a comprehensive approach is needed or if spot fixes are sufficient.

4.  **Develop Refinement Plan**:
    *   For each issue or issue group:
        *   Determine appropriate resolution strategy.
        *   Identify specific files and code sections to modify.
        *   Define success criteria for the refinement.

5.  **Implement Refinements**:
    *   For each issue:
        *   Use `read_file` to analyze current state.
        *   Use `edit_file` to implement fixes.
        *   Use other relevant tools as needed.
        *   Document the changes made.

6.  **Create Refinement Log**:
    *   Use `edit_file` to create/update `1000xbrain/system/major-changes/operational_feedback/refinement_log.md`:
        ```
        # Refinement Log
        
        **Date**: [current-date]
        **Verification Report**: [reference to verification report]
        
        ## Addressed Issues
        
        1. **[Issue 1]**:
           * Original Issue: [Description from verification report]
           * Resolution: [Description of fix implemented]
           * Files Modified:
             * [file path 1]
             * [file path 2]
           * Status: [Resolved/Partially Resolved]
        
        2. **[Issue 2]**:
           * Original Issue: [Description from verification report]
           * Resolution: [Description of fix implemented]
           * Files Modified:
             * [file path]
           * Status: [Resolved/Partially Resolved]
        
        [Additional issues as addressed]
        
        ## Remaining Issues
        
        * [Issue X]: [Description of any unresolved issues]
        * [Issue Y]: [Description of any unresolved issues]
        
        ## Overall Refinement Status
        
        [Complete/Partial]: [Summary of refinement results]
        ```

7.  **Update Cycle Log**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`:
        *   Update Status to "Refinement Completed"
        *   Update Current Phase to indicate refinement completion
        *   Add reference to the refinement log

8.  **Determine Next Step**:
    *   If all issues were successfully addressed with minor fixes:
        *   Recommend proceeding directly to `run command:system/major-changes/7` (completion).
    *   If substantial changes were made or some issues remain unresolved:
        *   Recommend re-verification with `run command:system/major-changes/5`.
    *   Signal the appropriate next step based on the refinement outcome. 