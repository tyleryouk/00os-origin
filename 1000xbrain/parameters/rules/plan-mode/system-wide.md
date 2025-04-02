# Plan Mode: System-Wide Enhancement

## File Purpose and Relationship

This file defines the specific operation of the `plan-mode: rules-workflow @parameters/rules/plan-mode-system-wide.mdc` message-command, which initializes planning mode with a focus on system-wide enhancement planning. It should be consulted to understand:

- How to plan comprehensive system-wide enhancements
- Specialized planning structure for cross-component changes
- Tool call sequences for system analysis and planning
- File organization for system-wide enhancement planning

This file complements:
- `fetch_rules(["knowledge/reference/architecture/brain-files-cursor-rules"])`: General planning mode operations
- `fetch_rules(["knowledge/patterns/impl/architecture-patterns"])`: Overall rules workflow
- Various other pathway-specific files

## Usage as Project-Rule-Parameter

This file contains specialized planning details for system-wide enhancements. It should be referenced as a project-rule-parameter when initializing planning for comprehensive system improvements:

```
plan-mode: rules-workflow @parameters/rules/plan-mode-system-wide.mdc
```

For more focused enhancement pathways, see the alternative pathway-specific project-rule-parameters listed in `@parameters/rules/rules-workflow.mdc`.

## 1. System-Wide Enhancement Overview

The system-wide enhancement pathway creates a specialized planning structure optimized for coordinated improvements across multiple subsystems within the 1000xbrain cognitive architecture. This approach is ideal when:

- Changes affect multiple cognitive components
- Cross-system consistency needs improvement
- Architectural patterns require standardization
- New capabilities need system-wide integration
- Major version updates are being implemented

### Key Benefits

1. **Architectural Consistency**: Ensures coherent changes across the system
2. **Coordinated Evolution**: Manages dependencies between subsystems
3. **Comprehensive Testing**: Validates changes across all affected components
4. **Holistic Improvement**: Optimizes overall system rather than isolated parts
5. **Future-Proofing**: Establishes patterns that scale across the architecture

## 2. Core Command Operation

When the `plan-mode: rules-workflow @parameters/rules/plan-mode-system-wide.mdc` message-command is received, 1000xdev will:

1. **Initialize Planning Mode**: Enter or remain in Planning Mode with the 📋 1000xdev [rules-workflow] indicator
2. **Map System Architecture**: Create comprehensive cognitive architecture map
3. **Identify Cross-System Patterns**: Document patterns that span subsystems
4. **Design Coordinated Enhancements**: Create implementation plans with cross-system coordination
5. **Develop Integration Testing**: Create strategies to verify system-wide coherence

### Tool Call Sequence

```typescript
// 1. Check planning folder structure
list_dir("[planning_folder_path]")

// 2. Read requirements to identify system-wide focus
read_file("[planning_folder_path]/requirements.md", should_read_entire_file=true)

// 3. Analyze cognitive architecture structure
list_dir("1000xbrain")
list_dir("1000xbrain/core")
list_dir("1000xbrain/workflows")
list_dir("1000xbrain/knowledge")

// 4. Read architecture overview
read_file("1000xbrain/README.md", should_read_entire_file=true)
read_file("meta/architecture/structure-overview.md", should_read_entire_file=true)

// 5. Create system-wide architecture mapping
edit_file("[planning_folder_path]/context-architecture-mapping.md",
          "Create system-wide architecture mapping",
          "# Context Analysis: Cognitive Architecture Mapping\n\n...")

// 6. Create cross-system patterns analysis
edit_file("[planning_folder_path]/context-cross-system-patterns.md",
          "Create cross-system patterns analysis",
          "# Context Analysis: Cross-System Patterns\n\n...")

// 7. Create comprehensive implementation plan
edit_file("[planning_folder_path]/implementation-system-wide-enhancement.md",
          "Create system-wide implementation plan",
          "# Implementation Plan: System-Wide Enhancement\n\n...")

// 8. Create integration testing framework
edit_file("[planning_folder_path]/test-cheatsheet.md",
          "Create integration testing framework",
          "# Test Cheatsheet: System-Wide Integration\n\n...")
```

## 3. Specialized Planning Structure

The system-wide enhancement pathway creates a specialized planning structure:

### Required Files

| File | Purpose | Special Focus |
|---|---|---|
| `requirements.md` | Define system-wide enhancement objectives | Identify cross-system requirements |
| `context-architecture-mapping.md` | Map cognitive architecture | Document subsystem relationships |
| `context-cross-system-patterns.md` | Analyze cross-system patterns | Identify patterns spanning subsystems |
| `implementation-system-wide-enhancement.md` | Plan implementation approach | Coordinated multi-phase implementation |
| `test-cheatsheet.md` | Define integration testing approach | Cross-system validation |
| `README.md` | Provide planning overview | System-wide enhancement approach |

### Optional Files

