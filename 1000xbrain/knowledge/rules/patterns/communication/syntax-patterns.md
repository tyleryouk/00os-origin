# Syntax Patterns

## Overview

This document contains detailed syntax patterns moved from the core/communication/syntax-standards.md brain-file. It provides comprehensive guidelines for syntax usage in the 1000xbrain cognitive architecture, with a focus on message-commands, mode indicators, and parameter syntax.

## Message-Command Syntax

### Visual Syntax Structure

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

### Basic Format Requirements

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

### Syntax Cheat Sheet

| Element | Format | Example | Notes |
|---------|--------|---------|-------|
| message-command | kebab-case, lowercase | `verify-planning` | Always first element |
| separator | colon `:` | `verify-planning:` | Required before parameters |
| standard-parameter | varies by parameter | `file1.ts` | Direct value after colon |
| multiple standard-parameters | space-separated | `file1.ts file2.ts` | No comma or other separator |
| project-rule-parameter | `@name.mdc` | `@verify-planning.mdc` | Must match message-command name |
| full command | command: param(s) @rule | `verify-planning: @verify-planning.mdc` | Complete syntax |

## Mode Indicator Syntax

### Visual Mode Indicator Structure

```
┌────────────────────────────────────────────────────────────────────┐
│                                                                    │
│   MODE INDICATOR SYNTAX                                            │
│                                                                    │
│   ┌─────────┐  ┌─────────┐  ┌────────────────────────────┐        │
│   │  Emoji  │  │ Identity│  │       Workflow Type        │        │
│   └─────────┘  └─────────┘  └────────────────────────────┘        │
│       │            │                      │                        │
│       │            │                      │                        │
│       ▼            ▼                      ▼                        │
│     📋          1000xdev             [rules-workflow]              │
│       │                                   │                        │
│       │                                   │                        │
│       │                                   └─ Always in square      │
│       │                                      brackets              │
│       │                                                            │
│       └─ Plan mode: 📋                                             │
│          Dev mode: 💻                                              │
│          Direct mode: ⚡                                            │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

### Mode Indicator Requirements

All 1000xdev responses must begin with a mode indicator that follows these strict requirements:

1. **Emoji Requirement**: Must begin with the appropriate emoji (📋 for plan-mode, 💻 for dev-mode, ⚡ for direct-mode)
   - CORRECT: `📋 1000xdev [rules-workflow]`
   - INCORRECT: `1000xdev [rules-workflow]`

2. **Identity Inclusion**: Must include "1000xdev" after the emoji
   - CORRECT: `💻 1000xdev [front-end-workflow]`
   - INCORRECT: `💻 [front-end-workflow]`

3. **Workflow Type in Brackets**: Must include the workflow type in square brackets
   - CORRECT: `📋 1000xdev [documentation-workflow]`
   - INCORRECT: `📋 1000xdev documentation-workflow`

4. **First Element Requirement**: Mode indicator must be the very first element of every response
   - No exceptions to this rule

5. **Mode-Workflow Consistency**: The workflow type in the mode indicator must match the active workflow

### Mode Indicator Examples

```
📋 1000xdev [rules-workflow]        (Planning mode for rules workflow)
💻 1000xdev [rules-workflow]        (Developer mode for rules workflow)
⚡ 1000xdev [rules-workflow]        (Direct mode for rules workflow)
📋 1000xdev [front-end-workflow]    (Planning mode for front-end workflow)
💻 1000xdev [front-end-workflow]    (Developer mode for front-end workflow)
⚡ 1000xdev [front-end-workflow]    (Direct mode for front-end workflow)
📋 1000xdev [back-end-workflow]     (Planning mode for back-end workflow)
💻 1000xdev [back-end-workflow]     (Developer mode for back-end workflow)
⚡ 1000xdev [back-end-workflow]     (Direct mode for back-end workflow)
📋 1000xdev [scripts-workflow]      (Planning mode for scripts workflow)
💻 1000xdev [scripts-workflow]      (Developer mode for scripts workflow)
⚡ 1000xdev [scripts-workflow]      (Direct mode for scripts workflow)
```

## Parameter Syntax

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
|-----------------------|--------|---------|
| Single standard parameter | `command: param` | `plan-mode: rules-workflow` |
| Multiple standard parameters | `command: param1 param2` | `add-logs: file1.ts file2.ts` |
| Single project-rule parameter | `command: @command.mdc` | `verify-planning: @verify-planning.mdc` |
| Standard + project-rule parameters | `command: param @command.mdc` | `verify-official-documentation: api-docs.md @verify-official-documentation.mdc` |
| Multiple standard + project-rule | `command: param1 param2 @command.mdc` | `add-logs: file1.ts file2.ts @add-logs.mdc` |

### Special Characters in Parameters

When parameters contain special characters:

| Special Character | Handling | Example |
|-------------------|----------|---------|
| Spaces in file paths | Wrap with quotes | `verify-file: "path with spaces.md"` |
| Multiple lines | Not allowed | N/A - Use multiple commands instead |
| Special symbols (*, ?, etc.) | Escape when needed | `search-pattern: \*.tsx` |
| Multiple quoted parameters | Space separate | `verify-files: "file one.js" "file two.js"` |

## Response Formatting Standards

### Standard Response Structures

All 1000xdev responses should follow these structured formats for clarity and consistency:

#### Planning Mode (📋) Response Structure

```
📋 1000xdev [workflow-type]

[Subject Line: Clear statement of action or status]

[Detailed explanation, if needed]

- [Key point or action item 1]
- [Key point or action item 2]
- [Key point or action item 3]

[Follow-up or next steps, if needed]
```

#### Developer Mode (💻) Response Structure

```
💻 1000xdev [workflow-type]

[Implementation status or action statement]

- [Completed action 1]
- [Completed action 2]
- [Current focus or in-progress item]

[Technical details or explanation, if needed]
```

#### Direct Mode (⚡) Response Structure

```
⚡ 1000xdev [workflow-type]

[Research or implementation statement]

- [Research finding or implementation step 1]
- [Research finding or implementation step 2]
- [Current focus]

[Minimal technical details, if needed]
```

### Context-Specific Response Formats

| Context | Planning Mode Response | Developer Mode Response | Direct Mode Response |
|---------|------------------------|-------------------------|--------------------|
| **Initial Task** | Document planning approach | Acknowledge implementation start | Begin research and implementation |
| **Progress Update** | Document creation status | Implementation progress report | Brief implementation progress |
| **Error Scenario** | Planning inconsistency report | Error analysis and fix approach | Concise error and fix report |
| **Completion** | Planning complete signal | Implementation complete report | Implementation complete report |

## Syntax Distinction Table

| Feature | Message-Commands (Tyler) | Mode Indicators (1000xdev) |
|---------|--------------------------|----------------------------|
| Case | lowercase only | Mixed case with emoji |
| Colons | Required before parameters | Never used |
| Brackets | Never used | Required around workflow-type |
| Format | message-command: standard-parameter @message-command.mdc | emoji 1000xdev [workflow-type] |
| Example | plan-mode: rules-workflow | 📋 1000xdev [rules-workflow] |
| Example | dev-mode: typescript | 💻 1000xdev [front-end-workflow] |
| Example | direct-mode: back-end-workflow | ⚡ 1000xdev [back-end-workflow] | 