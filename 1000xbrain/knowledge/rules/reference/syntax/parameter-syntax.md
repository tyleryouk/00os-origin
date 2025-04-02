# USE WHEN defining parameter syntax, documenting parameter formats, or troubleshooting parameter issues

# Parameter Syntax Reference

## Overview

This reference document details the syntax requirements for parameters used with message-commands in the 1000xbrain cognitive architecture, including standard parameters and project-rule-parameters.

## Parameter Types

The 1000xbrain cognitive architecture supports two distinct parameter types:

### 1. Standard Parameters

Standard parameters modify the behavior of message-commands and have these characteristics:

- Specified directly after the message-command and colon
- No special formatting required
- Multiple values can be separated by spaces
- Used for workflow selection, mode specification, and simple options

**Format:**
```
message-command: standard-parameter
```

**Examples:**
```
plan-mode: rules-workflow
dev-mode: front-end-workflow
direct-mode: back-end-workflow
```

### 2. Project-Rule-Parameters

Project-rule-parameters provide detailed implementation instructions and have these characteristics:

- Always prefixed with the `@` symbol
- Must reference a valid file path with .mdc extension
- Always appears at the end of the command
- Used to specify detailed implementation strategies or templates

**Format:**
```
message-command: standard-parameter @parameters/rules/project-rule-parameter.mdc
```

**Examples:**
```
plan-mode: rules-workflow @parameters/rules/plan-mode/template-basic.mdc
dev-mode: rules-workflow @parameters/rules/dev-mode/subsystem-enhancement.mdc
verify-planning: @parameters/rules/helpers/verification/verify-planning.mdc
```

## Parameter Format Requirements

### Standard Parameter Requirements

1. **Kebab-Case Format**: All standard parameters must use kebab-case (lowercase words separated by hyphens)
   - CORRECT: `rules-workflow` 
   - INCORRECT: `rulesWorkflow`

2. **Lowercase Requirement**: All standard parameters must be entirely lowercase
   - CORRECT: `front-end-workflow`
   - INCORRECT: `Front-End-Workflow`

3. **No Special Characters**: Standard parameters should not contain special characters
   - CORRECT: `back-end-workflow`
   - INCORRECT: `back_end_workflow!`

4. **Space Separation**: Multiple standard parameters must be separated by spaces
   - CORRECT: `parameter1 parameter2 parameter3`
   - INCORRECT: `parameter1, parameter2, parameter3`

### Project-Rule-Parameter Requirements

1. **@ Symbol Prefix**: Must always begin with the @ symbol
   - CORRECT: `@parameters/rules/plan-mode/template-basic.mdc`
   - INCORRECT: `parameters/rules/plan-mode/template-basic.mdc`

2. **Path Format**: Must use forward slashes for path separation
   - CORRECT: `@parameters/rules/plan-mode/template-basic.mdc`
   - INCORRECT: `@parameters\rules\plan-mode\template-basic.mdc`

3. **File Extension**: Must always use .mdc extension
   - CORRECT: `@parameters/rules/plan-mode/template-basic.mdc`
   - INCORRECT: `@parameters/rules/plan-mode/template-basic.md`

4. **Path Correctness**: Must reference valid paths within the parameters directory
   - CORRECT: `@parameters/rules/plan-mode/template-basic.mdc`
   - INCORRECT: `@incorrect/path/plan-mode/template-basic.mdc`

5. **Position Requirement**: Must always appear at the end of the message-command
   - CORRECT: `plan-mode: rules-workflow @parameters/rules/plan-mode/template-basic.mdc`
   - INCORRECT: `plan-mode: @parameters/rules/plan-mode/template-basic.mdc rules-workflow`

## Multiple Parameter Usage

### Multiple Standard Parameters

When using multiple standard parameters:

1. **Space Separation**: Parameters are separated by spaces
2. **Order Significance**: Order of parameters may be significant
3. **Limit**: Typically limited to 2-3 parameters for clarity

**Example:**
```
message-command: parameter1 parameter2 parameter3
```

### Multiple Project-Rule-Parameters

Multiple project-rule-parameters are typically not supported in a single message-command. If multiple implementation strategies are needed, use a specialized project-rule-parameter that combines them.

## Parameter Validation Rules

For proper validation:

1. **Valid Standard Parameters**: Use only recognized standard parameters for each message-command
   - CORRECT: `plan-mode: rules-workflow`
   - INCORRECT: `plan-mode: unknown-workflow`

2. **Valid Project-Rule-Parameters**: Use only existing project-rule-parameters
   - CORRECT: `plan-mode: rules-workflow @parameters/rules/plan-mode/template-basic.mdc`
   - INCORRECT: `plan-mode: rules-workflow @parameters/rules/nonexistent-file.mdc`

3. **Parameter Compatibility**: Ensure parameters are compatible with the message-command
   - CORRECT: `plan-mode: rules-workflow @parameters/rules/plan-mode/template-basic.mdc`
   - INCORRECT: `plan-mode: rules-workflow @parameters/rules/dev-mode/error-recovery.mdc`

## File Extension Rules

The automatic synchronization system requires careful attention to file extensions:

1. **Brain-Files in 1000xbrain**: Use `.md` extension for all editable source files
2. **Cursor Project Rules**: Referenced with `.mdc` extension when used as project-rule-parameters
3. **Reference Consistency**: Always use `.md` when referring to the files themselves, and `.mdc` when using them as parameters

This distinction is critical as the automatic synchronization process maintains the link between these parallel versions.

## @ Symbol Usage Guidelines

When using @ symbols in documentation:

1. **Always wrap in backticks**: 
   - CORRECT: `verify-planning: @parameters/rules/verify-planning.mdc`
   - INCORRECT: To use verify-planning: @parameters/rules/verify-planning.mdc

2. **Keep @ symbol references minimal**:
   - Avoid multiple @ symbols in a single paragraph
   - Use code blocks for examples with multiple @ symbols
   - Place necessary cross-references at the beginning of files

## Related References

- Message Command Syntax: `knowledge/rules/reference/syntax/message-command-syntax`
- Message Command Examples: `knowledge/rules/reference/examples/message-command-examples`
- Message Command Validation: `knowledge/rules/patterns/communication/message-command-validation`

## Conclusion

Proper parameter syntax is essential for effective message-command processing in the 1000xbrain cognitive architecture. By following these syntax requirements for standard parameters and project-rule-parameters, you ensure clear communication and proper execution of commands. 