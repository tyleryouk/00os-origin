# Common Mode Patterns

## Overview

This file contains common patterns and shared functionalities used across all modes (Planning Mode, Developer Mode, and Direct Mode). By centralizing these shared patterns, we reduce duplication and ensure consistency across the different mode implementations.

## Mode Indicators

All mode responses must begin with the appropriate mode indicator:

| Mode | Indicator | Example |
|------|-----------|---------|
| Planning Mode | 📋 1000xdev [workflow-type] | 📋 1000xdev [rules-workflow] |
| Developer Mode | 💻 1000xdev [workflow-type] | 💻 1000xdev [front-end-workflow] |
| Direct Mode | ⚡ 1000xdev [workflow-type] | ⚡ 1000xdev [back-end-workflow] |

## Common Knowledge Access Patterns

All modes should access knowledge using these common patterns:

```typescript
// Access architecture understanding
fetch_rules(["knowledge/rules/guides/architecture"], 
           "Understanding system architecture")

// Access implementation patterns
fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"], 
           "Understanding implementation patterns")

// Access tool patterns
fetch_rules(["knowledge/rules/patterns/tool/tool-combinations"],
           "Understanding tool combinations")
```

## Common File Operation Patterns

### Reading Files

```typescript
// Read entire file
read_file("target_file.ext", should_read_entire_file=true)

// Read specific section
read_file("target_file.ext", [start_line], [line_count])
```

### Modifying Files

```typescript
// Edit file
edit_file("target_file.ext",
          "Clear description of changes",
          "File content with changes")
```

### Searching

```typescript
// Search for patterns
codebase_search("search query", ["relevant_directories"])

// Grep search for specific patterns
grep_search("pattern", false, "*.ext")
```

## Common Verification Patterns

All implementations should be verified through:

1. **Functionality Check**:
   - Feature completeness
   - Error handling
   - Edge cases
   - Expected behavior

2. **Quality Check**:
   - Structure and organization
   - Formatting and style
   - Documentation
   - Best practices

## Common Completion Patterns

### Completion Requirements

All tasks must meet these requirements before completion:

1. **Completeness**:
   - All required elements implemented
   - No unfinished components
   - Edge cases handled
   - Dependencies addressed

2. **Quality**:
   - Meets quality standards for the task
   - Follows established patterns
   - Properly documented
   - Consistent with system architecture

### Common Completion Checklist

- [ ] All required elements complete
- [ ] Quality standards met
- [ ] Edge cases handled
- [ ] Documentation complete
- [ ] Verification complete

## Common Completion Signals

### Planning Completion Signal

```
📋 1000xdev [workflow-type]

planning-document-complete

Planning is complete with:
- Requirements document with clear objectives and success criteria
- Implementation plan with detailed approach
- Context files with essential system information
```

### Implementation Completion Signal

```
💻 1000xdev [workflow-type]

Implementation complete:
- All requirements implemented
- Functionality verified
- Used appropriate implementation patterns

implementation-complete
```

### Direct Mode Completion Signal

```
⚡ 1000xdev [workflow-type]

Implementation complete:
- Research completed
- Solution implemented
- Functionality verified

implementation-complete
```

## Common Error Handling Patterns

When encountering errors, follow this approach:

1. **Identify the Issue**: Determine what's not working
2. **Check the Context**: Understand related components
3. **Research Solutions**: Find appropriate patterns and approaches
4. **Fix the Problem**: Make targeted changes to address the issue
5. **Verify the Fix**: Test to ensure the problem is resolved

## Communication Patterns

### Common Communication Styles

| Element | Description | Example |
|---------|-------------|---------|
| Mode Indicator | Always begin with the appropriate mode indicator | 💻 1000xdev [rules-workflow] |
| Clear Status | Provide clear status updates | "Implementation in progress: 75% complete" |
| Focused Content | Focus on the specific task at hand | "Implementing user authentication system" |
| Action-Oriented | Use action-oriented language | "Created component structure, implementing authentication logic" |
| Technical Precision | Use precise technical language | "Implemented JWT token validation with proper error handling" |

### Common Message Structure

1. **Mode Indicator**: Always begin with the appropriate mode indicator
2. **Status Update**: Provide clear status update if appropriate
3. **Current Focus**: Describe what you're currently focusing on
4. **Progress Details**: Provide specific details on progress
5. **Next Steps**: Outline next steps if in the middle of a task
6. **Completion Signal**: Use appropriate completion signal if complete
