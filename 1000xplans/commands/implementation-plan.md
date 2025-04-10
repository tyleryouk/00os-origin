# Implementation Plan: Commands Domain Enhancement & Plan Streamlining

## Goal
Enhance the `commands` domain by creating core command management functionalities (`create`, `update`, `delete`, `list`, `new-1000xplan`) and streamline the planning process itself by creating dedicated planning commands and associated knowledge/process files within the `plans` domain.

## Phase 0: Correct Command Location & Rule Discrepancy

*   [X] **Update Core Rule:** Read `1000xrules/core/communication/1000xcommands-guidelines.md` and modify it to correctly reference `1000xcommands/<domain>/` as the location for command definition `.md` files.
*   [X] **Migrate Existing Commands:**
    *   [X] List files in `1000xbrain/commands/` (and subdirectories) to identify any misplaced command definitions.
    *   [X] For each misplaced command `.md` file found (`dev-start.md`, `plan-start.md`):
        *   Read the file.
        *   Create the equivalent file in the correct location under `1000xcommands/commands/`.
        *   Delete the original file from `1000xbrain/commands/commands/`.
*   [X] **Verify Structure:** List directories in `1000xbrain/commands/` and `1000xcommands/` to confirm migration is complete and no command definitions remain in `1000xbrain/commands/commands/`.

## Phase 1: Enhance Command Domain (`commands`)

1.  **Define Core Command CRUD Operations:**
    *   [ ] Create `1000xcommands/commands/create-command.md`: Command to guide the creation of a new command file in the appropriate `1000xcommands/<domain>/` directory, including initial content structure.
    *   [ ] Create `1000xcommands/commands/update-command.md`: Command to facilitate editing an existing command file in `1000xcommands/<domain>/`.
    *   [ ] Create `1000xcommands/commands/delete-command.md`: Command to safely delete an existing command file from `1000xcommands/<domain>/`.
    *   [ ] Create `1000xcommands/commands/list-commands.md`: Command to list available commands from `1000xcommands/`, potentially filterable by domain.
    *   [ ] Create `1000xcommands/commands/new-1000xplan.md`: Command to automate the analysis of the commands domain (`1000xbrain/commands/`, `1000xcommands/`) and update the planning files (`requirements.md`, `implementation-plan.md`, `implementation-progress.md`, `README.md`) in `1000xplans/commands/`. Tool calls should include:
        *   `list_dir` and `read_file` calls for `1000xbrain/commands/` (structure, knowledge, processes)
        *   `list_dir` calls for all subdirs within `1000xcommands/`
        *   `read_file` calls for all files in `1000xplans/commands/`
        *   `edit_file` calls to update the four planning files based on analysis findings.

2.  **Refine Command Knowledge & Processes (in `1000xbrain/commands/`)**
    *   [ ] Update `1000xbrain/commands/knowledge/command-planning-knowledge.md`: Add guidance related to choosing appropriate domains and naming conventions for new commands in `1000xcommands/`.
    *   [ ] Update `1000xbrain/commands/processes/command-development-process.md`: Incorporate steps for using the new `create/update/delete` commands (which operate on `1000xcommands/`).
    *   [ ] Update `1000xbrain/commands/commands-structure.md`: Ensure it accurately reflects the structure and the new CRUD commands operating on `1000xcommands/`.

## Phase 2: Streamline Planning Process (`plans`)

3.  **Establish `plans` Domain Foundation (in `1000xbrain/plans/`)**
    *   [ ] Create `1000xbrain/plans/knowledge/plan-development-knowledge.md`: Document best practices for creating effective implementation plans.
    *   [ ] Create `1000xbrain/plans/processes/plan-creation-process.md`: Define the standard workflow for generating planning artifacts.
    *   [ ] Create `1000xbrain/plans/processes/plan-execution-process.md`: Outline how plans are tracked and updated.
    *   [ ] Update `1000xbrain/plans/plans-structure.md`: Document the new knowledge/process files.

4.  **Create Core Planning Commands (in `1000xcommands/plans/`)**
    *   [ ] Create `1000xcommands/plans/plan-initiate.md`: Command to initialize a new planning directory.
    *   [ ] Create `1000xcommands/plans/plan-update-progress.md`: Command to assist in updating `implementation-progress.md`.
    *   [ ] Create `1000xcommands/plans/plan-finalize.md`: Command to mark a plan as complete.

5.  **Refine Existing `commands/plan-start` (in `1000xcommands/commands/`)**
    *   [ ] Update `1000xcommands/commands/plan-start.md`: Modify this command to potentially leverage the new `plans/plan-initiate.md` command or incorporate insights from the new planning knowledge/processes.

## Phase 3: Verification

6.  **Verify New Commands and Processes:**
    *   [ ] Review all newly created/updated files in `1000xcommands/` and `1000xbrain/` (specifically `plans/` and `commands/` subdirs).
    *   [ ] Mentally simulate the workflow using the new commands (`create-command`, `plan-initiate`, etc.) to ensure logical flow and integration.
    *   [ ] Update `1000xplans/commands/README.md` to reflect the completed plan corrections and current phase.
    *   [ ] Update `1000xplans/commands/requirements.md` if necessary.

## Future Enhancements
*   Develop `dev-continue` command for the `commands` domain.
*   Create commands for validating command syntax/structure (`validate-command`).
*   Develop more sophisticated planning commands (e.g., estimating effort, dependency analysis).
*   Integrate planning commands with other domain-specific workflows. 