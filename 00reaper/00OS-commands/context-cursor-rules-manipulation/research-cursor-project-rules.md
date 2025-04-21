# Cursor Project Rules: Comprehensive Guide

## Overview

Project Rules in Cursor are specialized configuration files that provide system-level guidance to the AI, allowing developers to customize how the AI behaves when working with their specific codebase. They are stored in the `.cursor/rules` directory and are version-controlled alongside the project.

## Key Characteristics

- **Location**: Stored in `.cursor/rules` directory
- **Format**: Uses MDC (`.mdc`) file format, a lightweight markdown variant with metadata support
- **Scope**: Project-specific, applicable to the codebase where they are defined
- **Version Control**: Can be committed to git and shared with the team
- **Application**: Applied to both Chat and Cmd-K AI

## Types of Project Rules

| Rule Type       | Description                                                                                  |
| --------------- | -------------------------------------------------------------------------------------------- |
| Always          | Always included in the model context                                                         |
| Auto Attached   | Included when files matching a glob pattern are referenced                                   |
| Agent Requested | Rule is available to the AI, which decides whether to include it. Must provide a description |
| Manual          | Only included when explicitly mentioned using @ruleName                                      |

## Rule Structure

Project rule files are written in the MDC format (`.mdc`) and have two main parts:

1. **Metadata**: At the top of the file, enclosed in `---` separators
2. **Content**: The actual rule content in markdown format

### Metadata Fields

- `description`: What the rule is for (helps the AI choose appropriate rules)
- `globs`: File patterns for automatic inclusion (e.g., `*.tsx`, `src/components/*.js`)
- `alwaysApply`: Boolean indicating if the rule should always be included (default: false)

### Example MDC Rule

```
---
description: RPC Service boilerplate
globs: src/services/*.ts
alwaysApply: false
---

- Use our internal RPC pattern when defining services
- Always use snake_case for service names.

@service-template.ts
```

## How Project Rules Work

When the AI processes a request in Cursor:

1. It checks available rules based on the current context
2. Rules are chosen based on:
   - Their description relevance to the current task
   - The file patterns specified in `globs` if they match files in the current context
   - Whether they're marked as `alwaysApply: true`
3. The selected rules' content is included in the AI's context
4. Referenced files (with `@filename`) are also included in the context

## Creating Project Rules

There are two main ways to create project rules:

1. **Using the Command Palette**:
   - Press `Cmd + Shift + P` (macOS) or `Ctrl + Shift + P` (Windows/Linux)
   - Search for and select "New Cursor Rule"
   - Name the rule and edit it in the editor

2. **Via Cursor Settings**:
   - Go to Cursor Settings > Rules
   - Click "Add Rule" to create a new rule file
   - Configure the metadata and content

## Best Practices for Project Rules

- **Keep rules concise**: Target under 500 lines for optimal performance
- **Split large concepts** into multiple, composable rules
- **Be specific and actionable**: Write clear, concrete instructions
- **Provide examples** when helpful, either inline or as referenced files
- **Use appropriate scope**: Apply rules to specific file types or directories
- **Prioritize important guidelines**: Place most critical instructions first
- **Update regularly**: Revise rules as project requirements evolve

## Use Cases for Project Rules

### Domain-Specific Guidance

```
---
description: Frontend component standards
globs: src/components/*.tsx
---

When working in the components directory:
- Always use Tailwind for styling
- Use Framer Motion for animations
- Follow our component naming conventions
```

### Code Templates & Boilerplate

```
---
description: React component template
globs: src/components/*.tsx
---

React components should follow this layout:
- Props interface at the top
- Component as named export
- Styles at the bottom

@component-template.tsx
```

### Workflow Automation

```
---
description: App analysis workflow
globs: 
---

When I ask to analyze the app:
1. Run the dev server with `npm run dev`
2. Fetch logs from the console
3. Suggest performance improvements
```

## File References with @

You can reference other files from within your rules using the `@` symbol:

```
@filename.ts
```

This includes the referenced file as additional context when the rule is applied, giving the AI more information to work with.

## Migrating from .cursorrules (Legacy)

The `.cursorrules` file in the project root is still supported but deprecated. To migrate:

1. Create the `.cursor/rules` directory if it doesn't exist
2. Create one or more `.mdc` files in this directory
3. Move your rules from `.cursorrules` into these files, adding appropriate metadata
4. Commit the new files to version control

## Troubleshooting Project Rules

If your rules aren't being applied as expected:

- Check rule type and configuration in the metadata
- For `Agent Requested` rules, ensure a clear description is defined
- For `Auto Attached` rules, verify the glob patterns match your intended files
- Reference rules manually using `@ruleName` if they're not being automatically included
- Monitor the AI's behavior to see if it acknowledges using the rules

## References

1. [Cursor Official Documentation: Rules](https://docs.cursor.com/context/rules)
2. [Cursor Project Rules Discussion](https://forum.cursor.com/t/project-rules-confusion/51055)
3. [Cursor 101: Customizing AI Behavior](https://cursor101.com/article/cursor-rules-customizing-ai-behavior)
