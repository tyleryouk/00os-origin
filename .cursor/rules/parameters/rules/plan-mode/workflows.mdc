# mode: plan-mode | workflow: rules-workflow | pathway: workflows | filepath: @parameters/rules/plan-mode/workflows.mdc | optional-standard-parameter(s): [workflow-type]

## Purpose

This parameter provides a specialized execution framework for planning changes to a specific workflow type across multiple subsystems, ensuring proper documentation and preparation for implementation. The workflow-type is specified as an optional standard parameter.

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: Limited to the /planning directory
- **Rationale**: Plan-mode focuses on documentation creation in the planning directory

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

The workflows pathway in plan-mode focuses on planning changes to a specific workflow type through these activities:

1. **Cross-Subsystem Analysis**: Thoroughly analyze how the workflow spans across all subsystems
2. **Documentation Planning**: Plan documentation updates for workflow components across subsystems
3. **Workflow Enhancement Planning**: Plan enhancements to workflow implementation in each subsystem
4. **Implementation Strategy**: Develop a clear implementation strategy for workflow changes
5. **Verification Approach**: Design an approach for verifying workflow changes across subsystems
6. **Domain Access Documentation**: Clearly document domain access for implementation

## Planning Workflow

### 1. Initial Analysis Phase

```typescript
// Access workflow relationship documentation
fetch_rules(["knowledge/system-structure/workflow-subsystem-relationships"], 
           "Understanding how the [workflow-type] spans across subsystems")

// Explore workflow implementation across subsystems
list_dir("1000xbrain/core/[workflow-type]")
list_dir("1000xbrain/knowledge/[workflow-type]")
list_dir("1000xbrain/parameters/[workflow-type]")
list_dir("1000xbrain/workflows/[workflow-type]")

// Read key documentation files
read_file("1000xbrain/knowledge/system-structure/workflow-subsystem-relationships.md", should_read_entire_file=true)
read_file("1000xbrain/knowledge/system-structure/subsystem-workflows.md", should_read_entire_file=true)
```

### 2. Documentation Planning Phase

```typescript
// Create/update planning documents
edit_file("planning/[project-folder]/requirements.md",
          "Document [workflow-type] requirements",
          "# [Workflow-Type] Requirements\n\n## Overview\n\nThis document outlines the requirements for changes to the [workflow-type] across all subsystems...")

edit_file("planning/[project-folder]/implementation.md",
          "Document [workflow-type] implementation approach",
          "# [Workflow-Type] Implementation\n\n## Overview\n\nThis document outlines the implementation approach for [workflow-type] changes across all subsystems...")
```

### 3. Implementation Strategy Phase

```typescript
// Document implementation strategy
edit_file("planning/[project-folder]/implementation-progress.md",
          "Create implementation progress tracker",
          "# Implementation Progress: [Workflow-Type]\n\n## Planning Status\n- Planning Phase: In Progress\n- Current Planning Task: [workflow-type] analysis\n\n## Implementation Status\n- Implementation Phase: Not Started\n- Will be managed by dev-mode\n\n## [Workflow-Type] Analysis\n\n...")
```

### 4. Verification Planning Phase

```typescript
// Plan verification approach
edit_file("planning/[project-folder]/test-cheatsheet.md",
          "Create verification approach for [workflow-type] changes",
          "# Verification Approach: [Workflow-Type]\n\n## Overview\n\nThis document outlines the approach for verifying [workflow-type] changes across all subsystems...")
```

## Documentation Standards

### Workflow Documentation

All planning documents for workflow changes should include:

1. **Cross-Subsystem Scope**: Clearly define how the workflow spans across all subsystems
2. **Subsystem-Specific Changes**: Document required changes in each subsystem
3. **Coordination Strategy**: Document how changes will be coordinated across subsystems
4. **Implementation Sequence**: Define the sequence of implementation steps
5. **Domain Access Specification**: Document domain access for implementation in each subsystem
6. **Consistency Requirements**: Document requirements for maintaining consistency across subsystems

### Documentation Structure

Structure planning documents according to these standards:

1. **requirements.md**: Document what needs to be changed in the workflow across subsystems
2. **implementation.md**: Document how the changes will be implemented
3. **implementation-progress.md**: Track progress of planning and implementation
4. **test-cheatsheet.md**: Document verification approach for changes

## Tool Call Process

### Documentation-First Process

Always follow this documentation-first process:

1. **Knowledge Access**: Fetch knowledge about workflow relationships
2. **Cross-Subsystem Analysis**: Analyze workflow implementation across subsystems
3. **Documentation Creation**: Create comprehensive planning documentation
4. **Implementation Strategy**: Document implementation strategy
5. **Verification Planning**: Plan approach for verifying changes

### Planning Completion

When planning is complete, send the planning-document-complete signal:

```
📋 1000xdev [rules-workflow]

planning-document-complete

Planning is complete with:
- Requirements document with clear objectives for [workflow-type] changes
- Implementation plan with detailed approach across all subsystems
- Context files with essential [workflow-type] information
```

## Transition to Implementation

Once planning is complete, transition to dev-mode for implementation:

```
dev-mode rules-workflow workflows @parameters/rules/dev-mode/workflows.mdc [workflow-type]
```

This will activate the dev-mode parameter for implementing the planned changes to the specified workflow type.

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For workflow implementation across subsystems, see `knowledge/system-structure/workflow-subsystem-relationships.md`
- For workflows subsystem details, see `knowledge/system-structure/subsystem-workflows.md`
- For pathway organization, see `knowledge/system-structure/pathway-organization.md` 