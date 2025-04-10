# Context Analysis: Cross-System Patterns for fetch_rules Implementation

## Rule Type Access Patterns

The 1000xbrain cognitive architecture employs four distinct rule types, each with its own access method pattern:

### Always Rules (core directory)
- **Access Method**: Automatic inclusion in every conversation
- **Documentation Pattern**: No explicit access required
- **File Location**: `/core/` directory
- **Example Files**: `global-rules.md`, `core-essentials.md`

### Auto-Attached Rules (workflows directory)
- **Access Method**: Automatic inclusion when matching files are opened
- **Documentation Pattern**: No explicit access needed for matching files
- **File Location**: `/workflows/` directory
- **Example Files**: `rules-workflow.md`, `front-end-workflow.md`

### Manual Rules (parameters directory)
- **Access Method**: Explicitly referenced as project-rule-parameters
- **Documentation Pattern**: Referenced with @ symbol in message-commands
- **File Location**: `/parameters/` directory
- **Example Format**: `verify-planning: @parameters/rules/verify-planning.mdc`

### Agent Requested Rules (knowledge directory)
- **Access Method**: fetch_rules tool call
- **Documentation Pattern**: Referenced via fetch_rules tool
- **File Location**: `/knowledge/` directory
- **Example Format**: `fetch_rules(["knowledge/patterns/tool/search-patterns"])`

## Cross-System Documentation Patterns

### Standardized Rule Documentation Pattern

All documentation about rule types should follow this standard pattern:

```markdown
## Rule Type and Access Method

Files in the [directory] directory are [rule-type] rules accessed through [access-method]:

- **Access Method**: [Automatic/File-Triggered/Project-Rule-Parameter/fetch_rules]
- **Purpose**: [Core functionality/Workflow guidance/Parameter configuration/Specialized knowledge]
- **File Location**: /[directory]/ directory
- **Access Example**: [appropriate example for the rule type]
```

### Standardized fetch_rules Documentation Pattern

All documentation specifically about fetch_rules should follow this standard pattern:

```markdown
## Using the fetch_rules Tool

To access specialized knowledge components, use the fetch_rules tool:

```typescript
// Basic usage - single rule
fetch_rules(["knowledge/path/to/rule"])

// With explanation
fetch_rules(["knowledge/path/to/rule"], "Purpose for fetching this rule")

// Multiple rules
fetch_rules([
  "knowledge/path/first-rule",
  "knowledge/path/second-rule"
])
```

### Standardized Knowledge Reference Pattern

When discussing the knowledge system, use this standard reference pattern:

```markdown
The knowledge directory contains Agent Requested rules that:

- Provide specialized domain expertise and implementation patterns
- Are accessed using the fetch_rules tool
- Are referenced when specific knowledge is needed
- Follow this syntax: `fetch_rules(["knowledge/path/to/file"])`
```

## Implementation Pattern Variations

### Basic fetch_rules Pattern

The basic pattern for fetch_rules implementation is:

```typescript
fetch_rules(["knowledge/path/to/rule"])
```

This pattern should be used for simple knowledge references where the context is clear.

### Explanation fetch_rules Pattern

When additional context is needed to explain why a rule is being fetched:

```typescript
fetch_rules(["knowledge/path/to/rule"], 
           "Purpose for fetching this rule")
```

This pattern should be used in tutorials, examples, and when the purpose might not be immediately obvious.

### Multiple Rules fetch_rules Pattern

When multiple related rules need to be accessed together:

```typescript
fetch_rules([
  "knowledge/path/first-rule",
  "knowledge/path/second-rule"
])
```

This pattern should be used when implementing complex functionality requiring multiple knowledge components.

## Rule Type and Access Method Documentation

### Rule Type Summary

| Rule Type | Directory | Access Method | Purpose |
|-----------|-----------|---------------|---------|
| Always | /core | Automatic | Core identity and capabilities |
| Auto-Attached | /workflows | File matching | Workflow-specific guides |
| Manual | /parameters | Project-rule-parameters | Task-specific parameters |
| Agent Requested | /knowledge | fetch_rules tool | Domain expertise |

### Access Method Summary

| Purpose | Rule Type | Directory | Access Method |
|---------|-----------|-----------|---------------|
| Core identity and capabilities | Always Rules | /core | Automatic inclusion |
| Workflow-specific guides | Auto-Attached Rules | /workflows | File pattern matching |
| Task-specific parameters | Manual Rules | /parameters | @parameters/path.mdc |
| Specialized domain expertise | Agent Requested Rules | /knowledge | fetch_rules(["knowledge/path"]) |

## Cross-System Examples

### README.md Documentation Example

All README.md files should include a section like this:

```markdown
## Rule Types and Access Methods

