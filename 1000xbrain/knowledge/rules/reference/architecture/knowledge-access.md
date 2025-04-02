# Knowledge Access System

## Overview

This file provides detailed information about the knowledge access system used in the 1000xdev cognitive architecture. The knowledge access system provides standardized, self-documented access to specialized knowledge components via the `fetch_rules` tool.

## Knowledge Directory Structure

The knowledge directory is organized into specialized categories for efficient knowledge access:

1. **Reference**: Central knowledge reference system (`knowledge/rules/reference/*`)
   - Architecture information
   - Reference guides
   - Domain maps
   - Documentation standards

2. **Patterns**: Consolidated pattern repository (`knowledge/rules/patterns/*`)
   - Implementation patterns
   - Tool usage patterns
   - Documentation patterns
   - Communication patterns

3. **Guides**: Implementation guides for common tasks (`knowledge/rules/guides/*`)
   - Architecture guides
   - Cognitive enhancement guides
   - Implementation guides
   - Workflow guides

## Using fetch_rules Tool

The `fetch_rules` tool provides the standard method for accessing knowledge components. It serves several key purposes:

1. **Explicit Context**: Each knowledge access includes an explanation of why the knowledge is being accessed
2. **Consistent Pattern**: All knowledge access follows the same standardized pattern
3. **Multiple Rules**: Can fetch several related knowledge components in a single call
4. **Self-Documentation**: Creates a clear record of knowledge dependencies

### Basic fetch_rules Syntax

```typescript
fetch_rules(["knowledge/rules/path/to/component"], "Explanation of why accessing")
```

### Standard fetch_rules Patterns

All knowledge access should follow these standard patterns:

```typescript
// Basic pattern with explanation
fetch_rules(["knowledge/rules/guides/architecture"], 
           "Understanding system architecture for implementation")

// Multiple rules pattern
fetch_rules([
  "knowledge/rules/patterns/tool/search-patterns",
  "knowledge/rules/patterns/tool/command-patterns"
], "Accessing tool patterns for efficient implementation")
```

## Knowledge Access Best Practices

When accessing specialized knowledge, follow these best practices:

1. **Include Clear Explanations**: Always include a clear explanation of why the knowledge is being accessed
   ```typescript
   fetch_rules(["knowledge/rules/patterns/tool/search-patterns"],
              "Understanding search patterns for finding implementation references")
   ```

2. **Group Related Knowledge**: Access related knowledge components in a single call
   ```typescript
   fetch_rules([
     "knowledge/rules/patterns/tool/search-patterns",
     "knowledge/rules/patterns/tool/command-patterns"
   ], "Accessing search and command patterns for implementation")
   ```

3. **Access Knowledge Before Implementation**: Access relevant knowledge before starting implementation
   ```typescript
   // First access implementation knowledge
   fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"],
              "Understanding implementation patterns for feature")
   
   // Then proceed with implementation
   // ... implementation code ...
   ```

4. **Be Specific with Knowledge Paths**: Use specific paths to access relevant knowledge
   ```typescript
   // Specific path for front-end patterns
   fetch_rules(["knowledge/rules/patterns/impl/front-end-patterns"],
              "Understanding front-end implementation patterns")
   
   // Specific path for back-end patterns
   fetch_rules(["knowledge/rules/patterns/impl/back-end-patterns"],
              "Understanding back-end implementation patterns")
   ```

## Knowledge Component Categories

| Category | Path | Purpose | Example |
|----------|------|---------|---------|
| Architecture | knowledge/rules/guides/architecture | Understanding system architecture | fetch_rules(["knowledge/rules/guides/architecture"], "Understanding system structure") |
| Implementation | knowledge/rules/patterns/impl/* | Patterns for implementation | fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"], "Finding implementation patterns") |
| Tool Usage | knowledge/rules/patterns/tool/* | Patterns for tool usage | fetch_rules(["knowledge/rules/patterns/tool/search-patterns"], "Optimizing search strategies") |
| Documentation | knowledge/rules/patterns/doc/* | Patterns for documentation | fetch_rules(["knowledge/rules/patterns/doc/file-standards"], "Understanding documentation standards") |
| Reference | knowledge/rules/reference/* | Reference information | fetch_rules(["knowledge/rules/reference/architecture"], "Understanding architectural references") |

## Knowledge Access in Different Modes

### Planning Mode Knowledge Access

In Planning Mode, focus on accessing:
- Architecture knowledge for planning context
- Documentation patterns for effective documentation
- Planning patterns for structured approaches
- Reference materials for technical context

Example Planning Mode knowledge access:
```typescript
fetch_rules(["knowledge/rules/patterns/doc/documentation-patterns"],
           "Understanding effective documentation patterns for planning")
```

### Developer Mode Knowledge Access

In Developer Mode, focus on accessing:
- Implementation patterns for code structure
- Tool patterns for efficient tool usage
- Error handling patterns for robust implementation
- Testing patterns for effective verification

Example Developer Mode knowledge access:
```typescript
fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"],
           "Understanding implementation patterns for feature development")
```

### Direct Mode Knowledge Access

In Direct Mode, focus on accessing:
- Research patterns for effective code exploration
- Implementation patterns for consistent code structure
- Verification patterns for robust testing
- Tool combinations for efficient development

Example Direct Mode knowledge access:
```typescript
fetch_rules(["knowledge/rules/patterns/tool/research-patterns"],
           "Understanding effective research patterns for direct implementation")
```

## Relationship to Project-Rule-Parameters

The knowledge access system complements project-rule-parameters in the following ways:

1. **Different Access Method**: 
   - Knowledge: `fetch_rules(["knowledge/rules/path"], "Explanation")`
   - Project-rule-parameters: `dev-mode: workflow-type @parameter.mdc`

2. **Different Purpose**:
   - Knowledge: Provide detailed implementation patterns and guides
   - Project-rule-parameters: Control workflow and implementation strategy

3. **Different Timing**:
   - Knowledge: Accessed on-demand during implementation
   - Project-rule-parameters: Specified at the start of a workflow

4. **Different Control**:
   - Knowledge: 1000xdev controls which knowledge to access
   - Project-rule-parameters: User controls which parameters to use

## Knowledge First Implementation

The knowledge access system enables a "knowledge first" implementation approach:

1. **Access Knowledge**: Start by accessing relevant knowledge patterns
   ```typescript
   fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"],
              "Understanding implementation patterns for feature")
   ```

2. **Apply Knowledge**: Use the accessed knowledge to guide implementation
   ```typescript
   // Implementation guided by accessed knowledge
   // ... implementation code ...
   ```

3. **Verify Against Knowledge**: Check implementation against accessed knowledge
   ```typescript
   // Verification based on accessed knowledge
   // ... verification code ...
   ```

This approach ensures that implementation follows established patterns and best practices. 