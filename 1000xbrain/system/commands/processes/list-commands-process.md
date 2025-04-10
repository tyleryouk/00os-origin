# Process: List Commands

## Overview

This process lists command definition files (`.md`) within the `1000xcommands/` directory, optionally filtering by domain or component path.

## Input Context

*   **Parameter `filter_path` (Optional)**: A relative path within `1000xcommands/` to list (e.g., `system`, `system/rules`, `frontend`). If omitted, lists all commands recursively.

## Steps

1.  **Determine Target Path**: 
    *   If `filter_path` is provided, construct the target path starting with `1000xcommands/`.
    *   If omitted, the target path is `1000xcommands/`.
2.  **Verify Target Path (Basic)**: Ensure the path starts with `1000xcommands/` and uses valid domain/component names if specified.
3.  **List Directory Contents**: 
    *   Use `list_dir` with the target path.
    *   Ideally, configure `list_dir` for recursion if no `filter_path` was given and filter for `.md` files (TBD: Requires checking `list_dir` capabilities or adding post-processing).
4.  **Format Output**: Present the list of found command files clearly, perhaps including their full invocation path (`run command:...`).

## Error Handling

*   Report errors if `filter_path` is invalid or `list_dir` fails.

*(Placeholder: Needs refinement based on `list_dir` capabilities.)* 