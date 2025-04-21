---
name: reaper-implement
description: Reads the current task defined in 00reaper/00OS-commands/current-task.md and executes the necessary changes to 00OS process files and tracking documents.
version: 2.0.0
author: 00reaper
permissions: [file-read, file-write, edit_file] # Needs ability to read context and edit files
inputs:
  - name: mode
    type: string
    required: false
    description: Implementation mode (plan, scaffold, full). Defaults to "plan" which only generates a plan without executing it.
outputs:
  - name: summary
    type: string
    description: A summary of the actions taken (files created/edited).
  - name: errors
    type: array
    description: List of any errors encountered during implementation.
---

# Process: reaper-implement

## Description

This process acts as the primary implementation engine for 00OS development. It performs the following steps:

1. Assumes the context of the `00reaper/00OS-commands/` directory has been loaded (e.g., by a preceding `> reaper-read-files` command, potentially storing results in process state).
2. Reads the specific objective from `00reaper/00OS-commands/current-task.md`.
3. Analyzes the task requirements against the loaded context (command standards, registry status, etc.).
4. Plans the necessary file modifications (creations or edits) to achieve the task.
5. Executes the planned changes using the `edit_file` tool if mode is "scaffold" or "full".
6. Updates relevant tracking files (like `command-registry.md`) if required by the task.
7. Reports a summary of actions taken and any errors encountered.

**Note:** This process relies heavily on the AI's ability to interpret the task, consult the standards, and generate correct `edit_file` calls. It requires careful definition of the task in `current-task.md`.

## Execution

```javascript
// --- Standard Formatting Helpers ---
function formatSuccess(message, data = null) {
  const formattedMessage = typeof message === 'string' 
    ? `✅ ${message}` 
    : JSON.stringify(message);
  
  const response = { success: true, message: formattedMessage };
  if (data) response.data = data;
  return response;
}

function formatError(message, code = "EXECUTION_ERROR", suggestions = []) {
  const formattedMessage = typeof message === 'string' 
    ? `❌ Error [${code}]: ${message}` 
    : `❌ Error [${code}]: ${JSON.stringify(message)}`;
  
  const response = { 
    success: false, 
    message: formattedMessage,
    code: code 
  };
  
  if (suggestions && suggestions.length > 0) {
    response.message += "\n\nSuggestions:";
    suggestions.forEach(suggestion => {
      response.message += `\n- ${suggestion}`;
    });
  }
  
  return response;
}

function formatWarning(message) {
  return `⚠️ Warning: ${message}`;
}

// --- Implementation-Specific Helpers ---
async function readTaskFile(taskFilePath) {
  try {
    tools.log(`Reading task definition from ${taskFilePath}...`);
    const readResult = await tools.call('read_file', {
      target_file: taskFilePath,
      should_read_entire_file: true,
      explanation: `Reading the implementation task from ${taskFilePath}`
    });

    if (!readResult || readResult.content === undefined) {
      throw new Error(`Could not read task file or received invalid response`);
    }
    
    tools.log(`Task file read successfully (${taskFilePath}).`);
    return readResult.content;
  } catch (error) {
    tools.error(`Failed to read task file ${taskFilePath}: ${error.message}`);
    throw new Error(`Failed to read ${taskFilePath}: ${error.message}`);
  }
}

async function analyzeTaskAndGeneratePlan(taskContent) {
  tools.log(`Analyzing task content and generating implementation plan...`);
  
  // [AI logic to analyze task and generate a plan based on the task content]
  // This will vary based on the specific task content, but the general steps include:
  // 1. Parse the task requirements, goals, and constraints
  // 2. Identify which files need to be created or modified
  // 3. Generate specific edit plans for each file
  
  // For demonstration purposes, we'll return a sample plan
  // In a real implementation, this would be dynamically generated based on taskContent
  return [
    {
      tool: 'edit_file',
      params: {
        target_file: '00os/processes/tools/file-search.md',
        instructions: 'Create the file-search.md process file with standard metadata and structure.',
        code_edit: `---
name: file-search
description: Searches for files matching a pattern within a specified path.
version: 1.0.0
author: 00reaper
permissions: [file-read, file_search]
inputs:
  - name: pattern
    type: string
    required: true
    description: The search pattern (e.g., "*.md", "config*.json").
  - name: path
    type: string
    required: false
    description: Optional directory path to search within. Defaults to workspace root.
outputs:
  - name: results
    type: array
    description: A list of file paths matching the pattern.
---

# Process: file-search

## Description
Searches the file system for files matching a specified pattern. Can search recursively from the workspace root or a given directory path.

## Execution

