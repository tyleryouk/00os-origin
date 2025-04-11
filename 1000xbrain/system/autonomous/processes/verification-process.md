# Process: Autonomous Verification

## Goal: Verify the changes made during implementation phase against defined criteria.

## Knowledge References:
* `1000xbrain/system/autonomous/knowledge/verification-checks.md` - Specific checks to run
* `1000xbrain/system/autonomous/knowledge/verification-principles.md` - Core verification principles

## Steps:

1.  **Initialize Verification Environment**:
    *   Check if operational feedback directories exist and create if needed.
    *   Verify current state is properly recorded.
    *   **(Error Handling)**: Create any missing operational feedback directories as needed.

2.  **Read Implementation Results**:
    *   Use `read_file` to read implementation log.
    *   Parse to identify modified/created/deleted files.
    *   **(Error Handling)**: If log is incomplete, check other sources for changes.

3.  **Verify File System Changes**:
    *   For each file reported as modified/created:
        *   Confirm it exists with expected structure.
        *   Check basic content validity.
    *   For deleted files, verify removal.
    *   Apply appropriate verification depth based on verification-principles.md.

4.  **Content Quality Checks**:
    *   For modified files:
        *   Verify formatting consistency.
        *   Check structural integrity.
        *   Validate references and dependencies.
    *   Apply verification-principles.md for content standards.

5.  **System Integration Verification**:
    *   Verify internal references between files.
    *   Check operational feedback structure.
    *   Follow verification-principles.md for integration checks.

6.  **Generate Verification Report**:
    *   Create structured verification_results.md in operational_feedback.
    *   Document all checks performed and results.
    *   Categorize issues by severity.
    *   Provide overall pass/fail assessment.
    *   **(Error Handling)**: Always use create mode, never update.

7.  **Update Cycle Status**:
    *   Update cycle log with verification completion.
    *   Update current state to reflect verification status.
    *   **(Error Handling)**: Create files if missing.

8.  **Determine Next Steps**:
    *   If verification passed: Signal completion, recommend cmd:7.
    *   If minor issues found: Recommend refinement, cmd:6.
    *   If critical issues found: Flag for manual intervention. 