| File | Purpose | When to Include |
|---|---|---|
| `context-dependency-analysis.md` | Map subsystem dependencies | For complex interdependencies |
| `implementation-migration.md` | Plan migration approach | When backward compatibility is needed |
| `context-future-architecture.md` | Document target architecture | For major architectural shifts |

## 4. Context File Structure

The `context-architecture-mapping.md` file for system-wide enhancement follows this structure:

```markdown
# Context Analysis: Cognitive Architecture Mapping

## Cognitive Architecture Overview
[High-level map of the current architecture]

## Core Subsystems
[Analysis of core identity and mode subsystems]

## Workflow Subsystems
[Analysis of workflow implementation subsystems]

## Knowledge Subsystems
[Analysis of domain-specific knowledge subsystems]

## Integration Points
[Documentation of key integration points between subsystems]

## Enhancement Impact
[Analysis of how enhancements will affect each subsystem]
```

## 5. Implementation Planning

System-wide enhancement implementation plans follow this structure:

```markdown
# Implementation Plan: System-Wide Enhancement

## Enhancement Scope
[Define scope of system-wide changes]

## Implementation Strategy
[Overall approach to coordinated implementation]

## Implementation Phases
1. **Phase 1: Core Foundations**
   - [Foundation changes affecting all subsystems]
   - [Core dependency updates]

2. **Phase 2: Subsystem Updates**
   - [Coordinated changes to each subsystem]
   - [Pattern standardization]

3. **Phase 3: Integration**
   - [Cross-system integration]
   - [Consistency validation]

4. **Phase 4: Optimization**
   - [System-wide optimization]
   - [Final refinements]

## Coordination Requirements
[How subsystem changes must be coordinated]

## Verification Approach
[How to verify system-wide consistency]
```

## 6. Common System-Wide Enhancement Patterns

### Architectural Pattern Standardization

For standardizing patterns across the architecture:

1. **Analysis Focus**: Map pattern variations across subsystems
2. **Implementation Approach**: Implement consistent patterns in phases
3. **Testing Strategy**: Verify pattern consistency in all contexts

### Cross-System Terminology Alignment

For aligning terminology across subsystems:

1. **Analysis Focus**: Identify terminology inconsistencies
2. **Implementation Approach**: Implement standardized terminology
3. **Testing Strategy**: Verify terminology usage across all documentation

### System-Wide Capability Enhancement

For adding new capabilities across the system:

1. **Analysis Focus**: Map capability integration points
2. **Implementation Approach**: Implement capabilities with consistent interfaces
3. **Testing Strategy**: Verify capability functionality in all contexts

### Major Version Update

For major version transitions:

1. **Analysis Focus**: Map all affected components and patterns
2. **Implementation Approach**: Phase implementation with backward compatibility
3. **Testing Strategy**: Comprehensive testing across all subsystems

## 7. Integration Testing Framework

The system-wide enhancement approach includes a specialized testing framework for cross-system integration:

### Cross-System Testing

```markdown
## Integration Test Framework

### Core Integration Tests
[Tests for core identity and mode subsystems]

### Workflow Integration Tests
[Tests for workflow implementations]

### Knowledge Integration Tests
[Tests for domain-specific knowledge integration]

### Cross-System Validation
[Tests that verify consistency across subsystem boundaries]
```

## 8. Success Criteria

Successful initialization of system-wide enhancement planning meets these criteria:

1. **Architecture Mapping**: Comprehensive mapping of the cognitive architecture
2. **Cross-System Analysis**: Identification of patterns spanning subsystems
3. **Coordinated Planning**: Well-structured implementation plan with clear dependencies
4. **Integration Focus**: Strong emphasis on subsystem integration and consistency
5. **Comprehensive Testing**: Testing strategies that verify cross-system integrity

## 9. Examples

### Example 1: Message Command Standardization

```
plan-mode: rules-workflow @parameters/rules/plan-mode-system-wide.mdc
```

With requirements.md focusing on message-command standardization, this would create:
- `context-architecture-mapping.md` (mapping all message-command usage)
- `context-cross-system-patterns.md` (analyzing command pattern variations)
- `implementation-system-wide-enhancement.md` (with phases for standardization)

### Example 2: Major Architecture Version Update

```
plan-mode: rules-workflow @parameters/rules/plan-mode-system-wide.mdc
```

With requirements.md focusing on major version update, this would create:
- `context-architecture-mapping.md` (mapping current architecture)
- `context-future-architecture.md` (documenting target architecture)
- `implementation-system-wide-enhancement.md` (with phases for migration)
- `implementation-migration.md` (with specific migration steps)

## 10. Related Files

- `fetch_rules(["knowledge/reference/architecture/brain-files-cursor-rules"])`: General planning mode operations
- `fetch_rules(["knowledge/patterns/impl/architecture-patterns"])`: Overall rules workflow
- **meta/architecture/structure-overview.md**: Architecture overview
- **meta/contributions/file-standards.md**: File standards 