# Process: Assess Change Request

# Defines the steps for assessing an explicit change request in the major-changes workflow.

## Goal: Analyze the change request to determine scope, requirements, and implementation approach.

## Steps:

1.  **Check Cycle Status**:
    *   Use `read_file` to check `1000xbrain/system/major-changes/operational_feedback/current_cycle.md`.
    *   Verify that a cycle has been initiated and is in the assessment phase.
    *   **(Error Handling)**: If no cycle exists or is in wrong phase, log error and suggest running initiation.

2.  **Engage With Tyler For Change Details**:
    *   Request detailed information about the change from Tyler.
    *   This should include:
        *   Description of the requested change
        *   Requirements and constraints
        *   Priority and timeline
        *   Success criteria
        *   Related components/systems
    *   Actively engage in dialogue to clarify ambiguities.

3.  **Document Change Request**:
    *   Use `edit_file` to update `1000xbrain/system/major-changes/operational_feedback/change_request.md`:
        *   Fill in the Request Description section
        *   Document specific requirements
        *   Define the scope (affected components/files)
        *   Document success criteria
        *   Add any constraints or special considerations

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

6.  **Signal Completion**:
    *   Indicate that assessment is complete.
    *   Summarize key findings from the assessment.
    *   Note that the next step is to create an implementation plan using `run command:system/major-changes/3`. 