# 00OS Command Development Standards

## Overview

This document defines the comprehensive standards for developing, implementing, and maintaining commands in the 00OS environment. Following these standards ensures consistency, reliability, and maintainability across all command implementations, leveraging Cursor's tool call capabilities effectively.

## Core Principles

The fundamental goal of 00OS commands is to create processes **based on tool call patterns** to automate development workflows. Commands must:

1.  **Use Native Tool Calls**: Rely exclusively on Cursor's built-in tools (`read_file`, `edit_file`, `list_dir`, `fetch_rules`, etc.) for all functionality. **NEVER** use `run_terminal_cmd` to execute another 00OS command (`> ...`) as this causes infinite loops.
2.  **Follow Consistent Structure**: Adhere to the defined process file structure, metadata requirements, and response formats.
3.  **Implement Robust Error Handling**: Include specific error codes, clear messages, and actionable recovery suggestions.
4.  **Optimize Tool Calls**: Design efficient tool call sequences to minimize execution time and avoid hitting usage limits.
5.  **Maintain Clarity**: Ensure command logic, documentation, and tests are easy to understand and maintain.

## Command Processing Flow

00OS commands follow a standardized processing pipeline:

1.  **Command Detection**: User input prefixed with `>` is identified as a command.
2.  **Process Selection**: The command handler uses `fetch_rules` to retrieve the appropriate process definition based on the command name.
3.  **Parameter Parsing**: Arguments, options, and flags are extracted and validated against the process definition.
4.  **Tool Call Execution**: The process executes its defined sequence of Cursor tool calls, potentially using results from previous calls.
5.  **Response Formatting**: The final result is formatted using standard indicators (✅, ❌, ⚠️) and returned to the user.

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
*   **Other Tools**: `fetch_rules`

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

## Command Categories & Naming

*   **Categories**: `system`, `tools`, `apps` (place files in corresponding `00os/processes/` subdirectories).
*   **Command Names**: Lowercase, hyphen-separated (e.g., `file-list`).
*   **Arguments/Flags**: Descriptive names. Use `<required>` and `[optional]` notation in usage/help text. Flags use `--flag-name` (boolean) or `--flag-name=value`.

## Parameter Processing

*   Validate required parameters early in the `execute` function.
*   Provide sensible defaults for optional parameters/flags.
*   Use helper functions for complex parsing if needed (e.g., flag parsing).

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