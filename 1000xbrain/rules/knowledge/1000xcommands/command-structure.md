# 1000xcommand: Structure and Syntax

## Overview

This document details the required structure and syntax for `1000xcommand` definition files (`.md` files located within `1000xrules/1000xcommands/`). Adherence to this structure is critical for correct parsing and execution by 1000xdev.

## File Structure

A `1000xcommand` definition file MUST consist of exactly two parts:

1.  **Header**: A single H1 Markdown header (`#`) defining the command's descriptive name.
2.  **Tool Calls**: One or more lines, each containing a valid 1000xdev tool call.

```markdown
# Descriptive Command Name (e.g., Analyze Core Identity Rules)

# Tool Call 1
# Note: Must be a valid tool call recognized by 1000xdev
tool_call_1(parameter1="value1", parameter2=true)

# Tool Call 2 (Optional Comment)
tool_call_2(target_file="path/to/file.md", should_read_entire_file=True)

# ... additional tool calls
tool_call_N(...)
```

## Syntax Requirements

*   **Header**: 
    *   MUST start with `# `. 
    *   MUST be the very first line of the file.
    *   Should be descriptive and reflect the command's purpose.
*   **Tool Calls**: 
    *   Each tool call MUST be on a new line.
    *   Each tool call MUST be a valid function call using the available tools (e.g., `read_file`, `edit_file`, `list_dir`, `codebase_search`, `grep_search`, `fetch_rules`, `run_terminal_cmd`).
    *   Parameters MUST be correctly formatted according to the tool's schema.
    *   Standard tool usage guidelines (`core/tools/tool-usage-standards.mdc`) apply.
*   **No Extra Content**: The file MUST NOT contain any text or markdown other than the single H1 header, the tool calls, and optional single-line comments starting with `#` immediately preceding a tool call.
*   **File Naming**: Command files use kebab-case (e.g., `enhance-core-rules.md`).

## Example: Valid Command Structure

```markdown
# Explore Core Identity Directory

list_dir(relative_workspace_path="1000xrules/core/identity/")
read_file(target_file="1000xrules/core/identity/core-identity.md", should_read_entire_file=True)
```

## Example: Invalid Command Structure (Incorrect)

```markdown
# Explore Core Identity Directory

## Subheading (Invalid - Only H1 Header allowed)

This command lists the identity directory.

list_dir(relative_workspace_path="1000xrules/core/identity/") 

# Missing quotes around path (Invalid Tool Call Syntax)
read_file(target_file=1000xrules/core/identity/core-identity.md, should_read_entire_file=True)
```

## Related Documents

*   `1000xrules/core/communication/1000xcommands-guidelines.md`: Overall system description.
*   `1000xbrain/knowledge/1000xcommands/directory-organization.md`: Where to place command files.
*   `core/tools/tool-usage-standards.mdc`: Rules for using specific tools. 