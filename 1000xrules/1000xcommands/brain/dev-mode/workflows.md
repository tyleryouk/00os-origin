# mode: dev-mode | workflow: rules-workflow | pathway: workflows | filepath: @parameters/rules/dev-mode/workflows.mdc | optional-standard-parameter(s): [workflow-type]

## Purpose

This parameter provides a specialized execution framework for implementing changes to a specific workflow type across multiple subsystems, ensuring documentation-first implementation that maintains the single source of truth architecture. The workflow-type is specified as an optional standard parameter.

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: Based on the workflow-type, following relevant subsystem patterns:
  - First: 1000xbrain/knowledge/system-structure/
  - Then: 1000xbrain/core/[workflow-type]/, 1000xbrain/knowledge/[workflow-type]/, 1000xbrain/parameters/[workflow-type]/, 1000xbrain/workflows/[workflow-type]/
- **Rationale**: Documentation must be updated first, then implementation across all subsystems that implement the workflow

## Knowledge Access

For comprehensive understanding of workflow relationships, access these knowledge components:

```typescript
// Access workflow relationships documentation
fetch_rules(["knowledge/system-structure/workflow-subsystem-relationships"], 
           "Understanding how workflows span across subsystems")

// Access related knowledge
fetch_rules([
  "knowledge/system-structure/system-architecture",
  "knowledge/system-structure/pathway-organization",
  "knowledge/system-structure/subsystem-workflows"
], "Understanding how workflows integrate with the system architecture")
```

## Implementation Approach

The workflows pathway in dev-mode implements changes to a specific workflow type through these sequential activities:

1. **Documentation Update**: Update knowledge/system-structure/workflow-subsystem-relationships.md FIRST
2. **Core Subsystem Implementation**: Implement changes to workflow files in the core subsystem
3. **Knowledge Subsystem Implementation**: Implement changes to workflow files in the knowledge subsystem
4. **Parameters Subsystem Implementation**: Implement changes to workflow files in the parameters subsystem
5. **Workflows Subsystem Implementation**: Implement changes to workflow files in the workflows subsystem
6. **Cross-Subsystem Verification**: Verify consistency across all subsystem implementations
7. **Implementation Documentation**: Document the implementation in implementation-progress.md

## Tool Call Process

### Documentation-First Implementation Process

Always follow this documentation-first implementation process:

1. **Read Planning Documents**: Read planning folder documents to understand requirements
2. **Access Knowledge**: Fetch knowledge about workflow relationships
3. **Update Documentation First**: Update knowledge/system-structure/workflow-subsystem-relationships.md
4. **Implement Core Changes**: Implement changes to files in the core subsystem for the workflow
5. **Implement Knowledge Changes**: Implement changes to files in the knowledge subsystem for the workflow
6. **Implement Parameter Changes**: Implement changes to files in the parameters subsystem for the workflow
7. **Implement Workflow Changes**: Implement changes to files in the workflows subsystem for the workflow
8. **Verify Cross-Subsystem Consistency**: Verify consistency across all subsystem implementations
9. **Document Progress**: Update implementation-progress.md with status

### Example Tool Call Sequence

