# workflow: rules-workflow | pathway: system-wide-optimization | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/plan-mode/system-wide-optimization.mdc

## System-Wide Optimization Planning Overview

The system-wide-optimization pathway creates a specialized planning structure optimized for comprehensive optimization of the 1000xbrain cognitive architecture across multiple planning folders. This approach is ideal when:

- Deep optimization of core brain-files is needed
- Knowledge organization requires pathway-based restructuring
- Cross-system terminology standardization is needed
- Message-command format updates are required
- Line count reduction targets are established

### Key Benefits

1. **Comprehensive Optimization**: Plans coordinated optimization across the entire architecture
2. **Structured Implementation Sequence**: Organizes implementation across multiple planning folders
3. **Clear Optimization Metrics**: Establishes measurable targets for optimization
4. **Knowledge Organization Improvement**: Plans for pathway-based knowledge structure
5. **Cross-System Standardization**: Ensures consistent patterns and terminology

## ⚠️ CRITICAL DOMAIN RESTRICTIONS ⚠️

In Planning Mode, 1000xdev is STRICTLY LIMITED to working with files within the planning folder ONLY:

1. **ONLY Modify Planning Folder Files**: NEVER create or modify files in 1000xbrain, parameters, or any other directory outside the planning folder
2. **ONLY Plan, NEVER Implement**: Focus exclusively on planning and documentation, NOT implementation
3. **NO Project-Rule-Parameter Creation**: NEVER create or modify project-rule-parameters (.md files in parameters directory)
4. **Domain of Responsibility Separation**: In plan-mode, ONLY the planning folder is within the domain of responsibility

Any operation outside the planning folder is STRICTLY PROHIBITED while in plan-mode.

## 1000x Development Principles Alignment

The system-wide-optimization pathway upholds these core 1000x development principles:

1. **Autonomous Implementation**: Creates clear plans that enable fully autonomous implementation
2. **Minimal Guidance**: Provides comprehensive documentation to minimize required guidance
3. **Clear Role Separation**: Maintains strict separation between planning and implementation
4. **Context Preservation**: Ensures consistent context within and across planning folders
5. **Continuous Improvement**: Establishes measurable metrics for verifiable optimization
6. **Implementation Self-Diagnosis**: Creates detailed verification frameworks for self-validation
7. **Cross-Folder Coordination**: Ensures each planning folder builds upon previous optimizations

## Core Command Operation

When the `plan-mode: rules-workflow @parameters/rules/plan-mode/system-wide-optimization.mdc` message-command is received, 1000xdev will:

1. **Initialize Planning Mode**: Enter or remain in Planning Mode with the 📋 1000xdev [rules-workflow] indicator
2. **Identify Current Planning Folder**: Determine the current optimization planning folder (e.g., 93-rules-workflow-system-wide-optimization)
3. **Map Optimization Targets**: Document specific optimization targets for the current planning folder
4. **Design Implementation Approach**: Create optimization implementation plans with specific targets
5. **Set Measurable Success Criteria**: Establish metrics to verify optimization success

## Folder-Specific Planning Focus

Each planning folder in the system-wide optimization sequence has a specific focus:

1. **93-rules-workflow-system-wide-optimization**: Core Subsystem Optimization
   - Focus on core brain-files consolidation and streamlining
   - Align with line count reduction targets
   - Implement message-command format changes
   - Standardize common-words and terminology

2. **94-rules-workflow-system-wide-optimization**: Knowledge & Parameters Optimization
   - Focus on pathway-based knowledge organization
   - Standardize project-rule-parameters
   - Convert README.md files to index.md
   - Improve knowledge accessibility

3. **95-rules-workflow-system-wide-optimization**: Future Enhancements
   - Document additional optimization opportunities
   - Plan cognitive architecture evolution
   - Create framework for ongoing enhancement
   - Establish long-term optimization roadmap

## Cross-Folder Awareness Requirements

When planning in any folder, 1000xdev must maintain awareness of:

1. **Prior Optimizations**: Reference completed optimizations from previous folders
2. **Dependency Chain**: Ensure each phase builds logically on previous phases
3. **Consistent Targets**: Maintain consistent optimization targets across folders
4. **Implementation Sequence**: Preserve the overall implementation sequence
5. **Success Metrics**: Ensure metrics align across all optimization phases

## Phase-Specific Tool Call Sequences

