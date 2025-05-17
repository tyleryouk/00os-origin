# 00OS Command Standards Core

## Core Standard: The 3-Step Pattern

Every 00OS command process MUST follow this pattern:

1. **User sends a command**: `> command-name [arguments] [--flags]`
2. **AI fetches the process rule**: Use a single `fetch_rules` call to get the process definition
3. **AI executes the defined tool calls**: Follow exactly what's in the process rule, no more, no less

> **Simplicity is required:**
> - Avoid complex validation, error handling, or multi-step logic in process files
> - Do not add extra layers of abstraction or unnecessary sections
> - All examples and templates should be minimal and actionable

## Essential Standards

1. **Command Processing Flow**
   - Detect command prefix (`>`, hardcoded)
   - Fetch process rule (MANDATORY, always use `fetch_rules` first)
   - Parse parameters (minimal, only as needed)
   - Execute tool calls (direct, as defined in the rule)
   - Format response (use standard indicators)

2. **Tool Call Requirements**
   - NEVER execute 00OS commands via terminal (no self-execution)
   - Always include clear explanations in tool calls
   - Error handling should be minimal: let the system handle errors unless a specific suggestion is needed

3. **Response Format**
   - ✅ Success
   - ❌ Error
   - ⚠️ Warning

## Command Structure (Minimal Example)

```yaml
---
name: command-name       # Required: Command identifier
description: Brief desc  # Required: Short explanation
version: 1.0.0          # Required: Semantic version
author: 00reaper        # Required: Author ID
category: system        # Required: system/00reaper/1000xdev
permissions: [basic]    # Required: Permission list
inputs:                 # Arguments/flags (minimal)
  - name: param
    type: string
    required: true
    description: desc
outputs:
  - name: result
    type: string
    description: desc
---
```

## Implementation Rules

1. **Process Location**: `/00os/processes/{category}/{command}.md`
2. **Naming**: Lowercase with hyphens (e.g., `file-list.md`)
3. **Categories**: 
   - `system/`: Core commands
   - `00reaper/`: Admin commands
   - `1000xdev/`: Dev commands
4. **Error Handling**: Only add suggestions for common, user-facing issues. Do not over-engineer error logic.
5. **Response Format**: Use standard indicators and keep messages clear and concise.

## Minimal Error Handling Example

```javascript
try {
  // Tool calls
} catch (error) {
  return {
    success: false,
    error: error.message,
    suggestions: ['Check your input and try again.']
  };
}
```

## Best Practices

- **Favor Simplicity:**
  - Do not add extra validation, abstraction, or documentation sections unless absolutely necessary
  - All process files should be easy to read and maintain
- **Minimal Examples:**
  - All examples should show only the essential tool calls and logic
- **Discourage Over-Engineering:**
  - If a section or pattern feels complex, simplify it or remove it
- **Documentation:**
  - Include only what is needed for clarity and correct usage

## Example: Minimal Command Process

```markdown
---
name: echo
category: system
description: Print a message
version: 1.0
author: 00reaper
permissions: [basic]
inputs:
  - name: message
    type: string
    required: true
    description: Message to print
outputs:
  - name: result
    type: string
    description: Echoed message
---

# Process: echo

USE WHEN you want to execute echo

## Execution

This process executes the following tool call:

1. Return the message as the result

## Examples

> echo "Hello, world!"
``` 