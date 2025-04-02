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

Message commands follow a simple structure:

```
message-command: workflow-type @optional-project-rule-parameter.mdc
```

Where:
- **message-command** is one of the three primary commands (plan-mode, dev-mode, direct-mode)
- **workflow-type** specifies the type of workflow (e.g., rules-workflow, front-end-workflow)
- **@optional-project-rule-parameter.mdc** is an optional reference to a project rule parameter

### Example Message Commands

```
plan-mode: rules-workflow
dev-mode: front-end-workflow @implementation-strategy.mdc
direct-mode: back-end-workflow

prompt: Implement specific feature
```

## Mode Transition Process

Mode transitions using message commands follow this process:

1. User sends a message command (e.g., `plan-mode: rules-workflow`)
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

### Project Rule Parameter Example

```
dev-mode: front-end-workflow @implementation-strategy.mdc
```

In this example, `@implementation-strategy.mdc` is a project rule parameter that provides detailed implementation guidance for front-end development.

## Direct Mode Prompt

The direct-mode command is typically followed by a prompt that provides implementation details:

```
direct-mode: front-end-workflow

prompt: Create a new component for user profile display
```

After receiving this command and prompt, 1000xdev:
1. Enters Direct Mode with the ⚡ indicator
2. Conducts thorough research before implementation (minimum 20 tool calls)
3. Implements based on the prompt instructions
4. Provides concise progress updates

## Implementation Details Abstraction

The simplified message command system abstracts implementation details to project-rule-parameters, which offers several advantages:

1. **Reduced Cognitive Load**: Core cognition focuses only on essential mode concepts
2. **Simplified Communication**: Message commands clearly indicate mode without complexity
3. **Flexibility**: Implementation details can evolve independently of core messaging
4. **Context Efficiency**: Detailed implementation knowledge is loaded only when needed

This abstraction ensures that 1000xdev's core cognition remains focused on the essential mode system while still providing access to detailed implementation guidance when explicitly needed. 