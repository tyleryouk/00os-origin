# Process: Verify Plan File Structure

## Overview

Performs basic structural and consistency checks on a planning file (`.md`) within `1000xplans/`.

## Input Context

*   **Parameter `plan_file_path`**: Relative path within `1000xplans/` (e.g., `system/plan.md`). Must include `.md`.
*   **Knowledge**: `1000xbrain/system/guidelines/file-structure/markdown-standards.md`.

## Steps

1.  **Construct Full Path**: Combine `1000xplans/` with `plan_file_path`.
2.  **Read File**: Use `read_file`. Error if not found.
3.  **Perform Checks**: 
    *   **Path Validity**: Check path starts with `1000xplans/` and valid domain.
    *   **Markdown Validity**: Basic checks (headers, sections).
    *   **Consistency (Conceptual)**: Check if sections expected in a specific plan type (plan, requirements, etc.) are present.
4.  **Synthesize & Report**: Collate results and report status/issues.

## Error Handling

*   Report errors for invalid path, read failure, critical check failures.

*(Placeholder: Needs refinement.)* 