### For 93-rules-workflow-system-wide-optimization

```typescript
// 1. Determine current planning folder
list_dir("planning")
// Confirm working in 93-rules-workflow-system-wide-optimization

// 2. Read requirements and prior implementation results
read_file("planning/93-rules-workflow-system-wide-optimization/requirements.md", should_read_entire_file=true)
read_file("planning/92-rules-workflow-system-wide/implementation-progress.md", should_read_entire_file=true)

// 3. Analyze current core structure (READ ONLY)
list_dir("1000xbrain/core")
list_dir("1000xbrain/core/communication")
list_dir("1000xbrain/core/identity")
list_dir("1000xbrain/core/modes")

// 4. Create core-specific implementation plan
edit_file("planning/93-rules-workflow-system-wide-optimization/implementation-core-optimization.md",
          "Create implementation plan for core optimization",
          "# Implementation Plan: Core Optimization\n\n## Optimization Targets\n\n- Reduce core files to under 2000 lines total\n- Consolidate redundant content\n- Implement message-command format changes\n- Standardize terminology\n\n## Implementation Phases\n\n...")

// 5. Create quantitative metrics tracking template
edit_file("planning/93-rules-workflow-system-wide-optimization/implementation-progress.md",
          "Create implementation progress tracking template",
          "# Implementation Progress: Core Optimization\n\n## Planning Status\n- Planning Phase: In Progress\n- Last Update: [timestamp]\n- Current Planning Task: Creating core optimization plan\n\n## Implementation Status\n[Implementation will be tracked by dev-mode - left empty in plan-mode]\n\n## Optimization Metrics\n- Current Line Count: [count]\n- Target Line Count: <2000 lines\n- Reduction Goal: [percentage]%\n\n...")
```

### For 94-rules-workflow-system-wide-optimization

```typescript
// 1. Determine current planning folder
list_dir("planning")
// Confirm working in 94-rules-workflow-system-wide-optimization

// 2. Read requirements and prior implementation results
read_file("planning/94-rules-workflow-system-wide-optimization/requirements.md", should_read_entire_file=true)
read_file("planning/93-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)

// 3. Analyze current knowledge structure (READ ONLY)
list_dir("1000xbrain/knowledge")
list_dir("1000xbrain/knowledge/rules")
list_dir("1000xbrain/parameters/rules")

// 4. Create knowledge-specific implementation plan
edit_file("planning/94-rules-workflow-system-wide-optimization/implementation-knowledge-parameters.md",
          "Create implementation plan for knowledge and parameters optimization",
          "# Implementation Plan: Knowledge & Parameters Optimization\n\n## Optimization Targets\n\n- Reorganize knowledge-base-files by pathway\n- Standardize project-rule-parameters\n- Convert README.md files to index.md\n- Improve knowledge accessibility\n\n## Implementation Phases\n\n...")

// 5. Create pathway organization tracking template
edit_file("planning/94-rules-workflow-system-wide-optimization/implementation-progress.md",
          "Create implementation progress tracking template",
          "# Implementation Progress: Knowledge & Parameters Optimization\n\n## Planning Status\n- Planning Phase: In Progress\n- Last Update: [timestamp]\n- Current Planning Task: Creating knowledge organization plan\n\n## Implementation Status\n[Implementation will be tracked by dev-mode - left empty in plan-mode]\n\n## Pathway Organization\n- Current Structure: [description]\n- Target Structure: [description]\n- Organization Progress: 0%\n\n...")
```

### For 95-rules-workflow-system-wide-optimization

