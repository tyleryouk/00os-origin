# Process: Verify Script File Syntax (Basic)

## Overview

Performs very basic syntax/structure checks on a script file within `1000xscripts/`. Note: This cannot perform full linting or execution checks.

## Input Context

*   **Parameter `script_path`**: Relative path within `1000xscripts/`. Must include extension.

## Steps

1.  **Construct Full Path**: Combine `1000xscripts/` with `script_path`.
2.  **Read File**: Use `read_file`. Error if not found.
3.  **Perform Checks (Basic)**: 
    *   **Path Validity**: Check path starts with `1000xscripts/` and valid domain/extension.
    *   **Non-Empty**: Check if content exists.
    *   **(Future)** Basic language-specific checks (e.g., balanced parentheses/brackets if possible via simple text analysis, check for common syntax errors via regex - very limited).
4.  **Synthesize & Report**: Collate results and report status/issues.

## Error Handling

*   Report errors for invalid path, read failure.

*(Placeholder: Verification capability is very limited.)* 