\`\`\`javascript
// Standard response formatting
function formatSuccess(message, data = null) {
  const response = { success: true, message: \`✅ \${message}\` };
  if (data) response.data = data;
  return response;
}

function formatError(message, code = "EXECUTION_ERROR", suggestions = []) {
  const response = { success: false, message: \`❌ Error [\${code}]: \${message}\` };
  if (suggestions && suggestions.length > 0) {
    response.message += "\\n\\nSuggestions:";
    suggestions.forEach(suggestion => {
      response.message += \`\\n- \${suggestion}\`;
    });
  }
  return response;
}

async function execute(args, flags) {
  // 1. Validate Input
  const pattern = args[0];
  const searchPath = args[1] || '.'; // Default to current workspace root

  if (!pattern) {
    return formatError("Missing required argument: pattern", "VALIDATION_ERROR", ["Provide a search pattern, e.g., '*.md'"]);
  }

  // 2. Execute Tool Call Sequence
  try {
    tools.log(\`Searching for pattern: '\${pattern}' in path: '\${searchPath}'\`);
    const searchResult = await tools.call('file_search', {
      query: pattern,
      explanation: \`Searching for files matching '\${pattern}' starting from '\${searchPath}'\`
    });

    // 3. Process Results
    if (!searchResult || !searchResult.matching_files) {
      return formatError("File search tool call failed or returned invalid data.", "TOOL_CALL_ERROR", ["Check tool availability and logs."]);
    }

    const fileList = searchResult.matching_files || [];

    if (fileList.length === 0) {
      return formatSuccess(\`No files found matching pattern '\${pattern}' in path '\${searchPath}'.\`, { count: 0, files: [] });
    }

    // 4. Format Success Response
    const fileListString = fileList.map(f => \`- \${f}\`).join('\\n');
    return formatSuccess(\`Found \${fileList.length} file(s) matching pattern '\${pattern}':\\n\${fileListString}\`, { count: fileList.length, files: fileList });

  } catch (error) {
    // 5. Handle Errors
    tools.error(\`Execution error in file-search for pattern '\${pattern}': \${error.message}\`);
    return formatError(error.message, "EXECUTION_ERROR", [
      \`Verify the pattern '\${pattern}' is valid.\`,
      "Check file system permissions if a path was specified.",
      "Review system logs for details."
    ]);
  }
}

execute(inputs.args, inputs.flags);
\`\`\`
`
      }
    },
    {
      tool: 'edit_file',
      params: {
        target_file: '00reaper/00OS-commands/command-registry.md',
        instructions: 'Update file-search status to ✅',
        code_edit: `// ... existing code ...\n| \`file list\` | ✅ | tools/file-list.md | List files in directory |\n| \`file read\` | ✅ | tools/file-read.md | View file contents |\n| \`file search\` | ✅ | tools/file-search.md | Find files by pattern |\n\n## Context Management\n// ... existing code ...`
      }
    }
  ];
}

async function executeImplementationPlan(plan, mode) {
  tools.log(`Executing implementation plan in ${mode} mode with ${plan.length} action(s)...`);
  const actionsTaken = [];
  const errorsEncountered = [];

  // In "plan" mode, we only report the plan without executing actions
  if (mode === "plan") {
    const planSummary = plan.map(action => 
      `- Would execute ${action.tool} on ${action.params.target_file} with instruction: "${action.params.instructions}"`
    ).join('\n');
    
    return {
      actionsTaken: [`Generated implementation plan with ${plan.length} action(s)`],
      errorsEncountered: [],
      planDetails: planSummary
    };
  }

  // Execute actions for scaffold or full modes
  for (const action of plan) {
    try {
      tools.log(`Executing ${action.tool} for target: ${action.params.target_file}`);
      const result = await tools.call(action.tool, action.params);

      // Check for errors in the result
      if (result && (result.success === false || result.error)) {
        throw new Error(result.error || result.message || `Tool call ${action.tool} failed.`);
      }

      actionsTaken.push(`Executed ${action.tool} on ${action.params.target_file}. Instruction: "${action.params.instructions}"`);
      tools.log(`Action completed successfully.`);

    } catch(error) {
      const errorMsg = `Failed action: ${action.tool} on ${action.params.target_file}. Reason: ${error.message}`;
      tools.error(errorMsg);
      errorsEncountered.push(errorMsg);
      
      // Consider whether to continue or abort on error
      // In scaffold mode, we might want to continue despite errors
      if (mode !== "scaffold" && errorsEncountered.length > 2) {
        tools.log(`Too many errors (${errorsEncountered.length}), stopping execution`);
        break;
      }
    }
  }

  return {
    actionsTaken,
    errorsEncountered
  };
}

function validateImplementationMode(mode) {
  const validModes = ["plan", "scaffold", "full"];
  const normalizedMode = (mode || "plan").toLowerCase();
  
  if (!validModes.includes(normalizedMode)) {
    throw new Error(`Invalid implementation mode: ${mode}. Valid options are: ${validModes.join(", ")}`);
  }
  
  return normalizedMode;
}

