# Process: Create Core Rule

## Overview

This process handles the creation of a new core rule file within `1000xrules/core/` or its subdirectories.

## Input Context

*   **Parameter `rule_path`**: The desired relative path for the new rule within `1000xrules/` (e.g., `core/communication/new-comm-rule`). Should not include the `.md` extension.
*   **Parameter `rule_content`**: The initial Markdown content for the rule file.
*   **Knowledge**: `1000xbrain/system/rules/knowledge/rules-architecture.md` (Optional, for context on structure).
*   **Knowledge**: `1000xbrain/system/guidelines/file-structure/markdown-standards.md` (For formatting).

## Steps

1.  **Construct Full Path**: Combine the base path `1000xrules/` with the `rule_path` parameter and append `.md` to get the full target file path.
2.  **Verify Path**: Check if the path structure makes sense according to rule organization principles (using knowledge context if provided).
3.  **Check Existence (Optional but Recommended)**:
    *   Use `read_file` with the constructed path. 
    *   If the file already exists, report an error or potentially transition to an update process (TBD - requires more sophisticated error handling/branching logic).
4.  **Validate Content (Basic)**:
    *   Ensure `rule_content` is not empty.
    *   Check for basic Markdown validity (e.g., starts with a header).
    *   Ensure no forbidden frontmatter is included (as per `file-editing-safety.md`).
5.  **Create File**: 
    *   Use `edit_file` with the full target path.
    *   Provide the `rule_content` as the `code_edit`.
    *   Set `instructions` to clearly state the intent (e.g., "I will create a new rule file at [path] with the provided content.").
6.  **Verify Creation**: 
    *   Use `read_file` on the target path.
    *   Compare the returned content with the provided `rule_content` to ensure the file was created correctly.
7.  **Log Success**: Report successful creation (e.g., update `implementation-progress.md` or internal logs - TBD).
8.  **Consider Next Steps**: 
    *   Remind user that sync script (`Sync-CursorRules.ps1`) needs to run to generate the corresponding `.mdc` file.
    *   Suggest updating any relevant index or documentation if applicable.
    *   **Invoke Holistic Verification**: Conceptually trigger `holistic-update-verification.md` with `changed_file_path` = [constructed full path].

## Error Handling

*   Report errors clearly if path is invalid, file exists, content is invalid, or `edit_file`/`read_file` fails.

*(Placeholder: Needs refinement, especially around existence checks and error handling.)* 