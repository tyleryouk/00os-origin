# USE WHEN validating message commands, implementing command processing, or troubleshooting command errors

# Message Command Validation Patterns

## Overview

This document provides implementation patterns for validating message-commands in the 1000xbrain cognitive architecture, ensuring that all commands follow the required syntax and format rules. These patterns help maintain consistency and prevent errors in command processing.

## Key Validation Patterns

### Pattern 1: Basic Format Validation

This pattern validates the fundamental format requirements for all message-commands.

#### Implementation

1. **Check Command Format**: Verify that the message-command follows the basic format of `command: parameter`
2. **Verify Colon Presence**: Ensure the command includes a colon separator
3. **Check Command Case**: Verify the command is in kebab-case (lowercase with hyphens)
4. **Verify Space After Colon**: Ensure there's a space after the colon before parameters

#### Usage Context

Use this pattern for initial validation of all message-commands before processing specific parameters.

#### Example

```javascript
function validateBasicFormat(command) {
  // Check for colon presence
  if (!command.includes(':')) {
    return { valid: false, error: 'Missing colon separator' };
  }
  
  // Split into command and parameters
  const [cmd, params] = command.split(':');
  
  // Check command case (kebab-case)
  if (cmd !== cmd.toLowerCase() || /[^a-z0-9-]/.test(cmd)) {
    return { valid: false, error: 'Command must be lowercase kebab-case' };
  }
  
  // Check space after colon
  if (params && params.charAt(0) !== ' ') {
    return { valid: false, error: 'Must include space after colon' };
  }
  
  return { valid: true };
}
```

### Pattern 2: Parameter Validation

This pattern validates parameters based on their type and format requirements.

#### Implementation

1. **Identify Parameter Types**: Distinguish between standard parameters and project-rule-parameters
2. **Validate Standard Parameters**: Check format, case, and recognize valid options
3. **Validate Project-Rule-Parameters**: Check format, extension, and path correctness
4. **Verify Parameter Order**: Ensure project-rule-parameters appear at the end

#### Usage Context

Use this pattern after basic format validation to ensure parameter correctness.

#### Example

```javascript
function validateParameters(parameters) {
  // Trim leading space
  parameters = parameters.trim();
  
  // Split parameters by space
  const paramList = parameters.split(' ').filter(p => p.length > 0);
  
  // Check standard parameters (those without @ prefix)
  const standardParams = paramList.filter(p => !p.startsWith('@'));
  for (const param of standardParams) {
    // Verify kebab-case
    if (param !== param.toLowerCase() || /[^a-z0-9-]/.test(param)) {
      return { valid: false, error: `Standard parameter '${param}' must be lowercase kebab-case` };
    }
    
    // Verify it's a recognized parameter
    if (!isRecognizedParameter(param)) {
      return { valid: false, error: `Unrecognized parameter: ${param}` };
    }
  }
  
  // Check project-rule-parameters (those with @ prefix)
  const projectParams = paramList.filter(p => p.startsWith('@'));
  
  // Ensure project-rule-parameters appear at the end
  const lastStandardIndex = paramList.findLastIndex(p => !p.startsWith('@'));
  const firstProjectIndex = paramList.findIndex(p => p.startsWith('@'));
  if (lastStandardIndex > firstProjectIndex && firstProjectIndex !== -1) {
    return { valid: false, error: 'Project-rule-parameters must appear at the end' };
  }
  
  for (const param of projectParams) {
    // Verify extension is .mdc
    if (!param.endsWith('.mdc')) {
      return { valid: false, error: `Project-rule-parameter must use .mdc extension: ${param}` };
    }
    
    // Verify path format
    if (!/^@parameters\/rules\/[a-z0-9-/]+\.mdc$/.test(param)) {
      return { valid: false, error: `Invalid project-rule-parameter path format: ${param}` };
    }
    
    // Verify parameter exists
    if (!parameterExists(param)) {
      return { valid: false, error: `Project-rule-parameter not found: ${param}` };
    }
  }
  
  return { valid: true };
}
```

### Pattern 3: Command-Specific Validation

This pattern validates specific requirements based on the command type.

#### Implementation

1. **Identify Command Type**: Determine which command is being processed
2. **Apply Command-Specific Rules**: Check for required parameters for each command
3. **Verify Parameter Compatibility**: Ensure parameters are compatible with the command
4. **Check Required Parameters**: Verify all required parameters are present

#### Usage Context

Use this pattern after basic format and parameter validation to ensure command-specific correctness.

#### Example

```javascript
function validateCommandSpecific(command, parameters) {
  // Split parameters
  const paramList = parameters.trim().split(' ').filter(p => p.length > 0);
  
  switch (command) {
    case 'plan-mode':
      // Require workflow parameter
      if (paramList.length === 0 || !isWorkflowType(paramList[0])) {
        return { valid: false, error: 'plan-mode requires a valid workflow type' };
      }
      break;
      
    case 'dev-mode':
      // Require workflow parameter
      if (paramList.length === 0 || !isWorkflowType(paramList[0])) {
        return { valid: false, error: 'dev-mode requires a valid workflow type' };
      }
      break;
      
    case 'direct-mode':
      // Require workflow parameter
      if (paramList.length === 0 || !isWorkflowType(paramList[0])) {
        return { valid: false, error: 'direct-mode requires a valid workflow type' };
      }
      break;
      
    case 'verify-planning':
      // Require project-rule-parameter
      if (paramList.length === 0 || !paramList[0].startsWith('@')) {
        return { valid: false, error: 'verify-planning requires a project-rule-parameter' };
      }
      break;
      
    // Add other commands as needed
  }
  
  return { valid: true };
}
```

