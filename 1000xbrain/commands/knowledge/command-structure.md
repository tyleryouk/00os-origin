# 1000xcommand: Command Structure

## Overview

This document defines the mandatory structure and syntax for `1000xcommand` definition files (`.md` files located in `1000xcommands/{domain}/`). Each command file MUST adhere to these specifications to ensure proper parsing and execution.

## File Structure

Every `1000xcommand` definition file MUST contain:

1.  A single H1 header (`#`) that describes the command's purpose.
2.  Zero or more lines of comments (starting with `#`). Comments are ignored during execution but useful for documentation.
3.  One or more valid tool calls using the specified function-call format OR the dynamic execution marker.

## Tool Call Format (Explicit Execution)

Tool calls MUST follow standard function-call syntax:

```markdown
# Example Command Header

# Optional comment explaining the next step
tool_name(
    parameter1="value1", 
    parameter2="value2",
    multiline_parameter="""
    This is line 1.
    This is line 2.
    """,
    boolean_param=True, # Comments can follow parameters
    ...
)

# Another comment
another_tool_name(param="value")
```

### Key Syntax Points:

*   **Tool Name:** The exact name of the available tool.
*   **Parentheses:** Enclose the parameters.
*   **Parameters:** `parameter_name="value"` or `parameter_name=True/False` for booleans.
*   **Commas:** Separate parameters.
*   **Quotes:** String values MUST be enclosed in double quotes (`

### Required Parameters

Each tool call MUST include all required parameters for that specific tool. Optional parameters may be omitted.

### Parameter Values

* Parameter values MUST be properly escaped if they contain special characters
* Values MUST be enclosed within the parameter tags
* No empty parameter values are allowed0

## Examples

### Valid Command Structure

```markdown
# Create New Rule Definition

<edit_file>
<target_file>1000xrules/core/rules/new-rule.md</target_file>
<instructions>I will create a new rule definition file with the specified content.</instructions>
<code_edit># Rule Title

## Description
Rule description goes here.

## Requirements
1. First requirement
2. Second requirement

## Implementation
Implementation details go here.
</code_edit>
```

### Invalid Command Structure

```markdown
# Invalid Command

<edit_file>
<target_file>missing-parameter</target_file>
<code_edit>Content</code_edit>
</edit_file>
```

## Related Documents

* `1000xrules/core/communication/1000xcommands-guidelines.md`: Overall system description
* `1000xbrain/brain/knowledge/commands/directory-organization.md`: Directory structure requirements 