# Message Command System Standardization

## Overview
The current message-command system needs enhancement to support multiple standard-parameter combinations and establish a strict one-to-one relationship between project-rule-parameters and message-commands. This standardization will improve system clarity and prevent potential confusion.

## Implementation Scope
This standardization effort will focus specifically on:
- **rules-workflow**: The primary workflow for cognitive architecture development
- **front-end-workflow**: The workflow for front-end application development

The scope is intentionally limited to these workflows because:
1. They are currently the only complete workflows in the system
2. Other workflows require major enhancements before standardization
3. These workflows provide a foundation for establishing patterns
4. The approach can be extended to other workflows as they mature

## Core Requirements

### 1. Parameter Loyalty Enhancement
- Each project-rule-parameter must be loyal to exactly one message-command
- Parameter loyalty must be explicitly documented in the parameter file
- Loyalty information must be validated during system operation
- Migration of shared parameters must be handled with clear alternatives

### 2. Multiple Standard-Parameter Support
- Message-commands must support multiple standard-parameter combinations
- Each combination must be clearly documented
- Required vs. optional parameters must be distinguished
- Order dependencies must be maintained and validated

### 3. Call Pattern Enforcement (NEW)
- Each project-rule-parameter must have exactly ONE valid call pattern
- Call pattern includes specific message-command and standard-parameters
- Call patterns must be explicitly documented in parameter files
- System must validate commands against the defined call patterns
- Only the exact call pattern is considered valid for a project-rule-parameter

### 4. Enhanced Cheatsheet Generation
- Cheatsheets must clearly document parameter loyalty
- Multiple parameter patterns must be shown for each message-command
- Project-rule-parameter call patterns must be explicitly documented
- Migration notes must be included for previously shared parameters

### 5. Validation System Development
- A comprehensive validation system must be developed
- System must check parameter loyalty
- System must validate standard parameter combinations
- System must enforce exact call patterns for each project-rule-parameter
- Helpful error messages must be generated for invalid patterns

## Technical Requirements

### Parameter Definition Enhancement
The parameter definition system must be enhanced to:

1. Track parameter loyalty with a loyal_to property:
```powershell
"@parameter.mdc" = @{
    "loyal_to" = "message-command"
}
```

2. Support multiple standard-parameter combinations:
```powershell
"standard-parameter-combinations" = @(
    @{
        "parameters" = @(
            @{
                "name" = "parameter1"
                "required" = $true
                "order" = 1
            }
        )
    }
)
```

3. Include explicit call pattern definitions for each project-rule-parameter:
```powershell
"call_pattern" = @{
    "message_command" = "message-command"
    "standard_parameters" = @("parameter1", "parameter2")
    "example" = "message-command: parameter1 parameter2 @parameter.mdc"
}
```

### Parameter File Documentation
Each project-rule-parameter file must include:

1. Loyalty declaration:
```markdown
## Project Rule Parameter

Loyal to: message-command: @parameters/category/parameter.mdc
```

2. Call pattern documentation:
```markdown
## Call Pattern

Message-Command: message-command
Standard-Parameters: parameter1, parameter2
Example: `message-command: parameter1 parameter2 @parameter.mdc`
```

### Cheatsheet Format Enhancement
The cheatsheet format must be enhanced to include:

1. Parameter patterns for each message-command
2. Loyalty information for each project-rule-parameter
3. Explicit call pattern for each project-rule-parameter:
```markdown
#### Project-Rule-Parameter Call Patterns

| Parameter | Valid Call Pattern |
|-----------|-------------------|
| `@parameter.mdc` | `message-command: parameter1 parameter2 @parameter.mdc` |
```

## Success Criteria

1. Implementation
- [ ] Enhanced parameter definition system with call pattern support
- [ ] Parameter validation system with one-to-one relationship enforcement
- [ ] Enhanced cheatsheet generation with call pattern documentation
- [ ] Migration tool for adding call pattern information

2. Documentation
- [ ] Updated parameter files with loyalty and call pattern information
- [ ] Enhanced cheatsheets with call pattern sections
- [ ] Implementation guide for creating new parameters with call patterns

3. Validation
- [ ] Test suite for parameter loyalty and call pattern validation
- [ ] All parameters have exactly one valid call pattern defined
- [ ] System properly validates commands against defined call patterns

## Non-Goals
This phase of standardization explicitly does NOT include:
- Standardization of back-end-workflow, documentation-workflow, or scripts-workflow
- Changes to the message-command parsing system
- Changes to the project rule parameter synchronization system
- Modification of the core message-command categories

## Current Issues
1. **Incomplete Parameter Documentation**:
   - Cheatsheets don't show all valid standard-parameter combinations
   - Example: `create-template: rules-workflow @past-chat-folder @planning-folder project-rule-parameter` has three standard-parameters but only one is documented

2. **Inconsistent Project-Rule-Parameter Usage**:
   - Some project-rule-parameters are used with multiple message-commands
   - Example: `dev-mode-{feature}` parameters are used with both `dev-mode` and `continue-implementation`

## Requirements

### 1. Project-Rule-Parameter Loyalty
- Each project-rule-parameter must be associated with exactly one message-command
- Create new project-rule-parameters for `continue-implementation` to replace usage of `dev-mode-{feature}`
- Maintain backwards compatibility during transition
- Document all project-rule-parameter to message-command relationships

### 2. Standard-Parameter Documentation
- Enhance the script Update-Cheatsheets.bat to show all valid standard-parameter combinations
- Document multiple parameter patterns for commands like `create-template`
- Include parameter order requirements in documentation
- Add validation for correct parameter ordering

### 3. Parameter Relationship Documentation
- Create clear documentation of parameter relationships
- Define valid combinations of standard-parameters and project-rule-parameters
- Document required vs optional parameters
- Include examples of all valid parameter combinations

### 4. System Enhancements
- Update parameter definition system to support multiple standard-parameter combinations
- Enhance cheatsheet generation to show all valid combinations
- Create validation system for parameter combinations
- Implement backwards compatibility checks

### 5. Migration Plan
- Create new project-rule-parameters for `continue-implementation`
- Update existing documentation to reflect new standards
- Implement validation for new parameter loyalty rules
- Provide migration guide for transitioning to new system

## Technical Specifications

### New Project-Rule-Parameters Needed
1. `continue-implementation-system-wide.mdc`
2. `continue-implementation-subsystem.mdc`
3. `continue-implementation-performance.mdc`
4. `continue-implementation-error-recovery.mdc`

### Parameter Combination Examples
```
# Multiple standard-parameters example
create-template: rules-workflow @past-chat-folder @planning-folder @template-past-chat-hallucination.mdc

# Single standard-parameter example
dev-mode: rules-workflow @dev-mode-system-wide.mdc

# No standard-parameter example
continue-implementation: @continue-implementation-system-wide.mdc
```

### Validation Requirements
1. Check project-rule-parameter loyalty to single message-command
2. Validate parameter order in commands 
3. Verify all required parameters are present
4. Ensure backwards compatibility during transition

## Implementation Impact
- **Cheatsheet Updates**: All workflow cheatsheets will need updating
- **Documentation Changes**: Parameter relationship documentation needs enhancement
- **Validation System**: New validation rules for parameter loyalty
- **Migration**: Gradual transition to new project-rule-parameters 