# Symbol Usage Guidelines for 1000xbrain

## Overview

This document defines the essential standards for using symbols within the 1000xbrain cognitive architecture, with a focus on the @ symbol and extension usage. For detailed patterns and combinations, refer to the knowledge files referenced below.

## Knowledge Access

For comprehensive symbol usage documentation, access these knowledge components:

```typescript
// For detailed symbol usage patterns
fetch_rules(["knowledge/rules/patterns/communication/symbol-usage"], 
           "Understanding detailed symbol usage patterns")

// For symbol combination guidance
fetch_rules(["knowledge/rules/patterns/communication/symbol-combinations"], 
           "Learning about effective symbol combinations")
```

## Brain-Files vs. Cursor-Rules Extension Guidelines

### Extension Distinction

Files in the 1000xbrain cognitive architecture system follow a strict distinction between extensions:

1. **Brain-Files (.md)**:
   - Stored in the `1000xbrain/` directory
   - Editable source files that directly shape AI cognition when synchronized
   - Target for all edits and enhancements
   - Referenced in documentation contexts (.md)
   - Used when discussing file editing

2. **Cursor-Rules (.mdc)**:
   - Stored in the `.cursor/rules/` directory
   - Applied rules that directly control AI behavior
   - Never directly edited (only edited by Tyler through Cursor UI)
   - Referenced in message-command parameters (.mdc)
   - Used when showing how to reference rules in message-commands

## @ Symbol Usage Guidelines

### ⚠️ CRITICAL: @ Symbol Protection Requirements ⚠️

To avoid hallucinations and incorrect tool calls:

1. **ALWAYS use backticks (``) around @ symbols** in regular text
2. **NEVER reference .mdc files for editing** - only reference for message-commands
3. **NEVER reference .md files in message-command parameters** - only use .mdc
4. **Keep @ symbol references minimal** - excessive @ symbols can cause parsing issues
5. **Use absolute clarity** when distinguishing between .md files (for editing) and .mdc files (for message-commands)

### Allowed @ Symbol Usage

1. **File Cross-References at Beginning**:
   - Allowed only in the first 20 lines of files
   - Example: `@README.md`

2. **Backtick-Wrapped Examples**:
   - Wrapped in backticks to prevent reference detection
   - Example: `` `verify-planning: @parameters/rules/helpers/verification/verify-planning.mdc` ``

3. **Code Block Examples**:
   - Used within code blocks with proper backtick wrapping

### Prohibited @ Symbol Usage

1. **Direct Usage in Regular Text**:
   - Never use @ followed by a path in regular text
   - INCORRECT: `To verify planning, use @parameters/rules/helpers/verification/verify-planning.mdc`
   - CORRECT: `To verify planning, use `verify-planning: @parameters/rules/helpers/verification/verify-planning.mdc``

2. **In File Names or Headers**:
   - Never include @ in file names or section headers

3. **Multiple Unwrapped @ Symbols**:
   - Multiple @ symbols in close proximity can cause parsing issues

## Mode Indicators

Mode indicators must always:

1. **Appear First**: Be the very first element of every 1000xdev response
2. **Include All Components**: Contain emoji + identity + bracketed workflow type
3. **Match Current Mode**: Use the emoji corresponding to the current mode
   - Planning Mode: 📋
   - Developer Mode: 💻
   - Direct Mode: ⚡
4. **Match Current Workflow**: Include the workflow type matching the current task

For detailed information on mode indicators and syntax patterns, access:

```typescript
fetch_rules(["knowledge/rules/reference/syntax/mode-indicator-syntax"],
           "Understanding mode indicator syntax requirements")
```

