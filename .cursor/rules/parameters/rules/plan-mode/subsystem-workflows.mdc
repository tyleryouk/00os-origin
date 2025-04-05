# mode: plan-mode | workflow: rules-workflow | pathway: subsystem-workflows | filepath: @parameters/rules/plan-mode/subsystem-workflows.mdc | optional-standard-parameter(s): none

## Purpose

This parameter provides a specialized execution framework for planning changes specific to the workflows subsystem of the 1000xbrain cognitive architecture, ensuring proper documentation and preparation for implementation.

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: Limited to the /planning directory
- **Rationale**: Plan-mode focuses on documentation creation in the planning directory

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

The subsystem-workflows pathway in plan-mode focuses on planning changes to the workflows subsystem through these activities:

1. **Comprehensive Analysis**: Thoroughly analyze the workflows subsystem structure and organization
2. **Documentation Planning**: Plan documentation updates for workflows subsystem components
3. **Workflow Enhancement Planning**: Plan enhancements to workflow activation and implementation
4. **Implementation Strategy**: Develop a clear implementation strategy for workflow changes
5. **Verification Approach**: Design an approach for verifying workflow subsystem changes
6. **Domain Access Documentation**: Clearly document domain access for implementation

## Planning Workflow

### 1. Initial Analysis Phase

```typescript
// Access workflows subsystem documentation
fetch_rules(["knowledge/system-structure/subsystem-workflows"], 
           "Understanding the workflows subsystem architecture")

// Explore workflows directories to understand structure
list_dir("1000xbrain/workflows")

// Examine workflows by workflow type
list_dir("1000xbrain/workflows/rules")
list_dir("1000xbrain/workflows/front-end")
list_dir("1000xbrain/workflows/back-end")
list_dir("1000xbrain/workflows/quality")
list_dir("1000xbrain/workflows/scripts")

// Read key files to understand workflow organization
read_file("1000xbrain/knowledge/system-structure/subsystem-workflows.md", should_read_entire_file=true)
read_file("1000xbrain/knowledge/system-structure/workflow-subsystem-relationships.md", should_read_entire_file=true)
```

### 2. Documentation Planning Phase

```typescript
// Create/update planning documents
edit_file("planning/[project-folder]/requirements.md",
          "Document workflows subsystem requirements",
          "# Workflows Subsystem Requirements\n\n## Overview\n\nThis document outlines the requirements for changes to the workflows subsystem...")

edit_file("planning/[project-folder]/implementation.md",
          "Document workflows subsystem implementation approach",
          "# Workflows Subsystem Implementation\n\n## Overview\n\nThis document outlines the implementation approach for workflows subsystem changes...")
```

### 3. Implementation Strategy Phase

```typescript
// Document implementation strategy
edit_file("planning/[project-folder]/implementation-progress.md",
          "Create implementation progress tracker",
          "# Implementation Progress: Workflows Subsystem\n\n## Planning Status\n- Planning Phase: In Progress\n- Current Planning Task: Workflows subsystem analysis\n\n## Implementation Status\n- Implementation Phase: Not Started\n- Will be managed by dev-mode\n\n## Workflows Subsystem Analysis\n\n...")
```

### 4. Verification Planning Phase

```typescript
// Plan verification approach
edit_file("planning/[project-folder]/test-cheatsheet.md",
          "Create verification approach for workflows changes",
          "# Verification Approach: Workflows Subsystem\n\n## Overview\n\nThis document outlines the approach for verifying workflows subsystem changes...")
```

## Documentation Standards

### Workflows Subsystem Documentation

All planning documents for workflows subsystem changes should include:

1. **Clear Scope Definition**: Clearly define which aspects of the workflows subsystem will be modified
2. **Workflow Organization**: Document how workflows will be organized and activated
3. **Cross-Subsystem Coordination**: Document how workflows coordinate across subsystems
4. **Implementation Sequence**: Define the sequence of implementation steps
5. **Domain Access Documentation**: Document domain access for implementation
6. **Cross-Subsystem Impacts**: Document impacts on other subsystems

### Documentation Structure

Structure planning documents according to these standards:

1. **requirements.md**: Document what needs to be changed in the workflows subsystem
2. **implementation.md**: Document how the changes will be implemented
3. **implementation-progress.md**: Track progress of planning and implementation
4. **test-cheatsheet.md**: Document verification approach for changes

## Tool Call Process

### Documentation-First Process

Always follow this documentation-first process:

1. **Knowledge Access**: Fetch knowledge about the workflows subsystem
2. **Workflows Analysis**: Analyze workflows subsystem structure and organization
3. **Documentation Creation**: Create comprehensive planning documentation
4. **Implementation Strategy**: Document implementation strategy
5. **Verification Planning**: Plan approach for verifying changes

### Planning Completion

When planning is complete, send the planning-document-complete signal:

```
📋 1000xdev [rules-workflow]

planning-document-complete

Planning is complete with:
- Requirements document with clear objectives for workflows subsystem changes
- Implementation plan with detailed approach
- Context files with essential workflows subsystem information
```

## Transition to Implementation

Once planning is complete, transition to dev-mode for implementation:

```
dev-mode rules-workflow subsystem-workflows @parameters/rules/dev-mode/subsystem-workflows.mdc none
```

This will activate the dev-mode parameter for implementing the planned changes to the workflows subsystem.

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For workflows subsystem details, see `knowledge/system-structure/subsystem-workflows.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md`
- For pathway organization, see `knowledge/system-structure/pathway-organization.md` 