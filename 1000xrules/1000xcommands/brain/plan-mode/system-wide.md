# mode: plan-mode | workflow: rules-workflow | pathway: system-wide | filepath: @parameters/rules/plan-mode/system-wide.mdc | optional-standard-parameter(s): none

## Purpose

This parameter provides a specialized planning structure optimized for coordinated improvements across multiple subsystems within the 1000xbrain cognitive architecture. This approach is ideal when:

- Changes affect multiple cognitive components
- Cross-system consistency needs improvement
- Architectural patterns require standardization
- New capabilities need system-wide integration
- Major version updates are being implemented

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: Limited to the /planning directory
- **Rationale**: Plan-mode focuses on documentation creation in the planning directory

## Knowledge Access

For comprehensive understanding of the system architecture, access these knowledge components:

```typescript
// Access system architecture documentation
fetch_rules(["knowledge/system-structure/system-architecture"], 
           "Understanding the overall system architecture")

// Access related knowledge
fetch_rules([
  "knowledge/system-structure/workflow-subsystem-relationships",
  "knowledge/system-structure/system-vs-subsystem",
  "knowledge/system-structure/pathway-organization"
], "Understanding the relationships between components in the system architecture")

// Access additional system-wide knowledge components
fetch_rules(["knowledge/rules/system-wide/brain-files-cursor-rules"], 
           "Understanding brain-files and cursor-rules relationship")
fetch_rules(["knowledge/rules/system-wide/mode-patterns"], 
           "Understanding mode patterns and behaviors")
fetch_rules(["knowledge/rules/system-wide/message-commands"], 
           "Understanding message command processing")
```

## Implementation Approach

The system-wide pathway in plan-mode focuses on planning changes that affect multiple subsystems through these activities:

1. **Comprehensive System Analysis**: Thoroughly analyze the system architecture and relationships
2. **Cross-System Pattern Identification**: Identify patterns that span multiple subsystems
3. **Coordinated Enhancement Planning**: Create implementation plans with cross-system coordination
4. **Integration Testing Design**: Design strategies to verify system-wide coherence
5. **Domain Access Documentation**: Clearly document domain access for implementation

## Planning Workflow

### 1. Initial Analysis Phase

```typescript
// Access system architecture documentation
fetch_rules(["knowledge/system-structure/system-architecture"], 
           "Understanding the system architecture")

// Explore cognitive architecture structure (READ ONLY)
list_dir("1000xbrain")
list_dir("1000xbrain/core")
list_dir("1000xbrain/workflows")
list_dir("1000xbrain/knowledge")

// Read key architecture documentation
read_file("1000xbrain/knowledge/system-structure/system-architecture.md", should_read_entire_file=true)
read_file("1000xbrain/knowledge/system-structure/workflow-subsystem-relationships.md", should_read_entire_file=true)
```

### 2. Documentation Planning Phase

```typescript
// Create system-wide architecture mapping
edit_file("planning/[project-folder]/context-architecture-mapping.md",
          "Create system-wide architecture mapping",
          "# Context Analysis: Cognitive Architecture Mapping\n\n...")

// Create cross-system patterns analysis
edit_file("planning/[project-folder]/context-cross-system-patterns.md",
          "Create cross-system patterns analysis",
          "# Context Analysis: Cross-System Patterns\n\n...")

// Create requirements document
edit_file("planning/[project-folder]/requirements.md",
          "Document system-wide requirements",
          "# Requirements: System-Wide Enhancement\n\n...")
```

### 3. Implementation Strategy Phase

```typescript
// Create comprehensive implementation plan
edit_file("planning/[project-folder]/implementation-system-wide-enhancement.md",
          "Create system-wide implementation plan",
          "# Implementation Plan: System-Wide Enhancement\n\n...")

// Create implementation progress tracking template
edit_file("planning/[project-folder]/implementation-progress.md",
          "Create implementation progress tracking template",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[Current planning phase and status details]\n\n## Implementation Status\n[Implementation will be tracked by dev-mode - left empty in plan-mode]\n\n## Phase Overview\n\n...")
```

### 4. Testing Strategy Phase

```typescript
// Create integration testing framework
edit_file("planning/[project-folder]/test-cheatsheet.md",
          "Create integration testing framework",
          "# Test Cheatsheet: System-Wide Integration\n\n...")
```

## Planning Folder Structure

The system-wide pathway creates a specialized planning structure:

### Required Files

| File | Purpose | Special Focus |
|---|---|---|
| `README.md` | Provide planning overview | System-wide enhancement approach |
| `implementation-progress.md` | Provides tracking for planning AND implementation | Separate sections for planning and implementation |
| `requirements.md` | Define system-wide enhancement objectives | Identify cross-system requirements |
| `context-architecture-mapping.md` | Map cognitive architecture | Document subsystem relationships |
| `context-cross-system-patterns.md` | Analyze cross-system patterns | Identify patterns spanning subsystems |
| `implementation-system-wide-enhancement.md` | Plan implementation approach | Coordinated multi-phase implementation |
| `test-cheatsheet.md` | Define integration testing approach | Cross-system validation |

