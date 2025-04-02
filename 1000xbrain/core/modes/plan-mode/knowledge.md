# Planning Mode Knowledge Access

> **IMPORTANT**: This file defines knowledge access patterns and usage guidelines for Planning Mode.

## File Purpose

This file outlines how to access and use specialized knowledge during Planning Mode. It should be consulted to understand:

- Knowledge access patterns using fetch_rules
- Planning-specific knowledge components
- Best practices for knowledge access
- Context-specific knowledge usage

## 1. Using fetch_rules for Knowledge Access

### Basic Knowledge Access Patterns

```typescript
// Access architecture understanding for planning
fetch_rules(["knowledge/guides/architecture"], 
           "Understanding system architecture for planning implementation")

// Access implementation patterns for planning
fetch_rules(["knowledge/patterns/impl/implementation-patterns"], 
           "Finding implementation patterns for planning approach")

// Access multiple related knowledge components
fetch_rules([
  "knowledge/guides/architecture",
  "knowledge/patterns/impl/implementation-patterns"
], "Understanding both architecture and patterns for comprehensive planning")
```

## 2. Planning-Specific Knowledge Components

When creating planning documentation, use these knowledge components:

| Knowledge Type | fetch_rules Path | Planning Usage |
|---------------|-----------------|---------------|
| Architecture Guides | `knowledge/guides/architecture` | Understanding system structure |
| Implementation Patterns | `knowledge/patterns/impl/implementation-patterns` | Planning implementation approaches |
| Tool Patterns | `knowledge/patterns/tool/search-patterns` | Planning efficient search strategies |
| Documentation Patterns | `knowledge/patterns/doc/file-standards` | Creating standardized documentation |
| Domain Maps | `knowledge/reference/maps/domain-map` | Understanding knowledge relationships |
| Cognitive Enhancement | `knowledge/guides/cognitive-enhancement` | Planning system improvements |
| Architecture Patterns | `knowledge/patterns/impl/architecture-patterns` | Planning architectural changes |

## 3. Knowledge Access Best Practices

1. **Access Architecture Understanding First**:
   ```typescript
   fetch_rules(["knowledge/guides/architecture"], 
              "Understanding system architecture for planning")
   ```

2. **Research Implementation Patterns**:
   ```typescript
   fetch_rules(["knowledge/patterns/impl/implementation-patterns"], 
              "Researching implementation patterns for planning")
   ```

3. **Document Knowledge Dependencies**:
   ```markdown
   ## Implementation Approach
   
   This implementation uses patterns from:
   - Architecture guides for system understanding
   - Implementation patterns for standard approaches
   ```

4. **Combine Related Knowledge Components**:
   ```typescript
   fetch_rules([
     "knowledge/patterns/tool/search-patterns",
     "knowledge/patterns/tool/command-patterns"
   ], "Planning comprehensive tool usage strategy")
   ```

5. **Include Detailed Explanations**:
   ```typescript
   fetch_rules(["knowledge/reference/architecture/brain-files-cursor-rules"],
              "Understanding brain-files and cursor-rules relationship for planning proper file structure")
   ```

## 4. Context-Specific Knowledge Access

### Front-End Planning
```typescript
fetch_rules(["knowledge/reference/domains/front-end"],
           "Accessing front-end specific planning patterns")
```

### Back-End Planning
```typescript
fetch_rules(["knowledge/reference/domains/back-end"],
           "Understanding back-end architecture for planning implementation")
```

### System-Wide Planning
```typescript
fetch_rules([
  "knowledge/guides/architecture",
  "knowledge/patterns/impl/architecture-patterns",
  "knowledge/reference/maps/domain-map"
], "Comprehensive architectural understanding for system-wide planning")
```

For detailed fetch_rules usage patterns:
```typescript
fetch_rules(["knowledge/patterns/tool/fetch-rules-patterns"],
           "Learning standardized fetch_rules patterns for planning")
``` 