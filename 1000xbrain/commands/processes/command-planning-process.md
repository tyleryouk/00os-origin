# Command Planning Process

## Overview
This document outlines the standard process flow executed by the `run command:commands/plan-start` command. It ensures a consistent approach to initiating the planning phase for 1000xcommands within the `commands` domain.

## Process Steps (Executed by `plan-start`)

1.  **Read Context Files:**
    *   Read `1000xbrain/commands/commands-structure.md` to understand the current command landscape.
    *   Read `1000xbrain/commands/processes/command-planning-process.md` (this file) for process reference.
    *   Read `1000xbrain/commands/knowledge/command-planning-knowledge.md` for relevant planning concepts.
    *   Read `1000xplans/commands/requirements.md` to understand the user's specific goals for the command being planned.

2.  **Verify Planning Directory State:**
    *   List contents of `1000xplans/commands/` to ensure the expected planning artifacts (`requirements.md`, potentially existing plan/progress files) are present.

3.  **Initialize/Update Planning Artifacts:**
    *   Create or update `1000xplans/commands/implementation-plan.md` with the detailed steps derived from the requirements.
    *   Create or update `1000xplans/commands/implementation-progress.md` to reflect the start of the planning/implementation.
    *   Create or update `1000xplans/commands/README.md` to provide context for the planning directory.

## Goal

To establish a clean and well-defined starting point in the `1000xplans/commands/` directory, ready for the development phase initiated by `run command:commands/dev-start`.

## Related Commands

*   `run command:commands/dev-start`: Initiates the development phase based on the plan created here. 