# 00OS Command Standards

## Header Format

All 00OS process files must include a standardized YAML frontmatter header that follows this format:

```yaml
---
name: command-name         # The exact command name (required)
description: Short description of what the command does (required)
version: 1.0.0             # Semantic versioning (required)
author: 00reaper           # Command author (required)
category: system           # Command category (required: system, tools, examples, apps)
permissions: [basic]       # Required permissions (required, array)
inputs:                    # Command inputs (required, array)
  - name: parameter1       # Parameter name
    type: string           # Parameter type (string, number, boolean, array, object)
    required: true         # Whether parameter is required
    default: null          # Default value if any
    description: Parameter description
  - name: parameter2
    type: boolean
    required: false
    default: false
    description: Flag description
outputs:                   # Command outputs (required, array)
  - name: result
    type: object
    description: Command result description
usage: command [args]      # Command usage syntax (required)
examples:                  # Example commands (required, array)
  - command arg1
  - command arg2 --flag
aliases:                   # Command aliases (optional, array)
  - cmd
  - cm
---
```

## Command Structure

After the header, the command file should be structured as follows:

```markdown
# Process: command-name

## Metadata
- Description: Detailed description of the command's purpose
- Category: command-category
- Permissions: [permission1, permission2]
- Author: author-name
- Version: version-number

## Input
- parameter1: Description of parameter1
- parameter2: Description of parameter2

## Output
- Description of the command output

## Execution
```javascript
// Command execution code
```

## Usage Examples
```
> command-name parameter1 --parameter2
Example output
```
```

## Naming Conventions

1. **Command Files**: Name the file after the command with hyphens for spaces
   - Examples: `help.md`, `file-list.md`, `system-status.md`

2. **Commands**: Use lowercase with hyphens for multi-word commands
   - Examples: `help`, `file-list`, `system-status`

3. **Categories**: Use one of the standard categories:
   - `system`: Core system commands
   - `tools`: Utility tools
   - `examples`: Example applications
   - `apps`: User applications

4. **Parameters**: Use lowercase with hyphens for multi-word parameters
   - Examples: `path`, `detailed`, `show-all`

## Tool Call Standards

1. **MANDATORY fetch_rules**: Every command MUST use `fetch_rules` to get process information (NON-NEGOTIABLE)
2. **NEVER Self-Execute**: Commands must NEVER execute terminal commands that run 00OS commands (creates infinite loops)
3. **Minimal Tool Calls**: Keep tool calls to a minimum, preferring larger reads
4. **Error Handling**: Always include proper error handling with suggestions
5. **Response Format**: Use standard indicators (✅, ❌, ⚠️) for responses

## PowerShell Integration

PowerShell commands cannot be defined directly within 00OS processes. Instead:

1. Create a PowerShell script in the `00reaper/00scripts` directory
2. Use the `run_terminal_cmd` tool to call the script
3. Example: `> reaper-sync` calls `.\00reaper/00scripts\Sync-00OS-Complete.ps1`

## Documentation Standards

1. **Examples**: Include at least two examples for each command
2. **Usage Syntax**: Document all parameters, including optional ones
3. **Error Messages**: Document possible error scenarios
4. **Related Commands**: Reference related commands where applicable

## Implementation Guidelines

1. **Parameter Validation**: Always validate inputs before execution
2. **Error Messages**: Provide helpful error messages with suggestions
3. **Output Formatting**: Format output for readability
4. **Progress Indicators**: Show progress for long-running commands
5. **State Management**: Use state tools for persistent data

By following these standards, all 00OS commands will maintain a consistent interface, enabling dynamic discovery and improving the user experience.

## Overview

This document defines the comprehensive standards for developing, implementing, and maintaining commands in the 00OS environment. Following these standards ensures consistency, reliability, and maintainability across all command implementations, leveraging Cursor's tool call capabilities effectively.

## Core Principles

The fundamental goal of 00OS commands is to create processes **based on tool call patterns** to automate development workflows. Commands must:

1.  **Use Native Tool Calls**: Rely exclusively on Cursor's built-in tools (`read_file`, `edit_file`, `list_dir`, `fetch_rules`, etc.) for all functionality. **NEVER** use `run_terminal_cmd` to execute another 00OS command (`> ...`) as this causes infinite loops.
2.  **ALWAYS Fetch Process Rules**: Every command execution MUST begin with a `fetch_rules` call to retrieve the corresponding process rule.
3.  **Follow Consistent Structure**: Adhere to the defined process file structure, metadata requirements, and response formats.
4.  **Implement Robust Error Handling**: Include specific error codes, clear messages, and actionable recovery suggestions.
5.  **Optimize Tool Calls**: Design efficient tool call sequences to minimize execution time and avoid hitting usage limits.
6.  **Maintain Clarity**: Ensure command logic, documentation, and tests are easy to understand and maintain.

