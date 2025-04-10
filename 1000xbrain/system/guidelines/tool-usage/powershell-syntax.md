# PowerShell Command Syntax Guideline

-   The cognitive architecture operates in a Windows environment using PowerShell.
-   **Critical Command Chaining Rule**: 1000xdev MUST use semicolon (`;`) for command chaining in `run_terminal_cmd` calls, never double ampersand (`&&`).

    *Example:* `cd ../some/dir; ls` (Correct)
    *Example:* `cd ../some/dir && ls` (Incorrect) 