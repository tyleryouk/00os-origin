# Process: List Plan Files

## Overview

Lists planning files (`.md`) within `1000xplans/`, optionally filtered by domain.

## Input Context

*   **Parameter `domain` (Optional)**: Domain to list (`system`, `frontend`, `backend`). Defaults to listing all domains.

## Steps

1.  **Determine Target Path(s)**: 
    *   If `domain` specified, target path is `1000xplans/<domain>/`.
    *   If omitted, target paths are `1000xplans/system/`, `1000xplans/frontend/`, `1000xplans/backend/`.
2.  **List Directory Contents**: Use `list_dir` for each target path.
3.  **Filter & Format**: Filter results for `.md` files and format output clearly, grouped by domain.

## Error Handling

*   Report errors for invalid domain or `list_dir` failure.

*(Placeholder: Needs refinement.)* 