### Pattern 4: Error Response Generation

This pattern generates standardized error responses when validation fails.

#### Implementation

1. **Identify Error Type**: Determine the specific validation failure
2. **Generate Clear Error Message**: Create a clear, actionable error message
3. **Provide Corrected Format**: Show the correct format as an example
4. **Include Guidance**: Add brief explanation of the requirement

#### Usage Context

Use this pattern when validation fails to provide helpful feedback.

#### Example

```javascript
function generateErrorResponse(command, error) {
  let response = `I cannot process this message-command as it's incorrect. ${error}\n\n`;
  
  // Add example of correct format
  switch (true) {
    case error.includes('kebab-case'):
      response += 'Correct format: plan-mode: rules-workflow\n\n';
      response += 'Please resubmit using the lowercase kebab-case format.';
      break;
      
    case error.includes('missing colon'):
      response += 'Correct format: plan-mode: rules-workflow\n\n';
      response += 'Please include a colon after the command name.';
      break;
      
    case error.includes('.mdc extension'):
      response += 'Correct format: plan-mode: rules-workflow @parameters/rules/plan-mode/template-basic.mdc\n\n';
      response += 'Please use .mdc extension for project-rule-parameters.';
      break;
      
    // Add other error types
      
    default:
      response += 'Please review the message-command format and try again.';
  }
  
  return response;
}
```

## Implementation Strategy

To implement comprehensive message-command validation, follow this sequence:

1. **Basic Validation First**: Start with basic format validation
2. **Parameter Validation Second**: Proceed to parameter validation
3. **Command-Specific Validation Last**: Finally, perform command-specific validation
4. **Clear Error Responses**: Generate helpful error responses for any failures

## Message-Command Validation Rules

The following validation rules should be applied to all message-commands:

### 1. Format Rules

1. **Kebab-Case Format**: All message-commands must use kebab-case (lowercase words separated by hyphens)
   - CORRECT: `verify-planning:`
   - INCORRECT: `Verify-Planning:`

2. **Colon Requirement**: Always include colon after message-command
   - CORRECT: `verify-planning:`
   - INCORRECT: `verify-planning`

3. **Space After Colon**: Always include space after colon when parameters follow
   - CORRECT: `dev-mode: rules-workflow`
   - INCORRECT: `dev-mode:rules-workflow`

4. **No Brackets**: Never use brackets around parameters
   - CORRECT: `dev-mode: rules-workflow`
   - INCORRECT: `dev-mode: [rules-workflow]`

### 2. Parameter Rules

1. **Valid Standard-Parameters**: Use only recognized standard-parameters
   - CORRECT: `plan-mode: rules-workflow`
   - INCORRECT: `plan-mode: unknown-workflow`

2. **Extension Requirement**: Always use .mdc extension for project-rule-parameters
   - CORRECT: `plan-mode: rules-workflow @parameters/rules/plan-mode/template-basic.mdc`
   - INCORRECT: `plan-mode: rules-workflow @parameters/rules/plan-mode/template-basic.md`

3. **Path Correctness**: Use correct paths for project-rule-parameters
   - CORRECT: `plan-mode: rules-workflow @parameters/rules/plan-mode/template-basic.mdc`
   - INCORRECT: `plan-mode: rules-workflow @incorrect/path/plan-mode/template-basic.mdc`

4. **Parameter Order**: Project-rule-parameters must appear after standard parameters
   - CORRECT: `plan-mode: rules-workflow @parameters/rules/plan-mode/template-basic.mdc`
   - INCORRECT: `plan-mode: @parameters/rules/plan-mode/template-basic.mdc rules-workflow`

### 3. Command-Specific Rules

1. **Workflow Commands**: Must include a valid workflow type
   - CORRECT: `plan-mode: rules-workflow`
   - INCORRECT: `plan-mode:`

2. **Project-Rule-Parameter Commands**: Must include a valid project-rule-parameter
   - CORRECT: `verify-planning: @parameters/rules/helpers/verification/verify-planning.mdc`
   - INCORRECT: `verify-planning:`

3. **Completion Signals**: Must not include additional parameters
   - CORRECT: `planning-document-complete`
   - INCORRECT: `planning-document-complete: extra-parameter`

## Error Response Protocol

When a message-command fails validation, respond with:

1. **Error Identification**: Clearly state that the message-command is invalid
2. **Error Explanation**: Explain specifically what is incorrect
3. **Correction Suggestion**: Provide the correct format
4. **Example**: Demonstrate the correct usage

Example error response:

```
I cannot process this message-command as it's incorrect. The format "Plan-Mode: rules-workflow" uses incorrect case.

Correct format: plan-mode: rules-workflow

Please resubmit using the lowercase kebab-case format.
```

## Related Patterns

- Message Command Syntax: `knowledge/rules/reference/syntax/message-command-syntax`
- Parameter Syntax: `knowledge/rules/reference/syntax/parameter-syntax`
- Message Command Examples: `knowledge/rules/reference/examples/message-command-examples`
- Symbol Usage: `knowledge/rules/patterns/communication/symbol-usage`

## Conclusion

Effective message-command validation ensures clear communication and proper execution of commands in the 1000xbrain cognitive architecture. By implementing these validation patterns, you can prevent errors and maintain consistency in command processing. 