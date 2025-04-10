# Standard Command Creation Process

## Overview

This process file outlines the standard steps for creating a new `1000xcommands` definition file.

## Steps

1.  **Define Purpose & Scope**: Clearly articulate what the new command should do.
2.  **Determine Location**: Identify the correct domain (`system`, `frontend`, `backend`) and component subdirectory within `1000xcommands/`.
3.  **Choose Implementation**: Decide between explicit tool calls (for very simple commands) or dynamic execution (preferred for most).
4.  **Design Process (If Dynamic)**: If using dynamic execution, outline the required logic in a corresponding process file within `1000xbrain/<domain>/<component>/processes/`.
    *   Identify necessary knowledge context.
    *   Define required parameters or context files.
    *   Outline logical steps, tool usage, and verification.
5.  **Create Command File (.md)**:
    *   Use the standard naming convention (`verb-noun.md`).
    *   Add optional header.
    *   If dynamic, add the `BEGIN/END DYNAMIC EXECUTION` block, referencing the process file and any knowledge/parameters/context files.
    *   If explicit, add the sequence of tool calls.
6.  **Verify Command Structure**: Ensure the command file adheres to format standards (`1000xbrain/system/commands/knowledge/command-structure.md`).
7.  **Test/Verify Functionality**: (Requires implementation of testing/verification commands or manual testing).
8.  **Update Documentation (If Necessary)**: Consider if related knowledge files or indexes need updating.
9.  **Apply Holistic Verification**: Follow steps in `1000xbrain/system/brain/processes/holistic-update-verification.md`.

*(Placeholder: This process needs further refinement)* 