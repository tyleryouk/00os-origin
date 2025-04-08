# mode: plan-mode | workflow: rules-workflow | pathway: subsystem-knowledge | filepath: @parameters/rules/plan-mode/subsystem-knowledge.mdc | optional-standard-parameter(s): none

## Purpose

This parameter provides a specialized execution framework for planning changes specific to the knowledge subsystem of the 1000xbrain cognitive architecture, ensuring proper documentation and preparation for implementation.

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: Limited to the /planning directory
- **Rationale**: Plan-mode focuses on documentation creation in the planning directory

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

The subsystem-knowledge pathway in plan-mode focuses on planning changes to the knowledge subsystem through these activities:

1. **Comprehensive Analysis**: Thoroughly analyze the knowledge subsystem structure and organization
2. **Documentation Planning**: Plan documentation updates for knowledge subsystem components
3. **Knowledge Enhancement Planning**: Plan enhancements to knowledge organization and access
4. **Implementation Strategy**: Develop a clear implementation strategy for knowledge changes
5. **Verification Approach**: Design an approach for verifying knowledge subsystem changes
6. **Domain Access Documentation**: Clearly document domain access for implementation

## Planning Workflow

### 1. Initial Analysis Phase

```typescript
// Access knowledge subsystem documentation
fetch_rules(["knowledge/system-structure/subsystem-knowledge"], 
           "Understanding the knowledge subsystem architecture")

// Explore knowledge directories to understand structure
list_dir("1000xbrain/knowledge")

// Examine knowledge components by workflow
list_dir("1000xbrain/knowledge/rules")
list_dir("1000xbrain/knowledge/front-end")
list_dir("1000xbrain/knowledge/back-end")

// Read key files to understand knowledge organization
read_file("1000xbrain/knowledge/rules/system-structure/subsystem-knowledge.md", should_read_entire_file=true)
```

### 2. Documentation Planning Phase

```typescript
// Create/update planning documents
edit_file("planning/[project-folder]/requirements.md",
          "Document knowledge subsystem requirements",
          "# Knowledge Subsystem Requirements\n\n## Overview\n\nThis document outlines the requirements for changes to the knowledge subsystem...")

edit_file("planning/[project-folder]/implementation.md",
          "Document knowledge subsystem implementation approach",
          "# Knowledge Subsystem Implementation\n\n## Overview\n\nThis document outlines the implementation approach for knowledge subsystem changes...")
```

### 3. Implementation Strategy Phase

```typescript
// Document implementation strategy
edit_file("planning/[project-folder]/implementation-progress.md",
          "Create implementation progress tracker",
          "# Implementation Progress: Knowledge Subsystem\n\n## Planning Status\n- Planning Phase: In Progress\n- Current Planning Task: Knowledge subsystem analysis\n\n## Implementation Status\n- Implementation Phase: Not Started\n- Will be managed by dev-mode\n\n## Knowledge Subsystem Analysis\n\n...")
```

### 4. Verification Planning Phase

```typescript
// Plan verification approach
edit_file("planning/[project-folder]/test-cheatsheet.md",
          "Create verification approach for knowledge changes",
          "# Verification Approach: Knowledge Subsystem\n\n## Overview\n\nThis document outlines the approach for verifying knowledge subsystem changes...")
```

## Documentation Standards

### Knowledge Subsystem Documentation

All planning documents for knowledge subsystem changes should include:

1. **Clear Scope Definition**: Clearly define which aspects of the knowledge subsystem will be modified
2. **Knowledge Organization**: Document how knowledge will be organized
3. **Access Patterns**: Document how knowledge will be accessed
4. **Implementation Sequence**: Define the sequence of implementation steps
5. **Domain Access Documentation**: Document domain access for implementation
6. **Cross-Subsystem Impacts**: Document impacts on other subsystems

### Documentation Structure

Structure planning documents according to these standards:

1. **requirements.md**: Document what needs to be changed in the knowledge subsystem
2. **implementation.md**: Document how the changes will be implemented
3. **implementation-progress.md**: Track progress of planning and implementation
4. **test-cheatsheet.md**: Document verification approach for changes

## Tool Call Process

### Documentation-First Process

Always follow this documentation-first process:

1. **Knowledge Access**: Fetch knowledge about the knowledge subsystem
2. **Knowledge Analysis**: Analyze knowledge subsystem structure and organization
3. **Documentation Creation**: Create comprehensive planning documentation
4. **Implementation Strategy**: Document implementation strategy
5. **Verification Planning**: Plan approach for verifying changes

### Planning Completion

When planning is complete, send the planning-document-complete signal:

```
📋 1000xdev [rules-workflow]

planning-document-complete

Planning is complete with:
- Requirements document with clear objectives for knowledge subsystem changes
- Implementation plan with detailed approach
- Context files with essential knowledge subsystem information
```

## Transition to Implementation

Once planning is complete, transition to dev-mode for implementation:

```
dev-mode rules-workflow subsystem-knowledge @parameters/rules/dev-mode/subsystem-knowledge.mdc none
```

This will activate the dev-mode parameter for implementing the planned changes to the knowledge subsystem.

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For knowledge subsystem details, see `knowledge/system-structure/subsystem-knowledge.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md` 