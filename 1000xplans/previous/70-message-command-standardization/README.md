# Message Command Standardization Implementation

## Overview

This planning folder contains the documentation and implementation plan for standardizing the message-command system in the PolygonExpress project. The goal is to create a more consistent, reliable, and maintainable message-command infrastructure, with initial focus on the rules-workflow and front-end-workflow.

## Implementation Scope

This standardization effort is deliberately focused on:
- **rules-workflow**: The workflow for creating and updating cognitive architecture
- **front-end-workflow**: The workflow for front-end development

These workflows were selected because:
- They are currently the only complete workflows in the system
- Other workflows still require major enhancements
- They provide a solid foundation for establishing patterns
- The standards can be extended to other workflows as they mature

## Key Components

Our implementation consists of five key components:

1. **Enhanced Parameter Definition System**: A more robust data structure that supports:
   - Multiple standard-parameter combinations
   - Parameter loyalty tracking
   - Required vs. optional parameters
   - Parameter order requirements
   - **One-to-one call pattern enforcement**

2. **Parameter Validation System**: A comprehensive validation system for:
   - Verifying parameter loyalty to message-commands
   - Validating standard parameter combinations
   - Checking parameter file loyalty declarations
   - Complete message command validation
   - **Enforcing exact call patterns for project-rule-parameters**

3. **Enhanced Cheatsheet Generation**: A more informative cheatsheet format that:
   - Displays all parameter patterns for each command
   - Shows parameter loyalty information
   - Provides comprehensive references
   - Documents parameter relationships
   - **Documents the exact call pattern for each project-rule-parameter**

4. **Migration Tool**: An automated tool that:
   - Updates existing parameter files with loyalty information
   - Generates enhanced cheatsheets
   - Validates parameter loyalty across the system
   - **Adds call pattern documentation to each parameter file**

5. **Comprehensive Testing Suite**: A set of tests that verify:
   - Parameter loyalty validation
   - Standard parameter combination validation
   - Message command validation
   - Parameter file validation
   - **Call pattern validation for one-to-one relationships**

## One-to-One Call Pattern Enforcement

A key enhancement in this standardization is establishing a strict one-to-one relationship between project-rule-parameters and their call patterns:

- Each project-rule-parameter can be used with exactly ONE message-command
- Each project-rule-parameter has exactly ONE valid combination of standard-parameters
- Each call pattern is clearly documented in the project-rule-parameter file
- Validation enforces these one-to-one relationships

### Call Pattern Documentation in Parameter Files

```markdown
## Project Rule Parameter

Loyal to: dev-mode: @parameters/rules/dev-mode-system-wide.mdc

## Call Pattern

Message-Command: dev-mode
Standard-Parameters: rules-workflow
Example: `dev-mode: rules-workflow @dev-mode-system-wide.mdc`
```

### Call Pattern Validation

```powershell
function Test-CallPattern {
    param (
        [string]$Command,
        [string]$ProjectRuleParameter
    )
    
    # Validation logic to ensure the command uses the project-rule-parameter
    # with exactly the right message-command and standard-parameters
}
```

## Key Files

- `requirements.md`: Core requirements and objectives for message-command standardization
- `context-message-command-system.md`: Technical context and architecture of the message-command system
- `implementation-message-command-standardization.md`: Detailed implementation plan and approach
- `implementation-progress.md`: Tracks implementation progress and milestones
- `test-cheatsheet.md`: Testing scenarios and enhanced format examples

## Implementation Status

Current implementation phase: In Progress
See `implementation-progress.md` for detailed status updates.

## Key Technical Enhancements

### 1. Enhanced Parameter Definition Structure with Call Patterns

```powershell
# Enhanced structure with explicit call patterns
$parameterDefinitions = @{
    "create-template" = @{
        "standard-parameter-combinations" = @(
            # Pattern 1: Simple template creation
            @{
                "parameters" = @(
                    @{
                        "name" = "workflow-type"
                        "required" = $true
                        "order" = 1
                    }
                )
            },
            # Pattern 2: Advanced template creation
            @{
                "parameters" = @(
                    @{
                        "name" = "workflow-type"
                        "required" = $true
                        "order" = 1
                    },
                    @{
                        "name" = "folder-type"
                        "required" = $true
                        "order" = 2
                    },
                    @{
                        "name" = "project-rule-parameter"
                        "required" = $true
                        "order" = 3
                    }
                )
            }
        ),
        "project-rule-parameters" = @{
            "@template-basic.mdc" = @{
                "loyal_to" = "create-template",
                "description" = "Basic template creation",
                "call_pattern" = @{
                    "message_command" = "create-template",
                    "standard_parameters" = @("workflow-type"),
                    "example" = "create-template: rules-workflow @template-basic.mdc"
                },
                "requires" = @(),
                "conflicts_with" = @(),
                "deprecated" = $false
            }
        }
    }
}
```

### 2. Parameter Loyalty and Call Pattern Declaration

Each project-rule-parameter file will include both loyalty and call pattern information:

```markdown
## Project Rule Parameter

Loyal to: continue-implementation: @parameters/rules/continue-implementation-system-wide.mdc

## Call Pattern

Message-Command: continue-implementation
Standard-Parameters: none
Example: `continue-implementation: @continue-implementation-system-wide.mdc`
```

### 3. Enhanced Cheatsheet Format with Call Patterns

```markdown
#### Project-Rule-Parameter Call Patterns

| Parameter | Valid Call Pattern | 
|-----------|-------------------|
| `@template-basic.mdc` | `create-template: workflow-type @template-basic.mdc` |
| `@template-advanced.mdc` | `create-template: workflow-type @template-advanced.mdc` |
```

## Implementation Approach

The implementation follows a systematic approach:

1. **Foundation Development**: Create enhanced data structures with call pattern support
2. **Tool Development**: Implement validation and cheatsheet generation with call pattern enforcement
3. **Migration Execution**: Update parameter files with call pattern documentation
4. **Testing and Validation**: Verify call patterns and one-to-one relationships
5. **Documentation**: Create comprehensive documentation of call patterns

For detailed implementation information, see `implementation-message-command-standardization.md`.

## Key Benefits

This standardization effort provides several key benefits:

1. **Consistency**: Ensures each project-rule-parameter is loyal to exactly one message-command
2. **Clarity**: Clearly documents all valid parameter combinations
3. **Reliability**: Validates parameters against defined relationships
4. **Predictability**: Ensures exactly one way to call each project-rule-parameter
5. **Maintainability**: Makes the system easier to understand and maintain
6. **Discoverability**: Makes it easy to find the exact way to use each parameter

## Additional Resources

For more information about the message-command system architecture and implementation details, refer to:
- `context-message-command-system.md` for system architecture
- `implementation-progress.md` for current status
- `test-cheatsheet.md` for enhanced format examples 