# Knowledge: Autonomous Verification Checks

# Defines specific checks to run during verification

## Example Checks (To be expanded)

*   **File Existence**: For any file reported as created or modified, use `read_file` (attempting full read) to confirm it exists.
*   **Basic Markdown Structure**: For modified `.md` files (rules, brain, commands), check for basic Markdown syntax validity (e.g., presence of headers, consistent list formatting - initial implementation might just be a `read_file` check).
*   **Rules Sync Check**: If `1000xrules` modified, ensure `.\\Sync-All.bat | cat` runs without explicit error messages in the output (Requires `run_terminal_cmd`).
*   **Commands List Check**: If `1000xcommands` modified, ensure `.\\list.ps1 | cat` runs without explicit error messages and reflects expected changes (Requires `run_terminal_cmd`).
*   **Internal Consistency**: Cross-reference command calls within modified files against the `commands-index.md` (Requires parsing logic).
*   **File Structure**: Validate expected file structures after changes (e.g., ensure core directories exist if modifications happened within them). 