## Command Processing Flow

The 00OS command processing flow follows this exact sequence:

1. **Command Detection**: User input with `>` prefix is detected as a command
2. **Process Selection**: The appropriate process rule is fetched using `fetch_rules` (MANDATORY)
3. **Parameter Parsing**: Command arguments and flags are extracted
4. **Tool Call Execution**: The sequence of tool calls defined in the process is executed
5. **Response Formatting**: Results are formatted with standard indicators

This flow is non-negotiable and critical to the functioning of 00OS commands. Every command MUST follow this pattern to ensure consistency and reliability.

## Fixed System Properties

Some aspects of the 00OS system are fixed and cannot be changed through configuration:

1. **Command Prefix**: The `>` character is hardcoded in the command handler as the command prefix identifier.
2. **Process Fetching**: The `fetch_rules` step is non-optional and must be executed for every command.
3. **Process Execution Flow**: The command handler must allow the fetched rule to control the execution flow and must never attempt to execute commands directly.

## Process File Standards

Each command must be implemented in its own process file within the `00os/processes/` directory, categorized appropriately (e.g., `system/`, `tools/`, `apps/`).

### Process File Structure

Process files (typically `.md` containing JavaScript blocks) must include:

1.  **Metadata (YAML Frontmatter):**
    ```yaml
    ---
    name: command-name         # Unique command identifier
    description: Brief description # Concise explanation
    version: 1.0.0             # Semantic versioning
    author: 00reaper           # Author identifier
    permissions: [basic]     # List of required permissions (e.g., file-read, system-write)
    inputs:                  # Definition of arguments and flags
      - name: param1
        type: string         # Data type (string, number, boolean, object, array)
        required: true       # Whether the parameter is mandatory
        description: Parameter description
      - name: flag1
        type: boolean
        required: false
        default: false       # Default value if not provided
        description: Flag description
    outputs:                 # Definition of expected output structure (optional)
      - name: result
        type: string
        description: Primary command output
    ---
    ```

2.  **Description Section (Markdown):**
    ```markdown
    # Process: command-name

    ## Description
    Detailed explanation of the command's purpose, functionality, and usage scenarios.
    ```

3.  **Execution Logic (JavaScript Block):**
    ```javascript
    ## Execution

    ```javascript
    // Optional: Input validation helper function
    function validateInput(args, flags) {
      // ... validation logic ...
      if (!args || args.length < 1 /* based on required inputs */) {
        return { valid: false, error: "Missing required parameter...", suggestions: ["..." ] };
      }
      // ... other checks ...
      return { valid: true };
    }

    // Main execution function
    async function execute(args, flags) {
      // 1. Validate Input
      const validation = validateInput(args, flags);
      if (!validation.valid) {
        return formatError(validation.error, "VALIDATION_ERROR", validation.suggestions);
      }

      // 2. Execute Tool Call Sequence
      try {
        const result1 = await tools.call('tool_name', { /* params */ explanation: '...' });
        // Check result1 for errors if necessary

        const result2 = await tools.call('another_tool', { /* params using result1 */ explanation: '...' });
        // Check result2 for errors

        // 3. Process Results
        const processedData = processToolResults(result1, result2);

        // 4. Format Success Response
        return formatSuccess("Command executed successfully", processedData);

      } catch (error) {
        // 5. Handle Errors
        tools.error(`Execution error in command-name: ${error.message}`); // Log the error
        return formatError(error.message, determineErrorCode(error), generateSuggestions(error));
      }
    }

    // Optional: Helper functions for processing, formatting, error handling
    function processToolResults(res1, res2) { /* ... */ return {}; }
    function determineErrorCode(error) { /* ... */ return "EXECUTION_ERROR"; }
    function generateSuggestions(error) { /* ... */ return ["Check logs", "Verify parameters"]; }

    // Standard Formatting Helpers (should be globally available or imported)
    function formatSuccess(message, data = null) {
      const response = { success: true, message: `✅ ${message}` };
      if (data) response.data = data;
      return response;
    }

    function formatError(message, code = "EXECUTION_ERROR", suggestions = []) {
      const response = { success: false, message: `❌ Error [${code}]: ${message}` };
      if (suggestions && suggestions.length > 0) response.suggestions = suggestions;
      return response;
    }

    // Call the main execution function
    execute(inputs.args, inputs.flags); // Assuming args/flags are passed via an 'inputs' object
    ```
    ```

## Tool Call Standards

### Available Tool Types

