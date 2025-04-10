# Process: Autonomous Planning

# Defines the initial steps for the plan-enhancements command.

## Goal: Generate an implementation plan based on research findings and overwrite planning files.

## Steps:

1.  **Read Research Findings**:
    *   Use `read_file` to read the content of `1000xbrain/system/autonomous/operational_feedback/research_findings.md`.
    *   **(Error Handling)**: If the file is empty or doesn't exist, log a message and potentially stop the cycle or proceed to implementation with an empty plan (TBD: Initial version assumes findings exist).

2.  **Parse Findings**:
    *   Assume findings are a simple Markdown list (e.g., `- File Path: [path], Reason: [reason]`).
    *   Extract the file path and reason for each finding.

3.  **Generate Implementation Steps (Initial Logic)**:
    *   Iterate through parsed findings.
    *   **Focus on Placeholders/Small Files**: If the reason is "Placeholder/Small File", create a plan step:
        *   `Action`: Review/Delete Placeholder
        *   `Target`: [file path]
        *   `Justification`: Identified as potential placeholder/empty file during research.
    *   **(Future Enhancement)**: Add logic to handle other finding types (e.g., redundancy requires more complex planning).
    *   Compile these steps into a structured list for the new `plan.md`.

4.  **Construct New Planning File Contents**:
    *   **`plan.md`**: Create content outlining the generated implementation steps (e.g., Phase 1: Address Placeholders).
    *   **`requirements.md`**: Create basic content stating the requirement is to address findings from the latest research cycle.
    *   **`commands-index.md`**: Keep this static for now, referencing the autonomous commands (or potentially update based on plan complexity later).
    *   **`implementation-progress.md`**: Create a new checklist based *only* on the generated steps in the new `plan.md`.
    *   **`notes.md`**: Create content summarizing the source of the plan (research findings file) and the high-level goal (addressing findings).

5.  **Overwrite Planning Files**: 
    *   Execute `edit_file` FIVE times, once for each planning file in `1000xplans/system/`, using the constructed content. Hardcoded paths:
        *   `1000xplans/system/plan.md`
        *   `1000xplans/system/requirements.md`
        *   `1000xplans/system/commands-index.md`
        *   `1000xplans/system/implementation-progress.md`
        *   `1000xplans/system/notes.md`

6.  **Signal Completion**: Indicate that the new plan based on research findings has been generated and planning files are updated, ready for the `implement-enhancements` command. 