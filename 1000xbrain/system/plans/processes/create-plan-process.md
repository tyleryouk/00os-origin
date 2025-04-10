# Process: Create Plan File

## Overview

Handles the creation of a new planning file (e.g., `plan.md`, `requirements.md`) within the appropriate domain directory in `1000xplans/`.

## Input Context

*   **Parameter `plan_file_path`**: The desired relative path within `1000xplans/` (e.g., `system/new-feature-plan.md`, `frontend/requirements.md`). Must include the `.md` extension and target a valid domain (`system`, `frontend`, `backend`).
*   **Parameter `plan_content`**: The initial Markdown content for the planning file.
*   **Knowledge**: `1000xbrain/system/guidelines/file-structure/markdown-standards.md`.

## Steps

1.  **Construct Full Path**: Combine `1000xplans/` with `plan_file_path`.
2.  **Verify Path**: 
    *   Check path starts with `1000xplans/` and a valid domain.
    *   Check file ends with `.md`.
3.  **Check Existence (Optional)**: Use `read_file`. Report error if exists.
4.  **Validate Content**: Basic check for non-empty content and Markdown structure.
5.  **Create File**: Use `edit_file` with path, content, and instructions.
6.  **Verify Creation**: Use `read_file` to compare result.
7.  **Log Success**: Report successful creation.
8.  **Consider Next Steps**: 
    *   **Invoke Holistic Verification**: Conceptually trigger `holistic-update-verification.md` with `changed_file_path` = [constructed full path].

## Error Handling

*   Report errors for invalid path, file exists, invalid content, tool failures.

*(Placeholder: Needs refinement.)* 