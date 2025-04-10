# Process: Update Command File

## Overview

This process handles updating the content of an existing command definition file (`.md`) within the `1000xcommands/` directory structure.

## Input Context

*   **Parameter `command_path`**: The relative path of the command to update within `1000xcommands/` (e.g., `system/rules/existing-rule-cmd`). Should not include the `.md` extension.
*   **Parameter `update_instructions`**: A clear instruction describing the intended change (e.g., "Change the target process file", "Add a knowledge file reference").
*   **Parameter `code_edit_content`**: The specific lines representing the change, following `edit_file` format.
*   **Knowledge**: `1000xbrain/system/commands/knowledge/command-structure.md` (For validation).
*   **Knowledge**: `1000xbrain/system/guidelines/tool-usage/edit-file-best-practices.md`.

## Steps

1.  **Construct Full Path**: Combine `1000xcommands/` with `command_path` and append `.md`.
2.  **Read Existing File**: Use `read_file` on the full path to get context and ensure existence. Report error if not found.
3.  **Validate Edit Content**: Ensure `code_edit_content` and `update_instructions` are provided and valid. Check if edit adheres to command structure knowledge.
4.  **Apply Edit**: Use `edit_file` with path, `code_edit_content`, and `update_instructions`.
5.  **Verify Edit**: Use `read_file` to check the result. Consider `reapply` on failure.
6.  **Log Success**: Report successful update.
7.  **Consider Next Steps**: 
    *   Suggest updating the command index if structure changed significantly.
    *   **Invoke Holistic Verification**: Conceptually trigger `holistic-update-verification.md` with `changed_file_path` = [constructed full path].

## Error Handling

*   Report errors for invalid path, file not found, invalid edit, or tool failures.

*(Placeholder: Needs refinement.)* 