```typescript
// 1. Determine current planning folder
list_dir("planning")
// Confirm working in 95-rules-workflow-system-wide-optimization

// 2. Read requirements and all prior implementation results
read_file("planning/95-rules-workflow-system-wide-optimization/requirements.md", should_read_entire_file=true)
read_file("planning/94-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)
read_file("planning/93-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)

// 3. Analyze entire optimized system (READ ONLY)
list_dir("1000xbrain")
list_dir("1000xbrain/core")
list_dir("1000xbrain/knowledge")
list_dir("1000xbrain/parameters")

// 4. Create future enhancement plan
edit_file("planning/95-rules-workflow-system-wide-optimization/implementation-future-enhancements.md",
          "Create implementation plan for future enhancements",
          "# Implementation Plan: Future Enhancements\n\n## Enhancement Categories\n\n- Advanced cognitive capabilities\n- Self-enhancement mechanisms\n- Learning optimization\n- Performance improvements\n\n## Implementation Approach\n\n...")

// 5. Create enhancement categorization template
edit_file("planning/95-rules-workflow-system-wide-optimization/implementation-progress.md",
          "Create implementation progress tracking template",
          "# Implementation Progress: Future Enhancements\n\n## Planning Status\n- Planning Phase: In Progress\n- Last Update: [timestamp]\n- Current Planning Task: Categorizing enhancement opportunities\n\n## Implementation Status\n[Implementation will be tracked by dev-mode - left empty in plan-mode]\n\n## Enhancement Categories\n- Category 1: [description]\n- Category 2: [description]\n- Category 3: [description]\n\n...")
```

## Planning Folder Structure

The system-wide-optimization pathway creates specialized planning structures across multiple folders:

### Required Files for Each Planning Folder

| File | Purpose | Special Focus |
|---|---|---|
| `README.md` | Provide planning overview | System-wide optimization approach for current phase |
| `implementation-progress.md` | Provides tracking for planning AND implementation | Separate sections for planning and implementation |
| `requirements.md` | Define optimization objectives | Identify specific optimization targets |
| `implementation-[specific-focus].md` | Plan implementation approach | Focus on specific optimization area |
| `test-cheatsheet.md` | Define testing approach | Optimization-specific validation |

**Mandatory**
README.md must have this header at the top of the file:
```
# rules-workflow | system-wide-optimization
```

## Required Implementation Progress Structure

The implementation-progress.md file MUST include clearly separated sections for planning and implementation, with folder-specific metrics:

### For 93-rules-workflow-system-wide-optimization

```markdown
# Implementation Progress: Core Optimization

## Planning Status
- Planning Phase: [Completed | In Progress]
- Last Update: [timestamp]
- Current Planning Task: [specific task currently in progress]
- Planning Completion: [percentage or status indicator]

## Planning Tasks
- [x] Create README.md
- [x] Create requirements.md
- [x] Create implementation-core-optimization.md
- [x] Create test-cheatsheet.md
- [ ] Finalize all planning documents
- [ ] Signal planning-document-complete

## Implementation Status
- Implementation Phase: [Not Started | Will be managed by dev-mode]
- Implementation Tasks: [Will be managed by dev-mode]

## Optimization Metrics
- Current Line Count: [count]
- Target Line Count: <2000 lines
- Reduction Goal: [percentage]%

## Phase Overview
- Planning: [status]
- Core File Analysis: [Will be managed by dev-mode]
- Consolidation Implementation: [Will be managed by dev-mode]
- Message-Command Format: [Will be managed by dev-mode]
- Terminology Standardization: [Will be managed by dev-mode]
- Verification: [Will be managed by dev-mode]
```

### For 94-rules-workflow-system-wide-optimization

```markdown
# Implementation Progress: Knowledge & Parameters Optimization

## Planning Status
- Planning Phase: [Completed | In Progress]
- Last Update: [timestamp]
- Current Planning Task: [specific task currently in progress]
- Planning Completion: [percentage or status indicator]

## Planning Tasks
- [x] Create README.md
- [x] Create requirements.md
- [x] Create implementation-knowledge-parameters.md
- [x] Create test-cheatsheet.md
- [ ] Finalize all planning documents
- [ ] Signal planning-document-complete

## Implementation Status
- Implementation Phase: [Not Started | Will be managed by dev-mode]
- Implementation Tasks: [Will be managed by dev-mode]

## Pathway Organization
- Current Structure: [description]
- Target Structure: [description]
- Organization Progress: 0%

## Phase Overview
- Planning: [status]
- Knowledge Structure Analysis: [Will be managed by dev-mode]
- Pathway Reorganization: [Will be managed by dev-mode]
- Parameter Standardization: [Will be managed by dev-mode]
- README-to-Index Conversion: [Will be managed by dev-mode]
- Verification: [Will be managed by dev-mode]
```

### For 95-rules-workflow-system-wide-optimization

