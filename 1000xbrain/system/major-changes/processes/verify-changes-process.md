# Process: Verify Changes

# Defines the steps for verifying the implemented changes for the explicit change request.

## Goal: Ensure that the implemented changes meet the requirements and success criteria.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`.
    *   Verify that implementation has been completed.
    *   **(Error Handling)**: If implementation is not complete, log error and suggest running implementation.

2.  **Gather Verification Sources**:
    *   Use `read_file` to read:
        *   `1000xbrain/system/major-changes/operational_feedback/change_request.md` (for requirements and success criteria)
        *   `1000xbrain/system/major-changes/operational_feedback/implementation_plan.md` (for planned tasks)
        *   `1000xbrain/system/major-changes/operational_feedback/implementation_log.md` (for executed tasks)
    *   **(Error Handling)**: If any file doesn't exist, log error and request appropriate file creation.

3.  **Verify Each Requirement**:
    *   For each requirement/success criterion in the change request:
        *   Check implementation log to confirm related tasks were completed
        *   Examine the relevant files using `read_file` to verify changes
        *   If appropriate, suggest verification steps for Tyler to perform (e.g., manual testing steps)
        *   Document the verification status (verified/not verified)

4.  **Verify File Integrity**:
    *   For each modified file in the implementation log:
        *   Use `read_file` to check if the file exists and has expected content structure
        *   Verify that no syntax or structure errors were introduced
        *   Document any issues discovered

5.  **Create Verification Report**:
    *   Use `edit_file` to create `1000xbrain/system/major-changes/operational_feedback/verification_report.md`:
        ```
        # Verification Report
        
        **Date**: [current-date]
        **Change Request**: [reference to change request]
        **Implementation Plan**: [reference to implementation plan]
        
        ## Requirements Verification
        
        1. **[Requirement 1]**:
           * Status: [Verified/Not Verified]
           * Evidence: [Description of verification evidence]
           * Notes: [Any relevant details]
        
        2. **[Requirement 2]**:
           * Status: [Verified/Not Verified]
           * Evidence: [Description of verification evidence]
           * Notes: [Any relevant details]
        
        [Additional requirements as verified]
        
        ## File Integrity Verification
        
        * **[File 1]**:
          * Status: [Verified/Issues Found]
          * Notes: [Description of any issues]
        
        * **[File 2]**:
          * Status: [Verified/Issues Found]
          * Notes: [Description of any issues]
        
        [Additional files as verified]
        
        ## Manual Testing Required
        
        * [Test 1]: [Description of manual test for Tyler to perform]
        * [Test 2]: [Description of manual test for Tyler to perform]
        
        ## Overall Verification Status
        
        [PASSED/FAILED]: [Summary of verification results]
        
        ## Issues Requiring Refinement
        
        * [Issue 1]: [Description of issue and potential resolution]
        * [Issue 2]: [Description of issue and potential resolution]
        ```

6.  **Update Cycle Log**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`:
        *   Update Status to "Verification Completed"
        *   Update Current Phase to indicate verification result (Pass/Fail)
        *   Add reference to the verification report

7.  **Signal Completion & Next Steps**:
    *   Indicate that verification is complete.
    *   If issues were found, recommend `run command:system/major-changes/6` (refinement).
    *   If no issues were found, recommend `run command:system/major-changes/7` (completion). 