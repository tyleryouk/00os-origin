# workflow: rules-workflow | pathway: system-wide-optimization | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/dev-mode/system-wide-optimization.mdc

## 1. System-Wide Optimization Implementation Overview

The system-wide-optimization implementation pathway provides a specialized execution structure optimized for implementing coordinated optimization across multiple components of the 1000xbrain cognitive architecture. This approach is ideal when:

- Implementing comprehensive optimization across multiple subsystems
- Reducing line counts while maintaining functionality
- Reorganizing knowledge structures for better accessibility
- Standardizing terminology and patterns across the system
- Implementing measurable optimization targets

### Key Benefits

1. **Comprehensive Optimization**: Enables coordinated optimization across the entire architecture
2. **Measurable Improvements**: Implements changes with quantifiable metrics
3. **Structured Implementation**: Follows clear phase-based implementation approach
4. **Knowledge Organization**: Improves knowledge structure and accessibility
5. **System-Wide Standardization**: Ensures consistent patterns and terminology

## ⚠️ CRITICAL DOMAIN RESPONSIBILITIES ⚠️

In Developer Mode, 1000xdev has clearly defined responsibilities and domains:

1. **Planning vs. Implementation Separation**: 
   - Plan-mode: ONLY modifies files in planning folder 
   - Dev-mode: Reads planning folder files but implements changes in 1000xbrain directory
   
2. **File Domains by Mode**:
   - Plan-mode domain: ONLY planning folder files
   - Dev-mode domain: 1000xbrain files AND planning/implementation-progress.md
   
3. **Project-Rule-Parameter Handling**:
   - Plan-mode: NEVER creates or modifies project-rule-parameters
   - Dev-mode: CAN create or modify project-rule-parameters AS NEEDED for implementation
   
4. **Cross-Mode Coordination**:
   - Plan-mode creates optimization plan
   - Dev-mode implements according to plan without modifying planning documents (except implementation-progress.md)

## 2. Core Command Operation

When the `dev-mode: rules-workflow @parameters/rules/dev-mode/system-wide-optimization.mdc` message-command is received, 1000xdev will:

1. **Initialize Developer Mode**: Enter or remain in Developer Mode with the 💻 1000xdev [rules-workflow] indicator
2. **ALWAYS Re-Read Planning Folder Files**: Read the following planning-folder-files IN THIS EXACT ORDER:
   - README.md (MANDATORY FIRST FILE)
   - implementation-progress.md (MANDATORY SECOND FILE)
   - requirements.md (to understand optimization targets)
   - implementation-[specific-focus].md (for implementation details)
   - test-cheatsheet.md (for verification approach)
3. **Continue Implementation from Current Point**: Use implementation-progress.md to determine the current state
4. **Frequently Update Implementation Progress**: Update after EACH significant change or every 3-5 tool calls
5. **Execute Optimization Tasks**: Implement optimization targets defined in the planning documentation
6. **Verify Optimization Success**: Measure and verify optimization metrics

### ⚠️ CRITICAL: Memory Reset Handling

This project-rule-parameter will be repeatedly sent until implementation is complete. Additionally, memory resets may occur during implementation. Therefore:

1. **ALWAYS begin with explicit file reading** in the exact order specified above
2. **FIRST read README.md and implementation-progress.md** to establish context
3. **Update implementation-progress.md frequently** to maintain continuity
4. **Never assume previous context is remembered** - verify current state through explicit file reads
5. **Make each response self-contained** with clear status indicators

## 3. Mandatory Tool Call Sequence After Each Memory Reset

```typescript
// MANDATORY: ALWAYS start by reading README.md FIRST
read_file("[planning_folder_path]/README.md", should_read_entire_file=true)

// MANDATORY: ALWAYS read implementation-progress.md SECOND to determine current state
read_file("[planning_folder_path]/implementation-progress.md", should_read_entire_file=true)

// Read requirements to understand optimization targets
read_file("[planning_folder_path]/requirements.md", should_read_entire_file=true)

// Read implementation plan for specific optimization focus
read_file("[planning_folder_path]/implementation-[specific-focus].md", should_read_entire_file=true)

// Read test cheatsheet for verification approach
read_file("[planning_folder_path]/test-cheatsheet.md", should_read_entire_file=true)

// Examine system structure as needed based on current optimization target
list_dir("1000xbrain")
list_dir("1000xbrain/core")
list_dir("1000xbrain/workflows")
list_dir("1000xbrain/knowledge")

// Continue implementation from current progress point
// Implementation based on current state in implementation-progress.md
```