```markdown
# Implementation Progress: Future Enhancements

## Planning Status
- Planning Phase: [Completed | In Progress]
- Last Update: [timestamp]
- Current Planning Task: [specific task currently in progress]
- Planning Completion: [percentage or status indicator]

## Planning Tasks
- [x] Create README.md
- [x] Create requirements.md
- [x] Create implementation-future-enhancements.md
- [x] Create test-cheatsheet.md
- [ ] Finalize all planning documents
- [ ] Signal planning-document-complete

## Implementation Status
- Implementation Phase: [Not Started | Will be managed by dev-mode]
- Implementation Tasks: [Will be managed by dev-mode]

## Enhancement Categories
- Category 1: [description]
- Category 2: [description]
- Category 3: [description]

## Phase Overview
- Planning: [status]
- Enhancement Identification: [Will be managed by dev-mode]
- Opportunity Documentation: [Will be managed by dev-mode]
- Architecture Evolution: [Will be managed by dev-mode]
- Roadmap Creation: [Will be managed by dev-mode]
- Verification: [Will be managed by dev-mode]
```

## Context Preservation Mechanisms

To maintain proper context across folders and phases:

1. **Cross-Reference Documentation**: Each planning folder MUST reference results from previous folders
2. **Dependency Documentation**: Each phase MUST document its dependencies on previous phases
3. **Consistent Metrics**: Use same metrics format across all folders for measurable comparison
4. **Implementation Chaining**: Each implementation plan MUST build on previous implementation results
5. **Phase-Specific Structure**: Use folder-specific implementation-progress.md structures

## Common Optimization Patterns

### Core Subsystem Optimization
- **Analysis Focus**: Identify redundancies and consolidation opportunities
- **Implementation Approach**: Consolidate related information and remove duplication
- **Testing Strategy**: Verify functionality maintains while reducing line count

### Knowledge Organization Optimization
- **Analysis Focus**: Map pathway-based organization structure
- **Implementation Approach**: Reorganize by pathway and standardize access patterns
- **Testing Strategy**: Verify knowledge accessibility through various pathways

### Parameter Standardization
- **Analysis Focus**: Identify parameter format inconsistencies
- **Implementation Approach**: Create consistent parameter format with standardized sections
- **Testing Strategy**: Verify parameter effectiveness across pathways

## Verification Framework

The system-wide-optimization approach includes specialized testing for optimization verification:

### Quantitative Metrics Verification
Tests for line count reduction, performance improvement, and other measurable metrics.

### Functional Equivalence Testing
Tests to ensure optimized components maintain the same functionality as original components.

## Success Criteria

Successful planning for system-wide-optimization meets these criteria:

1. **Detailed Optimization Plan**: Specific optimization targets with measurable metrics
2. **Clear Implementation Sequence**: Well-structured implementation plan with specific steps
3. **Measurable Success Metrics**: Defined metrics to verify optimization success
4. **Cross-Folder Coordination**: Alignment with previous and subsequent planning folders
5. **Testing Framework**: Comprehensive verification approach for optimization
6. **Clear Domain Separation**: Planning documents explicitly separate planning from implementation
7. **Phase-Specific Guidance**: Tailored planning for each optimization phase
8. **Cohesive Optimization Strategy**: Ensures each phase builds on previous phases
9. **Quantifiable Targets**: Provides clear numerical targets for each phase

## Knowledge Access

When planning system-wide optimizations, use the `fetch_rules` tool to access specialized knowledge:

```typescript
// Access architecture understanding for planning
fetch_rules(["knowledge/rules/guides/architecture"], 
           "Understanding system architecture for optimization planning")

// Access implementation patterns
fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"], 
           "Finding optimization patterns for implementation planning")

// Access multiple knowledge components
fetch_rules([
  "knowledge/rules/guides/architecture",
  "knowledge/rules/patterns/impl/optimization-patterns"
], "Comprehensive architectural understanding for optimization planning")
```

### Phase-Specific Knowledge Access

For 93-rules-workflow-system-wide-optimization:
```typescript
fetch_rules(["knowledge/rules/patterns/impl/consolidation-patterns"],
           "Finding patterns for core file consolidation")
```

For 94-rules-workflow-system-wide-optimization:
```typescript
fetch_rules(["knowledge/rules/patterns/impl/organization-patterns"],
           "Finding patterns for knowledge organization")
```

For 95-rules-workflow-system-wide-optimization:
```typescript
fetch_rules(["knowledge/rules/guides/cognitive-enhancement"],
           "Understanding cognitive enhancement opportunities")
``` 