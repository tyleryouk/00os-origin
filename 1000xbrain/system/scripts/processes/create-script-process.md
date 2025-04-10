# Process: Create Script File

## Overview

Handles creating a new script file (e.g., `.ps1`, `.sh`, `.py`) within the appropriate domain directory in `1000xscripts/`.

## Input Context

*   **Parameter `script_path`**: Relative path within `1000xscripts/` (e.g., `system/new-utility.ps1`, `frontend/build-helper.sh`). Must include the file extension and target a valid domain.
*   **Parameter `script_content`**: The initial content/code for the script file.

## Steps

1.  **Construct Full Path**: Combine `1000xscripts/` with `script_path`.
2.  **Verify Path**: Check path starts with `1000xscripts/` and valid domain. Check for valid script extension.
3.  **Check Existence (Optional)**: Use `read_file`. Report error if exists.
4.  **Validate Content**: Basic check for non-empty content.
5.  **Create File**: Use `edit_file` with path, content, instructions.
6.  **Verify Creation**: Use `read_file`.
7.  **Log Success**: Report creation.
8.  **Consider Next Steps**:
    *   **Invoke Holistic Verification**: Conceptually trigger `holistic-update-verification.md` with `changed_file_path` = [constructed full path].

## Error Handling

*   Report errors for invalid path, file exists, invalid content, tool failures.

*(Placeholder: Needs refinement.)* 