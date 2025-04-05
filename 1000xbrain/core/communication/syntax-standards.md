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

The simplified three-command system follows a standardized space-delimited format with five components:

1. **plan-mode**: For planning and documentation
   - Format: `plan-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)`
   - Example: `plan-mode rules-workflow system-wide-optimization @parameters/rules/plan-mode/system-wide-optimization.mdc none`

2. **dev-mode**: For code implementation
   - Format: `dev-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)`
   - Example: `dev-mode rules-workflow system-wide-optimization @parameters/rules/dev-mode/system-wide-optimization.mdc none`

3. **direct-mode**: For immediate implementation
   - Format: `direct-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)`
   - Example: `direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc none`

## Basic Format Requirements

All message-commands must adhere to these strict format requirements:

1. **Kebab-Case Format**: All message-commands must use kebab-case (lowercase words separated by hyphens)
   - CORRECT: `plan-mode rules-workflow` 
   - INCORRECT: `planMode rules-workflow`

2. **Lowercase Requirement**: All message-commands must be entirely lowercase
   - CORRECT: `dev-mode front-end-workflow`
   - INCORRECT: `Dev-Mode front-end-workflow`

3. **Space-Only Delimiters**: All components must be separated by spaces (no colons)
   - CORRECT: `dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none`
   - INCORRECT: `dev-mode: rules-workflow @parameters/rules/dev-mode/performance.mdc`

4. **Explicit "none" Placeholders**: Use "none" explicitly when a component is not applicable
   - CORRECT: `plan-mode rules-workflow none @parameters/rules/plan-mode/enhance-planning.mdc none`
   - INCORRECT: `plan-mode rules-workflow @parameters/rules/plan-mode/enhance-planning.mdc`

5. **Five-Component Structure**: All message-commands must have exactly five components
   - mode
   - workflow-type
   - pathway-name
   - @project-rule-parameter.mdc or "none"
   - optional-standard-parameter(s) or "none"

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
   - Specified directly in the appropriate position
   - No special formatting required
   - Multiple values must be quoted if they contain spaces
   - Example: `dev-mode rules-workflow performance none typescript-file.ts`

2. **Project Rule Parameters**:
   - Always prefixed with the `@` symbol
   - Must match the message-command name with .mdc extension
   - Always appears in the fourth position
   - Example: `plan-mode rules-workflow enhance-planning @parameters/rules/plan-mode/enhance-planning.mdc none`
   
3. **"none" Placeholder**:
   - Used explicitly when a component is not needed
   - Maintains positional integrity of the command
   - Makes parameter position unambiguous
   - Example: `plan-mode rules-workflow none none workflow-name`

## Syntax Distinction Table

| Feature | Message-Commands (Tyler) | Mode Indicators (1000xdev) |
|---------|--------------------------|----------------------------|
| Case | lowercase only | Mixed case with emoji |
| Format | mode workflow-type pathway-name @parameter.mdc optional-params | emoji 1000xdev [workflow-type] |
| Example | plan-mode rules-workflow system-wide @parameters/rules/plan-mode/system-wide.mdc none | 📋 1000xdev [rules-workflow] |
| Example | dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none | 💻 1000xdev [rules-workflow] |
| Example | direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc none | ⚡ 1000xdev [rules-workflow] |

## Valid Workflows

The system supports only these four workflow types:
1. `rules-workflow`: For cognitive architecture enhancement
2. `front-end-workflow`: For front-end development
3. `back-end-workflow`: For back-end development
4. `scripts-workflow`: For scripts development

