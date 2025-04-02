# Communication Syntax Standards

## Overview

This document provides essential syntax standards for communication between Tyler and 1000xdev. For detailed patterns and comprehensive examples, refer to the knowledge files referenced below.

## Knowledge Access

For comprehensive syntax documentation, access these knowledge components:

```typescript
// For message-command syntax details
fetch_rules(["knowledge/rules/reference/syntax/message-command-syntax"], 
           "Understanding detailed message-command syntax")

// For mode indicator syntax details
fetch_rules(["knowledge/rules/reference/syntax/mode-indicator-syntax"], 
           "Understanding mode indicator syntax requirements")
```

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

## Basic Format Requirements

All message-commands must adhere to these strict format requirements:

1. **Kebab-Case Format**: All message-commands must use kebab-case (lowercase words separated by hyphens)
   - CORRECT: `plan-mode: rules-workflow` 
   - INCORRECT: `planMode: rules-workflow`

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

## Mode Indicator Requirements

All 1000xdev responses must begin with a mode indicator that follows these strict requirements:

1. **Emoji Requirement**: Must begin with the appropriate emoji (📋 for plan-mode, 💻 for dev-mode, ⚡ for direct-mode)
   - CORRECT: `📋 1000xdev [rules-workflow]`
   - INCORRECT: `1000xdev [rules-workflow]`

2. **Identity Inclusion**: Must include "1000xdev" after the emoji
   - CORRECT: `💻 1000xdev [front-end-workflow]`
   - INCORRECT: `💻 [front-end-workflow]`

3. **Workflow Type in Brackets**: Must include the workflow type in square brackets
   - CORRECT: `📋 1000xdev [rules-workflow]`
   - INCORRECT: `📋 1000xdev rules-workflow`

4. **First Element Requirement**: Mode indicator must be the very first element of every response
   - No exceptions to this rule

5. **Mode-Workflow Consistency**: The workflow type in the mode indicator must match the active workflow

## Parameter Types

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

## Syntax Distinction Table

| Feature | Message-Commands (Tyler) | Mode Indicators (1000xdev) |
|---------|--------------------------|----------------------------|
| Case | lowercase only | Mixed case with emoji |
| Colons | Required before parameters | Never used |
| Brackets | Never used | Required around workflow-type |
| Format | message-command: standard-parameter @message-command.mdc | emoji 1000xdev [workflow-type] |
| Example | plan-mode: rules-workflow | 📋 1000xdev [rules-workflow] |
| Example | dev-mode: front-end-workflow | 💻 1000xdev [front-end-workflow] |
| Example | direct-mode: back-end-workflow | ⚡ 1000xdev [back-end-workflow] |

## Valid Workflows

The system supports only these four workflow types:
1. `rules-workflow`: For cognitive architecture enhancement
2. `front-end-workflow`: For front-end development
3. `back-end-workflow`: For back-end development
4. `scripts-workflow`: For scripts development

