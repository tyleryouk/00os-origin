# Process: Autonomous Verification

# Defines the verification steps for the verify-enhancements command.

## Goal: Verify the changes made during implementation phase.

## Knowledge References:
* `1000xbrain/system/autonomous/knowledge/verification-checks.md` - Specific checks to run
* `1000xbrain/system/autonomous/knowledge/verification-principles.md` - Core verification principles

## Steps:

1.  **Read Implementation Log**:
    *   Use `read_file` to read `1000xbrain/system/autonomous/operational_feedback/implementation_log.md`.
    *   Parse log to identify which files were modified/created/deleted.
    *   **(Error Handling)**: If log doesn't exist or is empty, log error and check plan.md directly.

2.  **Verify Plan Execution (File Existence)**:
    *   For each file reported as modified/created in the implementation log:
        *   Use `read_file` to confirm it exists and has expected structure.
        *   Apply principles from verification-principles.md for appropriate depth of verification.
    *   For each file reported as deleted, verify it no longer exists.
    *   Store results for each check.

3.  **Verify Content Standards**:
    *   For modified `.md` files:
        *   Check basic Markdown structure (headers, formatting).
        *   For commands, verify dynamic execution patterns if required.
        *   For knowledge files, verify appropriate content sections.
        *   For process files, verify steps are properly defined.
    *   Apply principles from verification-principles.md for content verification standards.

4.  **System Integration Checks**:
    *   Verify references between files are valid.
    *   Check implementation updates mentioned in implementation-progress.md exist.
    *   Follow verification-principles.md guidelines for system integration verification.

5.  **Generate Verification Report**:
    *   Create or update `1000xbrain/system/autonomous/operational_feedback/verification_results.md`.
    *   Document all checks performed and their results.
    *   Categorize any issues found by severity.
    *   Provide an overall pass/fail assessment.

6.  **Update Progress Tracker**:
    *   Use `edit_file` to update `1000xplans/system/implementation-progress.md`.
    *   Mark verification phase as completed.
    *   Add specific verification steps completed.

7.  **Determine Next Steps**:
    *   If verification passed with no issues:
        *   Signal completion of enhancement cycle.
        *   Recommend executing `run command:system/autonomous/7`.
    *   If verification found minor issues:
        *   Recommend refinement phase.
        *   Recommend executing `run command:system/autonomous/6`.
    *   If verification found critical issues:
        *   Flag for manual intervention.
        *   Do not proceed to next phase automatically. 