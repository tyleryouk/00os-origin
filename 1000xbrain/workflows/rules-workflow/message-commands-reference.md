# Message Commands Reference for Rules Workflow - DEPRECATED

> **IMPORTANT NOTICE**: This centralized message command reference has been deprecated in favor of the new project-rule-parameter header system. Please refer to the header in each individual project-rule-parameter file for command information.

## Deprecation Notice

The centralized reference for rules-workflow message-commands has been replaced by a self-documenting header system directly in each project-rule-parameter file. This approach:

1. Makes each project-rule-parameter self-describing
2. Eliminates the need for centralized tracking
3. Ensures information is always up-to-date
4. Reduces the risk of inconsistencies
5. Improves maintainability

## Project-Rule-Parameter Header Format

Each project-rule-parameter now contains a standardized header with comprehensive classification information:

```
# workflow: rules-workflow | pathway: error-recovery | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-path: parameters/rules/dev-mode/continue-implementation-error-recovery.mdc
```

## Header Components

The standardized header includes:

- **workflow**: The workflow type this parameter is designed for (e.g., rules-workflow)
- **pathway**: The specific use-case pathway (e.g., error-recovery)
- **message-command**: The associated message-command (e.g., dev-mode)
- **standard-parameter(s)**: Required standard parameters (or "none" if not applicable)
- **project-rule-parameter-path**: Full path to the parameter file

## Rules-Workflow Specific Migration

For rules-workflow specifically, all project-rule-parameters associated with this workflow will be updated to include the standardized header with "workflow: rules-workflow" in the header.

## Accessing Rules-Workflow Message-Command Information

To understand the available rules-workflow message-commands:

1. Look at the header of the specific project-rule-parameter you're using
2. Refer to the core/communication/message-commands.md file for general structure guidance
3. Use the fetch_rules tool to access rules-workflow specific patterns:

```typescript
fetch_rules(["knowledge/patterns/tool/command-patterns"], 
           "Understanding rules-workflow message-command patterns")
```

## Basic File Format and Extension Rules

1. **Brain-Files in 1000xbrain**: Use `.md` extension for all editable source files
2. **Cursor Project Rules**: Referenced with `.mdc` extension when used as project-rule-parameters
3. **Reference Consistency**: Always use `.md` when referring to the files themselves, and `.mdc` when using them as parameters

## @ Symbol Usage Guidelines

When using message-commands with @ symbols in documentation:

1. **Always wrap in backticks**: 
   - CORRECT: `verify-planning: @parameters/rules/verify-planning.mdc`
   - INCORRECT: To use verify-planning: @parameters/rules/verify-planning.mdc

2. **Keep @ symbol references minimal**:
   - Avoid multiple @ symbols in a single paragraph
   - Use code blocks for examples with multiple @ symbols

## File Purpose

For file purpose patterns, use:
```typescript
fetch_rules(["knowledge/reference/guides/file-standards"], 
           "Understanding message-command reference standards")
```

This document provides a comprehensive reference for all message-commands used in the rules-workflow within the 1000xbrain cognitive architecture, including the direct mode transition protocol.

## Basic Message-Command Structure

For command structure patterns, use:
```typescript
fetch_rules(["knowledge/patterns/tool/basic-patterns"], 
           "Understanding basic message-command structure")
```

Rules-workflow message-commands follow this format:

```
message-command: standard-parameter
```

Or with project-rule-parameters:

```
message-command: standard-parameter `@parameters/rules/project-rule-parameter.mdc`
```

Where:
- `message-command:` is the actual command (e.g., `plan-mode:`)
- `standard-parameter` is an optional parameter that modifies the command (e.g., `rules-workflow`)
- `@parameters/rules/project-rule-parameter.mdc` is an optional project-rule-parameter that provides detailed execution instructions

## Direct Mode Transition

For mode transition patterns, use:
```typescript
fetch_rules(["knowledge/patterns/impl/implementation-patterns"], 
           "Understanding direct mode transition patterns")
```

The direct mode transition allows transitioning from plan-mode to dev-mode in a single step:

```
dev-mode: workflow-type @optional-project-rule-parameter.mdc
```

| Order | Command | Parameters | Purpose |
|-------|---------|------------|---------|
| 1 | `dev-mode: workflow-type` | Optional project rule parameters | Direct transition to implementation mode |

### Key Benefits

1. **Streamlined Transition**: Single command transition from planning to implementation
2. **Enhanced Context Retention**: Preserves planning context during transition
3. **Reduced Complexity**: Simplified workflow with fewer steps
4. **Parameter Flexibility**: Optional project rule parameters for enhanced guidance