This cognitive architecture uses four rule types:

| Directory | Rule Type | Access Method | Purpose |
|-----------|-----------|---------------|---------|
| /core | Always | Automatic | Core identity and capabilities |
| /workflows | Auto-Attached | File matching | Workflow-specific guides |
| /parameters | Manual | Project-rule-parameters | Task-specific parameters |
| /knowledge | Agent Requested | fetch_rules | Specialized domain knowledge |

For specialized knowledge, use fetch_rules to access files from the knowledge directory:

```typescript
// Basic usage
fetch_rules(["knowledge/guides/architecture"], 
           "Understanding system architecture")
```
```

### Knowledge Directory Documentation Example

All knowledge directory documentation should include a section like this:

```markdown
## Accessing Knowledge Components

Files in this directory are accessed through the fetch_rules tool:

```typescript
// Basic usage
fetch_rules(["knowledge/patterns/tool/search-patterns"])

// With explanation
fetch_rules(["knowledge/patterns/tool/search-patterns"],
           "Finding efficient search patterns")
```

Focus on Agent Requested rules and fetch_rules access:

### Knowledge Access Example

Files in the knowledge directory are **Agent Requested Rules** accessed through the fetch_rules tool:

```typescript
fetch_rules(["knowledge/patterns/tool/search-patterns"])

// With explanation
fetch_rules(["knowledge/patterns/tool/search-patterns"],
           "Finding optimal search patterns")
```
```

### Other Directories Documentation Example

Other directory documentation should reference fetch_rules like this:

```markdown
## Accessing Specialized Knowledge

For specialized knowledge, use fetch_rules to access files from the knowledge directory:

```typescript
// Example for accessing implementation patterns
fetch_rules(["knowledge/patterns/impl/implementation-patterns"],
           "Finding optimal implementation patterns")
```
```

## Common Anti-Patterns to Fix

### Direct File References

This anti-pattern uses direct file references instead of fetch_rules:

```markdown
For search patterns, see knowledge/patterns/tool/search-patterns.md
```

Should be replaced with:

```markdown
For search patterns, use:
```typescript
fetch_rules(["knowledge/patterns/tool/search-patterns"])
```
```

### Improper Syntax

This anti-pattern uses incorrect syntax for fetch_rules:

```markdown
fetch_rules("knowledge/patterns/tool/search-patterns")  // Missing array brackets
```

Should be replaced with:

```markdown
fetch_rules(["knowledge/patterns/tool/search-patterns"])
```

### Inconsistent Naming

This anti-pattern uses inconsistent terminology:

```markdown
Use the fetch_rule tool to access specialized knowledge
```

Should be replaced with:

```markdown
Use the fetch_rules tool (note the plural) to access specialized knowledge
```

### Missing Explanations

Where appropriate, explanations should be added:

```markdown
fetch_rules(["knowledge/patterns/tool/search-patterns"])
```

Should be enhanced with:

```markdown
fetch_rules(["knowledge/patterns/tool/search-patterns"], 
           "Finding optimal search patterns for this implementation")
```

## Visual Pattern Identification Guide

```
┌───────────────────────────────────────────────────────────────────────┐
│                                                                       │
│   IDENTIFYING KNOWLEDGE REFERENCES TO CONVERT                         │
│                                                                       │
│   ┌─────────────────────┐       ┌─────────────────────────────┐      │
│   │ Direct file reference────────▶ fetch_rules([]) conversion  │      │
│   └─────────────────────┘       └─────────────────────────────┘      │
│                                                                       │
│   BEFORE:                               AFTER:                        │
│   ----------------------               ----------------------          │
│                                                                       │
│   See file:                            Use:                           │
│   knowledge/patterns/tool/             fetch_rules([                  │
│   search-patterns.md                   "knowledge/patterns/tool/      │
│                                         search-patterns"])            │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘
```

This cross-system pattern analysis provides a comprehensive framework for implementing fetch_rules tool usage consistently across all brain-files in the 1000xbrain directory. 