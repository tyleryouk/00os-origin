# Process: Create Process File

## Overview

This process handles the creation of a new process file (`.md`) within the `1000xbrain/` directory structure, under the appropriate domain and component.

## Input Context

*   **Parameter `process_path`**: The desired relative path for the new process file within `1000xbrain/` (e.g., `system/rules/processes/new-rule-verification`). Should not include the `.md` extension.
*   **Parameter `process_content`**: The initial Markdown content for the process file (outlining steps, context, etc.).
*   **Knowledge**: `1000xbrain/system/brain/knowledge/system-architecture.md` (For path validation).
*   **Knowledge**: `1000xbrain/system/guidelines/file-structure/markdown-standards.md` (For content validation).

## Steps

1.  **Construct Full Path**: Combine `1000xbrain/` with `process_path` and append `.md`.
2.  **Verify Path**: 
    *   Check path starts with `1000xbrain/` and a valid domain.
    *   Check path includes `/processes/` as the immediate parent directory.
    *   Check component path makes sense.
3.  **Check Existence (Optional but Recommended)**: Use `read_file`. Report error if exists.
4.  **Validate Content (Basic)**: Ensure content is not empty and has basic Markdown structure (headers, steps).
5.  **Create File**: Use `edit_file` with path, content, and clear instructions.
6.  **Verify Creation**: Use `read_file` to compare result with input content.
7.  **Log Success**: Report successful creation.
8.  **Consider Next Steps**: 
    *   Suggest creating/updating the command file that will use this process.
    *   **Invoke Holistic Verification**: Conceptually trigger `holistic-update-verification.md` with `changed_file_path` = [constructed full path].

## Error Handling

*   Report errors for invalid path, file exists, invalid content, or tool failures.

*(Placeholder: Needs refinement.)* 