// --- Main Execution Function ---
async function execute(args, flags) {
  let mode;
  const actionsTaken = [];
  const errorsEncountered = [];
  const taskFilePath = "00reaper/00OS-commands/current-task.md";
  
  try {
    // 1. Validate and parse input parameters
    try {
      mode = validateImplementationMode(flags.mode);
      tools.log(`Using implementation mode: ${mode}`);
    } catch (error) {
      return formatError(error.message, "VALIDATION_ERROR", [
        "Use one of the valid modes: plan, scaffold, full",
        "Example: > reaper-implement --mode=scaffold"
      ]);
    }

    // 2. Read the current task definition
    let taskContent;
    try {
      taskContent = await readTaskFile(taskFilePath);
      actionsTaken.push(`Read task from ${taskFilePath}.`);
    } catch (error) {
      return formatError(`Critical error: ${error.message}`, "FILE_READ_ERROR", [
        "Ensure the current-task.md file exists in 00reaper/00OS-commands/",
        "Run > reaper-os-commands-workflow to initialize or update the workflow files"
      ]);
    }

    // 3. Analyze task and generate implementation plan
    const plan = await analyzeTaskAndGeneratePlan(taskContent);
    actionsTaken.push(`Generated implementation plan with ${plan.length} action(s).`);
    
    // 4. Execute the implementation plan (or just report it in "plan" mode)
    const executionResult = await executeImplementationPlan(plan, mode);
    
    // Add results to our tracking arrays
    actionsTaken.push(...executionResult.actionsTaken);
    errorsEncountered.push(...executionResult.errorsEncountered);
    
    // 5. Generate and return the execution summary
    let summary = `Implementation ${mode === "plan" ? "plan" : "execution"} completed.\n\nActions Taken (${actionsTaken.length}):\n`;
    actionsTaken.forEach(action => summary += `- ${action}\n`);
    
    // Include plan details in plan mode
    if (mode === "plan" && executionResult.planDetails) {
      summary += `\nImplementation Plan:\n${executionResult.planDetails}\n`;
    }

    // Add errors if any occurred
    if (errorsEncountered.length > 0) {
      summary += `\nErrors Encountered (${errorsEncountered.length}):\n`;
      errorsEncountered.forEach(error => summary += `- ${error}\n`);
      
      return formatError(summary, "PARTIAL_FAILURE", [
        "Review errors and logs.",
        "Verify any file changes that were made.",
        "Update current-task.md and retry if necessary.",
        `Consider using --mode=scaffold to make partial progress.`
      ]);
    } else {
      return formatSuccess(summary, {
        actionCount: actionsTaken.length,
        mode: mode,
        filesModified: plan.map(action => action.params.target_file)
      });
    }
    
  } catch (error) {
    // Catch-all for unexpected errors
    tools.error(`Unexpected error in reaper-implement: ${error.message}`);
    return formatError(`Unexpected error during implementation: ${error.message}`, "EXECUTION_ERROR", [
      "Check system logs for details.",
      "Ensure the context files are properly loaded (run reaper-read-files first).",
      "Try again with --mode=plan to diagnose issues without making changes."
    ]);
  }
}

// Call the main execution function with parsed inputs
execute(inputs.args || [], inputs.flags || {});
```

## Example Usage

### Generate Implementation Plan
```
> reaper-implement --mode=plan
```

### Generate Implementation Scaffolding
```
> reaper-implement --mode=scaffold
```

### Generate Full Implementation
```
> reaper-implement --mode=full
```

## Error Handling

### Invalid Mode
```
❌ Error [VALIDATION_ERROR]: Invalid implementation mode: test

Suggestions:
- Use one of the valid modes: plan, scaffold, full
- Example: > reaper-implement --mode=scaffold
```

### Missing Task File
```
❌ Error [FILE_READ_ERROR]: Critical error: Failed to read 00reaper/00OS-commands/current-task.md: File not found

Suggestions:
- Ensure the current-task.md file exists in 00reaper/00OS-commands/
- Run > reaper-os-commands-workflow to initialize or update the workflow files
```

### Partial Failure
```
❌ Error [PARTIAL_FAILURE]: Implementation execution completed.

Actions Taken (5):
- Read task from 00reaper/00OS-commands/current-task.md.
- Generated implementation plan with 2 action(s).
- Generated implementation plan with 2 action(s).
- Executed edit_file on 00os/processes/tools/file-search.md. Instruction: "Create the file-search.md process file with standard metadata and structure."
- Failed action: edit_file on 00reaper/00OS-commands/command-registry.md. Reason: Could not find file for editing

Suggestions:
- Review errors and logs.
- Verify any file changes that were made.
- Update current-task.md and retry if necessary.
- Consider using --mode=scaffold to make partial progress.
``` 