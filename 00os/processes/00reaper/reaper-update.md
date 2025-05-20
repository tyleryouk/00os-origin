---
name: reaper-update
description: Updates the 00reaper context state with latest information from workflow files
version: 2.0.0
author: 00reaper
category: 00reaper
permissions: [basic, file-read]
inputs:
  - name: focus
    type: string
    required: false
    description: Specific context to update (workflow, processes, config, all)
  - name: verbose
    type: boolean
    required: false
    default: false
    description: Show detailed information in the output
outputs:
  - name: result
    type: object
    description: Status of the context update
usage: reaper-update [--focus=workflow|processes|config|all] [--verbose]
examples:
  - reaper-update
  - reaper-update --focus=workflow --verbose
---

# Process: reaper-update

## Description
Updates the 00reaper context state by reading the latest information from workflow files, process definitions, and configuration files. This maintains an up-to-date understanding of the current development state across sessions.

## Execution
```javascript
/**
 * Main execution function for reaper-update
 */
async function execute() {
  try {
    // Parse and validate input parameters
    const params = parseAndValidateParameters();
    if (!params.valid) {
      return formatError(params.message, params.code, params.suggestions);
    }
    
    const { focus, verbose } = params;
    
    // Update context based on focus
    const updateResults = await updateContextByFocus(focus, verbose);
    
    // Collect results
    const successCount = updateResults.filter(r => r.success).length;
    const totalCount = updateResults.length;
    
    // Generate response based on update results
    if (successCount === totalCount) {
      return formatSuccess(`Successfully updated ${successCount} context components.`, 
                           verbose ? { results: updateResults } : null);
    } else {
      return formatWarning(`Partially updated context. ${successCount}/${totalCount} components updated successfully.`, 
                           verbose ? { results: updateResults } : null);
    }
  } catch (error) {
    return formatError(`Unexpected error during context update: ${error.message}`, "EXECUTION_ERROR");
  }
}

/**
 * Parse and validate input parameters
 * @returns {Object} Validated parameters or error information
 */
function parseAndValidateParameters() {
  try {
    // Get input parameters with defaults
    const focus = inputs.focus || "all";
    const verbose = inputs.verbose === true;
    
    // Validate focus value
    const validFocusValues = ["workflow", "processes", "config", "all"];
    if (!validFocusValues.includes(focus)) {
      return {
        valid: false,
        code: "INVALID_PARAMETER",
        message: `Invalid focus value: ${focus}`,
        suggestions: [
          `Valid options are: ${validFocusValues.join(', ')}`,
          `Use --focus=all to update all context components.`
        ]
      };
    }
    
    return {
      valid: true,
      focus,
      verbose
    };
  } catch (error) {
    return {
      valid: false,
      code: "PARAMETER_PARSING_ERROR",
      message: `Error parsing parameters: ${error.message}`,
      suggestions: [
        "Check parameter format and try again."
      ]
    };
  }
}

/**
 * Update context based on the specified focus
 * @param {string} focus - Context focus (workflow, processes, config, all)
 * @param {boolean} verbose - Whether to include detailed information
 * @returns {Array} Array of update results
 */
async function updateContextByFocus(focus, verbose) {
  const results = [];
  
  // Update workflow context if requested
  if (focus === "workflow" || focus === "all") {
    const workflowResult = await updateWorkflowContext(verbose);
    results.push(workflowResult);
  }
  
  // Update processes context if requested
  if (focus === "processes" || focus === "all") {
    const processesResult = await updateProcessesContext(verbose);
    results.push(processesResult);
  }
  
  // Update config context if requested
  if (focus === "config" || focus === "all") {
    const configResult = await updateConfigContext(verbose);
    results.push(configResult);
  }
  
  return results;
}

/**
 * Update workflow context by reading core workflow files
 * @param {boolean} verbose - Whether to include detailed information
 * @returns {Object} Update result
 */
async function updateWorkflowContext(verbose) {
  try {
    const workflowFiles = [
      "00reaper/active-request.md",
      "00reaper/implementation-plan.md",
      "00reaper/cycle-status.md"
    ];
    
    const filesRead = [];
    
    // Read each workflow file
    for (const filePath of workflowFiles) {
      try {
        const fileResult = await tools.call('read_file', {
          target_file: filePath,
          should_read_entire_file: true,
          explanation: `Reading workflow file ${filePath} for context update`
        });
        
        if (fileResult && fileResult.content) {
          filesRead.push({
            path: filePath,
            status: "read_success",
            size: fileResult.content.length
          });
        } else {
          filesRead.push({
            path: filePath,
            status: "read_error",
            error: "No content returned"
          });
        }
      } catch (readError) {
        filesRead.push({
          path: filePath,
          status: "read_error",
          error: readError.message
        });
      }
    }
    
    // Calculate success rate
    const successCount = filesRead.filter(f => f.status === "read_success").length;
    const totalCount = workflowFiles.length;
    
    return {
      component: "workflow",
      success: successCount > 0,
      message: `Updated workflow context (${successCount}/${totalCount} files)`,
      details: verbose ? filesRead : undefined
    };
  } catch (error) {
    return {
      component: "workflow",
      success: false,
      message: `Failed to update workflow context: ${error.message}`
    };
  }
}

/**
 * Update processes context by checking process directories
 * @param {boolean} verbose - Whether to include detailed information
 * @returns {Object} Update result
 */
async function updateProcessesContext(verbose) {
  try {
    const processDirectories = [
      "00os/processes/system",
      "00os/processes/00reaper",
      "00os/processes/1000xdev"
    ];
    
    const processStats = [];
    
    // Check each process directory
    for (const dirPath of processDirectories) {
      try {
        const dirResult = await tools.call('list_dir', {
          relative_workspace_path: dirPath,
          explanation: `Listing process files in ${dirPath} for context update`
        });
        
        if (dirResult && dirResult.entries) {
          const processFiles = dirResult.entries.filter(entry => !entry.is_directory && entry.path.endsWith('.md'));
          
          processStats.push({
            directory: dirPath,
            status: "read_success",
            count: processFiles.length,
            files: verbose ? processFiles.map(f => f.path) : undefined
          });
        } else {
          processStats.push({
            directory: dirPath,
            status: "read_error",
            error: "No directory entries returned"
          });
        }
      } catch (listError) {
        processStats.push({
          directory: dirPath,
          status: "read_error",
          error: listError.message
        });
      }
    }
    
    // Calculate success rate
    const successCount = processStats.filter(d => d.status === "read_success").length;
    const totalCount = processDirectories.length;
    
    return {
      component: "processes",
      success: successCount > 0,
      message: `Updated processes context (${successCount}/${totalCount} directories)`,
      details: verbose ? processStats : undefined
    };
  } catch (error) {
    return {
      component: "processes",
      success: false,
      message: `Failed to update processes context: ${error.message}`
    };
  }
}

/**
 * Update config context by reading configuration files
 * @param {boolean} verbose - Whether to include detailed information
 * @returns {Object} Update result
 */
async function updateConfigContext(verbose) {
  try {
    const configFiles = [
      "00os/config/settings.md"
    ];
    
    const filesRead = [];
    
    // Read each config file
    for (const filePath of configFiles) {
      try {
        const fileResult = await tools.call('read_file', {
          target_file: filePath,
          should_read_entire_file: true,
          explanation: `Reading config file ${filePath} for context update`
        });
        
        if (fileResult && fileResult.content) {
          filesRead.push({
            path: filePath,
            status: "read_success",
            size: fileResult.content.length
          });
        } else {
          filesRead.push({
            path: filePath,
            status: "read_error",
            error: "No content returned"
          });
        }
      } catch (readError) {
        filesRead.push({
          path: filePath,
          status: "read_error",
          error: readError.message
        });
      }
    }
    
    // Calculate success rate
    const successCount = filesRead.filter(f => f.status === "read_success").length;
    const totalCount = configFiles.length;
    
    return {
      component: "config",
      success: successCount > 0,
      message: `Updated config context (${successCount}/${totalCount} files)`,
      details: verbose ? filesRead : undefined
    };
  } catch (error) {
    return {
      component: "config",
      success: false,
      message: `Failed to update config context: ${error.message}`
    };
  }
}

/**
 * Format a success response
 * @param {string} message - Success message
 * @param {Object} data - Optional data to include
 * @returns {string} Formatted success message
 */
function formatSuccess(message, data = null) {
  return `✅ ${message}${data ? '\n\n' + JSON.stringify(data, null, 2) : ''}`;
}

/**
 * Format an error response
 * @param {string} message - Error message
 * @param {string} code - Error code
 * @param {Array} suggestions - Optional suggestions
 * @returns {string} Formatted error message
 */
function formatError(message, code = "ERROR", suggestions = []) {
  let output = `❌ Error [${code}]: ${message}`;
  
  if (suggestions && suggestions.length > 0) {
    output += "\n\nSuggestions:";
    for (const suggestion of suggestions) {
      output += `\n- ${suggestion}`;
    }
  }
  
  return output;
}

/**
 * Format a warning response
 * @param {string} message - Warning message
 * @param {Object} details - Optional details
 * @returns {string} Formatted warning message
 */
function formatWarning(message, details = null) {
  return `⚠️ Warning: ${message}${details ? '\n\n' + JSON.stringify(details, null, 2) : ''}`;
}

// Execute the process
execute();
```

## Usage Examples
```
> reaper-update
✅ Successfully updated 3 context components.

> reaper-update --focus=workflow --verbose
✅ Successfully updated 3 context components.
``` 