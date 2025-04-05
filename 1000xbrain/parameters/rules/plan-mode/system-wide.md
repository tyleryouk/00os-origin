# mode: plan-mode | workflow: rules-workflow | pathway: system-wide | filepath: @parameters/rules/plan-mode/system-wide.mdc | optional-standard-parameter(s): none

## System-Wide Enhancement Planning Overview

The system-wide pathway creates a specialized planning structure optimized for coordinated improvements across multiple subsystems within the 1000xbrain cognitive architecture. This approach is ideal when:

- Changes affect multiple cognitive components
- Cross-system consistency needs improvement
- Architectural patterns require standardization
- New capabilities need system-wide integration
- Major version updates are being implemented

### Key Benefits

1. **Comprehensive Impact**: Plans coordinated changes across the entire architecture
2. **Architectural Consistency**: Ensures consistent patterns across all components
3. **Coordinated Planning**: Manages dependencies between components
4. **Cross-Component Verification**: Designs testing for interactions between components
5. **Holistic Improvement**: Addresses system-level concerns rather than isolated components

## Core Command Operation

When the `plan-mode: rules-workflow @parameters/rules/plan-mode/system-wide.mdc` message-command is received, 1000xdev will:

1. **Initialize Planning Mode**: Enter or remain in Planning Mode with the 📋 1000xdev [rules-workflow] indicator
2. **Map System Architecture**: Create comprehensive cognitive architecture map
3. **Identify Cross-System Patterns**: Document patterns that span subsystems
4. **Design Coordinated Enhancements**: Create implementation plans with cross-system coordination
5. **Develop Integration Testing**: Create strategies to verify system-wide coherence

## ⚠️ CRITICAL DOMAIN RESTRICTIONS ⚠️

In Planning Mode, 1000xdev is STRICTLY LIMITED to working with files within the planning folder ONLY:

1. **ONLY Modify Planning Folder Files**: NEVER create or modify files in 1000xbrain, parameters, or any other directory outside the planning folder
2. **ONLY Plan, NEVER Implement**: Focus exclusively on planning and documentation, NOT implementation
3. **NO Project-Rule-Parameter Creation**: NEVER create or modify project-rule-parameters (.md files in parameters directory)
4. **Domain of Responsibility Separation**: In plan-mode, ONLY the planning folder is within the domain of responsibility

Any operation outside the planning folder is STRICTLY PROHIBITED while in plan-mode.

## Tool Call Sequence

```typescript
// 1. Check planning folder structure
list_dir("[planning_folder_path]")

// 2. Read requirements to identify system-wide focus
read_file("[planning_folder_path]/requirements.md", should_read_entire_file=true)

// 3. Analyze cognitive architecture structure (READ ONLY)
list_dir("1000xbrain")
list_dir("1000xbrain/core")
list_dir("1000xbrain/workflows")
list_dir("1000xbrain/knowledge")

// 4. Create system-wide architecture mapping
edit_file("[planning_folder_path]/context-architecture-mapping.md",
          "Create system-wide architecture mapping",
          "# Context Analysis: Cognitive Architecture Mapping\n\n...")

// 5. Create cross-system patterns analysis
edit_file("[planning_folder_path]/context-cross-system-patterns.md",
          "Create cross-system patterns analysis",
          "# Context Analysis: Cross-System Patterns\n\n...")

// 6. Create comprehensive implementation plan
edit_file("[planning_folder_path]/implementation-system-wide-enhancement.md",
          "Create system-wide implementation plan",
          "# Implementation Plan: System-Wide Enhancement\n\n...")

// 7. Create implementation progress tracking template
edit_file("[planning_folder_path]/implementation-progress.md",
          "Create implementation progress tracking template",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[Current planning phase and status details]\n\n## Implementation Status\n[Implementation will be tracked by dev-mode - left empty in plan-mode]\n\n## Phase Overview\n\n...")

// 8. Create integration testing framework
edit_file("[planning_folder_path]/test-cheatsheet.md",
          "Create integration testing framework",
          "# Test Cheatsheet: System-Wide Integration\n\n...")
```

## Planning Folder Structure

The system-wide enhancement pathway creates a specialized planning structure:

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

**mandatory**
README.md must have this header at the top of the file:
# rules-workflow | system-wide

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

## Success Criteria

Successful initialization of system-wide enhancement planning meets these criteria:

1. **Architecture Mapping**: Comprehensive mapping of the cognitive architecture
2. **Cross-System Analysis**: Identification of patterns spanning subsystems
3. **Coordinated Planning**: Well-structured implementation plan with clear dependencies
4. **Implementation Structure**: Clearly defined phases matching development workflow
5. **Integration Focus**: Strong emphasis on subsystem integration and consistency
6. **Comprehensive Testing**: Testing strategies that verify cross-system integrity
7. **Clear Domain Separation**: Planning documents explicitly separate planning from implementation

## Knowledge Access

```typescript
// Access essential system-wide knowledge components
fetch_rules(["knowledge/rules/system-wide/brain-files-cursor-rules"], 
           "Understanding brain-files and cursor-rules relationship")
fetch_rules(["knowledge/rules/system-wide/mode-patterns"], 
           "Understanding mode patterns and behaviors")
fetch_rules(["knowledge/rules/system-wide/message-commands"], 
           "Understanding message command processing")

// Access optimization knowledge
fetch_rules(["knowledge/rules/system-wide-optimization/cognitive-load-optimization"], 
           "Understanding cognitive load optimization")
fetch_rules(["knowledge/rules/common/file-standards"], 
           "Understanding file standards for system components")