# New Planning Cycle Initiation Process (Brain Domain)

## Overview

This process describes the automated steps taken after a brain domain change cycle is finalized (triggered by `run command:brain/finalize-change`) to prepare for the next potential planning cycle by resetting the existing planning files in `1000xplans/brain/`.

## Purpose

To minimize friction and maintain momentum by resetting the brain planning files (`1000xplans/brain/`) for the next cycle, relying on Git for history. This process ensures adherence to the standard structure defined in `planning-workflow.md`.

## Trigger

Invoked by the (currently placeholder) `run command:brain/finalize-change` command.

## Process Steps (Automated - Requires Scripting/Enhanced Tools)

The following steps are orchestrated by the `finalize-change` command's implementation (likely via `1000xscripts/`):

1.  **Analyze Completion (Optional):** Review the just-completed plan (`plan.md`), progress log (`implementation-progress.md`), and notes (`notes.md`) to inform the next cycle's requirements.
2.  **Reset Plan:** Overwrite `1000xplans/brain/plan.md` with a standard minimal template. A suggested template:
    ```markdown
    # Plan: Brain Domain - Next Cycle

    ## 1. Goals

    - (Define objectives for the next brain domain cycle based on requirements or analysis)

    ## 2. Implementation Steps

    - (Outline specific steps, commands, and edits)

    ## 3. Verification Plan

    - (Define verification procedures)

    ## Dependencies / Considerations
    - (List any dependencies or important context)
    ```
3.  **Reset Progress Log:** Overwrite `1000xplans/brain/implementation-progress.md` with a clean version using the standard format from `planning-workflow.md`.
    ```markdown
    # Brain Domain - Implementation Progress

    ## Status
    *   Planning

    ## Current Objective / Task
    *   Define initial plan for the next cycle.

    ## Implementation Status Summary
    *   **Pending:** [List initial high-level goals from plan.md]
    *   **In Progress:** 
    *   **Completed:** 

    ## Detailed Log & Decisions
    *   [Timestamp] - Planning cycle initiated.

    ## Blockers
    *   None

    ## Verification Log
    *   None

    ## Next Steps
    *   Develop detailed steps in plan.md.
    ```
4.  **Clear Notes (Optional but Recommended):** Overwrite `1000xplans/brain/notes.md` with an empty state or a simple header `# Notes - Next Cycle` to prevent outdated context from cluttering the new cycle.
5.  **Reset Requirements (Optional):** Clear or reset `1000xplans/brain/requirements.md` if it exists and is no longer relevant.
6.  **Signal Readiness (Internal/Optional)**: Log that the brain planning files have been reset and are ready for the next cycle.

## Key Command Invocation (Internal)

This *process* is not invoked directly. It is the *responsibility* of the `run command:brain/finalize-change` command's implementation (likely a script) to execute these reset steps within the fixed `1000xplans/brain/` directory, ensuring the structure aligns with `planning-workflow.md`. 