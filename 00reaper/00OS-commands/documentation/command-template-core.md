---
name: command-name
description: Brief command description
version: 1.0.0
author: 00reaper
category: system
permissions: [basic]
inputs:
  - name: param1
    type: string
    required: true
    description: First parameter
  - name: flag1
    type: boolean
    required: false
    default: false
    description: Optional flag
outputs:
  - name: result
    type: object
    description: Command result
usage: command-name <param1> [--flag1]
examples:
  - command-name value
  - command-name value --flag1
---

# Process: command-name

## Description
Brief explanation of command purpose and functionality.

## Implementation
```javascript
async function execute() {
  try {
    // 1. Validate Inputs
    if (!inputs.param1) {
      return {
        success: false,
        error: 'Missing required parameter: param1',
        suggestions: ['Provide a value for param1']
      };
    }

    // 2. Execute Tool Calls
    const result = await executeOperation(inputs.param1, inputs.flag1);
    
    // 3. Return Result
    return {
      success: true,
      result: result,
      message: 'Operation completed successfully'
    };

  } catch (error) {
    return {
      success: false,
      error: error.message,
      suggestions: generateSuggestions(error)
    };
  }
}

async function executeOperation(param1, useFlag) {
  // Implement operation logic here
  // Use appropriate tool calls with clear explanations
  return { /* operation result */ };
}

function generateSuggestions(error) {
  // Generate helpful suggestions based on error
  return [
    'Check parameter values',
    'Verify permissions',
    'See documentation for usage examples'
  ];
}
```

## Usage Examples
```
> command-name value
✅ Operation completed successfully

> command-name value --flag1
✅ Operation completed with flag enabled

> command-name
❌ Error: Missing required parameter: param1
Suggestions:
- Provide a value for param1
``` 