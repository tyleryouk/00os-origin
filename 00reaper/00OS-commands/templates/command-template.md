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
 * @param {string} param1 - Search pattern
 * @param {number} param2 - Numeric parameter
 * @param {boolean} useFlag - Whether to use the flag option
 * @returns {Object} Operation result
 */
async function executeSearchOperation(param1, param2, useFlag) {
  try {
    // Example 1: Semantic search
    const semanticResults = await tools.call('codebase_search', {
      query: param1,
      explanation: `Performing semantic search for ${param1}`
    });
    
    // Example 2: Grep search for more precise pattern matching
    const grepResults = await tools.call('grep_search', {
      query: param1,
      case_sensitive: useFlag,
      explanation: `Performing grep search for ${param1} pattern`
    });
    
    // Example 3: File search for filenames
    const fileResults = await tools.call('file_search', {
      query: param1,
      explanation: `Searching for files matching ${param1}`
    });
    
    // Combine results
    const combinedResults = {
      semantic: semanticResults || {},
      grep: grepResults || {},
      files: fileResults || {}
    };
    
    // Process results based on param2 (e.g., limit number of results)
    const limitedResults = limitResults(combinedResults, param2);
    
    return {
      message: `Search completed for pattern ${param1}`,
      data: limitedResults
    };
  } catch (error) {
    throw new Error(`Search operation failed: ${error.message}`);
  }
}

/**
 * Example system operation using tool calls
 * @param {string} param1 - System component
 * @param {number} param2 - Numeric parameter
 * @param {boolean} useFlag - Whether to use the flag option
 * @returns {Object} Operation result
 */
async function executeSystemOperation(param1, param2, useFlag) {
  try {
    // Example: Run a system command safely
    const cmdResult = await tools.call('run_terminal_cmd', {
      command: `echo System operation for ${param1} | cat`,
      is_background: false,
      explanation: `Running safe system command for ${param1}`
    });
    
    // Note: NEVER use run_terminal_cmd to execute 00OS commands (with > prefix)
    // This creates infinite loops and breaks the command processing flow
    
    return {
      message: `System operation completed for ${param1}`,
      data: {
        component: param1,
        output: cmdResult?.output || '',
        exitCode: cmdResult?.exitCode
      }
    };
  } catch (error) {
    throw new Error(`System operation failed: ${error.message}`);
  }
}

/**
 * Example default operation when other types don't match
 * @param {string} param1 - First parameter
 * @param {number} param2 - Numeric parameter
 * @param {boolean} useFlag - Whether to use the flag option
 * @returns {Object} Operation result
 */
async function executeDefaultOperation(param1, param2, useFlag) {
  // Simple default operation that doesn't require tool calls
  return {
    message: `Default operation completed for ${param1}`,
    data: {
      input: param1,
      multiplier: param2,
      result: param1.repeat(param2),
      flagApplied: useFlag
    }
  };
}

// =========================================
// HELPER FUNCTIONS 
// =========================================

/**
 * Limit results based on parameter
 * @param {Object} results - Results to limit
 * @param {number} limit - Maximum number of results to include
 * @returns {Object} Limited results
 */
function limitResults(results, limit) {
  const limited = {};
  
  // Apply limit to each result type
  for (const [key, value] of Object.entries(results)) {
    if (Array.isArray(value)) {
      limited[key] = value.slice(0, limit);
    } else if (value && typeof value === 'object' && value.results && Array.isArray(value.results)) {
      limited[key] = {
        ...value,
        results: value.results.slice(0, limit)
      };
    } else {
      limited[key] = value;
    }
  }
  
  return limited;
}

/**
 * Determine error code based on error type
 * @param {Error} error - The error that occurred
 * @returns {string} Error code
 */
function determineErrorCode(error) {
  const errorMessage = error.message.toLowerCase();
  
  if (errorMessage.includes('validation') || errorMessage.includes('invalid')) {
    return 'VALIDATION_ERROR';
  } else if (errorMessage.includes('not found') || errorMessage.includes('missing')) {
    return 'NOT_FOUND_ERROR';
  } else if (errorMessage.includes('permission') || errorMessage.includes('access')) {
    return 'PERMISSION_ERROR';
  } else if (errorMessage.includes('tool call') || errorMessage.includes('function call')) {
    return 'TOOL_CALL_ERROR';
  }
  
  return 'EXECUTION_ERROR';
}

