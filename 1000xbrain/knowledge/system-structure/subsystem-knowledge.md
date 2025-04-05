# USE WHEN understanding the knowledge subsystem of the 1000xbrain system

# Subsystem: Knowledge

## Overview

This knowledge file provides comprehensive documentation of the knowledge subsystem within the 1000xbrain cognitive architecture, including its organization, access patterns, and relationships with other subsystems.

## Knowledge Subsystem Purpose

The knowledge subsystem serves as the specialized information repository of the 1000xbrain cognitive architecture, providing:

1. **Domain-Specific Knowledge**: Specialized information for specific domains and workflows
2. **Self-Directed Learning**: Information accessed as needed rather than loaded by default
3. **Implementation Patterns**: Reusable patterns for various implementation contexts
4. **Reference Information**: Canonical knowledge about system structure and concepts
5. **Error Resolution Guidelines**: Approaches for resolving specific error types
6. **Context Expansion**: Detailed information that expands core understanding

As the knowledge repository, this subsystem enables focused, contextual access to specialized information only when needed, preventing cognitive overload.

## Rule Type: Agent Requested

Files in the knowledge subsystem are designated as **Agent Requested** rule type, meaning:

- **On-Demand Access**: Only loaded when specifically requested
- **Self-Determined Learning**: Accessed through AI's own initiative
- **Contextual Application**: Applied only in relevant contexts
- **Selective Loading**: Loaded through the fetch_rules tool
- **Efficiency Focused**: Prevents unnecessary cognitive load

This rule type ensures that specialized knowledge is accessed only when relevant, maintaining cognitive efficiency.

## Knowledge Directory Structure

The knowledge subsystem is organized by domains and workflows:

```
1000xbrain/knowledge/
├── rules/                      # Knowledge specific to rules-workflow
│   ├── patterns/               # Implementation patterns
│   ├── reference/              # Reference documentation
│   ├── guides/                 # Implementation guides
│   └── system-structure/       # System organization knowledge
├── quality/                    # Knowledge specific to quality-workflow
├── front-end/                  # Knowledge specific to front-end-workflow
├── back-end/                   # Knowledge specific to back-end-workflow
├── scripts/                    # Knowledge specific to scripts-workflow
└── common/                     # Knowledge applicable to multiple workflows
```

This organization allows for efficient access to domain-specific knowledge through the fetch_rules tool.

## Access Method: fetch_rules

The knowledge subsystem is accessed through the fetch_rules tool using this pattern:

```typescript
// Basic single file access
fetch_rules(["knowledge/rules/patterns/tool/search-patterns"], 
           "Understanding search patterns for effective queries")

// Multiple related files access
fetch_rules([
  "knowledge/rules/patterns/tool/search-patterns",
  "knowledge/rules/patterns/tool/read-patterns"
], "Understanding file exploration patterns")
```

The fetch_rules tool has two parameters:
1. An array of file paths to knowledge files
2. A clear purpose statement explaining why the knowledge is being accessed

## Key Components

### System Structure Knowledge

The system-structure directory contains definitive documentation about the 1000xbrain architecture:

- **system-architecture.md**: Complete system architecture overview
- **system-vs-subsystem.md**: Clarification of system vs. subsystem concepts
- **subsystem-core.md**: Documentation of the core subsystem
- **subsystem-knowledge.md**: Documentation of the knowledge subsystem
- **subsystem-parameters.md**: Documentation of the parameters subsystem
- **subsystem-workflows.md**: Documentation of the workflows subsystem
- **workflow-subsystem-relationships.md**: Workflow relationships across subsystems
- **pathway-organization.md**: Pathway concept and organization

These files serve as the single source of truth for system structure documentation.

### Implementation Patterns

Pattern directories contain reusable implementation patterns for specific contexts:

