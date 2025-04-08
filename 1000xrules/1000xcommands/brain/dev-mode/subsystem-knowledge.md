# mode: dev-mode | workflow: rules-workflow | pathway: subsystem-knowledge | filepath: @parameters/rules/dev-mode/subsystem-knowledge.mdc | optional-standard-parameter(s): none

## Purpose

This parameter provides a specialized execution framework for implementing changes to the knowledge subsystem of the 1000xbrain cognitive architecture, ensuring documentation-first implementation that maintains the single source of truth architecture.

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: Limited to 1000xbrain/knowledge/system-structure/ and 1000xbrain/knowledge/
- **Rationale**: Documentation must be updated first (in knowledge/system-structure/), then implementation in knowledge subsystem

## Knowledge Access

For comprehensive understanding of the knowledge subsystem, access these knowledge components:

```typescript
// Access knowledge subsystem documentation
fetch_rules(["knowledge/system-structure/subsystem-knowledge"], 
           "Understanding the knowledge subsystem architecture and organization")

// Access related knowledge
fetch_rules([
  "knowledge/system-structure/system-architecture",
  "knowledge/system-structure/workflow-subsystem-relationships"
], "Understanding how the knowledge subsystem relates to the overall system")
```

## Implementation Approach

The subsystem-knowledge pathway in dev-mode implements changes to the knowledge subsystem through these sequential activities:

1. **Documentation Update**: Update knowledge/system-structure/subsystem-knowledge.md FIRST
2. **Knowledge Implementation**: Implement changes to the knowledge subsystem files
3. **Cross-Subsystem Verification**: Verify impacts across other subsystems
4. **Implementation Verification**: Verify the implementation meets requirements
5. **Implementation Documentation**: Document the implementation in implementation-progress.md

## Tool Call Process

### Documentation-First Implementation Process

Always follow this documentation-first implementation process:

1. **Read Planning Documents**: Read planning folder documents to understand requirements
2. **Access Knowledge**: Fetch knowledge about the knowledge subsystem
3. **Update Documentation First**: Update knowledge/system-structure/subsystem-knowledge.md
4. **Implement Knowledge Changes**: Implement changes to files in the knowledge subsystem
5. **Verify Implementation**: Verify the implementation meets requirements
6. **Document Progress**: Update implementation-progress.md with status

### Example Tool Call Sequence

```typescript
// 1. Read planning documents
read_file("planning/[project-folder]/requirements.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation-progress.md", should_read_entire_file=true)

// 2. Access knowledge
fetch_rules(["knowledge/system-structure/subsystem-knowledge"], "Understanding the knowledge subsystem")

// 3. Update documentation FIRST
edit_file("1000xbrain/knowledge/system-structure/subsystem-knowledge.md",
          "Update knowledge subsystem documentation",
          "# USE WHEN understanding the knowledge subsystem...\n\n[Updated content]...")

// 4. Implement knowledge changes
list_dir("1000xbrain/knowledge")
read_file("1000xbrain/knowledge/[target-directory]/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/knowledge/[target-directory]/[target-file].md",
          "Implement knowledge subsystem changes",
          "[Updated content]...")

// 5. Verify implementation
read_file("1000xbrain/knowledge/[target-directory]/[target-file].md", should_read_entire_file=true)

// 6. Document progress
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress",
          "# Implementation Progress\n\n## Implementation Status\n- Current Task: [task]\n- Progress: [progress]...")
```

## Implementation Standards

### Knowledge Subsystem Implementation Standards

All knowledge subsystem implementation must follow these standards:

1. **Documentation First**: Always update knowledge/system-structure/subsystem-knowledge.md before implementing changes
2. **Knowledge Organization**: Maintain proper knowledge organization by workflow and domain
3. **File Structure**: Follow the established knowledge file structure with "USE WHEN" headers
4. **Cross-References**: Include cross-references to related knowledge files
5. **Practical Examples**: Include practical examples in knowledge files
6. **Access Pattern Documentation**: Document proper fetch_rules access patterns

### Knowledge File Structure

Implement knowledge files with this structure:

1. **Usage Guidance**: "USE WHEN" header explaining when to access the file
2. **Title**: Clear identification of the file's purpose
3. **Overview**: Brief explanation of the file's content and importance
4. **Main Content**: Detailed knowledge organized in clear sections
5. **Examples**: Practical examples demonstrating application
6. **Related Knowledge**: Cross-references to related knowledge files

## Testing and Verification

### Implementation Verification Process

Verify knowledge subsystem implementation through this process:

1. **Documentation Verification**: Verify knowledge/system-structure/ documentation is updated
2. **Structure Verification**: Verify knowledge files follow proper structure
3. **Content Verification**: Verify knowledge content is accurate and useful
4. **Access Pattern Verification**: Verify fetch_rules patterns work correctly
5. **Cross-Reference Verification**: Verify cross-references are accurate

### Common Verification Points

Verify these common aspects of knowledge subsystem implementation:

1. **Organization Logic**: Verify knowledge is organized logically
2. **Access Efficiency**: Verify knowledge can be accessed efficiently
3. **Content Accuracy**: Verify knowledge content is accurate
4. **File Structure**: Verify knowledge files follow proper structure
5. **Cross-References**: Verify cross-references are accurate

## Implementation Completion

### Implementation Complete Signal

When implementation is complete, update implementation-progress.md and signal completion:

```typescript
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress - Implementation complete",
          "# Implementation Progress\n\n## Implementation Status\n- Status: Complete\n- All knowledge subsystem changes implemented\n- All verification steps complete...")
```

Then send the implementation-complete signal:

```
💻 1000xdev [rules-workflow]

implementation-complete

Knowledge subsystem implementation is complete:
- Documentation updated in knowledge/system-structure/subsystem-knowledge.md
- Knowledge subsystem changes implemented
- Implementation verified
- All requirements met
```

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For knowledge subsystem details, see `knowledge/system-structure/subsystem-knowledge.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md` 