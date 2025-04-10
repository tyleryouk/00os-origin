# Knowledge File Template

This document provides a template for creating new knowledge files during the Rules Workflow Optimization project. This template should be used when abstracting content from Auto Attached brain-files to knowledge files.

## Guide File Template

Use this template for files in the `knowledge/rules/guides/` directory:

```markdown
# USE WHEN <verb> <subject>, <verb> <subject>, or <verb> <subject>

# [Title of Guide]

## Overview
[Brief explanation of the guide's purpose and context]

## Key Concepts
- **[Concept 1]**: [Definition]
- **[Concept 2]**: [Definition]
- **[Concept 3]**: [Definition]

## [Main Process/Guide Topic]
[Detailed explanation of the main process or guide topic]

### [Subtopic 1]
[Detailed explanation of subtopic 1]

### [Subtopic 2]
[Detailed explanation of subtopic 2]

### [Subtopic 3]
[Detailed explanation of subtopic 3]

## Implementation Guidance
[Specific implementation guidance related to the guide topic]

## Examples
[Practical examples with explanations]

## Related Components
- [Related Component 1]: `knowledge/rules/[path/to/component1]`
- [Related Component 2]: `knowledge/rules/[path/to/component2]`

## Conclusion
[Summary of key points]
```

## Pattern File Template

Use this template for files in the `knowledge/rules/patterns/` directory:

```markdown
# USE WHEN <verb> <subject>, <verb> <subject>, or <verb> <subject>

# [Title of Pattern Collection]

## Overview
[Brief explanation of the pattern collection's purpose]

## Key Patterns

### Pattern 1: [Pattern Name]
[Detailed explanation of Pattern 1]

#### Implementation
[Implementation details for Pattern 1]

#### Usage Context
[When to use Pattern 1]

#### Example
```[language]
[Code example for Pattern 1]
```

### Pattern 2: [Pattern Name]
[Detailed explanation of Pattern 2]

#### Implementation
[Implementation details for Pattern 2]

#### Usage Context
[When to use Pattern 2]

#### Example
```[language]
[Code example for Pattern 2]
```

### Pattern 3: [Pattern Name]
[Detailed explanation of Pattern 3]

#### Implementation
[Implementation details for Pattern 3]

#### Usage Context
[When to use Pattern 3]

#### Example
```[language]
[Code example for Pattern 3]
```

## Implementation Strategy
[Overall implementation strategy for using these patterns]

## Related Patterns
- [Related Pattern 1]: `knowledge/rules/[path/to/pattern1]`
- [Related Pattern 2]: `knowledge/rules/[path/to/pattern2]`

## Conclusion
[Summary of key points]
```

## Reference File Template

Use this template for files in the `knowledge/rules/reference/` directory:

```markdown
# USE WHEN <verb> <subject>, <verb> <subject>, or <verb> <subject>

# [Title of Reference]

## Overview
[Brief explanation of the reference's purpose]

## [Reference Section 1]
[Detailed reference information for section 1]

### [Subsection 1.1]
[Detailed reference information for subsection 1.1]

### [Subsection 1.2]
[Detailed reference information for subsection 1.2]

## [Reference Section 2]
[Detailed reference information for section 2]

### [Subsection 2.1]
[Detailed reference information for subsection 2.1]

### [Subsection 2.2]
[Detailed reference information for subsection 2.2]

## Examples
[Reference examples with explanations]

### Example 1: [Example Name]
[Example 1 details]

```[language]
[Code/syntax example 1]
```

### Example 2: [Example Name]
[Example 2 details]

```[language]
[Code/syntax example 2]
```

## Related References
- [Related Reference 1]: `knowledge/rules/[path/to/reference1]`
- [Related Reference 2]: `knowledge/rules/[path/to/reference2]`

## Conclusion
[Summary of key points]
```

## USE WHEN Header Guidelines

When creating USE WHEN headers, follow these guidelines:

1. **Start with "USE WHEN"**: Always begin with "USE WHEN" in uppercase
2. **Use Action Verbs**: Begin each clause with an action verb (implementing, understanding, optimizing, etc.)
3. **Include 3 Use Cases**: Typically include three different use cases separated by commas and "or"
4. **Be Specific**: Reference specific activities rather than general concepts
5. **Match Directory Type**:
   - **guides/**: understanding, learning, working with
   - **patterns/**: implementing, optimizing, enhancing
   - **reference/**: referencing, documenting, organizing

### Examples by Directory Type:

1. **guides/**:
   - `# USE WHEN understanding scanning processes, learning about validation techniques, or working with automated verification`

2. **patterns/impl/**:
   - `# USE WHEN implementing validation patterns, optimizing verification workflows, or enhancing error checking`

3. **patterns/doc/**:
   - `# USE WHEN creating documentation structures, formatting documentation sections, or organizing documentation content`

4. **reference/syntax/**:
   - `# USE WHEN referencing command syntax, documenting parameter formats, or troubleshooting syntax errors`

## File Naming Conventions

Follow these naming conventions for knowledge files:

1. **Use kebab-case**: All lowercase with words separated by hyphens
2. **Be Descriptive**: Names should clearly indicate the file content
3. **Avoid Redundancy**: Don't repeat directory information in the name
4. **Include Purpose**: Include the primary purpose in the name

### Examples by Directory Type:

1. **guides/**:
   - `scanning-process-guide.md`
   - `validation-implementation.md`
   - `error-resolution.md`

2. **patterns/impl/**:
   - `scanning-automation-patterns.md`
   - `validation-script-patterns.md`
   - `error-handling.md`

3. **patterns/doc/**:
   - `documentation-structure.md`
   - `reporting-formats.md`
   - `example-organization.md`

4. **reference/syntax/**:
   - `message-command-syntax.md`
   - `parameter-syntax.md`
   - `format-requirements.md`

## Content Transfer Process

When transferring content from Auto Attached files to knowledge files:

1. **Copy Exact Content**: Begin by copying the exact content to preserve formatting
2. **Add USE WHEN Header**: Add the appropriate USE WHEN header as the first line
3. **Organize with Template**: Reorganize content to follow the template structure
4. **Update Cross-References**: Update any references to other files
5. **Review and Refine**: Review for clarity and completeness
6. **Sync Changes**: Run the sync-all command after creating the file

## fetch_rules Reference Format

When adding fetch_rules references to Auto Attached files:

```typescript
fetch_rules(["knowledge/rules/[path/to/knowledge-file]"], 
           "Clear explanation of why this knowledge is needed")
```

For multiple related references:

```typescript
fetch_rules([
  "knowledge/rules/[path/to/knowledge-file1]",
  "knowledge/rules/[path/to/knowledge-file2]"
], "Clear explanation of why these knowledge components are needed")
```

This template document provides standardized formats for creating knowledge files during the Rules Workflow Optimization project. 