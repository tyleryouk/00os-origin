# Process: Application Domain Setup Verification

## Purpose

This process outlines the steps for verifying that the standard directory structure and template files exist for a specified application domain (`frontend` or `backend`) across `1000xbrain`, `1000xcommands`, `1000xplans`, and `1000xscripts`.

## Trigger

Invoked via `run command:system/brain/verify-app-domain-setup domain=<frontend|backend>`.

## Inputs

*   `domain`: The target application domain (`frontend` or `backend`).

## Steps

1.  **Parse & Validate Input**: Extract the `domain` argument. Verify it is either `frontend` or `backend`.
2.  **Read Requirements**: Read the template definitions from `1000xplans/system/requirements.md` using `read_file`.
3.  **Identify Expected Templates**: Filter the requirements to get the list of expected files and directories specific to the provided `domain`.
4.  **Verify Existence**: Iterate through the expected template list.
    *   For each item, construct the full target path.
    *   Use `list_dir` on the parent directory and check if the file/subdirectory exists. Alternatively, use `read_file` with a small range (e.g., lines 1-1) and check for a file-not-found error vs successful read (indicating existence).
    *   Record whether each expected item is present or missing.
5.  **Compile Findings**: Create a summary report listing all expected items and their verification status (Present/Missing).
6.  **Log Results**: Record the detailed findings and the summary report in `1000xbrain/system/brain/operational_feedback/app-domain-verification.log`. Optionally, append the summary to `1000xplans/system/notes.md`.
7.  **Update Progress**: Update `1000xplans/system/implementation-progress.md` indicating the completion status of the verification for the specified `domain`.

## Outputs

*   Verification report detailing the presence/absence of standard files/directories.
*   Log file updated.
*   Progress tracker updated (optional: notes file updated). 