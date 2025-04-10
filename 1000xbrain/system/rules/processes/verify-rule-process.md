# Process: Verify Core Rule Syntax and Structure

## Overview

This process performs basic checks on a core rule file within `1000xrules/core/` or subdirectories to verify its syntax and structural integrity.

## Input Context

*   **Parameter `rule_path`**: The relative path of the rule to verify within `1000xrules/` (e.g., `core/communication/existing-comm-rule`). Should not include the `.md` extension.
*   **Knowledge**: `1000xbrain/system/guidelines/file-structure/markdown-standards.md` (For formatting checks).
*   **Knowledge**: `1000xbrain/system/rules/knowledge/rules-architecture.md` (Optional, for structural context).

## Steps

1.  **Construct Full Path**: Combine the base path `1000xrules/` with the `rule_path` parameter and append `.md`.
2.  **Read Rule File**: 
    *   Use `read_file` on the full target path (reading the entire file).
    *   If the file doesn't exist, report an error.
3.  **Perform Checks**:
    *   **Markdown Validity**: Check for basic Markdown structure (e.g., presence of headers, reasonably formatted lists/code blocks). (Note: Requires more sophisticated parsing logic than currently feasible via simple analysis).
    *   **Forbidden Content**: Check for disallowed content like `.mdc` frontmatter or executable script tags (as per `file-editing-safety.md`).
    *   **Guideline Adherence (Basic)**: Compare structure/formatting against `markdown-standards.md` guidelines (e.g., consistent header levels).
    *   **Path Consistency (Internal)**: Check if any internal references to other rules or components use correct paths (potentially using `grep_search` or more advanced analysis).
4.  **Synthesize Results**: Collate the results of the checks (Pass/Fail/Warnings for each check performed).
5.  **Report Findings**: Clearly report the verification results.
    *   Indicate overall status (e.g., "Verification Passed", "Verification Failed", "Verification Passed with Warnings").
    *   List specific issues found.

## Error Handling

*   Report errors clearly if path is invalid, file cannot be read, or critical checks fail.

*(Placeholder: Needs significant refinement. Current checks are conceptual. Requires more advanced parsing/linting capabilities for robust verification.)* 