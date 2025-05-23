# 00OS Command Development Guide

> For the canonical rationale and design philosophy behind 00OS and Cursor rule manipulation, see [00OS-rationale.md].

This guide is the single source of truth for creating and maintaining 00OS commands. All development must follow the 3-step pattern and favor simplicity.

## The 3-Step Pattern (MANDATORY)

1. **User sends a command**: `> command-name [arguments] [--flags]`
2. **AI fetches the process rule**: Use a single `fetch_rules` call to get the process definition
3. **AI executes the defined tool calls**: Follow the rule exactly, no more, no less

> For workflow/process context, see the [master workflow file](../../README.md).

## Minimal Command Implementation: Good vs. Complex

### Good (Simple, Preferred)
```markdown
---
name: file-list
category: system
description: List files in a directory
version: 1.0
author: 00reaper
permissions: [basic]
inputs:
  - name: path
    type: string
    required: true
    description: Directory path
outputs:
  - name: result
    type: array
    description: List of files
---

# Process: file-list

USE WHEN you want to execute file-list

## Execution

1. list_dir: List files in the specified directory

## Examples

> file-list /00os/processes
```

### Complex (Discouraged)
```markdown
---
name: file-list
category: system
description: List files in a directory
version: 1.0
author: 00reaper
permissions: [basic]
inputs:
  - name: path
    type: string
    required: true
    description: Directory path
outputs:
  - name: result
    type: array
    description: List of files
---

# Process: file-list

## Execution

try {
  // Validate input
  if (!inputs.path) throw new Error('Missing path');
  // List directory
  const result = await tools.call('list_dir', { ... });
  // Format result
  return { success: true, result };
} catch (error) {
  // Handle errors
  return { success: false, error: error.message };
}
```
> **Discouraged:** Do not add extra validation, try/catch, or formatting logic unless required by the process rule.

## Migration Guide: Converting Complex Commands

1. Remove all extra validation and error handling
2. Keep only the direct tool call sequence
3. Ensure the process file starts with a fetch_rules call and follows the 3-step pattern
4. Update documentation and examples to be minimal and actionable

## Best Practices
- Always start with fetch_rules
- Favor direct, minimal tool call sequences
- Avoid over-engineering and complex error handling
- All examples should be short and practical
- Use clear explanations in tool calls

## Command File Structure and Template

```markdown
---
name: command-name
description: Brief description of command
version: 1.0
author: 00reaper
permissions: [basic]
inputs:
  - name: arg1
    type: string
    required: true
    description: Description of first argument
  - name: verbose
    type: boolean
    required: false
    default: false
    description: Show detailed output
outputs:
  - name: result
    type: string
    description: Command output
---

# Process: command-name

## Description
Detailed description of what the command does.

## Execution

1. [Describe the tool call sequence here]

## Examples

> command-name arg1 --verbose
```

## Summary
- The 3-step pattern is required for all commands
- Simplicity and clarity are the top priorities
- If in doubt, remove complexity

---

For detailed tool call patterns, error handling, and response formatting, see [tool-call-patterns.md](tool-call-patterns.md).