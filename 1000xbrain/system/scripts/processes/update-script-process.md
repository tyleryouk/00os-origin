# Process: Update Script File

## Overview

Handles updating an existing script file within `1000xscripts/`.

## Input Context

*   **Parameter `script_path`**: Relative path within `1000xscripts/`. Must include extension.
*   **Parameter `update_instructions`**: Clear instruction for the change.
*   **Parameter `code_edit_content`**: Specific edit content using `edit_file` format.
*   **Knowledge**: `1000xbrain/system/guidelines/tool-usage/edit-file-best-practices.md`.

## Steps

1.  **Construct Full Path**: Combine `1000xscripts/` with `script_path`.
2.  **Read File**: Use `read_file` for context and existence check. Error if not found.
3.  **Validate Edit**: Check parameters and `code_edit_content` validity.
4.  **Apply Edit**: Use `edit_file`.
5.  **Verify Edit**: Use `read_file`. Consider `reapply`.
6.  **Log Success**: Report update.
7.  **Consider Next Steps**: 
    *   **Invoke Holistic Verification**: Conceptually trigger `holistic-update-verification.md` with `changed_file_path` = [constructed full path].

## Error Handling

*   Report errors for invalid path, file not found, invalid edit, tool failures.

*(Placeholder: Needs refinement.)*
