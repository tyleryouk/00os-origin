# Process: Verify Command Syntax and Structure

## Overview

This process performs checks on a command definition file (`.md`) to verify its syntax, structure, and path validity according to system standards.

## Input Context

*   **Parameter `command_path`**: The relative path of the command to verify within `1000xcommands/` (e.g., `system/rules/existing-rule-cmd`). Should not include the `.md` extension.
*   **Knowledge**: `1000xbrain/system/commands/knowledge/command-structure.md`.
*   **Knowledge**: `1000xbrain/system/commands/knowledge/directory-organization.md`.

## Steps

1.  **Construct Full Path**: Combine `1000xcommands/` with `command_path` and append `.md`.
2.  **Read Command File**: Use `read_file` (entire file). Report error if not found.
3.  **Perform Checks**:
    *   **Path Validity**: Check if `command_path` follows domain/component structure described in `directory-organization.md`.
    *   **Structure Validity**: Check adherence to format in `command-structure.md`:
        *   Valid header (optional).
        *   Correct Dynamic Execution block syntax (if present): Exactly one `Process:`, valid marker lines.
        *   Valid tool call format (if explicit calls present).
    *   **Path Existence (Internal)**: If Dynamic Execution block present, use `read_file` to check if the referenced `Process:` and `Knowledge:` files exist. Use `list_dir` or similar checks for `ContextFile:` paths if they are directories.
    *   **Guideline Adherence (Basic)**: Check against relevant guidelines (e.g., `edit-file-best-practices.md` if `edit_file` is used explicitly).
4.  **Synthesize Results**: Collate check results (Pass/Fail/Warnings).
5.  **Report Findings**: Report overall status and specific issues found.

## Error Handling

*   Report errors for invalid path, file read failure, critical syntax errors, or non-existent referenced files.

*(Placeholder: Needs refinement. Path existence checks require careful implementation.)* 