**Mandatory**
README.md must have this header at the top of the file:
```
# rules-workflow | system-wide
```

## Implementation Planning

System-wide enhancement implementation plans follow this structured phase approach:

```markdown
# Implementation Plan: System-Wide Enhancement

## Implementation Phases
1. **Phase 1: Preparation and Dependency Analysis**
   - [System architecture analysis]
   - [Component dependency mapping]
   - [Implementation sequence planning]

2. **Phase 2: Core Component Implementation**
   - [Changes to core identity components]
   - [Updates to mode system components]
   - [Enhancements to communication components]

3. **Phase 3: Dependent Component Implementation**
   - [Updates to workflow components]
   - [Enhancements to knowledge components]
   - [Modifications to parameter components]

4. **Phase 4: System-Wide Verification**
   - [Core component verification]
   - [Dependent component verification]
   - [Cross-component integration testing]
   - [System-wide functionality validation]
```

## Required Implementation Progress Structure

The implementation-progress.md file MUST include clearly separated sections for planning and implementation:

```markdown
# Implementation Progress: System-Wide Enhancement

## Planning Status
- Planning Phase: [Completed | In Progress]
- Last Update: [timestamp]
- Current Planning Task: [specific task currently in progress]
- Planning Completion: [percentage or status indicator]

## Planning Tasks
- [x] Create README.md
- [x] Create requirements.md
- [x] Create context-architecture-mapping.md
- [x] Create context-cross-system-patterns.md
- [x] Create implementation-system-wide-enhancement.md
- [x] Create test-cheatsheet.md
- [ ] Finalize all planning documents
- [ ] Signal planning-document-complete

## Implementation Status
- Implementation Phase: [Not Started | Will be managed by dev-mode]
- Implementation Tasks: [Will be managed by dev-mode]

## Phase Overview
- Planning: [status]
- Phase 1: [Will be managed by dev-mode] - Preparation and Dependency Analysis
- Phase 2: [Will be managed by dev-mode] - Core Component Implementation
- Phase 3: [Will be managed by dev-mode] - Dependent Component Implementation
- Phase 4: [Will be managed by dev-mode] - System-Wide Verification
```

## Common System-Wide Enhancement Patterns

### Architectural Pattern Standardization
- **Analysis Focus**: Map pattern variations across subsystems
- **Implementation Approach**: Implement consistent patterns in phases
- **Testing Strategy**: Verify pattern consistency in all contexts

### Cross-System Terminology Alignment
- **Analysis Focus**: Identify terminology inconsistencies
- **Implementation Approach**: Implement standardized terminology
- **Testing Strategy**: Verify terminology usage across documentation

### System-Wide Capability Enhancement
- **Analysis Focus**: Map capability integration points
- **Implementation Approach**: Implement capabilities with consistent interfaces
- **Testing Strategy**: Verify capability functionality in all contexts

## Integration Testing Framework

The system-wide enhancement approach includes specialized testing for cross-system integration:

### Component Interaction Testing
Tests for interactions between core components, workflow interactions, and knowledge system integration.

### End-to-End Flow Testing
Tests for complete message-command processing flow, mode transitions, and knowledge access patterns.

## Tool Call Process

### Documentation-First Process

Always follow this documentation-first process:

1. **Knowledge Access**: Fetch knowledge about the system architecture
2. **System Analysis**: Analyze system architecture and relationships
3. **Documentation Creation**: Create comprehensive planning documentation
4. **Implementation Strategy**: Document implementation strategy with phases
5. **Testing Strategy**: Design approach for verifying system-wide changes

### Planning Completion

When planning is complete, send the planning-document-complete signal:

```
📋 1000xdev [rules-workflow]

planning-document-complete

Planning is complete with:
- Requirements document with clear objectives for system-wide enhancement
- Implementation plan with detailed approach across phases
- Context files with essential system architecture information
- Testing framework for system-wide verification
```

## Transition to Implementation

Once planning is complete, transition to dev-mode for implementation:

```
dev-mode rules-workflow system-wide @parameters/rules/dev-mode/system-wide.mdc none
```

This will activate the dev-mode parameter for implementing the planned system-wide changes.

## Success Criteria

Successful system-wide enhancement planning meets these criteria:

1. **Architecture Mapping**: Comprehensive mapping of the cognitive architecture
2. **Cross-System Analysis**: Identification of patterns spanning subsystems
3. **Coordinated Planning**: Well-structured implementation plan with clear dependencies
4. **Implementation Structure**: Clearly defined phases matching development workflow
5. **Integration Focus**: Strong emphasis on subsystem integration and consistency
6. **Comprehensive Testing**: Testing strategies that verify cross-system integrity
7. **Clear Domain Separation**: Planning documents explicitly separate planning from implementation

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For subsystem relationships, see `knowledge/system-structure/system-vs-subsystem.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md`
- For pathway organization, see `knowledge/system-structure/pathway-organization.md`