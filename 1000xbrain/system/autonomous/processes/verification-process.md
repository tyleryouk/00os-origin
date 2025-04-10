# Process: Autonomous Verification

# Defines the verification steps for the verify-enhancements command.

## Goal: Verify the changes made during implementation phase.

## Knowledge References:
* `1000xbrain/system/autonomous/knowledge/verification-checks.md` - Specific checks to run
* `1000xbrain/system/autonomous/knowledge/verification-principles.md` - Core verification principles

## Steps:

1.  **Check and Initialize Feedback Files**:
    *   Check if `1000xbrain/system/autonomous/operational_feedback/cycle_log.md` exists.
    *   If it doesn't exist, create it with basic cycle log structure.
    *   Check if `1000xbrain/system/autonomous/operational_feedback/current_state.md` exists.
    *   If it doesn't exist, create it with current state structure.
    *   **(Error Handling)**: Create any missing operational feedback directories as needed.

2.  **Read Implementation Log**:
    *   Use `read_file` to read `1000xbrain/system/autonomous/operational_feedback/implementation_log.md`.
    *   Parse log to identify which files were modified/created/deleted.
    *   **(Error Handling)**: If log doesn't exist or is empty, log error and check plan.md directly.

3.  **Verify Plan Execution (File Existence)**:
    *   For each file reported as modified/created in the implementation log:
        *   Use `read_file` to confirm it exists and has expected structure.
        *   Apply principles from verification-principles.md for appropriate depth of verification.
    *   For each file reported as deleted, verify it no longer exists.
    *   Store results for each check.

4.  **Verify Content Standards**:
    *   For modified `.md` files:
        *   Check basic Markdown structure (headers, formatting).
        *   For commands, verify dynamic execution patterns if required.
        *   For knowledge files, verify appropriate content sections.
        *   For process files, verify steps are properly defined.
    *   Apply principles from verification-principles.md for content verification standards.

5.  **System Integration Checks**:
    *   Verify references between files are valid.
    *   Check implementation updates mentioned in implementation-progress.md exist.
    *   Follow verification-principles.md guidelines for system integration verification.

6.  **Generate Verification Report**:
    *   **Create** (not update) `1000xbrain/system/autonomous/operational_feedback/verification_results.md`.
    *   Document all checks performed and their results.
    *   Categorize any issues found by severity.
    *   Provide an overall pass/fail assessment.
    *   **(Error Handling)**: Ensure creation instead of assuming update to prevent errors.

7.  **Update Progress Tracker**:
    *   Use `read_file` to read `1000xplans/system/implementation-progress.md` first.
    *   Then use `edit_file` to update the progress tracker.
    *   Mark verification phase as completed.
    *   Add specific verification steps completed.

8.  **Update Cycle Log and State**:
    *   Use `read_file` to read `1000xbrain/system/autonomous/operational_feedback/cycle_log.md` first.
    *   Then use `edit_file` to update the cycle log with verification completion.
    *   Use `read_file` to read `1000xbrain/system/autonomous/operational_feedback/current_state.md` first.
    *   Then use `edit_file` to update the current state to reflect completed verification.
    *   **(Error Handling)**: If either file doesn't exist, create it with appropriate structure.

9.  **Determine Next Steps**:
    *   If verification passed with no issues:
        *   Signal completion of enhancement cycle.
        *   Recommend executing `run command:system/autonomous/7`.
    *   If verification found minor issues:
        *   Recommend refinement phase.
        *   Recommend executing `run command:system/autonomous/6`.
    *   If verification found critical issues:
        *   Flag for manual intervention.
        *   Do not proceed to next phase automatically. 