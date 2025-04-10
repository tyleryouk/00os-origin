# Process: 1000xcommand Verification and Correction (Brain Domain)

## Objective

Define the automated steps for 1000xdev to take after the `generate_brain_command_index.ps1` script has run, focusing on analyzing and attempting to correct commands flagged with `[?]` (Needs Review) or `[!` (Failed Auto-Check) in `1000xplans/brain/commands-index.md`.

## Trigger

This process is initiated within the `run command:brain/verify-brain-commands` command, immediately after the `1000xplans/brain/commands-index.md` file has been updated by the script and read.

## Steps

1.  **Parse Index File:**
    *   Identify all lines in `1000xplans/brain/commands-index.md` marked with `[?]` or `[!`.
    *   Extract the command name (e.g., `finalize-change`) and the associated notes for each flagged command.

2.  **Iterate Through Flagged Commands:**
    *   For each flagged command:
        *   **Read Command File:** Use `read_file` to get the full content of `1000xcommands/brain/<command_name>.md`.
        *   **Analyze `run_terminal_cmd` Calls:** Locate the specific `run_terminal_cmd` call(s) within the file content.
        *   **Cross-Reference Notes:** Compare the command content with the reason(s) it was flagged (from the index file notes).
        *   **Attempt Automated Correction (if applicable):**
            *   **Incorrect Chaining (`&&`):** If flagged for using `&&` instead of `;`, use `edit_file` to replace `&&` with `;` in the `command` parameter of the relevant `run_terminal_cmd` call.
            *   **Missing `| cat`:** If flagged for potentially needing `| cat` (and the command is simple enough to assess), use `edit_file` to append ` | cat` within the `command` parameter string.
            *   **Simple Prohibited Commands:** If a clearly prohibited command is identified (and the fix is trivial, e.g., removing a debug `echo` that was accidentally left in), use `edit_file` to remove it. *Use caution here; complex fixes require manual review.*
            *   *(Self-Correction Note: Always re-read the file section after an edit to confirm the change was applied correctly.)*
        *   **Log Complex Issues:**
            *   If the reason for the `[?]` or `[!` flag is complex (e.g., potentially risky pattern requiring context, complex logic, failed regex match in script), or if an automated fix is too risky:
            *   **Action:** Append a note to the current `1000xplans/brain/implementation-progress.md` detailing the command name, the issue, and recommending manual review by Tyler.
        *   **Update Internal Status:** Maintain an internal representation of which flagged commands were attempted/fixed/logged.

3.  **Report Summary:**
    *   After iterating through all flagged commands, provide a summary (e.g., as the final output message of the `verify-brain-commands` execution, or by updating `1000xplans/brain/implementation-progress.md`) indicating:
        *   How many commands were checked.
        *   How many were flagged (`[?]/[!`).
        *   How many automated correction attempts were made.
        *   How many require manual review (and where they are logged).

## Related Files

*   `1000xplans/brain/commands-index.md` (Input/Output of script, Input to this process)
*   `1000xscripts/brain/generate_brain_command_index.ps1` (Generates the index)
*   `1000xcommands/brain/verify-brain-commands.md` (Invokes the script and this process)
*   `1000xplans/brain/implementation-progress.md` (Logging target)
*   `1000xplans/brain/plan.md` (Current plan context) 