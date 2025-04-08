# mode: dev-mode | workflow: rules-workflow | pathway: subsystem-parameters | filepath: @parameters/rules/dev-mode/subsystem-parameters.mdc | optional-standard-parameter(s): none

## Purpose

This parameter provides a specialized execution framework for implementing changes to the parameters subsystem of the 1000xbrain cognitive architecture, ensuring documentation-first implementation that maintains the single source of truth architecture.

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: Limited to 1000xbrain/knowledge/system-structure/ and 1000xbrain/parameters/
- **Rationale**: Documentation must be updated first (in knowledge/system-structure/), then implementation in parameters subsystem

## Knowledge Access

For comprehensive understanding of the parameters subsystem, access these knowledge components:

```typescript
// Access parameters subsystem documentation
fetch_rules(["knowledge/system-structure/subsystem-parameters"], 
           "Understanding the parameters subsystem architecture and organization")

// Access related knowledge
fetch_rules([
  "knowledge/system-structure/system-architecture",
  "knowledge/system-structure/pathway-organization",
  "knowledge/system-structure/workflow-subsystem-relationships"
], "Understanding how the parameters subsystem relates to the overall system")
```

## Implementation Approach

The subsystem-parameters pathway in dev-mode implements changes to the parameters subsystem through these sequential activities:

1. **Documentation Update**: Update knowledge/system-structure/subsystem-parameters.md FIRST
2. **Parameters Implementation**: Implement changes to the parameters subsystem files
3. **Cross-Subsystem Verification**: Verify impacts across other subsystems
4. **Implementation Verification**: Verify the implementation meets requirements
5. **Implementation Documentation**: Document the implementation in implementation-progress.md

## Tool Call Process

### Documentation-First Implementation Process

Always follow this documentation-first implementation process:

1. **Read Planning Documents**: Read planning folder documents to understand requirements
2. **Access Knowledge**: Fetch knowledge about the parameters subsystem
3. **Update Documentation First**: Update knowledge/system-structure/subsystem-parameters.md
4. **Implement Parameter Changes**: Implement changes to files in the parameters subsystem
5. **Verify Implementation**: Verify the implementation meets requirements
6. **Document Progress**: Update implementation-progress.md with status

### Example Tool Call Sequence

```typescript
// 1. Read planning documents
read_file("planning/[project-folder]/requirements.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation-progress.md", should_read_entire_file=true)

// 2. Access knowledge
fetch_rules(["knowledge/system-structure/subsystem-parameters"], "Understanding the parameters subsystem")
fetch_rules(["knowledge/system-structure/pathway-organization"], "Understanding pathway organization")

// 3. Update documentation FIRST
edit_file("1000xbrain/knowledge/system-structure/subsystem-parameters.md",
          "Update parameters subsystem documentation",
          "# USE WHEN understanding the parameters subsystem...\n\n[Updated content]...")

// 4. Implement parameter changes
list_dir("1000xbrain/parameters")
list_dir("1000xbrain/parameters/rules/plan-mode")
read_file("1000xbrain/parameters/rules/[mode]/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/parameters/rules/[mode]/[target-file].md",
          "Implement parameters subsystem changes",
          "[Updated content]...")

// 5. Verify implementation
read_file("1000xbrain/parameters/rules/[mode]/[target-file].md", should_read_entire_file=true)

// 6. Document progress
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress",
          "# Implementation Progress\n\n## Implementation Status\n- Current Task: [task]\n- Progress: [progress]...")
```

## Implementation Standards

### Parameters Subsystem Implementation Standards

All parameters subsystem implementation must follow these standards:

1. **Documentation First**: Always update knowledge/system-structure/subsystem-parameters.md before implementing changes
2. **Pathway Consistency**: Maintain consistent pathway structure across workflows
3. **Mode Separation**: Ensure clear separation between plan-mode and dev-mode
4. **Domain Access Clarity**: Clearly define domain access restrictions
5. **Knowledge Integration**: Reference system structure knowledge in all parameters
6. **Tool Call Process Definition**: Define structured tool call processes in all parameters

### Parameter File Structure

Implement parameter files with this structure:

1. **Header**: Standard parameter header with mode, workflow, pathway, and parameter specifications
2. **Purpose**: Clear explanation of the parameter's purpose
3. **Domain Access**: Clear specification of read/edit access domains for the parameter
4. **Knowledge Access**: Clear fetch_rules patterns to access relevant knowledge/system-structure/ files
5. **Implementation Approach**: Specific approach for the pathway
6. **Tool Call Process**: Step-by-step tool call process, always starting with fetch_rules
7. **Verification Framework**: Methods for verifying changes
8. **Success Criteria**: Clear criteria for successful implementation

## Testing and Verification

### Implementation Verification Process

Verify parameters subsystem implementation through this process:

1. **Documentation Verification**: Verify knowledge/system-structure/ documentation is updated
2. **Header Verification**: Verify parameter headers match the standard format
3. **Domain Access Verification**: Verify domain access specifications are correct
4. **Knowledge Reference Verification**: Verify knowledge references are appropriate
5. **Tool Call Process Verification**: Verify tool call processes follow the documentation-first approach

### Common Verification Points

Verify these common aspects of parameters subsystem implementation:

1. **Pathway Organization**: Verify parameters are organized by consistent pathways
2. **Mode Separation**: Verify clear separation between plan-mode and dev-mode
3. **Domain Access Specifications**: Verify domain access is clearly specified
4. **Knowledge References**: Verify knowledge references are appropriate
5. **Tool Call Process**: Verify tool call processes follow the documentation-first approach

## Implementation Completion

### Implementation Complete Signal

When implementation is complete, update implementation-progress.md and signal completion:

```typescript
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress - Implementation complete",
          "# Implementation Progress\n\n## Implementation Status\n- Status: Complete\n- All parameters subsystem changes implemented\n- All verification steps complete...")
```

Then send the implementation-complete signal:

```
💻 1000xdev [rules-workflow]

implementation-complete

Parameters subsystem implementation is complete:
- Documentation updated in knowledge/system-structure/subsystem-parameters.md
- Parameters subsystem changes implemented
- Implementation verified
- All requirements met
```

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For parameters subsystem details, see `knowledge/system-structure/subsystem-parameters.md`
- For pathway organization, see `knowledge/system-structure/pathway-organization.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md` 