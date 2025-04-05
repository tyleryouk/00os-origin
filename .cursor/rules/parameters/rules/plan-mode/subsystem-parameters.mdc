# mode: plan-mode | workflow: rules-workflow | pathway: subsystem-parameters | filepath: @parameters/rules/plan-mode/subsystem-parameters.mdc | optional-standard-parameter(s): none

## Purpose

This parameter provides a specialized execution framework for planning changes specific to the parameters subsystem of the 1000xbrain cognitive architecture, ensuring proper documentation and preparation for implementation.

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: Limited to the /planning directory
- **Rationale**: Plan-mode focuses on documentation creation in the planning directory

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

The subsystem-parameters pathway in plan-mode focuses on planning changes to the parameters subsystem through these activities:

1. **Comprehensive Analysis**: Thoroughly analyze the parameters subsystem structure and organization
2. **Documentation Planning**: Plan documentation updates for parameters subsystem components
3. **Parameter Enhancement Planning**: Plan enhancements to parameter organization and pathways
4. **Implementation Strategy**: Develop a clear implementation strategy for parameter changes
5. **Verification Approach**: Design an approach for verifying parameter subsystem changes
6. **Domain Access Documentation**: Clearly document domain access for implementation

## Planning Workflow

### 1. Initial Analysis Phase

```typescript
// Access parameters subsystem documentation
fetch_rules(["knowledge/system-structure/subsystem-parameters"], 
           "Understanding the parameters subsystem architecture")

// Explore parameters directories to understand structure
list_dir("1000xbrain/parameters")

// Examine parameters by workflow
list_dir("1000xbrain/parameters/rules")
list_dir("1000xbrain/parameters/front-end")
list_dir("1000xbrain/parameters/back-end")

// Examine parameters by mode
list_dir("1000xbrain/parameters/rules/plan-mode")
list_dir("1000xbrain/parameters/rules/dev-mode")
list_dir("1000xbrain/parameters/rules/direct-mode")

// Read key files to understand parameter organization
read_file("1000xbrain/knowledge/system-structure/subsystem-parameters.md", should_read_entire_file=true)
read_file("1000xbrain/knowledge/system-structure/pathway-organization.md", should_read_entire_file=true)
```

### 2. Documentation Planning Phase

```typescript
// Create/update planning documents
edit_file("planning/[project-folder]/requirements.md",
          "Document parameters subsystem requirements",
          "# Parameters Subsystem Requirements\n\n## Overview\n\nThis document outlines the requirements for changes to the parameters subsystem...")

edit_file("planning/[project-folder]/implementation.md",
          "Document parameters subsystem implementation approach",
          "# Parameters Subsystem Implementation\n\n## Overview\n\nThis document outlines the implementation approach for parameters subsystem changes...")
```

### 3. Implementation Strategy Phase

```typescript
// Document implementation strategy
edit_file("planning/[project-folder]/implementation-progress.md",
          "Create implementation progress tracker",
          "# Implementation Progress: Parameters Subsystem\n\n## Planning Status\n- Planning Phase: In Progress\n- Current Planning Task: Parameters subsystem analysis\n\n## Implementation Status\n- Implementation Phase: Not Started\n- Will be managed by dev-mode\n\n## Parameters Subsystem Analysis\n\n...")
```

### 4. Verification Planning Phase

```typescript
// Plan verification approach
edit_file("planning/[project-folder]/test-cheatsheet.md",
          "Create verification approach for parameters changes",
          "# Verification Approach: Parameters Subsystem\n\n## Overview\n\nThis document outlines the approach for verifying parameters subsystem changes...")
```

## Documentation Standards

### Parameters Subsystem Documentation

All planning documents for parameters subsystem changes should include:

1. **Clear Scope Definition**: Clearly define which aspects of the parameters subsystem will be modified
2. **Pathway Organization**: Document how parameters will be organized by pathway
3. **Modal Structure**: Document how plan-mode and dev-mode parameters will be structured
4. **Implementation Sequence**: Define the sequence of implementation steps
5. **Domain Access Documentation**: Document domain access for implementation
6. **Cross-Subsystem Impacts**: Document impacts on other subsystems

### Documentation Structure

Structure planning documents according to these standards:

1. **requirements.md**: Document what needs to be changed in the parameters subsystem
2. **implementation.md**: Document how the changes will be implemented
3. **implementation-progress.md**: Track progress of planning and implementation
4. **test-cheatsheet.md**: Document verification approach for changes

## Tool Call Process

### Documentation-First Process

Always follow this documentation-first process:

1. **Knowledge Access**: Fetch knowledge about the parameters subsystem
2. **Parameters Analysis**: Analyze parameters subsystem structure and organization
3. **Documentation Creation**: Create comprehensive planning documentation
4. **Implementation Strategy**: Document implementation strategy
5. **Verification Planning**: Plan approach for verifying changes

### Planning Completion

When planning is complete, send the planning-document-complete signal:

```
📋 1000xdev [rules-workflow]

planning-document-complete

Planning is complete with:
- Requirements document with clear objectives for parameters subsystem changes
- Implementation plan with detailed approach
- Context files with essential parameters subsystem information
```

## Transition to Implementation

Once planning is complete, transition to dev-mode for implementation:

```
dev-mode rules-workflow subsystem-parameters @parameters/rules/dev-mode/subsystem-parameters.mdc none
```

This will activate the dev-mode parameter for implementing the planned changes to the parameters subsystem.

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For parameters subsystem details, see `knowledge/system-structure/subsystem-parameters.md`
- For pathway organization, see `knowledge/system-structure/pathway-organization.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md` 