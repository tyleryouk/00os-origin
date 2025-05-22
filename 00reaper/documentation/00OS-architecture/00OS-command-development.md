# 00OS Command Development

This guide is the central reference for creating, managing, and optimizing 00OS commands. **All development should follow the 3-step pattern and favor simplicity.**

## The 3-Step Pattern (MANDATORY)

1. **User sends a command**: `> command-name [arguments] [--flags]`
2. **AI fetches the process rule**: Use a single `fetch_rules` call to get the process definition
3. **AI executes the defined tool calls**: Follow the rule exactly, no more, no less

> **Never add extra validation, error handling, or abstraction unless absolutely necessary.**

## Minimal Command Implementation: Good vs. Complex

### Good (Simple, Preferred)
```markdown
---
name: file-list
category: system
description: List files in a directory
version: 1.0
author: 00reaper
permissions: [basic]
inputs:
  - name: path
    type: string
    required: true
    description: Directory path
outputs:
  - name: result
    type: array
    description: List of files
---

# Process: file-list

USE WHEN you want to execute file-list

## Execution

1. list_dir: List files in the specified directory

## Examples

> file-list /00os/processes
```

### Complex (Discouraged)
```markdown
---
name: file-list
category: system
description: List files in a directory
version: 1.0
author: 00reaper
permissions: [basic]
inputs:
  - name: path
    type: string
    required: true
    description: Directory path
outputs:
  - name: result
    type: array
    description: List of files
---

# Process: file-list

## Execution

try {
  // Validate input
  if (!inputs.path) throw new Error('Missing path');
  // List directory
  const result = await tools.call('list_dir', { ... });
  // Format result
  return { success: true, result };
} catch (error) {
  // Handle errors
  return { success: false, error: error.message };
}
```
> **Discouraged:** Do not add extra validation, try/catch, or formatting logic unless required by the process rule.

## Migration Guide: Converting Complex Commands

1. **Remove all extra validation and error handling**
2. **Keep only the direct tool call sequence**
3. **Ensure the process file starts with a fetch_rules call and follows the 3-step pattern**
4. **Update documentation and examples to be minimal and actionable**

## Best Practices
- **Always start with fetch_rules**
- **Favor direct, minimal tool call sequences**
- **Avoid over-engineering and complex error handling**
- **All examples should be short and practical**
- **Use clear explanations in tool calls**

## Example: Minimal Command Process

```markdown
---
name: echo
category: system
description: Print a message
version: 1.0
author: 00reaper
permissions: [basic]
inputs:
  - name: message
    type: string
    required: true
    description: Message to print
outputs:
  - name: result
    type: string
    description: Echoed message
---

# Process: echo

USE WHEN you want to execute echo

## Execution

1. Return the message as the result

## Examples

> echo "Hello, world!"
```

## Summary
- **The 3-step pattern is required for all commands**
- **Simplicity and clarity are the top priorities**
- **If in doubt, remove complexity**

## Key Concepts

### Tool Call Based Command Execution

The goal of 00OS commands is to create processes **based on tool call patterns** to automate the development process:

1. User sends a command starting with `>` (this prefix is fixed and hardcoded)
2. We make a `fetch_rules` tool call to get the appropriate process - **this step is MANDATORY**
3. We execute a sequence of tool calls as defined in the process
4. We return formatted results with standardized indicators (✅, ❌, ⚠️)

### Core Command Workflow

```
Command Detection → Process Rule Fetching (using fetch_rules) → Parameter Parsing → Tool Call Execution → Response Formatting
```

## Development Workflow (NEW)

To ensure reliable and intelligent changes to 00OS, follow this two-command workflow:

1.  **Define Task:** Update `current-task.md` with the specific goal for the current development session.
2.  **Load Context & Implement:**
    *   Run `> reaper-read-files 00reaper/00OS-commands` to load the full context of this directory, including your task directive.
    *   Run `> reaper-implement`. This command will:
        *   Read `current-task.md`.
        *   Analyze the task against the loaded context (standards, status, etc.).
        *   Plan and execute the necessary changes to `00OS/processes/` and tracking files using `edit_file`.
        *   Report the actions taken.

## File Structure

