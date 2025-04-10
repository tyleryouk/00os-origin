# Process: List Core Rules

## Overview

This process lists the core rule files (`.md`) within the `1000xrules/` directory, optionally filtering by a subdirectory path.

## Input Context

*   **Parameter `sub_path` (Optional)**: A relative path within `1000xrules/` to list (e.g., `core/communication`). If omitted, lists all rules in `1000xrules/` recursively.

## Steps

1.  **Determine Target Path**: 
    *   If `sub_path` is provided, construct the target path by combining `1000xrules/` and `sub_path`.
    *   If `sub_path` is omitted, the target path is `1000xrules/`.
2.  **Verify Target Path (Basic)**: Ensure the constructed path starts with `1000xrules/`.
3.  **List Directory Contents**: 
    *   Use `list_dir` with the target path.
    *   Ideally, configure `list_dir` to list recursively if no `sub_path` was given and filter for `.md` files (TBD: Requires checking `list_dir` capabilities or adding post-processing).
4.  **Format Output**: Present the list of found rule files clearly.

## Error Handling

*   Report errors if the provided `sub_path` is invalid or `list_dir` fails.

*(Placeholder: Needs refinement based on `list_dir` capabilities for recursion and filtering.)* 