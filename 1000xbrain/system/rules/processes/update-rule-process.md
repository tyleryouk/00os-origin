# Process: Update Core Rule

## Overview

This process handles updating the content of an existing core rule file within `1000xrules/core/` or its subdirectories.

## Input Context

*   **Parameter `rule_path`**: The relative path of the rule to update within `1000xrules/` (e.g., `core/communication/existing-comm-rule`). Should not include the `.md` extension.
*   **Parameter `update_instructions`**: A clear, concise instruction describing the intended change (e.g., "Add a new section about symbol usage", "Correct typo in overview"). This guides the `edit_file` tool.
*   **Parameter `code_edit_content`**: The specific lines representing the change, following the `edit_file` tool's format (using `// ... existing code ...` for unchanged sections).
*   **Knowledge**: `1000xbrain/system/guidelines/file-structure/markdown-standards.md` (For formatting consistency).
*   **Knowledge**: `1000xbrain/system/guidelines/tool-usage/edit-file-best-practices.md` (For structuring the edit).

## Steps

1.  **Construct Full Path**: Combine the base path `1000xrules/` with the `rule_path` parameter and append `.md` to get the full target file path.
2.  **Read Existing File**: 
    *   Use `read_file` on the full target path (ideally reading the entire file if feasible, or relevant chunks) to ensure the context for the edit is understood and the file exists.
    *   If the file doesn't exist, report an error.
3.  **Validate Edit Content (Basic)**:
    *   Ensure `code_edit_content` is not empty and contains valid `edit_file` syntax.
    *   Ensure `update_instructions` are provided.
4.  **Apply Edit**: 
    *   Use `edit_file` with the full target path.
    *   Provide `code_edit_content` as `code_edit`.
    *   Provide `update_instructions` as `instructions`.
5.  **Verify Edit**: 
    *   Use `read_file` on the target path again (reading the edited section or the whole file).
    *   Compare the result against the intended change described by `update_instructions` and `code_edit_content`.
    *   If the edit failed or was applied incorrectly, consider logging an error or attempting `reapply` (TBD).
6.  **Log Success**: Report successful update (e.g., update `implementation-progress.md` or internal logs - TBD).
7.  **Consider Next Steps**: 
    *   Remind user that sync script (`Sync-CursorRules.ps1`) needs to run to generate the corresponding `.mdc` file.
    *   Suggest updating any relevant index or documentation if applicable.
    *   **Invoke Holistic Verification**: Conceptually trigger `holistic-update-verification.md` with `changed_file_path` = [constructed full path].

## Error Handling

*   Report errors clearly if path is invalid, file doesn't exist, edit content is invalid, or `edit_file`/`read_file`/`reapply` fails.

*(Placeholder: Needs refinement, especially around verification and error handling.)* 