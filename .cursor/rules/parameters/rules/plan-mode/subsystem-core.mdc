# mode: plan-mode | workflow: rules-workflow | pathway: subsystem-core | filepath: @parameters/rules/plan-mode/subsystem-core.mdc | optional-standard-parameter(s): none

## Purpose

This parameter provides a specialized execution framework for planning changes specific to the core subsystem of the 1000xbrain cognitive architecture, ensuring proper documentation and preparation for implementation.

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: Limited to the /planning directory
- **Rationale**: Plan-mode focuses on documentation creation in the planning directory

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

The subsystem-core pathway in plan-mode focuses on planning changes to the core subsystem through these activities:

1. **Comprehensive Analysis**: Thoroughly analyze the core subsystem structure and organization
2. **Documentation Planning**: Plan documentation updates for core subsystem components
3. **Core Enhancement Planning**: Plan enhancements to core functionality
4. **Implementation Strategy**: Develop a clear implementation strategy for core changes
5. **Verification Approach**: Design an approach for verifying core subsystem changes
6. **Domain Access Documentation**: Clearly document domain access for implementation

## Planning Workflow

### 1. Initial Analysis Phase

```typescript
// Access core subsystem knowledge
fetch_rules(["knowledge/system-structure/subsystem-core"], 
           "Understanding the core subsystem architecture")

// Explore core directories to understand structure
list_dir("1000xbrain/core")

// Examine core components
list_dir("1000xbrain/core/identity")
list_dir("1000xbrain/core/modes")
list_dir("1000xbrain/core/communication")

// Read key files to understand core functionality
read_file("1000xbrain/core/identity/global-rules.md", should_read_entire_file=true)
```

### 2. Documentation Planning Phase

```typescript
// Create/update planning documents
edit_file("planning/[project-folder]/requirements.md",
          "Document core subsystem requirements",
          "# Core Subsystem Requirements\n\n## Overview\n\nThis document outlines the requirements for changes to the core subsystem...")

edit_file("planning/[project-folder]/implementation.md",
          "Document core subsystem implementation approach",
          "# Core Subsystem Implementation\n\n## Overview\n\nThis document outlines the implementation approach for core subsystem changes...")
```

### 3. Implementation Strategy Phase

```typescript
// Document implementation strategy
edit_file("planning/[project-folder]/implementation-progress.md",
          "Create implementation progress tracker",
          "# Implementation Progress: Core Subsystem\n\n## Planning Status\n- Planning Phase: In Progress\n- Current Planning Task: Core subsystem analysis\n\n## Implementation Status\n- Implementation Phase: Not Started\n- Will be managed by dev-mode\n\n## Core Subsystem Analysis\n\n...")
```

### 4. Verification Planning Phase

```typescript
// Plan verification approach
edit_file("planning/[project-folder]/test-cheatsheet.md",
          "Create verification approach for core changes",
          "# Verification Approach: Core Subsystem\n\n## Overview\n\nThis document outlines the approach for verifying core subsystem changes...")
```

## Documentation Standards

### Core Subsystem Documentation

All planning documents for core subsystem changes should include:

1. **Clear Scope Definition**: Clearly define which aspects of the core subsystem will be modified
2. **Component Documentation**: Document each component that will be affected
3. **Relationship Mapping**: Map relationships between affected components
4. **Implementation Sequence**: Define the sequence of implementation steps
5. **Domain Access Documentation**: Document domain access for implementation
6. **Cross-Subsystem Impacts**: Document impacts on other subsystems

### Documentation Structure

Structure planning documents according to these standards:

1. **requirements.md**: Document what needs to be changed in the core subsystem
2. **implementation.md**: Document how the changes will be implemented
3. **implementation-progress.md**: Track progress of planning and implementation
4. **test-cheatsheet.md**: Document verification approach for changes

## Tool Call Process

### Documentation-First Process

Always follow this documentation-first process:

1. **Knowledge Access**: Fetch knowledge about the core subsystem
2. **Core Analysis**: Analyze core subsystem structure and functionality
3. **Documentation Creation**: Create comprehensive planning documentation
4. **Implementation Strategy**: Document implementation strategy
5. **Verification Planning**: Plan approach for verifying changes

### Planning Completion

When planning is complete, send the planning-document-complete signal:

```
📋 1000xdev [rules-workflow]

planning-document-complete

Planning is complete with:
- Requirements document with clear objectives for core subsystem changes
- Implementation plan with detailed approach
- Context files with essential core subsystem information
```

## Transition to Implementation

Once planning is complete, transition to dev-mode for implementation:

```
dev-mode rules-workflow subsystem-core @parameters/rules/dev-mode/subsystem-core.mdc none
```

This will activate the dev-mode parameter for implementing the planned changes to the core subsystem.

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For core subsystem details, see `knowledge/system-structure/subsystem-core.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md` 