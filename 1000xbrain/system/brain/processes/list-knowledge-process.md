# Process: List Knowledge Files

## Overview

Lists knowledge files (`.md` within a `knowledge/` subdirectory) in `1000xbrain/`, optionally filtered.

## Input Context

*   **Parameter `filter_path` (Optional)**: Relative path within `1000xbrain/` to search (e.g., `system/rules`, `frontend`). Lists recursively from this path. Defaults to `1000xbrain/`.

## Steps

1.  **Determine Target Path**: Default to `1000xbrain/` or use `1000xbrain/` + `filter_path`.
2.  **Verify Target Path**: Ensure path starts with `1000xbrain/`.
3.  **List Directory Contents**: Use `list_dir` recursively on target path.
4.  **Filter & Format**: Post-process results to show only files ending in `.md` residing within a `/knowledge/` directory. Format output clearly.

## Error Handling

*   Report errors for invalid path or `list_dir` failure.

*(Placeholder: Needs refinement on filtering.)* 