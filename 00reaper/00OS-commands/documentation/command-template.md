---
name: command-name
description: Brief description of what the command does
version: 1.0.0
author: 00reaper
category: system  # system, tools, examples, apps
permissions: [basic]  # basic, file-read, file-write, system-read, system-write, etc.
inputs:
  - name: parameter1
    type: string  # string, number, boolean, array, object
    required: true
    default: null
    description: Description of the first parameter
  - name: parameter2
    type: number
    required: false
    default: 10
    description: Description of the second parameter
  - name: flag1
    type: boolean
    required: false
    default: false
    description: Description of the first flag
outputs:
  - name: result
    type: object
    description: The command execution result
usage: command-name <parameter1> [parameter2] [--flag1]
examples:
  - command-name required-value
  - command-name required-value 20 --flag1
---

# Process: command-name

## Metadata
- Description: Detailed explanation of the command and its purpose
- Category: system
- Permissions: [basic]
- Author: 00reaper
- Version: 1.0.0

## Input
- parameter1: Required string parameter (required)
- parameter2: Optional number parameter, defaults to 10
- flag1: Optional boolean flag

## Output
- Structured result object with operation outcome and data

## Execution
```javascript
// Main execution function
async function execute() {
  try {
    // =========================================
    // 1. PARAMETER VALIDATION
    // =========================================
    const validationResult = validateInputs();
    if (!validationResult.valid) {
      return formatError(validationResult.error, 'VALIDATION_ERROR', validationResult.suggestions);
    }

    // Extract validated inputs
    const param1 = inputs.parameter1;
    const param2 = inputs.parameter2 || 10;  // Use default if not provided
    const useFlag = inputs.flag1 === true;

    // Log execution start
    tools.log(`Executing command with parameters: ${param1}, ${param2}, flag: ${useFlag}`);

    // =========================================
    // 2. TOOL CALL EXECUTION 
    // =========================================
    
    // Demonstrate different tool call patterns based on operation type
    const operationType = determineOperationType(param1);
    
    // Execute the appropriate operation
    let result;
    switch (operationType) {
      case 'file':
        result = await executeFileOperation(param1, param2, useFlag);
        break;
      case 'search':
        result = await executeSearchOperation(param1, param2, useFlag);
        break;
      case 'system':
        result = await executeSystemOperation(param1, param2, useFlag);
        break;
      default:
        result = await executeDefaultOperation(param1, param2, useFlag);
    }

    // =========================================
    // 3. RESULT FORMATTING 
    // =========================================
    
    // Check for partial results or warnings
    if (result.warning) {
      return formatWarning(result.message, result.data);
    }
    
    // Return successful result
    return formatSuccess(result.message, result.data);
    
  } catch (error) {
    // =========================================
    // 4. ERROR HANDLING 
    // =========================================
    
    // Log the error for diagnostic purposes
    tools.error(`Error executing command: ${error.message}`);
    
    // Determine error code and suggestions
    const errorCode = determineErrorCode(error);
    const suggestions = generateSuggestions(error, errorCode);
    
    // Return formatted error response
    return formatError(error.message, errorCode, suggestions);
  }
}

// =========================================
// INPUT VALIDATION FUNCTIONS
// =========================================

/**
 * Validate all command inputs
 * @returns {Object} Validation result with valid flag and error details
 */
function validateInputs() {
  // Check for required parameter1
  if (!inputs.parameter1) {
    return {
      valid: false,
      error: 'Missing required parameter: parameter1',
      suggestions: [
        'Provide a value for parameter1',
        'Example: > command-name value'
      ]
    };
  }
  
  // Check parameter2 type if provided
  if (inputs.parameter2 !== undefined && typeof inputs.parameter2 !== 'number') {
    // Try to convert to number if it's a string
    if (typeof inputs.parameter2 === 'string') {
      const num = Number(inputs.parameter2);
      if (!isNaN(num)) {
        inputs.parameter2 = num;  // Convert to number
      } else {
        return {
          valid: false,
          error: 'Parameter parameter2 must be a number',
          suggestions: [
            'Provide a valid number for parameter2',
            'Example: > command-name value 42'
          ]
        };
      }
    } else {
      return {
        valid: false,
        error: 'Parameter parameter2 must be a number',
        suggestions: [
          'Provide a valid number for parameter2',
          'Example: > command-name value 42'
        ]
      };
    }
  }
  
  // All validations passed
  return { valid: true };
}

// =========================================
// OPERATION TYPE DETERMINATION
// =========================================

/**
 * Determine the type of operation based on input
 * @param {string} param1 - First parameter value
 * @returns {string} Operation type
 */
function determineOperationType(param1) {
  if (param1.startsWith('/') || param1.includes('\\')) {
    return 'file';
  } else if (param1.includes('*') || param1.includes('?')) {
    return 'search';
  } else if (param1 === 'system' || param1 === 'config') {
    return 'system';
  }
  return 'default';
}

// =========================================
// OPERATION IMPLEMENTATIONS 
// =========================================

/**
 * Example file operation using tool calls
 * @param {string} param1 - Path or file identifier
 * @param {number} param2 - Numeric parameter
 * @param {boolean} useFlag - Whether to use the flag option
 * @returns {Object} Operation result
 */
async function executeFileOperation(param1, param2, useFlag) {
  try {
    // Example 1: Reading file content
    const readResult = await tools.call('read_file', {
      target_file: param1,
      should_read_entire_file: true,
      explanation: `Reading file ${param1} as part of command execution`
    });
    
    // Check for errors in the read result
    if (!readResult || !readResult.content) {
      throw new Error(`Failed to read file ${param1}`);
    }
    
    // Process the file content based on parameters
    let processedContent = readResult.content;
    
    if (useFlag) {
      // Example of conditional processing based on flag
      processedContent = processedContent.toUpperCase();
    }
    
    // Example 2: List directory if parameter is a directory
    const isDirCheck = await tools.call('list_dir', {
      relative_workspace_path: param1,
      explanation: `Checking if ${param1} is a directory`
    });
    
    // Construct the result
    const result = {
      message: `File operation completed for ${param1}`,
      data: {
        path: param1,
        isDirectory: !!isDirCheck.entries,
        contentLength: processedContent.length,
        sample: processedContent.substring(0, Math.min(100, processedContent.length))
      }
    };
    
    return result;
  } catch (error) {
    // Re-throw with more context
    throw new Error(`File operation failed: ${error.message}`);
  }
}

/**
 * Example search operation using tool calls
 * @param {string} param1 - Search query
 * @param {number} param2 - Numeric parameter (e.g., max results)
 * @param {boolean} useFlag - Whether to use the flag option (e.g., case sensitive)
 * @returns {Object} Operation result
 */
async function executeSearchOperation(param1, param2, useFlag) {
  try {
    // Example: Using grep_search
    const searchResults = await tools.call('grep_search', {
      query: param1,
      case_sensitive: useFlag,
      explanation: `Searching for pattern ${param1}`
    });
    
    // Process search results
    const processedResults = searchResults.results || []; // Assuming results format
    
    return {
      message: `Search completed. Found ${processedResults.length} matches.`,
      data: processedResults
    };
  } catch (error) {
    throw new Error(`Search operation failed: ${error.message}`);
  }
}

/**
 * Example system operation using tool calls
 * @param {string} param1 - System command or target
 * @param {number} param2 - Numeric parameter
 * @param {boolean} useFlag - Whether to use the flag option
 * @returns {Object} Operation result
 */
async function executeSystemOperation(param1, param2, useFlag) {
  try {
    // Example: Getting system status (assuming a system status tool exists)
    // This is hypothetical, replace with actual system tool calls
    // const status = await tools.call('get_system_status', { detailed: useFlag });
    
    // Placeholder result
    const status = { uptime: 12345, cpuUsage: 0.5, memory: { used: 1024, total: 2048 } }; 
    
    return {
      message: `System operation completed for ${param1}`,
      data: status
    };
  } catch (error) {
    throw new Error(`System operation failed: ${error.message}`);
  }
}

/**
 * Example default operation
 * @param {string} param1 - First parameter
 * @param {number} param2 - Second parameter
 * @param {boolean} useFlag - Flag option
 * @returns {Object} Operation result
 */
async function executeDefaultOperation(param1, param2, useFlag) {
  // Simple echo-like behavior for default
  return {
    message: `Default operation executed with: ${param1}, ${param2}, flag: ${useFlag}`,
    data: { inputParam1: param1, inputParam2: param2, inputFlag1: useFlag }
  };
}

// =========================================
// UTILITY FUNCTIONS (Formatting, Error Handling)
// =========================================

/**
 * Format a success response
 * @param {string} message - Success message
 * @param {any} data - Optional data payload
 * @returns {Object} Formatted success response
 */
function formatSuccess(message, data = null) {
  const response = {
    success: true,
    message: `✅ ${message}`
  };
  if (data !== null) {
    response.data = data;
  }
  return response;
}

/**
 * Format a warning response
 * @param {string} message - Warning message
 * @param {any} data - Optional data payload
 * @returns {Object} Formatted warning response
 */
function formatWarning(message, data = null) {
  const response = {
    success: true, // Still considered successful overall
    warning: true,
    message: `⚠️ ${message}`
  };
  if (data !== null) {
    response.data = data;
  }
  return response;
}

/**
 * Format an error response
 * @param {string} message - Error message
 * @param {string} code - Error code
 * @param {Array<string>} suggestions - Optional suggestions for recovery
 * @returns {Object} Formatted error response
 */
function formatError(message, code = 'EXECUTION_ERROR', suggestions = []) {
  let output = `❌ Error [${code}]: ${message}\n`;
  
  if (suggestions.length > 0) {
    output += "\nSuggestions:\n";
    suggestions.forEach(s => output += `- ${s}\n`);
  }
  
  return {
    success: false,
    message: output.trim(),
    errorDetails: { code, originalMessage: message }
  };
}

/**
 * Determine an appropriate error code based on the error object
 * @param {Error} error - The error object
 * @returns {string} Error code string
 */
function determineErrorCode(error) {
  // Example: Check for specific error types or messages
  if (error.message.includes('not found')) return 'NOT_FOUND';
  if (error.message.includes('permission')) return 'PERMISSION_DENIED';
  if (error.message.includes('timeout')) return 'TIMEOUT';
  // Default error code
  return 'EXECUTION_ERROR';
}

/**
 * Generate suggestions based on the error and code
 * @param {Error} error - The error object
 * @param {string} errorCode - The determined error code
 * @returns {Array<string>} List of suggestions
 */
function generateSuggestions(error, errorCode) {
  const suggestions = ['Check the command documentation using > help command-name'];
  
  switch (errorCode) {
    case 'NOT_FOUND':
      suggestions.push('Verify the file path or resource name is correct.');
      suggestions.push('Ensure the resource exists and is accessible.');
      break;
    case 'PERMISSION_DENIED':
      suggestions.push('Check if you have the necessary permissions for this operation.');
      break;
    case 'VALIDATION_ERROR':
      // Suggestions should ideally come from the validation function itself
      suggestions.push('Review the command syntax and required parameters.');
      break;
    default:
      suggestions.push('Try the command again.');
      suggestions.push('If the problem persists, check system logs or report the issue.');
      break;
  }
  
  return suggestions;
}

// Call the main execution function when the process is run
execute();

```

## Usage Examples
```
> command-name required-value
✅ Default operation executed with: required-value, 10, flag: false
```
```
> command-name required-value 20 --flag1
✅ Default operation executed with: required-value, 20, flag: true
```
```
> command-name /path/to/file.txt --flag1
✅ File operation completed for /path/to/file.txt
```

## Error Handling Examples
```
> command-name
❌ Error [VALIDATION_ERROR]: Missing required parameter: parameter1

Suggestions:
- Provide a value for parameter1
- Example: > command-name value
```
```
> command-name /nonexistent/file.txt
❌ Error [NOT_FOUND]: File operation failed: Failed to read file /nonexistent/file.txt

Suggestions:
- Check the command documentation using > help command-name
- Verify the file path or resource name is correct.
- Ensure the resource exists and is accessible.
``` 