## 4. Continuous Implementation Progress Tracking

Implementation progress MUST be updated frequently to maintain context across memory resets:

1. **Update After Each Significant Change**: Document every completed step
2. **Update Every 3-5 Tool Calls**: Even for minor changes or analysis
3. **Include Timestamps**: Add timestamps to each update for tracking
4. **Mark Current Position Clearly**: Indicate exactly which step is in progress
5. **Describe Next Steps**: Always outline the next planned actions
6. **Use Status Indicators**: Use checkmarks, status tags, and clear labeling
7. **Preserve Planning Status**: Always preserve the Planning Status section from plan-mode

```typescript
// Update implementation progress after EACH significant change
edit_file("[planning_folder_path]/implementation-progress.md",
          "Update implementation progress - [specific change description]",
          "# Implementation Progress: [Optimization Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [phase]\n- Step: [step]\n- Last Update: [timestamp]\n- Current Task: [specific task in progress]\n- Next Steps: [next planned actions]\n\n...")
```

## 5. Specialized Implementation Structure

The system-wide-optimization implementation follows a structured phase approach specific to each planning folder. Each folder corresponds to one of the major optimization phases:

### 93-rules-workflow-system-wide-optimization: Core Subsystem Optimization

```typescript
// 1. Analyze core subsystem structure
list_dir("1000xbrain/core")
read_file("1000xbrain/core/[file_to_analyze].md", should_read_entire_file=true)

// 2. Identify optimization opportunities
edit_file("[planning_folder_path]/implementation-progress.md",
          "Document optimization opportunities",
          "# Implementation Progress: Core Optimization\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.1\n- Last Update: [timestamp]\n- Current Task: Identifying optimization opportunities\n\n## Optimization Targets\n\n...")

// 3. Consolidate core files
read_file("1000xbrain/core/[file_to_optimize].md", should_read_entire_file=true)
edit_file("1000xbrain/core/[file_to_optimize].md",
          "Optimize core file",
          "# [Title]\n\n## [Optimized Section]\n\n[Optimized Content]")

// 4. Update implementation progress IMMEDIATELY after change
edit_file("[planning_folder_path]/implementation-progress.md",
          "Update implementation progress - [file] optimized",
          "# Implementation Progress: Core Optimization\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.2\n- Last Update: [timestamp]\n- Current Task: Completed optimization of [file]\n- Next Steps: [next file to optimize]\n\n## Line Count Reduction\n\n- [file]: [before] → [after] lines ([reduction]% reduction)\n...")
```

### 94-rules-workflow-system-wide-optimization: Knowledge & Parameters Optimization

```typescript
// 1. Analyze knowledge structure
list_dir("1000xbrain/knowledge")
list_dir("1000xbrain/knowledge/rules")

// 2. Document reorganization plan
edit_file("[planning_folder_path]/implementation-progress.md",
          "Document knowledge reorganization plan",
          "# Implementation Progress: Knowledge Optimization\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.1\n- Last Update: [timestamp]\n- Current Task: Planning knowledge reorganization\n\n## Reorganization Structure\n\n...")

// 3. Implement knowledge reorganization
read_file("1000xbrain/knowledge/rules/[file_to_reorganize].md", should_read_entire_file=true)
edit_file("1000xbrain/knowledge/rules/[new_pathway]/[file_to_reorganize].md",
          "Reorganize knowledge file",
          "# [Title]\n\n## [Reorganized Section]\n\n[Reorganized Content]")

// 4. Update implementation progress
edit_file("[planning_folder_path]/implementation-progress.md",
          "Update implementation progress - Knowledge reorganization",
          "# Implementation Progress: Knowledge Optimization\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.2\n- Last Update: [timestamp]\n- Current Task: Completed reorganization of [file]\n- Next Steps: [next file to reorganize]\n\n## Reorganization Progress\n\n- [file]: Moved to new pathway structure\n...")
```

### 95-rules-workflow-system-wide-optimization: Future Enhancements