- **patterns/tool/**: Patterns for effective tool usage
- **patterns/doc/**: Patterns for documentation creation
- **patterns/impl/**: Patterns for code implementation
- **patterns/verify/**: Patterns for verification
- **patterns/modes/**: Patterns specific to different modes

These patterns provide consistent approaches to common implementation tasks.

### Reference Information

Reference directories contain canonical information about system concepts:

- **reference/syntax/**: Syntax definitions and standards
- **reference/architecture/**: Architectural patterns and principles
- **reference/contributions/**: Guidelines for enhancing the system
- **reference/terminology/**: Definitive terminology explanations

This reference information ensures consistency in understanding and implementation.

### Workflow-Specific Knowledge

Each workflow has its own knowledge directory with specialized information:

- **rules/**: Knowledge for cognitive architecture enhancement
- **quality/**: Knowledge for quality assurance
- **front-end/**: Knowledge for front-end development
- **back-end/**: Knowledge for back-end development
- **scripts/**: Knowledge for scripts and automation

This organization ensures that knowledge is properly contextualized for each workflow.

## Knowledge File Structure

Each knowledge file follows a standardized structure:

1. **Usage Guidance**: "USE WHEN" header explaining when to access the file
2. **Title**: Clear identification of the file's purpose
3. **Overview**: Brief explanation of the file's content and importance
4. **Main Content**: Detailed knowledge organized in clear sections
5. **Examples**: Practical examples demonstrating application
6. **Related Knowledge**: Cross-references to related knowledge files

This structure ensures clarity and effective knowledge integration.

## Agent Requested Rule Behavior

As Agent Requested rule type, knowledge subsystem files:

1. **Load Selectively**: Only loaded when specifically requested
2. **Context-Specific Access**: Accessed based on contextual relevance
3. **Self-Directed Learning**: The AI determines when to access knowledge
4. **Implementation Time Access**: Often accessed during implementation phases
5. **Complement Core Knowledge**: Extends and enhances core understanding

This selective access pattern prevents cognitive overload while ensuring access to specialized knowledge when needed.

## Interaction with Other Subsystems

The knowledge subsystem interacts with other subsystems in these specific ways:

### Knowledge → Core Interaction

The knowledge subsystem extends core understanding:

- Provides detailed implementation of core principles
- Offers examples of core concepts in action
- Specializes general core guidelines for specific contexts
- Maintains consistency with core principles

### Knowledge → Parameters Interaction

The knowledge subsystem informs parameter operation:

- Provides implementation patterns referenced by parameters
- Documents system structure referenced by parameters
- Supplies specialized knowledge needed for parameter execution
- Offers examples of parameter usage in practice

### Knowledge → Workflows Interaction

The knowledge subsystem guides workflow implementation:

- Provides workflow-specific implementation patterns
- Offers detailed guidance for workflow components
- Documents workflow best practices
- Supplies examples of workflow implementation

## Implementation Patterns

When implementing changes to the knowledge subsystem:

1. **Maintain Clear Organization**: Keep knowledge properly organized by domain and workflow
2. **Ensure Consistency**: Align with core principles and existing knowledge
3. **Focus on Specificity**: Provide detailed, specific guidance rather than general principles
4. **Include Practical Examples**: Always include practical examples of application
5. **Use Clear "USE WHEN" Headers**: Begin files with clear usage guidance
6. **Maintain Cross-References**: Include references to related knowledge files

These patterns ensure effective knowledge organization and accessibility.

## Best Practices

### Knowledge Organization

When organizing knowledge files:

1. **Workflow-First**: Organize primary directories by workflow type
2. **Domain-Second**: Within workflows, organize by domain or function
3. **Pattern-Based**: Group implementation patterns together
4. **Reference Separation**: Keep reference documentation separate from implementation guidance
5. **Clear Naming**: Use clear, descriptive file names
6. **Avoid Duplication**: Cross-reference rather than duplicate information

### Knowledge Access Patterns

When accessing knowledge:

1. **Purpose-Driven**: Always specify a clear purpose when using fetch_rules
2. **Minimal Loading**: Request only the knowledge files actually needed
3. **Logical Grouping**: Group related knowledge files in a single request
4. **Contextual Access**: Access knowledge based on contextual relevance
5. **Domain Specificity**: Prefer specific domain knowledge over general information

### Knowledge Creation

When creating new knowledge files:

1. **Begin with Usage Guidance**: Start with a clear "USE WHEN" header
2. **Follow Standard Structure**: Maintain the standard knowledge file structure
3. **Include Practical Examples**: Always provide examples of application
4. **Ensure Consistency**: Align with existing knowledge and core principles
5. **Cross-Reference**: Include references to related knowledge files
6. **Avoid Duplication**: Don't duplicate information available elsewhere

## Common Questions and Answers

### Q: How do I know what knowledge files are available?
A: Knowledge files are listed in the available_instructions section, which provides a searchable directory of available knowledge.

### Q: When should I access knowledge files vs. using core understanding?
A: Access knowledge files when you need specialized, detailed information about specific domains or implementation patterns that go beyond core principles.

### Q: How many knowledge files should I access at once?
A: Access only the knowledge files actually needed for the current context, typically 1-3 files at a time, to prevent cognitive overload.

### Q: What's the difference between knowledge files and parameters?
A: Knowledge files provide information and guidance, while parameters define specific execution frameworks for particular tasks.

## Related Knowledge Files

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For subsystem vs. system relationships, see `knowledge/system-structure/system-vs-subsystem.md`
- For core subsystem details, see `knowledge/system-structure/subsystem-core.md`
- For parameters subsystem details, see `knowledge/system-structure/subsystem-parameters.md`
- For workflows subsystem details, see `knowledge/system-structure/subsystem-workflows.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md` 