# mode: dev-mode | workflow: rules-workflow | pathway: system-wide-optimization | filepath: @parameters/rules/dev-mode/system-wide-optimization.mdc  | optional-standard-parameter(s): none

## Purpose

This parameter provides a specialized execution structure optimized for implementing coordinated optimization across multiple components of the 1000xbrain cognitive architecture, with a focus on system-wide optimization.

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: All of 1000xbrain/**
- **Rationale**: System-wide optimization changes affect the entire cognitive architecture and require comprehensive access

## Knowledge Access

For comprehensive understanding of the system architecture and optimization approaches, access these knowledge components:

```typescript
// Access system architecture documentation
fetch_rules(["knowledge/system-structure/system-architecture"], 
           "Understanding the overall system architecture for optimization implementation")

// Access related knowledge
fetch_rules([
  "knowledge/system-structure/workflow-subsystem-relationships",
  "knowledge/system-structure/system-vs-subsystem",
  "knowledge/system-structure/pathway-organization"
], "Understanding the relationships between components for optimization implementation")

// Access optimization knowledge
fetch_rules(["knowledge/rules/system-wide/brain-files-cursor-rules"], 
           "Understanding brain-files and cursor-rules relationship")
fetch_rules(["knowledge/rules/system-wide-optimization/cognitive-load-optimization"], 
           "Understanding cognitive load optimization strategies")
fetch_rules(["knowledge/rules/performance/implementation-performance"], 
           "Understanding implementation performance optimization")
```

## Implementation Approach

The system-wide-optimization pathway in dev-mode implements comprehensive optimization across the cognitive architecture through these sequential activities:

1. **Documentation Update**: Update knowledge/system-structure/ files FIRST to reflect optimization changes
2. **Core Component Optimization**: Implement optimization of core subsystem components
3. **Dependent Component Optimization**: Implement optimization of dependent subsystem components
4. **Cross-Component Integration**: Ensure coordinated optimization across all components
5. **Optimization Metrics Verification**: Measure and verify optimization metrics
6. **Implementation Documentation**: Document the implementation in implementation-progress.md

## Autonomous Implementation Protocol

The implementation follows a fully autonomous workflow:

1. **Complete Implementation Autonomy**: 
   - Autonomously identify and execute all necessary implementation steps
   - No user input required for next steps determination
   - Continual progress through implementation until completion
   
2. **Self-Directed Implementation Flow**:
   - Automatic progression through implementation phases
   - Independent decision-making on implementation approach
   - Autonomous prioritization of optimization targets
   - Self-determined workflow sequencing
   
3. **Continuous Progress Without Interruption**:
   - Implementation continues until fully complete
   - No pauses for user direction on next steps
   - Automatic transition between implementation phases
   - Independent verification of completion criteria

## 1000x Development Principles

The system-wide-optimization pathway upholds these core 1000x development principles:

1. **Autonomous Implementation**: Implements changes based on comprehensive planning
2. **Minimal Guidance**: Requires minimal human intervention through self-contained implementation
3. **Clear Role Separation**: Maintains strict separation between planning and implementation
4. **Context Preservation**: Ensures consistent context across memory resets and folder transitions
5. **Continuous Improvement**: Measures and verifies optimization success with clear metrics
6. **Implementation Self-Diagnosis**: Verifies implementation success through quantitative metrics
7. **Cross-Folder Coordination**: Ensures sequential implementation across multiple planning folders

## Tool Call Process

### Documentation-First Implementation Process

Always follow this documentation-first implementation process:

1. **Read Planning Documents**: Read planning folder documents to understand optimization requirements
2. **Access Knowledge**: Fetch knowledge about the system architecture and optimization approaches
3. **Update Documentation First**: Update knowledge/system-structure/ files to reflect optimization changes
4. **Implement Core Optimizations**: Implement optimization of core components
5. **Implement Dependent Optimizations**: Implement optimization of dependent components
6. **Verify Optimization Metrics**: Measure and verify optimization metrics
7. **Document Progress**: Update implementation-progress.md with status

### Example Tool Call Sequence

```typescript
// 1. ALWAYS start by reading planning folder documents
read_file("planning/[project-folder]/README.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation-progress.md", should_read_entire_file=true)
read_file("planning/[project-folder]/requirements.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation-[specific-focus].md", should_read_entire_file=true)
read_file("planning/[project-folder]/test-cheatsheet.md", should_read_entire_file=true)

// 2. Access knowledge
fetch_rules(["knowledge/system-structure/system-architecture"], 
           "Understanding the system architecture for optimization")
fetch_rules(["knowledge/system-structure/workflow-subsystem-relationships"], 
           "Understanding workflow relationships for optimization")

// 3. Update documentation FIRST
list_dir("1000xbrain/knowledge/system-structure")
read_file("1000xbrain/knowledge/system-structure/system-architecture.md", should_read_entire_file=true)
edit_file("1000xbrain/knowledge/system-structure/system-architecture.md",
          "Update system architecture documentation to reflect optimization changes",
          "# USE WHEN understanding the overall system architecture...\n\n[Updated content to reflect optimization changes]...")

// 4. Implement core component optimizations
list_dir("1000xbrain/core/[component]")
read_file("1000xbrain/core/[component]/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/core/[component]/[target-file].md",
          "Optimize core component",
          "# [Title]\n\n## [Optimized Section]\n\n[Optimized Content]")

// 5. Update implementation progress
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress - Core component optimized",
          "# Implementation Progress: System-Wide Optimization\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 2\n- Step: 2.1\n- Current Task: Completed optimization of [component]\n- Next Steps: [next component to optimize]\n\n## Detailed Progress\n\n...")

// 6. Implement dependent component optimizations
list_dir("1000xbrain/[dependent-subsystem]/[component]")
read_file("1000xbrain/[dependent-subsystem]/[component]/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/[dependent-subsystem]/[component]/[target-file].md",
          "Optimize dependent component",
          "# [Title]\n\n## [Optimized Section]\n\n[Optimized Content]")

// 7. Verify optimization metrics
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/[component_path]\" -Recurse -Filter \"*.md\" | Where-Object { $_.Name -ne \"README.md\" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum", false)

// 8. Final implementation progress update
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress - Optimization complete",
          "# Implementation Progress: System-Wide Optimization\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: Complete\n- Current Task: Optimization completed\n- Metrics: [include specific metrics showing optimization results]\n\n## Detailed Progress\n\n...")
```

## Memory Reset Handling

This project-rule-parameter will be repeatedly sent until implementation is complete. Additionally, memory resets may occur during implementation. Therefore:

1. **ALWAYS begin with explicit file reading** in the exact order specified above
2. **FIRST read README.md and implementation-progress.md** to establish context
3. **Update implementation-progress.md frequently** to maintain continuity
4. **Never assume previous context is remembered** - verify current state through explicit file reads
5. **Make each response self-contained** with clear status indicators

## Cross-Folder Transition Handling

When autonomously transitioning between planning folders:

1. **Self-Determined Completion Assessment**: Independently verify all implementation tasks in the current folder are complete
2. **Autonomous Final Status Update**: Update implementation-progress.md with completed status
3. **Clear Completion Signaling**: Signal implementation-complete with specific folder transition information
4. **Self-Directed Continuity**: Maintain implementation continuity when starting the next folder
5. **Independent Dependency Verification**: Ensure all dependencies from previous folders are met before implementing

## Error Handling

When encountering errors during implementation, follow these structured error handling patterns autonomously:

### Path Not Found Handling

```typescript
// 1. Attempt to access path with try-catch logic
list_dir("1000xbrain/[path]")

// 2. If path not found, check parent directories in hierarchical order
list_dir("1000xbrain")
// Document path issue for error tracking
edit_file("planning/[current_folder]/implementation-progress.md",
          "Document path error encountered",
          "# Implementation Progress: [Optimization Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [phase]\n- Step: [step]\n- Current Task: Encountered missing path [path]\n- Next Steps: Resolve path issue\n- Current Folder: [current_folder]\n\n## Error Tracking\n- Error: Path not found: [path]\n- Resolution Approach: Create directory\n- Status: In Progress\n\n...")

// 3. Create directory with explicit error handling
run_terminal_cmd("New-Item -Path \"1000xbrain/[path]\" -ItemType Directory -Force -ErrorAction SilentlyContinue; $?", false)

// 4. Verify directory creation with explicit check
list_dir("1000xbrain/[path]")

// 5. Document error resolution with verification
edit_file("planning/[current_folder]/implementation-progress.md",
          "Update implementation progress - Directory creation verification",
          "# Implementation Progress: [Optimization Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [phase]\n- Step: [step]\n- Current Task: Resolved missing directory [path]\n- Next Steps: [next steps]\n- Current Folder: [current_folder]\n\n## Error Resolution\n- Error: Path not found: [path]\n- Resolution: Created directory [path]\n- Verification: Directory exists and is accessible\n- Status: Resolved\n\n...")
```

## Common Optimization Implementation Patterns

### Core Optimization

For implementing core subsystem optimization:

1. **Redundancy Elimination**: Identify and eliminate redundancies in core files
2. **Consistent Patterns**: Standardize patterns across core components
3. **Line Count Reduction**: Consolidate related information to reduce line counts
4. **Terminology Standardization**: Implement consistent terminology

### Knowledge Organization Optimization

For implementing knowledge subsystem optimization:

1. **Pathway-Based Organization**: Reorganize knowledge files by pathway
2. **Access Pattern Standardization**: Standardize knowledge access patterns
3. **Content Deduplication**: Eliminate duplicated content across knowledge files
4. **Cross-Reference Enhancement**: Improve cross-references between knowledge files

## Implementation Completion

When system-wide optimization implementation is complete:

1. **Verify Optimization Metrics**: Ensure optimization targets have been met
2. **Update Final Metrics**: Document final metrics in implementation-progress.md
3. **Signal Completion**: Send implementation-complete message-command

### Completion Indicator

```
💻 1000xdev [rules-workflow]

System-Wide Optimization implementation fully complete:
- [Specific optimization achievements]
- [Specific metrics and improvements]
- [Specific completion criteria met]
- All planned tasks implemented and verified
- Implementation-progress.md updated with final status

implementation-complete
```

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For subsystem relationships, see `knowledge/system-structure/system-vs-subsystem.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md`
- For pathway organization, see `knowledge/system-structure/pathway-organization.md`
- For cognitive load optimization, see `knowledge/rules/system-wide-optimization/cognitive-load-optimization.md`
- For implementation performance, see `knowledge/rules/performance/implementation-performance.md` 