```typescript
// 1. Document future enhancement opportunities
edit_file("1000xbrain/knowledge/rules/futures/enhancement-opportunities.md",
          "Document future enhancement opportunities",
          "# Future Enhancement Opportunities\n\n## [Enhancement Category]\n\n...")

// 2. Update implementation progress
edit_file("[planning_folder_path]/implementation-progress.md",
          "Update implementation progress - Future enhancements documented",
          "# Implementation Progress: Future Enhancements\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.1\n- Last Update: [timestamp]\n- Current Task: Documented future enhancement opportunities\n- Next Steps: [next enhancement category]\n\n## Enhancement Categories\n\n- [category]: [description]\n...")
```

## 6. Implementation Progress Structure

For system-wide-optimization, implementation progress tracking follows this specialized structure:

```markdown
# Implementation Progress: [Optimization Focus]

## Planning Status
- Planning Phase: [Completed | In Progress]
- Last Update: [timestamp]
- Current Planning Task: [specific task currently in progress]
- Planning Completion: [percentage or status indicator]

## Planning Tasks
- [x] Create README.md
- [x] Create requirements.md
- [x] Create implementation-[specific-focus].md
- [x] Create test-cheatsheet.md
- [ ] Finalize all planning documents
- [ ] Signal planning-document-complete

## Implementation Status
- Phase: [current phase number]
- Step: [current step number]
- Last Update: [timestamp]
- Current Task: [specific task currently in progress]
- Next Steps: [upcoming tasks]

## Optimization Metrics
- Lines Before: [total line count at start]
- Lines Current: [current line count]
- Lines Target: [target line count]
- Reduction: [percentage reduction]

## Phase Overview
- Planning: [status]
- Phase 1: [status] - [Phase description]
- Phase 2: [status] - [Phase description]
- Phase 3: [status] - [Phase description]
- Verification: [status] - [Verification description]

## Detailed Progress

### Phase 1: [Phase description]
- [x] Step 1.1: [completed step]
- [x] Step 1.2: [completed step]
- [ ] Step 1.3: [pending step]

### Phase 2: [Phase description]
- [ ] Step 2.1: [pending step]
- [ ] Step 2.2: [pending step]

## Recent Updates
- [timestamp]: [specific update detail]
- [timestamp]: [specific update detail]
- [timestamp]: [specific update detail]
```

## 7. Common Optimization Implementation Patterns

### Core File Consolidation

For optimizing core-brain-files:

1. **Line Count Analysis**: Analyze current line counts
2. **Redundancy Identification**: Identify redundant content
3. **Consolidation Implementation**: Consolidate related information
4. **Content Relocation**: Move implementation details to knowledge-base-files
5. **Line Count Verification**: Verify line count reduction

### Knowledge Reorganization

For implementing pathway-based knowledge organization:

1. **Pathway Mapping**: Define pathway-based structure
2. **File Reorganization**: Move files to new pathway-based locations
3. **Access Pattern Standardization**: Implement consistent access patterns
4. **Reference Updating**: Update cross-references to new locations
5. **Verification**: Ensure all knowledge remains accessible

### Parameter Standardization

For standardizing project-rule-parameters:

1. **Format Definition**: Define standard parameter format
2. **Format Implementation**: Update parameters to match standard
3. **Knowledge Integration**: Enhance knowledge access patterns
4. **Documentation**: Document standardized format
5. **Verification**: Test parameter effectiveness

## 8. Optimization Verification

System-wide-optimization requires comprehensive verification:

### Line Count Verification

```typescript
// 1. Update progress before verification
edit_file("[planning_folder_path]/implementation-progress.md",
          "Beginning line count verification",
          "# Implementation Progress: [Optimization Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [verification phase]\n- Step: [verification step]\n- Last Update: [timestamp]\n- Current Task: Verifying line count reduction\n...")

// 2. Count lines in optimized files
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/core\" -Recurse -Filter \"*.md\" | Get-Content | Measure-Object -Line).Lines", false)

// 3. Document verification results
edit_file("[planning_folder_path]/implementation-progress.md",
          "Update verification results - Line count verification",
          "# Implementation Progress: [Optimization Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [verification phase]\n- Step: [verification step]\n- Last Update: [timestamp]\n- Current Task: Completed line count verification\n- Next Steps: [next verification step]\n\n## Line Count Verification\n\n- Target: [target line count]\n- Actual: [actual line count]\n- Result: [Pass/Fail]\n...")
```

