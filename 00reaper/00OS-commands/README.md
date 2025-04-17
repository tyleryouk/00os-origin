# 00OS Command Development

This directory serves as the central hub for creating, managing, and optimizing 00OS commands. Read this file first at the beginning of each development session.

## Key Concepts

### Tool Call Based Command Execution

The goal of 00OS commands is to create processes **based on tool call patterns** to automate the development process:

1. User sends a command starting with `>` 
2. We make a `fetch_rules` tool call to get the appropriate process
3. We execute a sequence of tool calls as defined in the process
4. We return formatted results with standardized indicators (✅, ❌, ⚠️)

### Core Command Workflow

```
Command Detection → Process Selection → Parameter Parsing → Tool Call Execution → Response Formatting
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
- `major-changes.md` - Foundational document explaining the tool-call architecture rationale.

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
   - `fetch_rules`: Retrieves Cursor rules

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