# Process: Create Knowledge File

## Overview

This process handles the creation of a new knowledge file (`.md`) within the `1000xbrain/` directory structure, under the appropriate domain and component.

## Input Context

*   **Parameter `knowledge_path`**: The desired relative path for the new knowledge file within `1000xbrain/` (e.g., `system/rules/knowledge/new-rule-concepts`, `frontend/authentication/knowledge/auth-patterns`). Should not include the `.md` extension.
*   **Parameter `knowledge_content`**: The initial Markdown content for the knowledge file.
*   **Knowledge**: `1000xbrain/system/brain/knowledge/system-architecture.md` (For path validation).
*   **Knowledge**: `1000xbrain/system/guidelines/file-structure/markdown-standards.md` (For content validation).

## Steps

1.  **Construct Full Path**: Combine the base path `1000xbrain/` with the `knowledge_path` parameter and append `.md`.
2.  **Verify Path**: 
    *   Check if the path starts with `1000xbrain/` followed by a valid domain (`system`, `frontend`, `backend`).
    *   Check if the path includes `/knowledge/` as the immediate parent directory of the file.
    *   Check if the component path (e.g., `/system/rules/`) makes sense.
3.  **Check Existence (Optional but Recommended)**:
    *   Use `read_file` with the constructed path.
    *   If the file already exists, report an error.
4.  **Validate Content (Basic)**:
    *   Ensure `knowledge_content` is not empty.
    *   Check for basic Markdown validity (e.g., starts with a header).
5.  **Create File**: 
    *   Use `edit_file` with the full target path.
    *   Provide the `knowledge_content` as `code_edit`.
    *   Set `instructions` clearly (e.g., "I will create a new knowledge file at [path]...").
6.  **Verify Creation**: 
    *   Use `read_file` on the target path.
    *   Compare the returned content with the provided `knowledge_content`.
7.  **Log Success**: Report successful creation.
8.  **Consider Next Steps**: 
    *   Suggest updating any related process files or commands that might use this new knowledge.
    *   **Invoke Holistic Verification**: Conceptually trigger `holistic-update-verification.md` with `changed_file_path` = [constructed full path].

## Error Handling

*   Report errors clearly if path is invalid, file exists, content is invalid, or `edit_file`/`read_file` fails.

*(Placeholder: Needs refinement.)* 