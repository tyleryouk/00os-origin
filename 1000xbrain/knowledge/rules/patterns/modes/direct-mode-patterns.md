# Direct Mode Patterns

## Core Direct Mode Responsibilities

1. **Research**: Conduct thorough research to understand the codebase
2. **Immediate Implementation**: Implement solutions without planning documentation
3. **Verification**: Verify implementation meets requirements
4. **Self-Documentation**: Include essential documentation in code

## Research-First Implementation Process

Direct Mode requires a research-first approach:

1. **Make Minimum 20 Tool Calls**: Research the codebase before implementation
2. **Analyze Existing Patterns**: Study similar functionality in the codebase
3. **Understand Architecture**: Comprehend how components fit together
4. **Follow Established Patterns**: Implement using discovered patterns
5. **Verify Implementation**: Confirm solution meets requirements

## Tool Usage Pattern

### Research Pattern (Minimum 20 Calls)
```typescript
// Search for similar components
codebase_search("similar functionality patterns")

// Examine directory structure
list_dir("relevant_directory")

// Study related files
read_file("related_file.ext", should_read_entire_file=true)

// Find dependencies
grep_search("import.*from.*component", false, "*.tsx")
```

### Implementation Pattern
```typescript
// After research, implement
edit_file("target_file.ext",
          "Implement feature based on research",
          "// Implementation code...")
```

### Verification Pattern
```typescript
// Verify implementation
run_terminal_cmd("npm run verify", false)
```

## Implementation Rules

All implementations in Direct Mode must follow these rules:

1. **Mandatory Mode Indicator**: Always begin with ⚡ 1000xdev [workflow-type]
2. **Research First**: Always conduct thorough codebase research before making changes
3. **Patterns First**: Identify and follow existing patterns aggressively
4. **Self-Verification**: Include verification steps after implementation
5. **Minimal Interaction**: Complete implementation with minimal back-and-forth
6. **Concise Updates**: Provide extremely concise progress updates

## Knowledge Access Approach

During direct mode, access relevant knowledge components:

```typescript
// Direct mode research patterns
fetch_rules(["knowledge/rules/patterns/impl/direct-mode-research"], 
           "Understanding optimal research patterns for direct implementation")

// Pattern discovery and application
fetch_rules(["knowledge/rules/patterns/impl/pattern-discovery"], 
           "Discovering implementation patterns from existing code")
```

## Verification Requirements

Before signaling implementation completion, verify:

### Implementation Completeness
- [ ] All requirements implemented
- [ ] Edge cases handled
- [ ] Error handling complete
- [ ] Performance optimized

### Code Quality
- [ ] No type errors
- [ ] No linter errors
- [ ] Follows style guide
- [ ] Properly documented in code

### Testing
- [ ] Functionality verified
- [ ] Edge cases tested
- [ ] Error handling tested
- [ ] Integration tested

## Implementation Completion Signal

When implementation is complete and verified, signal completion:

```
⚡ 1000xdev [workflow-type]

Implementation complete:
- All requirements implemented from direct research
- Functionality verified
- Followed existing code patterns

implementation-complete
```

## Direct Mode Communication Style

- **Focus**: Research findings and implementation progress
- **Tone**: Extremely concise and action-focused
- **Detail Level**: Minimal with essential technical information only
- **Emphasis**: Rapid implementation and verification results 