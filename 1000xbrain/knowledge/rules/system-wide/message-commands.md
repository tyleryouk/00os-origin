# USE WHEN implementing or understanding message-command processing in the 1000xbrain system

# Message Commands Architecture

## Overview

This component defines the architecture and syntax for message-commands, the primary means through which the human user directs the AI assistant's mode and workflow behavior.

## Core Principles

### 1. Simplified Three-Command System

The message-command system is built on three core commands:

1. **plan-mode**: For planning and documentation
   - Format: `plan-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)`
   - Example: `plan-mode rules-workflow system-wide @parameters/rules/plan-mode/system-wide.mdc none`

2. **dev-mode**: For code implementation
   - Format: `dev-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)`
   - Example: `dev-mode rules-workflow system-wide @parameters/rules/dev-mode/system-wide.mdc none`

3. **direct-mode**: For immediate implementation
   - Format: `direct-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)`
   - Example: `direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc none`

### 2. Space-Delimited Format

Message-commands use a standardized space-delimited format with five components:

1. **mode**: The operating mode (plan-mode, dev-mode, direct-mode)
2. **workflow-type**: The workflow domain (rules-workflow, front-end-workflow, back-end-workflow, scripts-workflow)
3. **pathway-name**: The specific implementation pathway or "none" if not applicable
4. **@project-rule-parameter.mdc**: The project rule parameter or "none" if not applicable
5. **optional-standard-parameter(s)**: Additional parameters or "none" if not applicable

### 3. Extension Distinction

A strict distinction exists for file extensions in message-commands:

- **Brain-Files (.md)**: Used for file operations (editing, reading)
- **Cursor-Rules (.mdc)**: Used for message-command parameters

## Implementation Patterns

### Standard Message-Command Pattern

```markdown
# Basic format with all components
plan-mode rules-workflow system-wide @parameters/rules/plan-mode/system-wide.mdc none

# With optional parameters
dev-mode front-end-workflow component-creation @parameters/rules/dev-mode/front-end-workflow.mdc component-name

# With explicit "none" placeholders
direct-mode rules-workflow none @parameters/rules/direct-mode/add-project-rule-parameter.mdc none
```

### "none" Placeholder Usage

The keyword "none" is used as an explicit placeholder:

```markdown
# When pathway is not applicable
plan-mode rules-workflow none @parameters/rules/plan-mode/enhance-planning.mdc none

# When project-rule-parameter is not needed
dev-mode rules-workflow system-wide none param1

# When optional parameters are not needed
dev-mode rules-workflow performance @parameters/rules/dev-mode/performance.mdc none
```

## Integration with Other Components

This component integrates with:

- **Brain-Files and Cursor-Rules**: Defines proper extension usage in message-commands
- **Mode System**: Works with the mode system to control AI behavior
- **Parameter Structure**: Sets the format for accessing project-rule-parameters

## Access and Usage

```typescript
// Access this component for message command architecture
fetch_rules(["knowledge/rules/system-wide/message-commands"], 
           "Understanding message command architecture and syntax")

// Usage in communication
fetch_rules(["knowledge/rules/system-wide/message-commands"], 
           "Implementing proper message command format")
```

## Related Components

- [Brain-Files and Cursor-Rules](brain-files-cursor-rules.md): Defines extension usage
- [File Safety](file-safety.md): Guidelines for safe file editing
- [Symbol Guidelines](../common/symbol-guidelines.md): Proper usage of symbols with @ 