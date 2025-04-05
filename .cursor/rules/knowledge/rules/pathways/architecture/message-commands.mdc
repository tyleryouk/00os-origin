# Message Commands Reference

## Overview

This file provides detailed information about message commands in the 1000xdev system. Message commands are the primary means of communication between the user and 1000xdev, allowing for explicit mode transitions and workflow control.

## Simplified Message Command System

The 1000xdev system has been simplified to use only three primary message commands:

1. **plan-mode**: Activates Planning Mode (📋)
2. **dev-mode**: Activates Developer Mode (💻)
3. **direct-mode**: Activates Direct Mode (⚡)

These commands indicate which mode 1000xdev should operate in, with all implementation details abstracted to project-rule-parameters that are only accessed when explicitly referenced.

## Message Command Structure

Message commands follow a standardized space-delimited format with five components:

```
message-command workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)
```

Where:
- **message-command** is one of the three primary commands (plan-mode, dev-mode, direct-mode)
- **workflow-type** specifies the type of workflow (e.g., rules-workflow, front-end-workflow)
- **pathway-name** is the specific implementation pathway or "none" if not applicable
- **@project-rule-parameter.mdc** is a reference to a project rule parameter or "none" if not applicable
- **optional-standard-parameter(s)** are additional parameters or "none" if not applicable

### Example Message Commands

```
plan-mode rules-workflow system-wide-optimization @parameters/rules/plan-mode/system-wide-optimization.mdc none
dev-mode front-end-workflow component-creation @parameters/rules/dev-mode/implementation-strategy.mdc typescript-file.ts
direct-mode back-end-workflow none none none
```

## Mode Transition Process

Mode transitions using message commands follow this process:

1. User sends a message command (e.g., `plan-mode rules-workflow none none none`)
2. 1000xdev transitions to the specified mode
3. 1000xdev uses the corresponding mode indicator (e.g., 📋 1000xdev [rules-workflow])
4. 1000xdev operates according to the mode-specific guidelines
5. Mode persists until a new message command is received

## Project Rule Parameters

Project rule parameters provide detailed implementation guidance that is abstracted from the core message command system:

1. **Format**: Always prefixed with `@` symbol and ending with `.mdc` extension
2. **Purpose**: Provide detailed implementation guidance without cluttering core cognition
3. **Access**: Only accessed when explicitly referenced in a message command
4. **Extension**: Always use `.mdc` extension, never `.md`

### Project Rule Parameter Header Format

All project-rule-parameters must use this standardized header format:
```
# mode: [mode] | workflow: [workflow-type] | pathway: [pathway-name] | filepath: @[filepath].mdc | optional-standard-parameter(s): [params]
```

### Project Rule Parameter Example

```
dev-mode front-end-workflow component-creation @parameters/rules/dev-mode/implementation-strategy.mdc typescript-file.ts
```

In this example, `@parameters/rules/dev-mode/implementation-strategy.mdc` is a project rule parameter that provides detailed implementation guidance for front-end component creation.

## "none" Placeholder Usage

The keyword "none" is used as an explicit placeholder when a component is not needed:

```
plan-mode rules-workflow none @parameters/rules/plan-mode/enhance-planning.mdc none
```

This ensures consistent parsing with exactly 5 components and makes parameter position unambiguous.

## Direct Mode Simplified Format

The direct-mode command can also use a simplified 3-component format for immediate implementation:

```
direct-mode front-end-workflow
prompt:
```

After receiving this command and prompt, 1000xdev:
1. Enters Direct Mode with the ⚡ indicator
2. Conducts thorough research before implementation
3. Implements based on the prompt instructions
4. Provides concise progress updates

## Valid Workflows

The system supports only these four workflow types:
1. `rules-workflow`: For cognitive architecture enhancement
2. `front-end-workflow`: For front-end development
3. `back-end-workflow`: For back-end development
4. `scripts-workflow`: For scripts development

## Implementation Details Abstraction

The simplified message command system abstracts implementation details to project-rule-parameters, which offers several advantages:

1. **Reduced Cognitive Load**: Core cognition focuses only on essential mode concepts
2. **Simplified Communication**: Message commands clearly indicate mode without complexity
3. **Flexibility**: Implementation details can evolve independently of core messaging
4. **Context Efficiency**: Detailed implementation knowledge is loaded only when needed

This abstraction ensures that 1000xdev's core cognition remains focused on the essential mode system while still providing access to detailed implementation guidance when explicitly needed. 