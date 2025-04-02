# Developer Mode Knowledge Access

> **IMPORTANT**: This file defines knowledge access patterns and requirements for Developer Mode.

## File Purpose

This file outlines how knowledge should be accessed and utilized during implementation in Developer Mode. It covers:

- Knowledge access patterns
- Required knowledge components
- Implementation-specific knowledge
- Pattern-based development

## 1. Knowledge Access Patterns

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

## 2. Required Knowledge Components

### Essential Knowledge Categories

| Category | Purpose | Access Pattern |
|----------|---------|----------------|
| Implementation Patterns | Code structure and organization | `knowledge/rules/patterns/impl/*` |
| Tool Patterns | Efficient tool usage | `knowledge/rules/patterns/tool/*` |
| Domain Knowledge | Technical requirements | `knowledge/rules/reference/domains/*` |
| Architecture | System structure | `knowledge/rules/reference/architecture/*` |

### Knowledge Component Dependencies

```typescript
// Access implementation patterns
fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"])

// Access related tool patterns
fetch_rules(["knowledge/rules/patterns/tool/tool-combinations"])

// Access domain knowledge
fetch_rules(["knowledge/rules/reference/domains/implementation"])
```

## 3. Implementation-Specific Knowledge

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

3. **Access Tool Patterns**:
   ```typescript
   fetch_rules(["knowledge/rules/patterns/tool/implementation-tools"],
              "Understanding tool usage for implementation")
   ```

### Error Resolution Knowledge

When debugging:

1. **Access Error Patterns**:
   ```typescript
   fetch_rules(["knowledge/rules/patterns/impl/error-patterns"],
              "Understanding error resolution patterns")
   ```

2. **Access Debug Tools**:
   ```typescript
   fetch_rules(["knowledge/rules/patterns/tool/debug-tools"],
              "Understanding debugging tool usage")
   ```

## 4. Pattern-Based Development

### Pattern Selection Process

1. **Identify Pattern Category**:
   - Basic patterns
   - Domain-specific patterns
   - Implementation patterns
   - Tool patterns

2. **Access Pattern Knowledge**:
   ```typescript
   fetch_rules(["knowledge/rules/patterns/impl/pattern-selection"],
              "Understanding pattern selection criteria")
   ```

3. **Apply Pattern**:
   - Follow pattern structure
   - Adapt to requirements
   - Maintain consistency

### Pattern Categories

| Pattern Type | Use Case | Knowledge Access |
|-------------|----------|------------------|
| Basic | Common implementations | `knowledge/rules/patterns/impl/basic-patterns` |
| Domain | Specific features | `knowledge/rules/patterns/impl/domain-patterns` |
| Tool | Tool usage | `knowledge/rules/patterns/tool/tool-patterns` |
| Error | Problem resolution | `knowledge/rules/patterns/impl/error-patterns` | 