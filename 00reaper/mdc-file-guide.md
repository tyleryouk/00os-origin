# MDC File Format Guide for 00OS

## Overview

This document provides guidance on properly creating and editing .mdc files for the 00OS implementation in Cursor Project Rules. Following these guidelines will prevent common issues like duplicate YAML headers and ensure consistent behavior of our terminal interface.

## The MDC File Structure

`.mdc` (Markdown Configuration) files consist of two main parts:

1. **Frontmatter** - YAML-like configuration metadata at the top of the file
2. **Markdown Content** - The actual rule instructions in Markdown format

### Frontmatter Format

The frontmatter must be the first content in the file and enclosed between triple-dash lines (`---`).

```
---
description: Brief description of what the rule does or when it should be used
globs: glob/pattern/*.js, another/pattern/*.ts
alwaysApply: true|false
---
```

**Important Notes:**
- There should only be ONE frontmatter block per file
- The frontmatter is NOT strict YAML (despite appearances)
- `globs` should be comma-separated patterns WITHOUT brackets `[]` or quotes
- Cursor's UI editor can sometimes create duplicate frontmatter - always check and fix raw files

### Rule Types Based on Configuration

#### 1. Always Applied Rules
For critical system components that should always be active:
```
---
description: Core system component that processes command syntax
globs: 
alwaysApply: true
---
```

#### 2. Path-Specific Rules
For rules that only apply to specific file types:
```
---
description: USE WHEN working with React components
globs: src/components/**/*.tsx, src/components/**/*.jsx
alwaysApply: false
---
```

#### 3. On-Demand Rules
For rules that should only be loaded when specifically needed:
```
---
description: USE WHEN you need to list files in a directory
globs: 
alwaysApply: false
---
```

### Effective Descriptions

- Use clear, actionable descriptions that tell the AI when to use the rule
- For processes, prefix with "USE WHEN..." to make the trigger condition obvious
- Examples:
  - `USE WHEN you need to list files in a directory`
  - `USE WHEN you need help with available commands`
  - `USE WHEN you want to echo text back to the user`

## Current Issues and Solutions

### 1. Duplicate Frontmatter Problem

The issue we're currently experiencing with 00reaper.mdc is that it has two frontmatter blocks:

```
---
description: 
globs: 
alwaysApply: false
---
---
description: 
globs: 
alwaysApply: true
---
```

**Solution**: Only the first frontmatter block is processed, so we must ensure it has the correct settings.

### 2. MDC Editor UI Limitations

The Cursor UI for editing .mdc files:
- Hides the frontmatter section in its special MDC editor
- May create duplicate frontmatter if you manually add it while using the UI editor
- Doesn't properly show the current settings

**Solution**: To edit .mdc files properly:
1. Either use a regular text editor to edit the raw files
2. Or add this to Cursor settings to disable the special MDC editor:
   ```json
   "workbench.editorAssociations": {
     "*.mdc": "default"
   }
   ```

### 3. Rule Activation Issues

Rules may not be activated properly if:
- The description is unclear or doesn't match the use case
- The rule type is set to "Manual" instead of "Always" or "Auto-attached"
- Multiple conflicting headers exist

**Solution**: 
- Ensure the frontmatter is correct and singular
- Use clear, descriptive triggers in the description field
- Set `alwaysApply: true` for critical components
- Use appropriate glob patterns for file-specific rules

## Implementation Guidelines for 00OS

### For Core System Components

Core components like command-handler, parser, registry, and executor should:
- Set `alwaysApply: true`
- Have clear descriptions that identify them as system components
- Be properly structured with single frontmatter blocks

### For Process Files

Process files that implement specific commands should:
- Use "USE WHEN..." format in descriptions
- Only set `alwaysApply: true` if they're critical (most shouldn't be)
- Have clear, focused functionality

## Workflow for Updating .mdc Files

1. **Check existing file format**: View the raw file first to see if there are any issues
2. **Remove duplicate frontmatter**: If multiple frontmatter blocks exist, keep only one
3. **Update settings**: Set appropriate description, globs, and alwaysApply values
4. **Save and verify**: Ensure the file is saved properly without duplications

## Example of a Well-Formed MDC File

```
---
description: Core system component that processes terminal commands with '>' prefix
globs: 
alwaysApply: true
---

# Command Handler

This component is responsible for identifying and routing commands that use the '>' prefix.

## Functionality

- Detects command prefix
- Parses command structure
- Routes to appropriate process
- Formats response

... 