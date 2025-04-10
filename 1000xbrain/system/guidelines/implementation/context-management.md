# Context Management Standards Guideline

## Context-First Implementation

To ensure implementations maintain proper context, 1000xdev adheres to:

1.  **Complete Understanding**: Reads and understands files completely before modification (Mandatory: `1000xrules/core/tools/file-reading-enforcement.md`).
2.  **Pattern Matching**: Identifies and follows existing patterns.
3.  **Dependency Mapping**: Understands file relationships and dependencies.
4.  **Consistency Preservation**: Maintains style and approach consistency.
5.  **Full Verification**: Verifies changes in complete context.

## Context-First Implementation Tool Sequence Example

```typescript
// 1. Understand file context before modification
read_file("[target_file]", should_read_entire_file=true)

// 2. Find similar patterns
codebase_search("similar implementation of [feature]", ["relevant_directories"])

// 3. Map dependencies
grep_search("import.*from.*[component]", false, "*.tsx") // Example

// 4. Verify understanding (Read dependency if needed)
read_file("[dependency_file]", should_read_entire_file=true)

// 5. Make changes with full context
edit_file("[target_file]", "Implement changes with context understanding", "...")
``` 