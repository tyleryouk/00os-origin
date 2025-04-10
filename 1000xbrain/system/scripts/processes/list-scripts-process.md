# Process: List Script Files

## Overview

Lists script files within `1000xscripts/`, optionally filtered by domain.

## Input Context

*   **Parameter `domain` (Optional)**: Domain to list (`system`, `frontend`, `backend`). Defaults to listing all domains.

## Steps

1.  **Determine Target Path(s)**: Based on `domain` parameter (or all domains if omitted).
2.  **List Directory Contents**: Use `list_dir` for each target path.
3.  **Filter & Format**: Filter results for common script extensions (e.g., `.ps1`, `.sh`, `.py`, `.js`) and format output, grouped by domain.

## Error Handling

*   Report errors for invalid domain or `list_dir` failure.

*(Placeholder: Needs refinement.)* 