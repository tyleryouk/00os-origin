# mode: dev-mode | workflow: rules-workflow | pathway: subsystem-core | filepath: @parameters/rules/dev-mode/subsystem-core.mdc | optional-standard-parameter(s): none

## Purpose

This parameter provides a specialized execution framework for implementing changes to the core subsystem of the 1000xbrain cognitive architecture, ensuring documentation-first implementation that maintains the single source of truth architecture.

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: Limited to 1000xbrain/knowledge/system-structure/ and 1000xbrain/core/
- **Rationale**: Documentation must be updated first (in knowledge/system-structure/), then implementation in core subsystem

## Knowledge Access

For comprehensive understanding of the core subsystem, access these knowledge components:

```typescript
// Access core subsystem knowledge
fetch_rules(["knowledge/system-structure/subsystem-core"], 
           "Understanding the core subsystem architecture and organization")

// Access related knowledge
fetch_rules([
  "knowledge/system-structure/system-architecture",
  "knowledge/system-structure/workflow-subsystem-relationships"
], "Understanding how the core subsystem relates to the overall system")
```

## Implementation Approach

The subsystem-core pathway in dev-mode implements changes to the core subsystem through these sequential activities:

1. **Documentation Update**: Update knowledge/system-structure/subsystem-core.md FIRST
2. **Core Implementation**: Implement changes to the core subsystem files
3. **Cross-Subsystem Verification**: Verify impacts across other subsystems
4. **Implementation Verification**: Verify the implementation meets requirements
5. **Implementation Documentation**: Document the implementation in implementation-progress.md

## Tool Call Process

### Documentation-First Implementation Process

Always follow this documentation-first implementation process:

1. **Read Planning Documents**: Read planning folder documents to understand requirements
2. **Access Knowledge**: Fetch knowledge about the core subsystem
3. **Update Documentation First**: Update knowledge/system-structure/subsystem-core.md
4. **Implement Core Changes**: Implement changes to files in the core subsystem
5. **Verify Implementation**: Verify the implementation meets requirements
6. **Document Progress**: Update implementation-progress.md with status

### Example Tool Call Sequence

```typescript
// 1. Read planning documents
read_file("planning/[project-folder]/requirements.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation-progress.md", should_read_entire_file=true)

// 2. Access knowledge
fetch_rules(["knowledge/system-structure/subsystem-core"], "Understanding the core subsystem")

// 3. Update documentation FIRST
edit_file("1000xbrain/knowledge/system-structure/subsystem-core.md",
          "Update core subsystem documentation",
          "# USE WHEN understanding the core subsystem...\n\n[Updated content]...")

// 4. Implement core changes
list_dir("1000xbrain/core")
read_file("1000xbrain/core/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/core/[target-file].md",
          "Implement core subsystem changes",
          "[Updated content]...")

// 5. Verify implementation
read_file("1000xbrain/core/[target-file].md", should_read_entire_file=true)

// 6. Document progress
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress",
          "# Implementation Progress\n\n## Implementation Status\n- Current Task: [task]\n- Progress: [progress]...")
```

## Implementation Standards

### Core Subsystem Implementation Standards

All core subsystem implementation must follow these standards:

1. **Documentation First**: Always update knowledge/system-structure/subsystem-core.md before implementing changes
2. **Consistency with Core Identity**: Ensure changes align with core identity defined in global-rules.md
3. **Mode System Integrity**: Maintain clear separation between modes
4. **Communication Standards**: Follow established communication standards
5. **Cross-Subsystem Consideration**: Consider impacts on other subsystems
6. **Structured Organization**: Maintain the established directory structure

### Core Subsystem File Types

Implement changes to these core subsystem file types:

1. **Identity Files**: Define who 1000xdev is and how it operates
2. **Mode System Files**: Manage operational states (plan-mode, dev-mode, direct-mode)
3. **Communication Files**: Define structured communication protocols
4. **Tool Files**: Define standards for tool usage

## Testing and Verification

### Implementation Verification Process

Verify core subsystem implementation through this process:

1. **Consistency Verification**: Verify consistency with core identity
2. **Function Verification**: Verify core functionality works as expected
3. **Cross-Subsystem Verification**: Verify impacts on other subsystems
4. **Documentation Alignment**: Verify implementation aligns with documentation

### Common Verification Points

Verify these common aspects of core subsystem implementation:

1. **Identity Consistency**: Verify changes align with core identity
2. **Mode Separation**: Verify clear separation between modes
3. **Communication Protocols**: Verify communication standards are followed
4. **Tool Usage Standards**: Verify tool usage standards are followed
5. **Cross-Subsystem Impacts**: Verify impacts on other subsystems

## Implementation Completion

### Implementation Complete Signal

When implementation is complete, update implementation-progress.md and signal completion:

```typescript
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress - Implementation complete",
          "# Implementation Progress\n\n## Implementation Status\n- Status: Complete\n- All core subsystem changes implemented\n- All verification steps complete...")
```

Then send the implementation-complete signal:

```
💻 1000xdev [rules-workflow]

implementation-complete

Core subsystem implementation is complete:
- Documentation updated in knowledge/system-structure/subsystem-core.md
- Core subsystem changes implemented
- Implementation verified
- All requirements met
```

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For core subsystem details, see `knowledge/system-structure/subsystem-core.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md` 