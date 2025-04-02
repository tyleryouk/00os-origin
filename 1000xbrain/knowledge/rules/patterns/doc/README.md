# Verification System Enhancement
...

# Documentation Pattern Requirements

## USE WHEN Header Requirement

All files in this directory MUST include a "USE WHEN" header at the very top of the file. This header clearly indicates when the pattern should be used and helps with discovering relevant patterns through the available_instructions system.

### Proper Format

The USE WHEN header must:
1. Be the very first line of the file
2. Start with "# USE WHEN" (all caps)
3. List 2-4 primary use cases in -ing verb form, separated by commas
4. Be followed by a blank line before the main title

### Examples

```markdown
# USE WHEN structuring documentation hierarchies, establishing component relationships, or implementing progressive disclosure

# Hierarchical Relationship Guide
...
```

| Pattern File | Purpose | When to Use |
|--------------|---------|-------------|
| [standard-file-template.md](standard-file-template.md) | Provides standardized file structure for all documentation | When creating any new documentation file |
| [information-chunking-guide.md](information-chunking-guide.md) | Patterns for organizing information into logical chunks | When structuring content within a file |
| [reference-architecture-guide.md](reference-architecture-guide.md) | Patterns for organizing references between components | When establishing references between files |
| [reference-format-template.md](reference-format-template.md) | Concrete formatting templates for all reference types | When creating or updating specific references |
| [direct-reference-patterns.md](direct-reference-patterns.md) | Standardized direct reference paths for frequently accessed files | When optimizing reference paths and reducing chains |
| [fetch-rules-optimization.md](fetch-rules-optimization.md) | Patterns for optimizing fetch_rules usage and efficiency | When accessing knowledge components with fetch_rules |
| [hierarchical-relationship-guide.md](hierarchical-relationship-guide.md) | Patterns for establishing parent-child relationships | When creating hierarchical documentation |
| [progressive-disclosure-guide.md](progressive-disclosure-guide.md) | Patterns for structuring information from simple to complex | When organizing complex information |
| [cognitive-load-optimization.md](cognitive-load-optimization.md) | Comprehensive guidance for optimizing cognitive load and context management | When improving information processing efficiency and context utilization |

### Template Files

| Template File | Purpose | When to Use |
|--------------|---------|-------------|
| [templates/parameter-template.md](templates/parameter-template.md) | Template for creating parameter documentation | When documenting new parameters |

## Pattern Usage Flow

For optimal documentation development, follow this recommended pattern usage flow:

1. **Start with Structure**: Apply [standard-file-template.md](standard-file-template.md) to create the basic file structure
2. **Establish Relationships**: Use [hierarchical-relationship-guide.md](hierarchical-relationship-guide.md) to define the file's place in the documentation hierarchy
3. **Organize Information**: Apply [information-chunking-guide.md](information-chunking-guide.md) to organize content into logical chunks
4. **Structure Complexity**: Implement [progressive-disclosure-guide.md](progressive-disclosure-guide.md) to organize information from simple to complex
5. **Define References**: Follow [reference-architecture-guide.md](reference-architecture-guide.md) to establish reference architecture
6. **Format References**: Apply [reference-format-template.md](reference-format-template.md) to ensure consistent reference formatting
7. **Optimize References**: Use [direct-reference-patterns.md](direct-reference-patterns.md) to create efficient reference paths
8. **Optimize Knowledge Access**: Apply [fetch-rules-optimization.md](fetch-rules-optimization.md) when accessing knowledge components
9. **Optimize Cognitive Load**: Apply [cognitive-load-optimization.md](cognitive-load-optimization.md) to optimize information processing and context management

## Pattern Relationships

These patterns are designed to work together as an integrated system:

```
┌─────────────────────────┐
│                         │
│  standard-file-template │
│                         │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐     ┌─────────────────────────┐
│                         │     │                         │
│ hierarchical-relationship◄─────► information-chunking    │
│                         │     │                         │
└───────────┬─────────────┘     └───────────┬─────────────┘
            │                               │
            ▼                               ▼
┌─────────────────────────┐     ┌─────────────────────────┐
│                         │     │                         │
│ reference-architecture  ├────►│ reference-format        │
│                         │     │                         │
└───────────┬─────────────┘     └───────────┬─────────────┘
            │                               │
            ▼                               │
┌─────────────────────────┐                 │
│                         │                 │
│ direct-reference        │◄────────────────┘
│                         │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐     ┌─────────────────────────┐
│                         │     │                         │
│ progressive-disclosure  ├────►│ cognitive-load-optimization│
│                         │     │                         │
└─────────────────────────┘     └──────────┬──────────────┘
                                           │
                                           ▼
                                ┌─────────────────────────┐
                                │                         │
                                │ fetch-rules-optimization│
                                │                         │
                                └─────────────────────────┘
```

## Implementation Benefits

Using these documentation patterns consistently provides several key benefits:

1. **Cognitive Efficiency**: Reduces cognitive load through consistent organization
2. **Clearer Relationships**: Establishes explicit relationships between components
3. **Progressive Understanding**: Supports learning complex concepts incrementally
4. **Reduced Redundancy**: Eliminates duplicate information through proper references
5. **Hallucination Prevention**: Creates clear boundaries and explicit relationships
6. **Improved Navigation**: Makes documentation easier to navigate and understand
7. **Enhanced Maintainability**: Simplifies documentation updates and maintenance
8. **Reference Consistency**: Ensures consistent reference formats across all documentation
9. **Reference Optimization**: Minimizes reference chain complexity and improves reliability
10. **Knowledge Access Efficiency**: Improves fetch_rules usage for better context preservation
11. **Context Management**: Optimizes context window utilization and reduces context switching

## Best Practices

For optimal results when using these patterns:

1. **Consistency**: Apply patterns consistently across all documentation
2. **Completeness**: Implement all relevant patterns in each document
3. **Clarity**: Maintain clear boundaries between different components
4. **Contextual Application**: Adapt patterns to specific documentation needs
5. **Hierarchical Integrity**: Maintain proper hierarchical relationships
6. **Reference Validation**: Ensure all references are valid and properly formatted
7. **Progressive Structure**: Structure information from simple to complex
8. **Format Standardization**: Use standardized reference formats for all references
9. **Reference Efficiency**: Optimize reference paths for frequently accessed components
10. **Knowledge Access Optimization**: Consolidate and optimize fetch_rules calls
11. **Cognitive Load Management**: Optimize information organization for efficient processing

## Related Knowledge Components

These patterns are part of the broader documentation system and relate to:

- **Core Architecture**: Defines the fundamental structure of the cognitive architecture
- **Workflow Processes**: Documents the implementation processes for various workflows
- **Knowledge Organization**: Establishes how specialized knowledge is organized and accessed
- **Parameter System**: Defines how parameters are documented and managed 