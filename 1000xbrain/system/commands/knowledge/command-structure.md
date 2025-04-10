# Command Structure

## Overview

This file defines the standard structure and conventions for `1000xcommands` definition files (`.md`). Adhering to this structure ensures consistency and facilitates reliable command processing.

## Command File Format (`.md`)

Command definition files are Markdown files containing:

1.  **Optional Header**: A brief `# Command Name` header is recommended for clarity.
2.  **Optional Dynamic Execution Block**: For commands requiring complex logic, knowledge access, or conditional execution.
3.  **Explicit Tool Calls**: Zero or more direct tool calls.

### Dynamic Execution Block

If a command delegates its primary logic to a `1000xbrain` process, it uses the dynamic execution block:

```markdown
# Optional Command Name Header

# --- BEGIN DYNAMIC EXECUTION ---
# Process: 1000xbrain/<domain>/<component>/processes/guiding-process-file.md
# Knowledge: 1000xbrain/<domain>/<component>/knowledge/supplementary-knowledge-1.md (Optional)
# Knowledge: 1000xbrain/<domain>/<component>/knowledge/supplementary-knowledge-2.md (Optional)
# Parameter: <parameter_name>=<value> (Optional, for passing simple static values)
# ContextFile: <path_to_context_file> (Optional, provides context for the process)
# --- END DYNAMIC EXECUTION --- 

# (Any explicit tool calls AFTER the block are IGNORED during dynamic execution)
```

*   **Markers**: Must use `# --- BEGIN DYNAMIC EXECUTION ---` and `# --- END DYNAMIC EXECUTION ---` exactly.
*   **Process**: Exactly one `# Process:` line specifying the path to the main `1000xbrain` process file.
*   **Knowledge (Optional)**: Zero or more `# Knowledge:` lines specifying paths to supporting knowledge files.
*   **Parameter (Optional)**: Zero or more `# Parameter:` lines defining simple key-value pairs accessible within the process.
*   **ContextFile (Optional)**: Zero or more `# ContextFile:` lines specifying paths to files whose content should be loaded as context for the process.
*   **Location**: Typically placed at the beginning of the file if the command primarily relies on dynamic logic.
*   **Path Specificity**: Paths must be relative to the workspace root and point to the correct domain/component within `1000xbrain`.

### Explicit Tool Calls

Commands can contain direct tool calls (e.g., `read_file`, `list_dir`, `edit_file`, `run_terminal_cmd`).

```markdown
# Command Name: Simple Context Gathering

# Explicit tool call 1
tool_code
print(default_api.read_file(target_file="1000xplans/system/plan.md"))

# Explicit tool call 2
tool_code
print(default_api.list_dir(relative_workspace_path="1000xrules/core"))
```

*   **Execution Order**: Explicit tool calls are executed sequentially as they appear in the file.
*   **Interaction with Dynamic Execution**: If a dynamic execution block is present, explicit tool calls *before* the block are executed first. Explicit tool calls *after* the `# --- END DYNAMIC EXECUTION ---` marker are **ignored** when dynamic execution is triggered.
*   **Use Case**: Best suited for simple, linear command sequences or for gathering initial context *before* entering a dynamic process.

## Command Invocation

Commands are invoked using the strict syntax:

`run command:<domain>/<path>/<command-name>`

*   **`run command:`**: Mandatory prefix.
*   **`<domain>`**: The top-level domain (`system`, `frontend`, `backend`).
*   **`<path>/<command-name>`**: The path relative to the domain directory within `1000xcommands/` (e.g., `brain/analyze-structure`, `rules/create-rule`).

## Best Practices

*   **Delegate Complexity**: Prefer dynamic execution for non-trivial logic. Keep command files primarily as triggers and context definitions.
*   **Clear Naming**: Use descriptive names for command files.
*   **Correct Paths**: Ensure all paths in `Process:`, `Knowledge:`, and explicit tool calls are accurate.
*   **Minimal Logic in Commands**: Avoid complex scripting or conditional logic within the command file itself.
*   **Reference Guidelines**: Consult relevant `1000xbrain/system/guidelines/` for tool usage and implementation patterns. 