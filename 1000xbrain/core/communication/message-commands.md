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

The simplified system uses a standardized space-delimited format with five components and an optional prompt component, with NO COLONS between components:

1. **plan-mode**: For planning and documentation
   - Basic Format: `plan-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)`
   - With Prompt: `plan-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)
prompt: Additional guidance or instructions`
   - Example: `plan-mode rules-workflow system-wide-optimization @parameters/rules/plan-mode/system-wide-optimization.mdc none`
   - Example with prompt: `plan-mode rules-workflow system-wide-optimization @parameters/rules/plan-mode/system-wide-optimization.mdc none
prompt: Focus on optimizing the knowledge access patterns`

2. **dev-mode**: For code implementation
   - Basic Format: `dev-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)`
   - With Prompt: `dev-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)
prompt: Additional guidance or instructions`
   - Example: `dev-mode rules-workflow system-wide-optimization @parameters/rules/dev-mode/system-wide-optimization.mdc none`
   - Example with prompt: `dev-mode rules-workflow none @parameters/rules/dev-mode/continue-implementation.mdc none
prompt: Make sure to include comprehensive error handling`

3. **direct-mode**: For immediate implementation
   - Standard format: `direct-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)`
   - Simplified format: `direct-mode workflow-type`
   - Example: `direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc none`
   - Example: `direct-mode rules-workflow none @parameters/rules/direct-mode/major-key-message-commands.mdc none`

## Important Syntax Change

⚠️ **CRITICAL SYNTAX UPDATE**: The message-command format has been updated to use ONLY spaces between components with no colons:

- CORRECT: `dev-mode rules-workflow system-wide-optimization @parameters/rules/dev-mode/system-wide-optimization.mdc none`
- INCORRECT: `dev-mode: rules-workflow system-wide-optimization @parameters/rules/dev-mode/system-wide-optimization.mdc none`

This space-only syntax is now the standard for all message-commands.

## Component Descriptions

Each message-command has five standardized components and an optional prompt component:

1. **mode**: The operating mode (plan-mode, dev-mode, direct-mode)
2. **workflow-type**: The workflow domain (rules-workflow, front-end-workflow, back-end-workflow, scripts-workflow)
3. **pathway-name**: The specific implementation pathway or "none" if not applicable
4. **@project-rule-parameter.mdc**: The project rule parameter or "none" if not applicable
5. **optional-standard-parameter(s)**: Additional parameters or "none" if not applicable
6. **prompt**: (Optional) Additional guidance or instructions, must start on a new line with the prefix "prompt:"

## Prompt Component Usage

The prompt component allows for providing additional guidance while maintaining the current mode:

1. **Format Requirement**:
   - Must begin on a new line after the five standard components
   - Must start with the prefix "prompt:" followed by a space
   - Can contain multiple lines of text
   - No special formatting required for the content

2. **Use Cases**:
   - Providing guidance without switching to direct-mode
   - Adding context to the current operation
   - Clarifying implementation details
   - Suggesting specific approaches or considerations

3. **Examples**:
   ```
   plan-mode rules-workflow optimize-architecture @parameters/rules/plan-mode/optimize-architecture.mdc core
   prompt: Focus on the message-command system and ensure backward compatibility
   ```

   ```
   dev-mode front-end-workflow ui-component @parameters/front-end/dev-mode/ui-component.mdc button
   prompt: Make sure to implement accessibility features and follow the design system
   ```

## Project-Rule-Parameter Header System

Each project-rule-parameter file includes a standardized header:

```
# mode: [mode] | workflow: [workflow-type] | pathway: [pathway-name] | filepath: @[filepath].mdc | optional-standard-parameter(s): [params]
```

This header includes:
- **mode**: The mode this parameter is designed for
- **workflow**: The workflow type this parameter is designed for
- **pathway**: The specific use-case pathway
- **filepath**: Full path to the parameter file
- **optional-standard-parameter(s)**: Required standard parameters

## ⚠️ CRITICAL: Project-Rule-Parameter Extension Requirements ⚠️

When referring to project-rule-parameters:

1. **ALWAYS use .mdc extension**:
   - CORRECT: `@parameters/rules/plan-mode/enhance-planning.mdc`
   - INCORRECT: `@parameters/rules/plan-mode/enhance-planning.md`

2. **Rationale**:
   - 1000xbrain (.md files) are editable source files that AI can modify
   - Cursor Rules (.mdc files) are the actual rules that get applied
   - Only Tyler can edit .mdc files through the Cursor Settings UI
   - Message-commands must reference the actual rules (.mdc), not their source (.md)
   - The 1000xscripts directory contains synchronization tools to keep 1000xbrain and Cursor Rules in sync

## Valid Workflows

The system supports only these five workflow types:
1. `rules-workflow`: For cognitive architecture enhancement
2. `front-end-workflow`: For front-end development
3. `back-end-workflow`: For back-end development
4. `scripts-workflow`: For scripts development
5. `quality-workflow`: For quality assurance and monitoring

## "none" Placeholder Usage

The keyword "none" is used as an explicit placeholder:

1. **When to use "none"**:
   - When a pathway-name is not applicable: `plan-mode rules-workflow none @parameters/rules/plan-mode/enhance-planning.mdc none`
   - When a project-rule-parameter is not needed: `dev-mode rules-workflow system-wide-optimization none param1`
   - When optional parameters are not needed: `dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none`

2. **Why explicit "none" is required**:
   - Ensures consistent parsing with exactly 5 components
   - Makes parameter position unambiguous
   - Prevents accidental parameter misalignment
   - Facilitates component-by-component verification

## Message-Command Usage Standards

### Syntax Standards

1. **Kebab-Case Requirement**: All message-commands must use kebab-case format (e.g., `plan-mode`)
2. **Space-Only Delimiters**: Use spaces to separate all components (no colons)
3. **Explicit "none" Placeholders**: Use "none" explicitly when a component is not applicable
4. **Project-Rule Prefix**: Always prefix project-rule parameters with `@` symbol
5. **Knowledge Access**: Use fetch_rules tool for knowledge directory access
6. **Prompt Format**: Always place the prompt component on a new line with "prompt:" prefix
