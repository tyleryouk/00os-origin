# Implementation Approaches

## Overview

This file defines the implementation approaches for rules-workflow, covering different strategies based on complexity and requirements.

## Implementation Types

### direct-mode

The direct-mode approach is ideal for simpler tasks when requirements are clear:

1. **Research Phase**: Minimum 20 tool calls to understand the codebase
   - Find similar implementations with `codebase_search`
   - Understand directory structure with `list_dir`
   - Analyze patterns with `read_file`
   - Find specific usages with `grep_search`

2. **Implementation**: Make minimal, focused changes
   - Follow existing code patterns
   - Add proper error handling
   - Ensure type safety
   - Create or update tests when needed

3. **Verification**: Ensure changes work as expected
   - Run type checking
   - Execute tests
   - Verify requirements are met

**Best for**: Small features, bug fixes, well-defined optimizations, UI components following existing patterns

### context-first approach: plan-mode and dev-mode iterations

The context-first approach is ideal for complex features touching multiple subsystems:

1. **Enhanced Research**: Minimum 30 tool calls for deep understanding
   - Conduct extensive semantic searches
   - Map directory structure comprehensively
   - Read key files to understand patterns
   - Identify all dependencies and relationships

2. **Comprehensive Context Building**:
   - Document components and their relationships
   - Create dependency graphs
   - Identify all relevant patterns
   - Note potential side effects

3. **Context-Aware Implementation**:
   - Start with isolated components
   - Follow identified patterns rigorously
   - Ensure seamless integration
   - Add comprehensive error handling

4. **Thorough Verification**:
   - Verify type safety across components
   - Run all relevant tests
   - Check for edge cases

**Best for**: Complex features affecting multiple subsystems, core components, performance optimizations with side effects

## Implementation Workflow

For both approaches, follow this general workflow:

1. **Understand Requirements**: Clearly define what needs to be implemented
2. **Research Extensively**: Understand the codebase before making changes
3. **Follow Patterns**: Maintain consistency with existing code
4. **Implement Changes**: Make focused, purposeful modifications
5. **Verify Implementation**: Ensure everything works as expected
6. **Signal Completion**: Use `implementation-complete` when finished

## Implementation Signals

When implementation is complete, send:

```
implementation-complete
```

This signals that the implementation process is finished and the feature has been successfully implemented. 