After planning is complete and 1000xdev has sent the `planning-document-complete` message-command, Tyler initiates the direct transition to Developer Mode with:

```
dev-mode: rules-workflow @optional-project-rule-parameter.mdc
```

## Key Message-Commands by Mode

For mode-specific patterns, use:
```typescript
fetch_rules(["knowledge/patterns/impl/basic-patterns"], 
           "Understanding mode-specific message-commands")
```

### Plan-Mode Message-Commands

| Message-Command | Standard-Parameter | Project-Rule-Parameter | Purpose |
|-----------------|-------------------|---------|---------|
| `create-template:` | `rules-workflow` | Required: `@parameters/rules/plan-mode/template-basic.mdc` or `@parameters/rules/plan-mode/template-advanced.mdc` or `@parameters/rules/helpers/analysis/template-hallucination.mdc` | Generate initial requirements.md content |
| `plan-mode:` | `rules-workflow` | Required: Pathway-specific parameter | Initialize planning mode with specific enhancement focus |
| `plan-mode:` | `rules-workflow` | Required: `@parameters/rules/plan-mode/subsystem-enhancement.mdc` | Initialize subsystem enhancement planning |
| `plan-mode:` | `rules-workflow` | Required: `@parameters/rules/plan-mode/error-recovery.mdc` | Initialize error recovery planning |
| `plan-mode:` | `rules-workflow` | Required: `@parameters/rules/plan-mode/performance-optimization.mdc` | Initialize performance optimization planning |
| `plan-mode:` | `rules-workflow` | Required: `@parameters/rules/plan-mode/system-wide-enhancement.mdc` | Initialize system-wide enhancement planning |
| `plan-mode:` | `rules-workflow` | Optional: `@parameters/rules/plan-mode/template-basic.mdc` | Initialize planning with basic template |
| `plan-mode:` | `rules-workflow` | Optional: `@parameters/rules/plan-mode/template-advanced.mdc` | Initialize planning with advanced template |
| `continue-planning:` | None | Required: `@parameters/rules/plan-mode/continue-planning.mdc` | Continue creating planning files |
| `verify-planning:` | None | Required: `@parameters/rules/helpers/verification/verify-planning.mdc` | Verify planning folder completeness |
| `planning-document-complete` | None | None | Signal planning is complete |

### Dev-Mode Message-Commands

| Message-Command | Standard-Parameter | Project-Rule-Parameter | Purpose |
|-----------------|-------------------|---------|---------|
| `dev-mode:` | `rules-workflow` | Use pathway-specific parameters | Initialize developer mode |
| `dev-mode:` | `rules-workflow` | Optional: `@parameters/rules/dev-mode/subsystem-enhancement.mdc` | Initialize subsystem enhancement development |
| `dev-mode:` | `rules-workflow` | Optional: `@parameters/rules/dev-mode/error-recovery.mdc` | Initialize error recovery development |
| `dev-mode:` | `rules-workflow` | Optional: `@parameters/rules/dev-mode/performance-optimization.mdc` | Initialize performance optimization development |
| `dev-mode:` | `rules-workflow` | Optional: `@parameters/rules/dev-mode/system-wide-enhancement.mdc` | Initialize system-wide enhancement development |
| `continue-implementation:` | None | Required: `@parameters/rules/dev-mode/continue-implementation.mdc` | Continue implementation process |
| `implementation-status` | None | None | Request current implementation status |
| `implementation-complete` | None | None | Signal implementation completion |

### Direct-Mode Message-Commands

| Message-Command | Standard-Parameter | Project-Rule-Parameter | Purpose |
|-----------------|-------------------|---------|---------|
| `direct-mode:` | `rules-workflow` | Optional: `@parameters/rules/direct-mode/direct-implementation.mdc` | Bypass planning and initialize direct implementation |
| `direct-mode:` | `rules-workflow` | Optional: `@parameters/rules/direct-mode/context-first-implementation.mdc` | Initialize with context-focused direct implementation |
| `direct-mode:` | `rules-workflow` | Optional: `@parameters/rules/direct-mode/direct-mode-subsystem.mdc` | Specialized direct implementation for subsystems |
| `direct-mode:` | `rules-workflow` | Optional: `@parameters/rules/direct-mode/direct-mode-system-wide.mdc` | Specialized direct implementation for system-wide changes |
| `continue-implementation:` | None | Optional: `@parameters/rules/helpers/recovery/direct-implementation-continuation.mdc` | Continue direct implementation process |