### Functional Verification

```typescript
// 1. Update progress before testing
edit_file("[planning_folder_path]/implementation-progress.md",
          "Beginning functional verification",
          "# Implementation Progress: [Optimization Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [verification phase]\n- Step: [verification step]\n- Last Update: [timestamp]\n- Current Task: Testing functional equivalence\n...")

// 2. Test functionality
read_file("1000xbrain/[component_path]/[optimized_file].md", should_read_entire_file=true)

// 3. Document test results
edit_file("[planning_folder_path]/implementation-progress.md",
          "Update verification results - Functional verification",
          "# Implementation Progress: [Optimization Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [verification phase]\n- Step: [verification step]\n- Last Update: [timestamp]\n- Current Task: Completed functional verification\n- Next Steps: [next verification step]\n\n## Functional Verification\n\n- [component]: [status]\n...")
```

## 9. Success Criteria

Successful implementation of system-wide-optimization meets these criteria:

1. **Line Count Reduction**: Achieved target line count reduction
2. **Functional Equivalence**: Optimized components maintain same functionality
3. **Knowledge Organization**: Knowledge is organized by pathway with consistent access
4. **Parameter Standardization**: Parameters follow consistent format
5. **Documentation Quality**: Documentation is clear and consistent
6. **Verification Completeness**: All optimization targets are verified
7. **Progress Documentation**: Comprehensive implementation-progress.md with detailed tracking
8. **Clear Domain Separation**: Always preserves planning content while updating implementation content

## 10. Implementation Completion

When system-wide-optimization implementation is complete for the current planning folder, 1000xdev:

1. **Verifies Optimization Targets**: Ensures all optimization targets are met
2. **Updates Progress**: Marks all phases and steps as complete
3. **Documents Optimization Results**: Provides comprehensive documentation of changes
4. **Prepares for Next Folder**: Prepares for continuation to the next optimization folder
5. **Signals Completion**: Sends `implementation-complete` message-command

### Completion Indicator

```
💻 1000xdev [rules-workflow]

System-Wide Optimization Implementation for [current folder] complete:
- All optimization targets met
- Line count reduced to [actual line count]
- Functionality maintained
- Implementation-progress.md updated with final status
- Ready to proceed to next folder: [next-folder-name]

implementation-complete
```

## 11. Knowledge Access During System-Wide Optimization

When implementing system-wide optimizations, use the `fetch_rules` tool to access specialized knowledge:

```typescript
// Access architecture understanding for optimization
fetch_rules(["knowledge/rules/guides/architecture"], 
           "Understanding system architecture for comprehensive optimization")

// Access optimization patterns
fetch_rules(["knowledge/rules/patterns/impl/optimization-patterns"], 
           "Understanding optimization patterns for implementation")

// Access multiple knowledge components for complex optimizations
fetch_rules([
  "knowledge/rules/guides/architecture",
  "knowledge/rules/patterns/impl/optimization-patterns",
  "knowledge/rules/reference/maps/domain-map"
], "Comprehensive architectural understanding for system-wide optimization")
```

### Recommended Knowledge Components

When implementing system-wide optimizations, these knowledge components are particularly valuable:

| Knowledge Component | fetch_rules Path | Usage |
|---------------------|-----------------|-------|
| Architecture Guide | `knowledge/rules/guides/architecture` | Understanding system architecture |
| Optimization Patterns | `knowledge/rules/patterns/impl/optimization-patterns` | Consistent optimization implementation |
| Domain Map | `knowledge/rules/reference/maps/domain-map` | Understanding relationships between components |
| Cognitive Enhancement | `knowledge/rules/guides/cognitive-enhancement` | System-wide enhancement approaches |
| File Standards | `knowledge/rules/patterns/doc/file-standards` | Consistent file structure |

### Knowledge Access Best Practices

For optimal knowledge access during system-wide optimization implementation:

1. **Start with Architecture Understanding**: Begin with comprehensive architectural knowledge
2. **Access Optimization Patterns**: Ensure consistent optimization approach
3. **Understand Component Relationships**: Map dependencies between components
4. **Combine Related Knowledge Components**: For complete understanding
5. **Access Implementation Guidelines**: For optimization implementation approaches 