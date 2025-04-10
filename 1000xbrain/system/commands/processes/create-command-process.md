# Process: Create Command File

## Overview

This process handles the creation of a new command definition file (`.md`) within the `1000xcommands/` directory structure.

## Input Context

*   **Parameter `command_path`**: The desired relative path for the new command within `1000xcommands/` (e.g., `system/rules/new-rule-command`, `frontend/components/create-button`). Should not include the `.md` extension.
*   **Parameter `command_content`**: The initial Markdown content for the command file, typically including a dynamic execution block or explicit tool calls.
*   **Knowledge**: `1000xbrain/system/commands/knowledge/directory-organization.md` (For path validation).
*   **Knowledge**: `1000xbrain/system/commands/knowledge/command-structure.md` (For content validation).

## Steps

1.  **Construct Full Path**: Combine the base path `1000xcommands/` with the `command_path` parameter and append `.md`.
2.  **Verify Path**: 
    *   Check if the path starts with `1000xcommands/` followed by a valid domain (`system`, `frontend`, `backend`).
    *   Check if the component path (e.g., `/system/rules/`) makes sense according to directory organization principles.
    *   Check if the command name follows `verb-noun.md` convention.
3.  **Check Existence (Optional but Recommended)**:
    *   Use `read_file` with the constructed path.
    *   If the file already exists, report an error.
4.  **Validate Content (Basic)**:
    *   Ensure `command_content` is not empty.
    *   Check for adherence to command structure (e.g., valid dynamic execution block syntax if present, valid tool call format).
5.  **Create File**: 
    *   Use `edit_file` with the full target path.
    *   Provide the `command_content` as `code_edit`.
    *   Set `instructions` clearly (e.g., "I will create a new command file at [path]...").
6.  **Verify Creation**: 
    *   Use `read_file` on the target path.
    *   Compare the returned content with the provided `command_content`.
7.  **Log Success**: Report successful creation.
8.  **Consider Next Steps**: 
    *   Suggest updating the command index (requires running the script `1000xscripts/system/generate_brain_command_index.ps1`).
    *   **Invoke Holistic Verification**: Conceptually trigger `holistic-update-verification.md` with `changed_file_path` = [constructed full path].

## Error Handling

*   Report errors clearly if path is invalid, file exists, content is invalid, or `edit_file`/`read_file` fails.

*(Placeholder: Needs refinement.)* 