*   **Search Tools**: `read_file`, `list_dir`, `codebase_search`, `grep_search`, `file_search`, `web_search`
*   **Edit Tools**: `edit_file`, `reapply`, `delete_file`
*   **Terminal Tools**: `run_terminal_cmd` (Use with extreme caution, **never** to run `>` commands)
*   **Other Tools**: `fetch_rules` (REQUIRED for command processing)

*(Refer to tool documentation for specific parameters and limits)*

### Best Practices

*   **Efficiency**: Minimize total calls (respect limits: 25 default, 200 MAX). Read larger file sections. Stop calls when info is obtained. Use targeted searches first.
*   **Chaining**: Sequence calls logically. Use results from previous calls. Cache results if applicable within the process execution. Process data between calls.
*   **Error Handling**: Check tool call results for errors. Handle failures gracefully (e.g., retry, alternative approach). Provide specific error codes (`TOOL_CALL_ERROR`) and helpful suggestions.
*   **Explanations**: Always provide a clear `explanation` parameter for each tool call, describing its purpose within the command's workflow.

## Command Response Format

Commands *must* return a consistent response object:

```javascript
{
  success: true|false,       // Boolean indicating success/failure
  message: "✅/❌/⚠️ Message", // Human-readable status message with indicator
  data: {},                  // Optional: Structured data for successful response
  suggestions: [],           // Optional: Actionable suggestions, especially for errors
  // Only for success: false
  // error: { code: "ERROR_CODE", details: "..." } // Optional: Structured error details
}
```

### Standard Indicators:
*   `✅`: Success
*   `❌`: Error
*   `⚠️`: Warning (for successful operations with caveats)

### Standard Error Codes:
*   `VALIDATION_ERROR`: Invalid input parameters.
*   `EXECUTION_ERROR`: General error during command logic execution.
*   `TOOL_CALL_ERROR`: An underlying tool call failed.
*   `NOT_FOUND_ERROR`: A requested resource (file, etc.) was not found.
*   `PERMISSION_ERROR`: Insufficient permissions to perform the action.
*   `PROCESS_NOT_FOUND`: The process rule for a command could not be found.

## Command Categories & Naming

*   **Categories**: `system`, `tools`, `apps` (place files in corresponding `00os/processes/` subdirectories).
*   **Command Names**: Lowercase, hyphen-separated (e.g., `file-list`).
*   **Arguments/Flags**: Descriptive names. Use `<required>` and `[optional]` notation in usage/help text. Flags use `--flag-name` (boolean) or `--flag-name=value`.

## Parameter Processing

*   Validate required parameters early in the `execute` function.
*   Provide sensible defaults for optional parameters/flags.
*   Use helper functions for complex parsing if needed (e.g., flag parsing).

## Command Handler Design

The command handler that processes user input must:

1. Detect the `>` prefix at the start of input (after trimming whitespace)
2. Parse the command into its components (command, subcommand, args, flags)
3. Determine the appropriate process rule path
4. Use `fetch_rules` to retrieve the process definition - this step is MANDATORY
5. Allow the fetched rule to control the execution flow
6. Format and return the response using standard indicators

Under no circumstances should the command handler attempt to:
- Execute the command directly without fetching its rule
- Use `run_terminal_cmd` to run another command with the `>` prefix
- Skip the `fetch_rules` step in the process

## Examples

*(This section should contain examples of well-structured commands)*

### Example: `file-read`

*(Include the file-read example from the guidelines here)*

```javascript
async function execute(args, flags) {
  // 1. Validate Input
  if (!args || args.length === 0) {
    return formatError("Missing file path parameter", "VALIDATION_ERROR", ["Provide a file path to read"]);
  }
  const filePath = args[0];

  // 2. Execute Tool Call Sequence
  try {
    const readResult = await tools.call("read_file", {
      target_file: filePath,
      should_read_entire_file: true, // Or determine based on flags/needs
      explanation: `Reading contents of ${filePath}`
    });

    // Check tool call result carefully
    if (!readResult || readResult.content === undefined || readResult.error) {
       const errorMsg = readResult?.error || "Failed to read file contents";
       return formatError(errorMsg, "TOOL_CALL_ERROR", [
          "Check if the file exists at the specified path",
          "Verify permissions to read the file"
        ]);
    }

    // 3. Process Results (Minimal for file-read)
    const processedData = {
        path: filePath,
        content: readResult.content,
        lineCount: readResult.content.split('\n').length
    };

    // 4. Format Success Response
    return formatSuccess(`File contents of ${filePath} read successfully`, processedData);

  } catch (error) {
    // 5. Handle Errors
    tools.error(`Execution error in file-read for ${filePath}: ${error.message}`);
    return formatError(error.message, "EXECUTION_ERROR", [
        "Verify the file path is correct",
        "Check file system permissions",
        "Review system logs for details"
    ]);
  }
}
```

*(Add more examples as commands are developed/standardized)* 