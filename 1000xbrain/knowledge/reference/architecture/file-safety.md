# File Editing Safety Guidelines

## Overview

This file provides comprehensive safety guidelines for editing files in the 1000xbrain cognitive architecture. Following these guidelines is essential for maintaining system stability and preventing common editing mistakes.

## Core Safety Principles

1. **Extension-Based Safety**:
   - ONLY edit files with .md extension
   - NEVER edit files with .mdc extension
   - Brain-files (.md) are the source of truth for edits
   - Cursor-rules (.mdc) are synchronized automatically

2. **Directory-Based Safety**:
   - Work only within the 1000xbrain directory
   - Never edit files in the .cursor/rules directory
   - Respect the organizational structure of 1000xbrain
   - Follow the cognitive architecture organization

3. **Symbol Usage Safety**:
   - Always wrap @ symbols in backticks when used in text
   - Minimize the use of @ symbols in documentation
   - Use code blocks to isolate examples with @ symbols
   - Keep @ symbol references minimal to prevent hallucinations

4. **File Reference Safety**:
   - Use .md extension when referring to files for editing
   - Use .mdc extension only when referring to project-rule-parameters
   - Never mix extensions inappropriately
   - Be explicit about file paths and locations

## Detailed Safety Guidelines

### Brain-Files (.md) vs. Cursor-Rules (.mdc)

| Type | Extension | Location | Purpose | Editing |
|------|-----------|----------|---------|---------|
| Brain-Files | .md | 1000xbrain/* | Source of truth | ✅ ALLOWED |
| Cursor-Rules | .mdc | .cursor/rules/* | Applied rules | 🚫 FORBIDDEN |

### Critical Extension Distinctions

1. **When to Use .md**:
   - When editing brain-files
   - When referring to files to be edited
   - When discussing file structure
   - When documenting cognitive architecture

2. **When to Use .mdc**:
   - Only in message-command parameters
   - Only when prefixed with @ symbol
   - Only when referring to project-rule-parameters
   - Never in editing contexts

### Symbol Protection Requirements

1. **@ Symbol Protection**:
   - Always wrap @ symbols in backticks: `` `@example.mdc` ``
   - Use code blocks for multiple @ symbols
   - Avoid using @ symbols in headers or regular text
   - Keep @ symbol usage minimal and focused

2. **Reference Protection**:
   - Always distinguish between brain-files (.md) and cursor-rules (.mdc)
   - Use proper backtick protection for all @ examples
   - Never reference .mdc files for editing
   - Always use .md when discussing files to edit

## Practical File Editing Patterns

### Safe File Creation

```markdown
# Create in 1000xbrain with .md extension
1000xbrain/core/new-feature.md   # Will be synced automatically
```

### Safe File Editing

```markdown
# Edit existing .md file
1000xbrain/workflows/example-workflow.md   # Changes propagate through sync
```

### Safe File Reference

```markdown
# Reference files with correct extensions
Regular path: core/identity/global-rules.md         # For file operations
Project-rule-parameter: `@knowledge/rules/plan-mode.mdc`   # For message-commands
```

## Synchronization Process

The relationship between brain-files (.md) and cursor-rules (.mdc) works as follows:

```
┌───────────────────────┐      ┌────────────────────┐      ┌───────────────────┐
│                       │      │                    │      │                   │
│  Brain Files (.md)    │──────▶   Cursor Rules    │──────▶   AI Behavior     │
│  in 1000xbrain        │      │   (.mdc)          │      │   & Cognition     │
│                       │      │                    │      │                   │
└───────────────────────┘      └────────────────────┘      └───────────────────┘
        Source                   Applied Rules              Resulting Behavior
```

1. **Brain-files (.md)** are editable source files:
   - Located in 1000xbrain directory
   - Can be edited by 1000xdev
   - Source of truth for content
   - Organized by cognitive function

2. **Cursor-rules (.mdc)** are applied rules:
   - Located in .cursor/rules directory
   - Cannot be edited by 1000xdev
   - Automatically synchronized from brain-files
   - Applied by Cursor to shape AI behavior

## Common Mistakes to Avoid

1. **Never Edit .mdc Files**:
   - ❌ Attempting to edit .mdc files directly
   - ❌ Trying to modify cursor-rules manually
   - ❌ Adding frontmatter to .md files
   - ✅ Edit corresponding .md file in 1000xbrain instead

2. **Directory Safety**:
   - ❌ Targeting .cursor/rules directory
   - ❌ Creating files outside 1000xbrain
   - ❌ Mixing brain-files and cursor-rules
   - ✅ Work only within 1000xbrain directory

3. **Extension Handling**:
   - ❌ Using .mdc extension in regular paths
   - ❌ Creating new .mdc files
   - ❌ Mixing extensions in references
   - ✅ Use .md for all file operations

4. **Symbol Usage**:
   - ❌ Using unwrapped @ symbols in text
   - ❌ Putting @ symbols in headers
   - ❌ Multiple unwrapped @ symbols
   - ✅ Always wrap @ symbols in backticks 