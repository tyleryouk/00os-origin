# Process: Autonomous Verification

# Defines the initial steps for the verify-enhancements command.

## Goal: Verify changes made during the implementation phase.

## Steps:

1.  **Read Implementation Log**:
    *   Use `read_file` to read `1000xbrain/system/autonomous/operational_feedback/implementation_log.md`.
    *   Parse the log to identify which files/subsystems were created, modified, or deleted.

2.  **Consult Verification Knowledge**:
    *   Read `1000xbrain/system/autonomous/knowledge/verification-checks.md`.

3.  **Perform Checks (Based on Log & Knowledge)**:
    *   **Initialize Status**: Assume SUCCESS initially. Log file for results: `1000xbrain/system/autonomous/operational_feedback/verification_log.md` (overwrite).
    *   **File Existence Check**: For each created/modified file in the log, use `read_file` (`should_read_entire_file=true`). If `read_file` fails for a specific file, log the error, set status to FAILED, and potentially skip further checks for that file.
    *   **Basic Markdown Structure Check**: For modified `.md` files, perform a simple structural validation (e.g., check if the read content appears grossly malformed). Log errors and set status to FAILED if issues are found. (Detailed parsing deferred).
    *   **(Deferred) Rules Sync Check**: If `1000xrules` modified, log that `.\\Sync-All.bat` check is pending manual execution or future automation.
    *   **(Deferred) Commands List Check**: If `1000xcommands` modified, log that `.\\list.ps1` check is pending manual execution or future automation.
    *   **(Future Enhancement)**: Implement Internal Consistency checks and other checks from the knowledge file.

4.  **Log Verification Results**:
    *   Write a summary of checks performed (including deferred ones) and the final status (SUCCESS/FAILED) to the log file.
    *   Include specific error details if status is FAILED.

5.  **Determine Next Step**: 
    *   If status is SUCCESS, signal readiness for `complete-cycle`.
    *   If status is FAILED, signal readiness for `refine-enhancements`. 