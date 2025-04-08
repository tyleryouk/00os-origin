# mode: dev-mode | workflow: rules-workflow | pathway: system-wide | filepath: @parameters/rules/dev-mode/system-wide.mdc  | optional-standard-parameter(s): none

## Purpose

This parameter provides a specialized execution structure optimized for implementing coordinated changes across multiple components of the 1000xbrain cognitive architecture. This approach is ideal when:

- Implementation requires changes to multiple subsystems
- Coordinated multi-component updates are necessary
- Cross-cutting concerns need to be addressed
- Maintaining system-wide consistency is critical

## Domain Access

- **Read Access**: All of 1000xbrain
- **Edit Access**: All of 1000xbrain/**
- **Rationale**: System-wide changes affect the entire cognitive architecture and require comprehensive access

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

// Access optimization knowledge
fetch_rules(["knowledge/rules/system-wide-optimization/cognitive-load-optimization"], 
           "Understanding cognitive load optimization")
fetch_rules(["knowledge/rules/performance/implementation-performance"], 
           "Understanding implementation performance optimization")
```

## Implementation Approach

The system-wide pathway in dev-mode implements changes across multiple subsystems through these sequential activities:

1. **Documentation Update**: Update knowledge/system-structure/ files FIRST to reflect system-wide changes
2. **Core Component Implementation**: Implement changes to core subsystem components
3. **Dependent Component Implementation**: Implement changes to dependent subsystem components
4. **Cross-Component Integration**: Ensure coordinated integration across all components
5. **System-Wide Verification**: Verify the implementation across the entire system
6. **Implementation Documentation**: Document the implementation in implementation-progress.md

## Role Responsibilities

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
   - Plan-mode creates implementation plan
   - Dev-mode implements according to plan without modifying planning documents (except implementation-progress.md)

## Tool Call Process

### Documentation-First Implementation Process

Always follow this documentation-first implementation process:

1. **Read Planning Documents**: Read planning folder documents to understand requirements
2. **Access Knowledge**: Fetch knowledge about the system architecture
3. **Update Documentation First**: Update knowledge/system-structure/ files to reflect system-wide changes
4. **Implement Core Changes**: Implement changes to core components
5. **Implement Dependent Changes**: Implement changes to dependent components
6. **Verify System-Wide Integration**: Verify system-wide functionality
7. **Document Progress**: Update implementation-progress.md with status

### Example Tool Call Sequence

```typescript
// 1. ALWAYS start by reading planning folder documents
read_file("planning/[project-folder]/README.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation-progress.md", should_read_entire_file=true)
read_file("planning/[project-folder]/requirements.md", should_read_entire_file=true)
read_file("planning/[project-folder]/implementation-system-wide-enhancement.md", should_read_entire_file=true)
read_file("planning/[project-folder]/test-cheatsheet.md", should_read_entire_file=true)

// 2. Access knowledge
fetch_rules(["knowledge/system-structure/system-architecture"], 
           "Understanding the system architecture")
fetch_rules(["knowledge/system-structure/workflow-subsystem-relationships"], 
           "Understanding workflow relationships")

// 3. Update documentation FIRST
list_dir("1000xbrain/knowledge/system-structure")
read_file("1000xbrain/knowledge/system-structure/system-architecture.md", should_read_entire_file=true)
edit_file("1000xbrain/knowledge/system-structure/system-architecture.md",
          "Update system architecture documentation to reflect changes",
          "# USE WHEN understanding the overall system architecture...\n\n[Updated content to reflect system-wide changes]...")

// 4. Implement core component changes
list_dir("1000xbrain/core/[component]")
read_file("1000xbrain/core/[component]/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/core/[component]/[target-file].md",
          "Implement core component changes",
          "# [Title]\n\n## [Enhanced Section]\n\n[Enhanced Content]")

// 5. Update implementation progress
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress - Core component modified",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 2\n- Step: 2.1\n- Current Task: Completed implementation of [component]\n- Next Steps: [next component to modify]\n\n## Detailed Progress\n\n...")

// 6. Implement dependent component changes
list_dir("1000xbrain/[dependent-subsystem]/[component]")
read_file("1000xbrain/[dependent-subsystem]/[component]/[target-file].md", should_read_entire_file=true)
edit_file("1000xbrain/[dependent-subsystem]/[component]/[target-file].md",
          "Implement dependent component changes",
          "# [Title]\n\n## [Enhanced Section]\n\n[Enhanced Content]")

// 7. Verify system-wide integration
read_file("1000xbrain/core/[component]/[modified-file].md", should_read_entire_file=true)
read_file("1000xbrain/[dependent-subsystem]/[component]/[modified-file].md", should_read_entire_file=true)

// 8. Final implementation progress update
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress - Implementation complete",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: Complete\n- Current Task: Implementation completed\n\n## Detailed Progress\n\n...")
```

## Memory Reset Handling

This project-rule-parameter will be repeatedly sent until implementation is complete. Additionally, memory resets may occur during implementation. Therefore:

1. **ALWAYS begin with explicit file reading** in the exact order specified above
2. **FIRST read README.md and implementation-progress.md** to establish context
3. **Update implementation-progress.md frequently** to maintain continuity
4. **Never assume previous context is remembered** - verify current state through explicit file reads
5. **Make each response self-contained** with clear status indicators

## Implementation Structure

The system-wide enhancement implementation follows this structured approach:

### Phase 1: Preparation and Dependency Analysis

```typescript
// Update documentation first
edit_file("1000xbrain/knowledge/system-structure/system-architecture.md",
          "Update system architecture documentation",
          "# USE WHEN understanding the overall system architecture...\n\n[Updated content with dependency analysis]...")

// Update implementation progress
edit_file("planning/[project-folder]/implementation-progress.md",
          "Document dependency analysis",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.1\n- Current Task: Analyzing system architecture\n\n...")
```

### Phase 2: Core Component Implementation

```typescript
// Update implementation progress before starting
edit_file("planning/[project-folder]/implementation-progress.md",
          "Beginning core component implementation",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 2\n- Step: 2.1\n- Current Task: Beginning implementation of [component]\n...")

// Implement changes to core components
read_file("1000xbrain/core/[component]/[file_to_modify].md", should_read_entire_file=true)
edit_file("1000xbrain/core/[component]/[file_to_modify].md",
          "Implement core component changes",
          "# [Title]\n\n## [Enhanced Section]\n\n[Enhanced Content]")

// Update implementation progress after each change
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress - [component] modified",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 2\n- Step: 2.1\n- Current Task: Completed implementation of [component]\n- Next Steps: [next component to modify]\n\n...")
```

### Phase 3: Dependent Component Implementation

```typescript
// Update implementation progress before starting
edit_file("planning/[project-folder]/implementation-progress.md",
          "Beginning dependent component implementation",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 3\n- Step: 3.1\n- Current Task: Beginning implementation of [dependent component]\n...")

// Implement changes to dependent components
read_file("1000xbrain/[dependent_path]/[file_to_modify].md", should_read_entire_file=true)
edit_file("1000xbrain/[dependent_path]/[file_to_modify].md",
          "Implement dependent component changes",
          "# [Title]\n\n## [Enhanced Section]\n\n[Enhanced Content]")

// Update implementation progress after each change
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update implementation progress - [dependent component] modified",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 3\n- Step: 3.1\n- Current Task: Completed implementation of [dependent component]\n- Next Steps: [next dependent component to modify]\n\n...")
```

### Phase 4: System-Wide Verification

```typescript
// Update implementation progress before verification
edit_file("planning/[project-folder]/implementation-progress.md",
          "Beginning system-wide verification",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.1\n- Current Task: Beginning verification of core components\n...")

// Verify core component changes
read_file("1000xbrain/core/[component]/[modified_file].md", should_read_entire_file=true)

// Verify dependent component changes
read_file("1000xbrain/[dependent_path]/[modified_file].md", should_read_entire_file=true)

// Update implementation progress with verification results
edit_file("planning/[project-folder]/implementation-progress.md",
          "Update verification progress - Verification complete",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.3\n- Current Task: Completed verification\n- Next Steps: Final implementation wrap-up\n\n...")
```

## Implementation Progress Structure

For system-wide enhancements, implementation progress tracking follows this structure:

```markdown
# Implementation Progress: System-Wide Enhancement

## Planning Status
- Planning Phase: [Completed | In Progress]
- Current Planning Task: [specific task currently in progress]

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
- Phase: [current phase number]
- Step: [current step number]
- Current Task: [specific task currently in progress]
- Next Steps: [upcoming tasks]

## System Components
- Core Components: [list of core components being modified]
- Dependent Components: [list of dependent components being modified]
- Integration Points: [list of cross-component integration points]

## Phase Overview
- Planning: [status]
- Phase 1: [status] - Preparation and Dependency Analysis
- Phase 2: [status] - Core Component Implementation
- Phase 3: [status] - Dependent Component Implementation
- Phase 4: [status] - System-Wide Verification

## Detailed Progress

### Phase 1: Preparation and Dependency Analysis
- [x] Step 1.1: [completed step]
- [x] Step 1.2: [completed step]
- [ ] Step 1.3: [pending step]

### Phase 2: Core Component Implementation
- [ ] Step 2.1: [pending step]
- [ ] Step 2.2: [pending step]

### Phase 3: Dependent Component Implementation
- [ ] Step 3.1: [pending step]
- [ ] Step 3.2: [pending step]

### Phase 4: System-Wide Verification
- [ ] Step 4.1: [pending step]
- [ ] Step 4.2: [pending step]

## Component Status
- Component 1: [status] - [details]
- Component 2: [status] - [details]
- Component 3: [status] - [details]

## Recent Updates
- [specific update detail]
- [specific update detail]
- [specific update detail]
```

## Common Implementation Patterns

### Architectural Pattern Standardization

For implementing consistent patterns across the system:

1. **Pattern Definition**: Define the standard pattern clearly
2. **Core Implementation**: Implement in core components first
3. **Outward Propagation**: Extend to dependent components
4. **Consistency Verification**: Ensure uniform implementation

### Cross-Component Communication Enhancement

For improving cross-component communication:

1. **Interface Definition**: Define clear component interfaces
2. **Provider Implementation**: Implement provider-side changes
3. **Consumer Implementation**: Update consumer components
4. **End-to-End Testing**: Verify complete communication flow

### System-Wide Terminology Standardization

For standardizing terminology across the system:

1. **Glossary Creation**: Define standard terminology
2. **Core Component Alignment**: Update core components with standard terms
3. **Dependent Component Updates**: Propagate terminology to all components
4. **Documentation Consistency**: Ensure documentation reflects standardized terms

## System Integration Testing

System-wide enhancements require comprehensive integration testing:

### Component Interaction Testing

```typescript
// Update implementation progress before testing
edit_file("planning/[project-folder]/implementation-progress.md",
          "Beginning component interaction testing",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.3\n- Current Task: Testing interaction between [component1] and [component2]\n...")

// Test interaction between components
read_file("1000xbrain/[component1_path]/[interface_file].md", should_read_entire_file=true)
read_file("1000xbrain/[component2_path]/[consumer_file].md", should_read_entire_file=true)

// Document interaction test results
edit_file("planning/[project-folder]/implementation-progress.md",
          "Document component interaction test",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.3\n- Current Task: Completed testing interaction between [component1] and [component2]\n- Next Steps: Test next component interaction\n\n...")
```

### End-to-End Flow Testing

```typescript
// Update implementation progress before testing
edit_file("planning/[project-folder]/implementation-progress.md",
          "Beginning end-to-end flow testing",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.4\n- Current Task: Testing end-to-end flow\n...")

// Test each step in the flow
read_file("1000xbrain/[component1_path]/[step1_file].md", should_read_entire_file=true)
read_file("1000xbrain/[component2_path]/[step2_file].md", should_read_entire_file=true)

// Document flow test results
edit_file("planning/[project-folder]/implementation-progress.md",
          "Document flow test results",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.4\n- Current Task: Completed end-to-end flow testing\n- Next Steps: Final implementation verification\n\n...")
```

## Implementation Completion

When system-wide enhancement implementation is complete:

1. **Verify System-Wide Requirements**: Ensure all requirements are met across the entire system
2. **Update Progress**: Mark all phases and steps as complete
3. **Signal Completion**: Send implementation-complete message-command

### Completion Indicator

```
💻 1000xdev [rules-workflow]

System-Wide Enhancement implementation complete:
- All components enhanced according to requirements
- System-wide integration verified
- Cross-component functionality confirmed
- Implementation-progress.md updated with final status

implementation-complete
```

## Related Knowledge

For more detailed information on related aspects of the system:

- For overall system architecture, see `knowledge/system-structure/system-architecture.md`
- For subsystem relationships, see `knowledge/system-structure/system-vs-subsystem.md`
- For workflow relationships, see `knowledge/system-structure/workflow-subsystem-relationships.md`
- For pathway organization, see `knowledge/system-structure/pathway-organization.md` 