## Message-Command Validation Requirements

For validation patterns, use:
```typescript
fetch_rules(["knowledge/patterns/tool/basic-patterns"], 
           "Understanding message-command validation requirements")
```

To ensure proper processing, all message-commands must follow these format rules:

1. **Case Sensitivity**: Always lowercase
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

5. **Valid Standard-Parameters**: Use only recognized standard-parameters
   - CORRECT: `plan-mode: rules-workflow`
   - INCORRECT: `plan-mode: unknown-workflow`

6. **Extension Requirement**: Always use .mdc extension for project-rule-parameters
   - CORRECT: `plan-mode: rules-workflow @parameters/rules/plan-mode.mdc`
   - INCORRECT: `plan-mode: rules-workflow @parameters/rules/plan-mode.md`

7. **Path Correctness**: Use correct paths for project-rule-parameters
   - CORRECT: `plan-mode: rules-workflow @parameters/rules/plan-mode.mdc`
   - INCORRECT: `plan-mode: rules-workflow @incorrect/path/plan-mode.mdc`

## Error Response Protocol

For error response patterns, use:
```typescript
fetch_rules(["knowledge/patterns/impl/basic-patterns"], 
           "Understanding error response protocols")
```

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

## @ Symbol Usage Guidelines

For symbol usage patterns, use:
```typescript
fetch_rules(["knowledge/reference/guides/terminology-standards"], 
           "Understanding @ symbol usage guidelines")
```

When using message-commands with @ symbols in documentation:

1. **Always wrap in backticks**: 
   - CORRECT: `verify-planning: @parameters/rules/verify-planning.mdc`
   - INCORRECT: To use verify-planning: @parameters/rules/verify-planning.mdc

2. **Keep @ symbol references minimal**:
   - Avoid multiple @ symbols in a single paragraph
   - Use code blocks for examples with multiple @ symbols
   - Place necessary cross-references at the beginning of files

## File Extension Requirements

For extension standards, use:
```typescript
fetch_rules(["knowledge/reference/guides/file-standards"], 
           "Understanding file extension requirements")
```

The automatic synchronization system requires careful attention to file extensions:

1. **Brain-Files in 1000xbrain**: Use `.md` extension for all editable source files
2. **Cursor Project Rules**: Referenced with `.mdc` extension when used as project-rule-parameters
3. **Reference Consistency**: Always use `.md` when referring to the files themselves, and `.mdc` when using them as parameters

This distinction is critical as the automatic synchronization process maintains the link between these parallel versions.

## Automatic Synchronization

For synchronization patterns, use:
```typescript
fetch_rules(["knowledge/reference/architecture/brain-files-cursor-rules"], 
           "Understanding automatic synchronization process")
```

The 1000xbrain cognitive architecture features automatic synchronization:

1. Edits to `.md` files in the 1000xbrain directory are automatically synchronized to corresponding `.mdc` Cursor Project Rules
2. This creates a direct cognitive link between editable brain-files and operational Project Rules
3. No manual synchronization steps are required
4. README.md files are excluded from synchronization as they serve only as navigation aids

## Extended Message-Command Examples

For example patterns, use:
```typescript
fetch_rules(["knowledge/patterns/tool/command-patterns"], 
           "Understanding extended message-command examples")
```

### Planning Mode Examples

```
# Generate requirements content with basic template
create-template: rules-workflow @parameters/rules/plan-mode/template-basic.mdc

# Generate detailed requirements content with advanced template
create-template: rules-workflow @parameters/rules/plan-mode/template-advanced.mdc

# Subsystem enhancement planning (after requirements.md is created)
plan-mode: rules-workflow @parameters/rules/plan-mode/subsystem-enhancement.mdc

# Advanced template with performance optimization
plan-mode: rules-workflow @parameters/rules/plan-mode/performance-optimization.mdc @parameters/rules/plan-mode/template-advanced.mdc

# Continue planning process
continue-planning: @parameters/rules/plan-mode/continue-planning.mdc

# Verify planning completeness
verify-planning: @parameters/rules/helpers/verification/verify-planning.mdc

# Signal planning completion
planning-document-complete
```

### Developer Mode Examples

```
# Basic development initialization
dev-mode: rules-workflow

# Subsystem enhancement development
dev-mode: rules-workflow @parameters/rules/dev-mode/subsystem-enhancement.mdc

# Continue implementation
continue-implementation: @parameters/rules/dev-mode/continue-implementation.mdc

# Check implementation status
implementation-status

# Signal implementation completion
implementation-complete
```