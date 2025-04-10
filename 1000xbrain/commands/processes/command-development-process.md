# Command Development Process

## Overview
This document outlines the standard process flow for developing 1000xcommands, typically initiated after a planning phase (`plan-start` or equivalent) and often triggered by a `dev-start` command for the relevant domain.

## Process Steps

1.  **Initiation (`dev-start` Command):**
    *   Verify Planning Artifacts: List and read files in the corresponding `1000xplans/<domain>/` directory (`implementation-plan.md`, `README.md`, etc.).
    *   Load Context: Read relevant support files from `1000xbrain/<domain>/` (knowledge, processes) and `1000xbrain/commands/` (general command structure, knowledge).

2.  **Implementation (AI Execution following `dev-start`):**
    *   Consult `1000xplans/<domain>/implementation-plan.md` for specific tasks.
    *   Use `1000xcommands/commands/create-command.md` logic (i.e., construct and execute `edit_file`) to create new command definition files in `1000xcommands/<domain>/`.
    *   Use `1000xcommands/commands/update-command.md` logic (i.e., construct and execute `read_file` then `edit_file`) to modify existing command definitions in `1000xcommands/<domain>/`.
    *   Use `1000xcommands/commands/delete-command.md` logic (i.e., construct and execute `delete_file`) to remove command definitions from `1000xcommands/<domain>/`.
    *   Update support files in `1000xbrain/<domain>/` (knowledge, processes) or `1000xbrain/commands/` as required by the plan.
    *   Update `1000xplans/<domain>/implementation-progress.md` as tasks are completed.

3.  **Verification:**
    *   Review created/modified command files (`1000xcommands/<domain>/...`) for correctness and adherence to the plan.
    *   Review updated support files (`1000xbrain/...`) for accuracy.
    *   Mentally simulate or (if feasible) test the new/updated commands.

4.  **Completion:**
    *   Update `1000xplans/<domain>/implementation-progress.md` to reflect completion.
    *   Consider using `run command:plans/plan-finalize` (once created) or similar.

## Goal

To provide a structured workflow for implementing new or modified 1000xcommands based on a defined plan, ensuring consistency and leveraging the newly created CRUD command logic.

## Related Commands

*   `run command:commands/plan-start` (or domain equivalent): Prepares the planning artifacts.
*   `run command:commands/dev-start` (or domain equivalent): Initiates the development phase by loading context.
*   `run command:commands/create-command` (Logic used by AI)
*   `run command:commands/update-command` (Logic used by AI)
*   `run command:commands/delete-command` (Logic used by AI)
*   *(Future)* `run command:commands/dev-continue`: Could manage ongoing development context. 