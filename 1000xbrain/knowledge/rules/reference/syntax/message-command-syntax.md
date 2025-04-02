# Message-Command Syntax

## Visual Syntax Structure

```
┌────────────────────────────────────────────────────────────────────┐
│                                                                    │
│   MESSAGE-COMMAND SYNTAX                                           │
│                                                                    │
│   ┌──────────────┐  ┌─────────────────┐  ┌────────────────────┐   │
│   │ message-cmd  │  │ standard-param  │  │ project-rule-param │   │
│   └──────────────┘  └─────────────────┘  └────────────────────┘   │
│         │                  │                      │                │
│         │                  │                      │                │
│         ▼                  ▼                      ▼                │
│   verify-planning: @context-file.md @verify-planning.mdc           │
│         │            │                │                            │
│         │            │                │                            │
│         │            │                └─ Must match command name   │
│         │            │                   with .mdc extension       │
│         │            │                                             │
│         │            └─ Standard parameters (target files,         │
│         │              workflow types, etc.)                       │
│         │                                                          │
│         └─ Always kebab-case (lowercase with hyphens)              │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

## Basic Format Requirements

All message-commands must adhere to these strict format requirements:

1. **Kebab-Case Format**: All message-commands must use kebab-case (lowercase words separated by hyphens)
   - CORRECT: `plan-mode: rules-workflow` 
   - INCORRECT: `planMode: rules-workflow`
   - INCORRECT: `plan_mode: rules-workflow`

2. **Lowercase Requirement**: All message-commands must be entirely lowercase
   - CORRECT: `dev-mode: front-end-workflow`
   - INCORRECT: `Dev-Mode: front-end-workflow`

3. **Colon Separator**: When using parameters, message-commands must include a colon separator
   - CORRECT: `verify-planning: @verify-planning.mdc`
   - INCORRECT: `verify-planning @verify-planning.mdc`

4. **No Brackets Around Parameters**: Parameters must not be enclosed in brackets
   - CORRECT: `dev-mode: typescript`
   - INCORRECT: `dev-mode: [typescript]`

5. **Space-Separated Multiple Parameters**: Multiple parameters must be separated by spaces
   - CORRECT: `add-logs: file1.ts file2.ts @add-logs.mdc`
   - INCORRECT: `add-logs: file1.ts, file2.ts @add-logs.mdc`

## Syntax Cheat Sheet

| Element | Format | Example | Notes |
|---|-----|---|----|
| message-command | kebab-case, lowercase | `verify-planning` | Always first element |
| separator | colon `:` | `verify-planning:` | Required before parameters |
| standard-parameter | varies by parameter | `file1.ts` | Direct value after colon |
| multiple standard-parameters | space-separated | `file1.ts file2.ts` | No comma or other separator |
| project-rule-parameter | `@name.mdc` | `@verify-planning.mdc` | Must match message-command name |
| full command | command: param(s) @rule | `verify-planning: @verify-planning.mdc` | Complete syntax |

## Three-Command System

The simplified three-command system focuses entirely on mode:

1. **plan-mode**: For planning and documentation
   - Format: `plan-mode: workflow-type @optional-template.mdc`
   - Example: `plan-mode: rules-workflow @template-basic.mdc`

2. **dev-mode**: For code implementation
   - Format: `dev-mode: workflow-type @optional-strategy.mdc`
   - Example: `dev-mode: front-end-workflow @log-based-implementation.mdc`

3. **direct-mode**: For immediate implementation
   - Format: `direct-mode: workflow-type @optional-strategy.mdc`
   - Example: `direct-mode: front-end-workflow @direct-implementation.mdc`

## Parameter System

### Parameter Types and Format

1. **Standard Parameters**:
   - Specified directly after the message-command and colon
   - No special formatting required
   - Multiple values separated by spaces
   - Example: `dev-mode: typescript`

2. **Project Rule Parameters**:
   - Always prefixed with the `@` symbol
   - Must match the message-command name with .mdc extension
   - Always appears at the end of the command
   - Example: `verify-planning: @verify-planning.mdc`

### Complex Parameter Combinations

Parameters can be combined in complex ways to provide precise instructions:

| Parameter Combination | Syntax | Example |
|-----|-----|---|
| Single standard parameter | `command: param` | `plan-mode: rules-workflow` |
| Multiple standard parameters | `command: param1 param2` | `add-logs: file1.ts file2.ts` |
| Single project-rule parameter | `command: @command.mdc` | `verify-planning: @verify-planning.mdc` |
| Standard + project-rule parameters | `command: param @command.mdc` | `verify-official-documentation: api-docs.md @verify-official-documentation.mdc` |
| Multiple standard + project-rule | `command: param1 param2 @command.mdc` | `add-logs: file1.ts file2.ts @add-logs.mdc` |

### Special Characters in Parameters

When parameters contain special characters:

| Special Character | Handling | Example |
|----|----|---|
| Spaces in file paths | Wrap with quotes | `verify-file: "path with spaces.md"` |
| Multiple lines | Not allowed | N/A - Use multiple commands instead |
| Special symbols (*, ?, etc.) | Escape when needed | `search-pattern: \*.tsx` |
| Multiple quoted parameters | Space separate | `verify-files: "file one.js" "file two.js"` |

## Parameter Notation

- **Colon Separator**: The `:` character separates the message-command from parameters
- **Space Delimiter**: Multiple parameters are separated by spaces
- **@ Symbol**: Used to designate Project Rule parameters or documentation references
- **Parameter Order**: Typically follows `message-command: standard-parameter @project-rule-parameter.mdc`

## Project-Rule-Parameter Header System

Each project-rule-parameter file includes a standardized header:

```
# workflow: rules-workflow | pathway: error-recovery | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-path: parameters/rules/dev-mode/continue-implementation-error-recovery.mdc
```

This header includes:
- **workflow**: The workflow type this parameter is designed for
- **pathway**: The specific use-case pathway
- **message-command**: The associated message-command
- **standard-parameter(s)**: Required standard parameters
- **project-rule-parameter-path**: Full path to the parameter file 