```typescript
// 1. Read planning documents
read_file("planning/[project-folder]/requirements.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation-progress.md", should_read_entire_file=true)

// 2. Access knowledge
fetch_rules(["knowledge/system-structure/workflow-subsystem-relationships"], 
           "Understanding how workflows span across subsystems")
fetch_rules(["knowledge/system-structure/subsystem-workflows"], 
           "Understanding the workflows subsystem")

// 3. Update documentation FIRST
edit_file("1000xbrain/knowledge/system-structure/workflow-subsystem-relationships.md",
          "Update workflow relationships documentation for [workflow-type]",
          "# USE WHEN understanding how workflows span across subsystems...\n\n[Updated content to include [workflow-type] changes]...")

// 4. Implement core subsystem changes
list_dir("1000xbrain/core/[workflow-type]")
read_file("1000xbrain/core/[workflow-type]/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/core/[workflow-type]/[target-file].md",
          "Implement [workflow-type] changes in core subsystem",
          "[Updated content]...")

// 5. Implement knowledge subsystem changes
list_dir("1000xbrain/knowledge/[workflow-type]")
read_file("1000xbrain/knowledge/[workflow-type]/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/knowledge/[workflow-type]/[target-file].md",
          "Implement [workflow-type] changes in knowledge subsystem",
          "[Updated content]...")

// 6. Implement parameters subsystem changes
list_dir("1000xbrain/parameters/[workflow-type]")
read_file("1000xbrain/parameters/[workflow-type]/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/parameters/[workflow-type]/[target-file].md",
          "Implement [workflow-type] changes in parameters subsystem",
          "[Updated content]...")

// 7. Implement workflows subsystem changes
list_dir("1000xbrain/workflows/[workflow-type]")
read_file("1000xbrain/workflows/[workflow-type]/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/workflows/[workflow-type]/[target-file].md",
          "Implement [workflow-type] changes in workflows subsystem",
          "[Updated content]...")

// 8. Verify cross-subsystem consistency
grep_search("[specific-term]", false, "1000xbrain/core/[workflow-type]/**/*.md")
grep_search("[specific-term]", false, "1000xbrain/knowledge/[workflow-type]/**/*.md")
grep_search("[specific-term]", false, "1000xbrain/parameters/[workflow-type]/**/*.md")
grep_search("[specific-term]", false, "1000xbrain/workflows/[workflow-type]/**/*.md")

// 9. Document progress
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress",
          "# Implementation Progress\n\n## Implementation Status\n- Current Task: [task]\n- Progress: [progress]...")
```

## Implementation Standards

### Cross-Subsystem Implementation Standards

All workflow implementations must follow these standards:

1. **Documentation First**: Always update knowledge/system-structure/ documentation before implementing changes
2. **Implementation Sequence**: Implement changes in this order: core → knowledge → parameters → workflows
3. **Terminology Consistency**: Use consistent terminology across all subsystem implementations
4. **Pattern Consistency**: Apply consistent patterns across all subsystem implementations
5. **Cross-References**: Include clear references to related files in other subsystems
6. **Coordination**: Ensure changes are coordinated across all subsystems

### Subsystem-Specific Implementation Focus

Each subsystem has a specific focus for workflow implementation:

1. **Core Subsystem**: Focus on fundamental principles for the workflow
2. **Knowledge Subsystem**: Focus on specialized knowledge for the workflow
3. **Parameters Subsystem**: Focus on execution frameworks for the workflow
4. **Workflows Subsystem**: Focus on implementation guidance for the workflow

## Testing and Verification

### Cross-Subsystem Verification Process

Verify workflow implementation across subsystems through this process:

1. **Documentation Verification**: Verify knowledge/system-structure/ documentation is updated
2. **Cross-Subsystem Consistency**: Verify consistent implementation across all subsystems
3. **Terminology Consistency**: Verify consistent terminology across all subsystems
4. **Pattern Consistency**: Verify consistent patterns across all subsystems
5. **Reference Accuracy**: Verify accurate cross-references between subsystems

### Common Verification Points

Verify these common aspects of workflow implementation:

1. **Core Principles**: Verify core principles are clearly defined
2. **Knowledge Organization**: Verify knowledge is properly organized
3. **Parameter Structure**: Verify parameters follow proper structure
4. **Workflow Guidance**: Verify implementation guidance is clear
5. **Cross-Subsystem Coordination**: Verify coordination across subsystems

## Implementation Completion

### Implementation Complete Signal

When implementation is complete, update implementation-progress.md and signal completion:

```typescript
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress - Implementation complete",
          "# Implementation Progress\n\n## Implementation Status\n- Status: Complete\n- All [workflow-type] changes implemented across all subsystems\n- All verification steps complete...")
```

Then send the implementation-complete signal:

```
💻 1000xdev [rules-workflow]

implementation-complete

[Workflow-type] implementation is complete:
- Documentation updated in knowledge/system-structure/
- [Workflow-type] changes implemented across all subsystems
- Implementation verified for cross-subsystem consistency
- All requirements met
```

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For workflow implementation across subsystems, see `knowledge/system-structure/workflow-subsystem-relationships.md`
- For workflows subsystem details, see `knowledge/system-structure/subsystem-workflows.md`
- For pathway organization, see `knowledge/system-structure/pathway-organization.md` 