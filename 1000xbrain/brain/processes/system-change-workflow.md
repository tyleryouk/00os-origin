# System Change Workflow

## Overview

This process defines the standard workflow for implementing changes that potentially impact multiple 1000x systems (`1000xbrain`, `1000xcommands`, `1000xplans`, `1000xrules`). It leverages the planning system (`1000xplans`) and dedicated commands (`1000xcommands`) for structured execution.

## Philosophy Reference

Adheres to the principles outlined in `1000xbrain/brain/knowledge/system-change-philosophy.md`.

## Workflow Steps

1.  **Requirement Input**: Tyler Youk provides high-level requirements for the system change (typically updating `1000xplans/brain/requirements.md` or providing context via `1000xplans/brain/notes.md`).
2.  **Planning Initiation**: 
    *   This step is largely merged into the `finalize-change` command's reset logic for the *brain* domain. Planning starts by editing the existing `1000xplans/brain/plan.md`.
    *   For *other* domains, the `run command:plans/initiate-plan` might still be used with a path.
3.  **Detailed Planning (Human/AI)**: 
    *   Tyler/1000xdev populate the `1000xplans/brain/` directory, primarily `plan.md` and potentially `requirements.md` or `notes.md`.
    *   The plan identifies affected files and required changes/scripts.

4.  **Implementation (AI - Using `run command:brain/execute-plan`)**:
    *   1000xdev executes the steps defined in `1000xplans/brain/plan.md` using the `run command:brain/execute-plan` command.
    *   **Note:** Placeholder - Requires Scripting.
    *   The command reads the fixed brain plan, executes actions, logs progress in `implementation-progress.md`, and conceptually tracks progress.

5.  **Verification (AI/Human)**:
    *   1000xdev performs automated checks.
    *   Tyler Youk performs final validation.

6.  **Change Finalization & Reset (AI - Using `run command:brain/finalize-change`)**:
    *   1000xdev runs `run command:brain/finalize-change`.
    *   **Note:** Placeholder - Requires Scripting.
    *   The command performs final verification and resets the planning files in `1000xplans/brain/` for the next cycle (invoking logic from `1000xbrain/brain/processes/new-planning-cycle-initiation.md`). Archiving is handled by Git.

7.  **Synchronization (Automated)**: System scripts (`1000xscripts`) handle `1000xrules` -> `.cursor/rules` sync.

## Key Commands Involved (Brain Domain Focus)

*   `run command:brain/execute-plan` (Placeholder - Requires Scripting)
*   `run command:brain/finalize-change` (Placeholder - Requires Scripting)
*   (`run command:plans/initiate-plan` is now primarily for resetting the brain plan, invoked by `finalize-change`)

## Key Commands Involved

*   `run command:plans/initiate-plan`
*   `run command:brain/execute-plan {plan_path}` (Placeholder - Requires Scripting)
*   `run command:brain/finalize-change {plan_path}` (Placeholder - Requires Scripting) 