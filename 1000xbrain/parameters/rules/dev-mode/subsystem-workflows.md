# mode: dev-mode | workflow: rules-workflow | pathway: subsystem-workflows | filepath: @parameters/rules/dev-mode/subsystem-workflows.mdc | optional-standard-parameter(s): none

## Purpose

This parameter provides a specialized execution framework for implementing changes to the workflows subsystem of the 1000xbrain cognitive architecture, ensuring documentation-first implementation that maintains the single source of truth architecture.

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: Limited to 1000xbrain/knowledge/system-structure/ and 1000xbrain/workflows/
- **Rationale**: Documentation must be updated first (in knowledge/system-structure/), then implementation in workflows subsystem

## Knowledge Access

For comprehensive understanding of the workflows subsystem, access these knowledge components:

```typescript
// Access workflows subsystem documentation
fetch_rules(["knowledge/system-structure/subsystem-workflows"], 
           "Understanding the workflows subsystem architecture and organization")

// Access related knowledge
fetch_rules([
  "knowledge/system-structure/system-architecture",
  "knowledge/system-structure/workflow-subsystem-relationships",
  "knowledge/system-structure/pathway-organization"
], "Understanding how the workflows subsystem relates to the overall system")
```

## Implementation Approach

The subsystem-workflows pathway in dev-mode implements changes to the workflows subsystem through these sequential activities:

1. **Documentation Update**: Update knowledge/system-structure/subsystem-workflows.md FIRST
2. **Workflows Implementation**: Implement changes to the workflows subsystem files
3. **Cross-Subsystem Verification**: Verify impacts across other subsystems
4. **Implementation Verification**: Verify the implementation meets requirements
5. **Implementation Documentation**: Document the implementation in implementation-progress.md

## Tool Call Process

### Documentation-First Implementation Process

Always follow this documentation-first implementation process:

1. **Read Planning Documents**: Read planning folder documents to understand requirements
2. **Access Knowledge**: Fetch knowledge about the workflows subsystem
3. **Update Documentation First**: Update knowledge/system-structure/subsystem-workflows.md
4. **Implement Workflow Changes**: Implement changes to files in the workflows subsystem
5. **Verify Implementation**: Verify the implementation meets requirements
6. **Document Progress**: Update implementation-progress.md with status

### Example Tool Call Sequence

```typescript
// 1. Read planning documents
read_file("planning/[project-folder]/requirements.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation-progress.md", should_read_entire_file=true)

// 2. Access knowledge
fetch_rules(["knowledge/system-structure/subsystem-workflows"], "Understanding the workflows subsystem")
fetch_rules(["knowledge/system-structure/workflow-subsystem-relationships"], "Understanding workflow relationships")

// 3. Update documentation FIRST
edit_file("1000xbrain/knowledge/system-structure/subsystem-workflows.md",
          "Update workflows subsystem documentation",
          "# USE WHEN understanding the workflows subsystem...\n\n[Updated content]...")

// 4. Implement workflow changes
list_dir("1000xbrain/workflows")
list_dir("1000xbrain/workflows/[workflow-type]")
read_file("1000xbrain/workflows/[workflow-type]/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/workflows/[workflow-type]/[target-file].md",
          "Implement workflows subsystem changes",
          "[Updated content]...")

// 5. Verify implementation
read_file("1000xbrain/workflows/[workflow-type]/[target-file].md", should_read_entire_file=true)

// 6. Document progress
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress",
          "# Implementation Progress\n\n## Implementation Status\n- Current Task: [task]\n- Progress: [progress]...")
```

## Implementation Standards

### Workflows Subsystem Implementation Standards

All workflows subsystem implementation must follow these standards:

1. **Documentation First**: Always update knowledge/system-structure/subsystem-workflows.md before implementing changes
2. **Workflow Type Clarity**: Maintain clear organization by workflow type
3. **File Structure**: Follow the established workflow file structure
4. **Activation Pattern Clarity**: Clearly define activation patterns for workflows
5. **Cross-Subsystem Coordination**: Consider how workflows span across subsystems
6. **Implementation Standards**: Document workflow-specific implementation standards

### Workflow File Structure

Implement workflow files with this structure:

1. **Title**: Clear identification of the workflow's purpose
2. **Overview**: Brief explanation of the workflow's scope and importance
3. **Implementation Standards**: Standards specific to this workflow
4. **Best Practices**: Best practices for effective implementation
5. **Examples**: Practical examples demonstrating implementation
6. **Cross-Subsystem Guidance**: How this workflow is implemented across subsystems

## Testing and Verification

### Implementation Verification Process

Verify workflows subsystem implementation through this process:

1. **Documentation Verification**: Verify knowledge/system-structure/ documentation is updated
2. **Structure Verification**: Verify workflow files follow proper structure
3. **Activation Verification**: Verify workflow activation patterns are correct
4. **Cross-Subsystem Verification**: Verify workflow coordination across subsystems
5. **Implementation Standards Verification**: Verify workflow-specific standards are documented

### Common Verification Points

Verify these common aspects of workflows subsystem implementation:

1. **Workflow Type Organization**: Verify workflows are organized by type
2. **Activation Patterns**: Verify activation patterns are clearly defined
3. **Cross-Subsystem Coordination**: Verify workflows coordinate across subsystems
4. **Implementation Standards**: Verify workflow-specific standards are documented
5. **File Structure**: Verify workflow files follow proper structure

## Implementation Completion

### Implementation Complete Signal

When implementation is complete, update implementation-progress.md and signal completion:

```typescript
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress - Implementation complete",
          "# Implementation Progress\n\n## Implementation Status\n- Status: Complete\n- All workflows subsystem changes implemented\n- All verification steps complete...")
```

Then send the implementation-complete signal:

```
💻 1000xdev [rules-workflow]

implementation-complete

Workflows subsystem implementation is complete:
- Documentation updated in knowledge/system-structure/subsystem-workflows.md
- Workflows subsystem changes implemented
- Implementation verified
- All requirements met
```

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For workflows subsystem details, see `knowledge/system-structure/subsystem-workflows.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md`
- For pathway organization, see `knowledge/system-structure/pathway-organization.md` 