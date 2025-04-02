# Message Commands

## Overview

This document provides essential guidance on message-commands in the simplified three-command system. For detailed patterns and comprehensive examples, refer to the knowledge files referenced below.

## Knowledge Access

For comprehensive message-command syntax documentation, access these knowledge components:

```typescript
// For message-command syntax details
fetch_rules(["knowledge/rules/reference/syntax/message-command-syntax"], 
           "Understanding detailed message-command syntax")
```

## Three-Command System

The simplified system focuses entirely on mode:

1. **plan-mode**: For planning and documentation
   - Format: `plan-mode: workflow-type @optional-template.mdc`
   - Example: `plan-mode: rules-workflow @template-basic.mdc`

2. **dev-mode**: For code implementation
   - Format: `dev-mode: workflow-type @optional-strategy.mdc`
   - Example: `dev-mode: front-end-workflow @log-based-implementation.mdc`

3. **direct-mode**: For immediate implementation
   - Format: `direct-mode: workflow-type @optional-strategy.mdc`
   - Example: `direct-mode: back-end-workflow @direct-implementation.mdc`

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

## ⚠️ CRITICAL: Project-Rule-Parameter Extension Requirements ⚠️

When referring to project-rule-parameters:

1. **ALWAYS use .mdc extension**:
   - CORRECT: `@template-basic.mdc`
   - INCORRECT: `@template-basic.md`

2. **Rationale**:
   - 1000xbrain (.md files) are editable source files that AI can modify
   - Cursor Rules (.mdc files) are the actual rules that get applied
   - Only Tyler can edit .mdc files through the Cursor Settings UI
   - Message-commands must reference the actual rules (.mdc), not their source (.md)
   - The 1000xscripts directory contains synchronization tools to keep 1000xbrain and Cursor Rules in sync

## Valid Workflows

The system supports only these four workflow types:
1. `rules-workflow`: For cognitive architecture enhancement
2. `front-end-workflow`: For front-end development
3. `back-end-workflow`: For back-end development
4. `scripts-workflow`: For scripts development

## Message-Command Usage Standards

### Syntax Standards

1. **Kebab-Case Requirement**: All message-commands must use kebab-case format (e.g., `plan-mode`)
2. **Parameter Separator**: Use colon (`:`) to separate message-commands from parameters
3. **Parameter Space**: Use space to separate multiple parameters
4. **Project-Rule Prefix**: Always prefix project-rule parameters with `@` symbol
5. **Knowledge Access**: Use fetch_rules tool for knowledge directory access
