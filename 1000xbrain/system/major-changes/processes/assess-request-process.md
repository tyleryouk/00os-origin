# Process: Assess Change Request

# Defines the steps for assessing an explicit change request in the major-changes workflow.

## Goal: Analyze the change request to determine scope, requirements, and implementation approach.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`.
    *   Verify that a cycle has been initiated and is awaiting user input.
    *   **(Error Handling)**: If no cycle exists or is in wrong phase, log error and suggest running initiation.

2.  **Read User Request From Notes**:
    *   Use `read_file` to read `1000xplans/system/notes.md`.
    *   Extract the content from the USER REQUEST SECTION.
    *   Parse for:
        *   Change request description
        *   Requirements
        *   Priority information
        *   Additional notes
    *   **(Error Handling)**: If section contains only placeholder text (e.g., "[Your change request description goes here]"), signal an error and provide clear instructions for filling out the request section. Do not proceed with assessment until a valid request is provided.

3.  **Document Change Request**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/change_request.md`:
        *   Fill in the Request Description section based on user's input
        *   Document specific requirements as specified by user
        *   Define the scope (affected components/files) based on analysis
        *   Document success criteria based on user's request
        *   Add any constraints or special considerations from the request

4.  **Analyze Technical Implications**:
    *   Identify affected subsystems, files, and components.
    *   Analyze potential dependencies and impacts.
    *   Determine necessary research or prerequisite tasks.
    *   Use `codebase_search` or `grep_search` to identify relevant code areas if appropriate.

5.  **Update Cycle Log**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`:
        *   Update Status to "Assessment Completed"
        *   Summarize change request in the Change Request section
        *   Update Current Phase to indicate assessment is complete and planning will begin

6.  **Preserve Template in Notes.md**:
    *   Use `read_file` to read the current `1000xplans/system/notes.md`.
    *   Extract and preserve the Tyler Youk section (between `## Tyler Youk` and `## end`).
    *   Extract and preserve the 1000XDEV NOTES section.
    *   Use `edit_file` to update notes.md:
        *   Restore the template with placeholders in the USER REQUEST SECTION
        *   This prepares the file for the next change request

7.  **Signal Completion**:
    *   Indicate that assessment is complete.
    *   Summarize key findings from the assessment.
    *   Note that the next step is to create an implementation plan using `run command:system/major-changes/3`. 