/**
 * Generate helpful suggestions based on error
 * @param {Error} error - The error that occurred
 * @param {string} errorCode - Error classification code
 * @returns {string[]} Suggestions for resolving the error
 */
function generateSuggestions(error, errorCode) {
  const suggestions = [];
  const errorMessage = error.message.toLowerCase();
  
  // Add common suggestions based on error code
  switch (errorCode) {
    case 'VALIDATION_ERROR':
      suggestions.push('Check the command syntax and parameters');
      suggestions.push('Run "> help command-name" to see usage information');
      break;
    case 'NOT_FOUND_ERROR':
      suggestions.push('Verify the file or resource path exists');
      suggestions.push('Check permissions to access the resource');
      suggestions.push('Use absolute paths for files outside the workspace');
      break;
    case 'PERMISSION_ERROR':
      suggestions.push('Check if you have the necessary permissions');
      suggestions.push('Use a different approach that requires fewer permissions');
      break;
    case 'TOOL_CALL_ERROR':
      suggestions.push('Check the tool call parameters');
      suggestions.push('Verify the resources being accessed exist');
      suggestions.push('Try an alternative approach if the tool is failing');
      break;
    default:
      suggestions.push('Check the command parameters');
      suggestions.push('Try simplifying the operation');
      suggestions.push('Check system resources and try again');
  }
  
  // Add specific suggestions based on error message content
  if (errorMessage.includes('file')) {
    suggestions.push('Verify the file path is correct');
    suggestions.push('Check if the file exists and is accessible');
  } else if (errorMessage.includes('timeout')) {
    suggestions.push('The operation may be taking too long, try with simpler parameters');
    suggestions.push('Break the operation into smaller steps');
  }
  
  return suggestions;
}

// =========================================
// RESPONSE FORMATTING FUNCTIONS
// =========================================

/**
 * Format successful response
 * @param {string} message - Success message
 * @param {any} data - Optional data to include
 * @returns {Object} Formatted response
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
 * Format warning response (success with caveats)
 * @param {string} message - Warning message
 * @param {any} data - Optional data to include
 * @returns {Object} Formatted response
 */
function formatWarning(message, data = null) {
  const response = {
    success: true,
    warning: true,
    message: `⚠️ ${message}`
  };
  
  if (data !== null) {
    response.data = data;
  }
  
  return response;
}

/**
 * Format error response
 * @param {string} message - Error message
 * @param {string} code - Error code
 * @param {string[]} suggestions - Helpful suggestions
 * @returns {Object} Formatted response
 */
function formatError(message, code = 'EXECUTION_ERROR', suggestions = []) {
  const response = {
    success: false,
    message: `❌ Error [${code}]: ${message}`
  };
  
  if (suggestions && suggestions.length > 0) {
    response.suggestions = suggestions;
  }
  
  return response;
}

// Execute the command
execute();
```

## Usage Examples

### Basic Command Usage
```
> command-name required-value
✅ Default operation completed for required-value
```

### With Optional Parameters
```
> command-name required-value 5 --flag1
✅ Default operation completed for required-value
```

### File Operation Example
```
> command-name /path/to/file.txt
✅ File operation completed for /path/to/file.txt
```

### Search Operation Example
```
> command-name pattern*
✅ Search completed for pattern pattern*
```

### Error Example
```
> command-name
❌ Error [VALIDATION_ERROR]: Missing required parameter: parameter1

Suggestions:
- Provide a value for parameter1
- Example: > command-name value
- Check the command syntax and parameters
- Run "> help command-name" to see usage information
```

## Implementation Notes

This template follows the standards defined in the command-standards.md document and demonstrates:

1. Complete YAML frontmatter with all required metadata
2. Proper parameter validation with helpful error messages
3. Different operation patterns for common tool call types
4. Standardized error handling with codes and suggestions
5. Consistent response formatting
6. Usage examples for different scenarios

To create a new command:
1. Copy this template
2. Update the metadata section
3. Modify the execution logic for your specific command
4. Implement the appropriate tool call patterns
5. Maintain all error handling and response formatting standards 