- `README.md` - This file. Entry point and workflow overview.
- `current-task.md` - **User Input**: Define the immediate goal for `reaper-implement` here.
- `command-standards.md` - **Primary Source**: Comprehensive standards for implementation.
- `command-registry.md` - Tracks command implementation status.
- `testing-framework.md` - Defines testing structure.
- `testing-guide.md` - Provides detailed testing procedures.
- `current-implementation.md` - Documents current system architecture.
- `user_requests.md` - Tracks longer-term backlog and hallucination logs.
- `user-guide.md` - End-user documentation (work in progress).

## Command Implementation Standards

### Command Structure
```
> [command] [subcommand] [arguments] [--flags]
```

### Process File Template
```markdown
---
name: command-name
description: Brief description of command
version: 1.0
author: 00reaper
permissions: [basic]
inputs:
  - name: arg1
    type: string
    required: true
    description: Description of first argument
  - name: verbose
    type: boolean
    required: false
    default: false
    description: Show detailed output
outputs:
  - name: result
    type: string
    description: Command output
---

# Process: command-name

## Description
Detailed description of what the command does.

## Execution

```javascript
// Input validation
function validateInput(args, flags) {
  // Validation logic
  return { valid: true/false, error: "Error message if invalid" };
}

// Execution logic - defines tool call sequence
async function execute(args, flags) {
  // Validate input
  const validation = validateInput(args, flags);
  if (!validation.valid) {
    return {
      success: false,
      message: `❌ Error: ${validation.error}`,
      suggestions: [...] // Recovery suggestions
    };
  }
  
  try {
    // Execute tool calls in sequence
    const result1 = await tools.call('tool_name', {...});
    const result2 = await tools.call('tool_name', {...});
    
    // Process results
    const processedResult = processResults(result1, result2);
    
    // Return formatted response
    return {
      success: true,
      message: `✅ Command executed successfully`,
      data: processedResult
    };
  } catch (error) {
    // Handle errors
    return {
      success: false,
      message: `❌ Error: ${error.message}`,
      code: determineErrorCode(error),
      suggestions: generateSuggestions(error)
    };
  }
}
```

### Response Format Standards
```
✅ Success: [Command output]
❌ Error [CODE]: [Error message]
⚠️ Warning: [Warning message]
```

## Critical Implementation Requirements

1. **Command Prefix**: The '>' prefix for commands is hardcoded in the command handler and is not configurable.
2. **Mandatory fetch_rules**: Every command MUST trigger a fetch_rules call to retrieve its process definition.
3. **No Self-Execution**: Commands should NEVER attempt to execute themselves via run_terminal_cmd.
4. **Process-Driven Execution**: Allow the fetched process to control the execution flow.

## Cursor Tool Types

1. **Search Tools**
   - `read_file`: Reads file contents
   - `list_dir`: Lists directory contents
   - `codebase_search`: Searches codebase semantically
   - `grep_search`: Searches for patterns in files
   - `file_search`: Finds files by name
   - `web_search`: Searches the web

2. **Edit Tools**
   - `edit_file`: Edits file content
   - `reapply`: Re-applies an edit
   - `delete_file`: Deletes a file

3. **Terminal Tools**
   - `run_terminal_cmd`: Executes terminal commands

4. **Other Tools**
   - `fetch_rules`: Retrieves Cursor rules (MANDATORY for command processing)

## Tool Call Best Practices

1. **Minimize Tool Calls**
   - Read larger sections of files at once
   - Stop tool calls once you have the information you need
   - Use targeted searches before broad file reads

2. **Optimize Sequences**
   - Chain tool calls in logical sequences
   - Use results from one tool call to inform the next
   - Handle errors gracefully with fallback approaches

3. **Format Responses Consistently**
   - Use standard prefixes (✅, ❌, ⚠️)
   - Include helpful context in error messages
   - Provide actionable suggestions when errors occur

## Development Process

(This section is superseded by the new Development Workflow above - focusing on the `reaper-read-files` -> `reaper-implement` cycle)

## Note

When implementing 00OS commands, remember that the core goal is to leverage Cursor's tool calls to automate workflows. Commands should NEVER try to run terminal commands that execute themselves - this creates an infinite loop and will not work.