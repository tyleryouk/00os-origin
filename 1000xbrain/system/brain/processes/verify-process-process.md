# Process: Verify Process File Structure

## Overview

Performs basic checks on a process file (`.md`) within `1000xbrain/`.

## Input Context

*   **Parameter `process_path`**: Relative path within `1000xbrain/` (e.g., `system/rules/processes/verify`). No `.md`.
*   **Knowledge**: `1000xbrain/system/guidelines/file-structure/markdown-standards.md`.
*   **Knowledge**: `1000xbrain/system/brain/knowledge/system-architecture.md`.

## Steps

1.  **Construct Full Path**: Combine `1000xbrain/` with `process_path` + `.md`.
2.  **Read File**: Use `read_file` (entire file). Error if not found.
3.  **Perform Checks**: 
    *   **Path Validity**: Check path structure (`1000xbrain/<domain>/.../processes/file`).
    *   **Markdown Validity**: Basic checks (headers, steps list).
    *   **Guideline Adherence**: Compare formatting to `markdown-standards.md`.
    *   **Internal Consistency**: Check if referenced steps/sections exist within the file.
4.  **Synthesize & Report**: Collate results and report status/issues.

## Error Handling

*   Report errors for invalid path, read failure, critical check failures.

*(Placeholder: Needs refinement.)* 