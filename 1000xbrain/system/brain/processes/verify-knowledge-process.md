# Process: Verify Knowledge File Structure

## Overview

This process performs basic checks on a knowledge file (`.md`) within `1000xbrain/`.

## Input Context

*   **Parameter `knowledge_path`**: Relative path within `1000xbrain/` (e.g., `system/rules/knowledge/concepts`). No `.md`.
*   **Knowledge**: `1000xbrain/system/guidelines/file-structure/markdown-standards.md`.
*   **Knowledge**: `1000xbrain/system/brain/knowledge/system-architecture.md`.

## Steps

1.  **Construct Full Path**: Combine `1000xbrain/` with `knowledge_path` + `.md`.
2.  **Read File**: Use `read_file` (entire file). Error if not found.
3.  **Perform Checks**: 
    *   **Path Validity**: Check path structure (`1000xbrain/<domain>/.../knowledge/file`).
    *   **Markdown Validity**: Basic checks (headers, lists).
    *   **Guideline Adherence**: Compare formatting to `markdown-standards.md`.
4.  **Synthesize & Report**: Collate results and report status/issues.

## Error Handling

*   Report errors for invalid path, read failure, critical check failures.

*(Placeholder: Needs refinement.)* 