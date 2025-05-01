# 00OS Command Standards Core

## Essential Standards

1. **Command Processing Flow**
   - Detect command prefix (`>`)
   - Fetch process rule (MANDATORY)
   - Parse parameters
   - Execute tool calls
   - Format response

2. **Tool Call Requirements**
   - ALWAYS use `fetch_rules` first
   - NEVER execute 00OS commands via terminal
   - Include clear explanations
   - Handle errors with suggestions

3. **Response Format**
   - ✅ Success
   - ❌ Error
   - ⚠️ Warning

## Command Structure

```yaml
---
name: command-name       # Required: Command identifier
description: Brief desc  # Required: Short explanation
version: 1.0.0          # Required: Semantic version
author: 00reaper        # Required: Author ID
category: system        # Required: system/tools/apps
permissions: [basic]    # Required: Permission list
inputs:                 # Required: Arguments/flags
  - name: param
    type: string       # string/number/boolean/array/object
    required: true     # Required flag
    default: null      # Default value
    description: desc  # Parameter description
outputs:               # Required: Output definition
  - name: result
    type: string
    description: desc
---
```

## Implementation Rules

1. **Process Location**: `/00os/processes/{category}/{command}.md`
2. **Naming**: Lowercase with hyphens (e.g., `file-list.md`)
3. **Categories**: 
   - `system/`: Core commands
   - `00reaper/`: Admin commands
   - `1000xdev/`: Dev commands

4. **Error Handling**:
   ```javascript
   try {
     // Tool calls
   } catch (error) {
     return {
       success: false,
       error: error.message,
       suggestions: ['Helpful suggestion 1', 'Helpful suggestion 2']
     };
   }
   ```

5. **Response Format**:
   ```javascript
   // Success
   return {
     success: true,
     result: data,
     message: 'Operation completed'
   };

   // Error
   return {
     success: false,
     error: 'Error message',
     code: 'ERROR_CODE',
     suggestions: ['Suggestion 1', 'Suggestion 2']
   };
   ```

## Best Practices

1. **Tool Call Optimization**
   - Minimize number of calls
   - Prefer larger reads over multiple small ones
   - Include clear explanations

2. **Parameter Validation**
   - Check required parameters
   - Validate parameter types
   - Provide helpful error messages

3. **Documentation**
   - Include usage examples
   - Document error scenarios
   - Reference related commands

4. **Testing**
   - Test with various inputs
   - Verify error handling
   - Check response format 