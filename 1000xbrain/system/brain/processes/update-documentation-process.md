# Process: Update System Documentation

## Overview

Handles updating cross-component documentation, primarily the command index, based on the current state of the system.

## Input Context

*   (Optional) Parameters specifying which documentation to update (e.g., `update_command_index=true`).

## Steps

1.  **Update Command Index**: 
    *   Check if the index generation script exists (`1000xscripts/system/generate_brain_command_index.ps1`).
    *   If yes, execute it using `run_terminal_cmd` (`.\list.ps1` from `1000xscripts/`).
    *   Verify the output file (`1000xplans/system/commands-index.md`) was updated (e.g., check timestamp or read content).
    *   If script doesn't exist or fails, report error.
2.  **Update Architecture Diagrams (Conceptual)**:
    *   Analyze current structure (`list_dir` recursively).
    *   Compare to diagrams in knowledge files (e.g., `system-architecture.md`).
    *   Propose/apply updates to diagrams using `edit_file` (requires robust analysis and editing logic).
3.  **Update Other Documentation (Conceptual)**:
    *   Identify other potential documentation files (e.g., READMEs, guideline overviews).
    *   Perform checks/updates as needed.
4.  **Report Summary**: Summarize documentation updates performed.

## Error Handling

*   Report errors during script execution or file updates.

*(Placeholder: Requires refinement, especially diagram updates.)* 