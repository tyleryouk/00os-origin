# Intelligent Planning Continuation Process

## Overview
This process guides the AI during the dynamic execution phase of the `run command:plans/continue-planning-process` command. It identifies the target planning domain from the invocation context, loads the relevant planning files, and uses that context to determine and execute the next logical step in the planning or implementation workflow.

## Process Steps

1.  **Identify Target Domain:**
    *   Analyze the invocation context (the user's `run command:...` message) to extract the target domain (e.g., 'brain', 'frontend', 'backend').
    *   If the domain is missing or ambiguous, halt execution and report the error.

2.  **Load Planning Context:**
    *   Construct the paths to the essential planning files dynamically using the identified domain:
        *   `plan_file = "1000xplans/{domain}/plan.md"`
        *   `requirements_file = "1000xplans/{domain}/requirements.md"`
        *   `notes_file = "1000xplans/{domain}/notes.md"`
        *   `progress_file = "1000xplans/{domain}/implementation-progress.md"`
    *   Execute `read_file` for each of these target files (with `should_read_entire_file=True`). Handle potential file-not-found errors gracefully (e.g., log, proceed if non-critical, halt if critical like `plan.md` or `progress.md` is missing).

3.  **Analyze Current State:**
    *   Use the content loaded from the `{progress_file}`.
    *   Identify the current objective listed under "Current Objective / Task" or "Next Steps".

4.  **Prioritize Actionable Tasks:**
    *   **Check for Enhancement Tasks:** If the current objective indicates implementing enhancements from `{notes_file}` (e.g., findings from command verification), proceed to Step 5.
    *   **Check for Plan Execution Tasks:** If the objective relates to executing steps defined in `{plan_file}`, proceed to Step 6.
    *   **Check for New Planning:** If the current objective is complete or unclear, proceed to Step 7.

5.  **Implement Enhancements from Notes:**
    *   Parse the content loaded from `{notes_file}`, specifically sections like "Command Verification Findings" / "Enhancement Suggestions".
    *   Identify the highest priority, most actionable enhancement suggestions (e.g., removing obsolete prefixes, adding standard comments, fixing simple structural issues).
    *   **Execute:** For each identified enhancement affecting a command file:
        *   Determine the target command file path (e.g., `1000xcommands/{affected_domain}/{command-name}.md`).
        *   Read the target command file.
        *   Apply the necessary correction using `edit_file`.
        *   Verify the change by re-reading the relevant section or the whole file if necessary.
    *   **Update Progress:** After implementing a batch of enhancements, update the `{progress_file}`:
        *   Log the specific changes made under "Detailed Log & Decisions".
        *   Update the "Current Objective / Task".
    *   **End Execution:** Stop the current dynamic execution cycle.

6.  **Execute Plan Steps:**
    *   *(Placeholder: Further definition needed based on `plan.md` structure)*
    *   Analyze `{plan_file}` and `{progress_file}` to identify the next pending step.
    *   Execute the required tool calls or invoke relevant commands/scripts.
    *   Update `{progress_file}`.
    *   End Execution.

7.  **Determine Next High-Level Goal:**
    *   *(Placeholder: Further definition needed based on workflow completion signals)*
    *   Analyze `{plan_file}`, `{requirements_file}`, and `{progress_file}` against overall goals.
    *   Update `{plan_file}` and `{progress_file}` if further planning is needed.
    *   Handle completion state (e.g., link to `finalize-change`).
    *   End Execution.

## Error Handling
*   Log errors to `1000xbrain/brain/operational_feedback/` and the relevant `{progress_file}`.
*   Attempt simple recovery.
*   Halt on unrecoverable errors, indicating the blocker in `{progress_file}`. 