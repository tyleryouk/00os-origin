# Developer Mode Patterns

## Overview

This file provides comprehensive implementation patterns and guidelines for Developer Mode. It contains the consolidated knowledge previously spread across multiple files in the core/modes/dev-mode directory.

## Core Developer Mode Responsibilities

1. **Code Implementation**: Create or modify code based on planning documentation
2. **Testing & Debugging**: Verify functionality and fix issues
3. **Error Handling**: Identify and resolve errors during implementation
4. **Implementation Verification**: Ensure the implementation meets requirements

## Knowledge Access Patterns

### Core Knowledge Access Pattern

All implementations should follow this knowledge access pattern:

1. **Access Implementation Knowledge**:
   ```typescript
   fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"],
              "Understanding implementation patterns for feature")
   ```

2. **Access Domain Knowledge**:
   ```typescript
   fetch_rules(["knowledge/rules/reference/domains/implementation"],
              "Understanding domain-specific implementation requirements")
   ```

3. **Access Tool Patterns**:
   ```typescript
   fetch_rules(["knowledge/rules/patterns/tool/tool-combinations"],
              "Understanding optimal tool combinations for implementation")
   ```

### Knowledge-First Implementation

Always access knowledge before starting implementation:

1. **Pattern Research**: Find relevant patterns
2. **Domain Understanding**: Access domain knowledge
3. **Tool Selection**: Choose appropriate tools
4. **Implementation**: Apply knowledge to code
5. **Verification**: Use knowledge for testing

### Feature Implementation Knowledge

For each feature implementation:

1. **Access Core Patterns**:
   ```typescript
   fetch_rules(["knowledge/rules/patterns/impl/basic-patterns"],
              "Understanding basic implementation patterns")
   ```

2. **Access Domain-Specific Patterns**:
   ```typescript
   fetch_rules(["knowledge/rules/patterns/impl/domain-patterns"],
              "Understanding domain-specific patterns")
   ```

## Implementation Patterns

### Knowledge-Enhanced Implementation Strategy

1. **Planning Review**: Understand the implementation requirements
2. **Knowledge Access**: Use fetch_rules to access relevant patterns and guides
3. **Pattern Research**: Find existing patterns to follow
4. **Implementation**: Create or modify code based on requirements and patterns
5. **Testing**: Verify functionality

### Implementation Process

All implementations should follow this knowledge-enhanced process:

1. **Read Planning**: Review the implementation.md file from the planning folder
2. **Access Knowledge**: Use fetch_rules to access relevant implementation patterns
3. **Research Patterns**: Find similar patterns in the codebase for reference
4. **Implement**: Create or modify code according to the implementation plan
5. **Test**: Verify the implementation works correctly
6. **Complete**: Signal completion when all requirements are met

### Code Implementation Tools
- **Primary Tools**: `edit_file`, `read_file`
- **Usage Pattern**: Read files before editing, verify after changes
- **Best Practice**: Make focused changes with clear commit messages

```typescript
// Read file before modification
read_file("target_file.ext", should_read_entire_file=true)

// Make changes
edit_file("target_file.ext",
          "Implement feature",
          "// Implementation code...")
```

### Research Tools
- **Primary Tools**: `codebase_search`, `grep_search`
- **Usage Pattern**: Search for patterns, then read implementations
- **Best Practice**: Follow existing patterns in the codebase

```typescript
// Find related patterns
codebase_search("similar functionality")
```

## Verification Patterns

### Core Verification Process

All implementations must be verified through this process:

1. **Code Quality Check**:
   - Syntax verification
   - Type checking
   - Linter compliance
   - Style guide adherence

2. **Functionality Verification**:
   - Feature completeness
   - Error handling
   - Edge cases
   - Performance

3. **Integration Check**:
   - Component integration
   - API compatibility
   - State management
   - Event handling

### Testing Requirements

| Category | Purpose | Verification Method |
|----------|---------|-------------------|
| Unit Tests | Individual component testing | Automated test suite |
| Integration Tests | Component interaction testing | Integration test suite |
| Type Tests | Type safety verification | TypeScript compiler |
| Linting | Code quality checks | ESLint/TSLint |

### Testing Process

1. **Unit Testing**:
   - Test individual components
   - Verify isolated functionality
   - Check edge cases

2. **Integration Testing**:
   - Test component interactions
   - Verify data flow
   - Check state management

## Error Handling Patterns

When encountering errors, follow this knowledge-enhanced approach:

1. **Access Error Handling Knowledge**: Get standardized error handling patterns
   ```typescript
   fetch_rules(["knowledge/rules/patterns/impl/error-handling"], 
              "Accessing error handling patterns for debugging")
   ```

2. **Identify the Issue**: Determine what's not working
3. **Check the Context**: Understand related components
4. **Fix the Problem**: Make targeted changes to address the issue
5. **Verify the Fix**: Test to ensure the problem is resolved

### Common Error Types and Resolutions

| Error Type | Resolution Approach | Knowledge Access |
|------------|---------------------|-----------------|
| **Type Errors** | Add proper type annotations | `fetch_rules(["knowledge/rules/patterns/impl/typescript-patterns"])` |
| **API Integration** | Verify endpoints and add error handling | `fetch_rules(["knowledge/rules/patterns/impl/api-patterns"])` |
| **State Management** | Use proper state update patterns | `fetch_rules(["knowledge/rules/patterns/impl/state-management"])` |
| **Network Errors** | Add retry logic and error handling | `fetch_rules(["knowledge/rules/patterns/impl/network-handling"])` |

## Completion Patterns

### Completion Requirements

All implementations must meet these requirements:

1. **Feature Completeness**:
   - All requirements implemented
   - Edge cases handled
   - Error handling complete
   - Performance optimized

2. **Code Quality**:
   - No type errors
   - No linter errors
   - Follows style guide
   - Properly documented

3. **Testing**:
   - Unit tests passing
   - Integration tests passing
   - Coverage requirements met
   - Edge cases tested

### Completion Checklist

- [ ] All features implemented
- [ ] Edge cases handled
- [ ] Error handling complete
- [ ] Performance optimized
- [ ] Code documented
- [ ] Unit tests written and passing
- [ ] Integration tests written and passing
- [ ] No type errors
- [ ] No linter errors
- [ ] Style guide followed

### Completion Signal

When all requirements are met, signal completion with:

```
💻 1000xdev [workflow-type]

Implementation complete:
- All requirements implemented
- Functionality verified
- Used appropriate implementation patterns

implementation-complete
```

## Mode-Specific Rules

1. **Mandatory Mode Indicator**: Always begin with 💻 1000xdev [workflow-type]
2. **Pattern Matching**: Follow existing code patterns
3. **Error Handling**: Include appropriate error handling
4. **Planning Folder Adherence**: Implement according to planning documentation
5. **No Documentation Updates**: Save documentation updates for Planning Mode
6. **Knowledge Access**: Use fetch_rules to access specialized knowledge

## Developer Mode Communication Style

- **Focus**: Implementation status and technical details
- **Tone**: Direct and action-oriented
- **Detail Level**: Concise with technical precision
- **Emphasis**: Progress updates and technical solutions 