# Process: Update Process File

## Overview

This process handles updating the content of an existing process file (`.md`) within the `1000xbrain/` directory structure.

## Input Context

*   **Parameter `process_path`**: The relative path of the process file to update within `1000xbrain/` (e.g., `system/rules/processes/existing-verification`). Should not include `.md`.
*   **Parameter `update_instructions`**: A clear instruction describing the change.
*   **Parameter `code_edit_content`**: The specific edit content using `edit_file` format.
*   **Knowledge**: `1000xbrain/system/guidelines/file-structure/markdown-standards.md`.
*   **Knowledge**: `1000xbrain/system/guidelines/tool-usage/edit-file-best-practices.md`.

## Steps

1.  **Construct Full Path**: Combine `1000xbrain/` with `process_path` and append `.md`.
2.  **Read Existing File**: Use `read_file` to get context and ensure existence. Report error if not found.
3.  **Validate Edit**: Ensure parameters are provided and `code_edit_content` is valid.
4.  **Apply Edit**: Use `edit_file` with path, content, and instructions.
5.  **Verify Edit**: Use `read_file` to check the result. Consider `reapply`.
6.  **Log Success**: Report successful update.
7.  **Consider Next Steps**: 
    *   **Invoke Holistic Verification**: Conceptually trigger `holistic-update-verification.md` with `changed_file_path` = [constructed full path].

## Error Handling

*   Report errors for invalid path, file not found, invalid edit, or tool failures.

*(Placeholder: Needs refinement.)* 