# mode: dev-mode | workflow: rules-workflow | pathway: system-wide | filepath: @parameters/rules/dev-mode/system-wide.mdc  | optional-standard-parameter(s): none


## 1. System-Wide Enhancement Implementation Overview

The system-wide enhancement implementation pathway provides a specialized execution structure optimized for implementing coordinated changes across multiple components of the 1000xbrain cognitive architecture. This approach is ideal when:

- Implementation requires changes to multiple subsystems
- Coordinated multi-component updates are necessary
- Cross-cutting concerns need to be addressed
- Maintaining system-wide consistency is critical

### Key Benefits

1. **Comprehensive Impact**: Enables coordinated changes across the entire architecture
2. **Architectural Consistency**: Ensures consistent patterns across all components
3. **Coordinated Implementation**: Manages dependencies between components
4. **Cross-Component Verification**: Tests interactions between modified components
5. **Holistic Improvement**: Addresses system-level concerns rather than isolated components

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
   - Plan-mode creates implementation plan
   - Dev-mode implements according to plan without modifying planning documents (except implementation-progress.md)

## 2. Core Command Operation

When the `dev-mode: rules-workflow @parameters/rules/dev-mode/system-wide.mdc` message-command is received, 1000xdev will:

1. **Initialize Developer Mode**: Enter or remain in Developer Mode with the 💻 1000xdev [rules-workflow] indicator
2. **ALWAYS Re-Read Planning Folder Files**: Read the following planning-folder-files IN THIS EXACT ORDER:
   - README.md (MANDATORY FIRST FILE)
   - implementation-progress.md (MANDATORY SECOND FILE)
   - context-files (all context-files)
   - implementation-files (all implementation-files)
   - test-cheatsheet.md
3. **Continue Implementation from Current Point**: Use implementation-progress.md to determine the current state
4. **Frequently Update Implementation Progress**: Update after EACH significant change or every 3-5 tool calls
5. **Execute Coordinated Changes**: Implement changes across multiple components in a coordinated sequence
6. **Verify System-Wide Integrity**: Test the entire system's functionality after changes

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

// Read relevant context files based on implementation phase
read_file("[planning_folder_path]/context-architecture-mapping.md", should_read_entire_file=true)
read_file("[planning_folder_path]/context-cross-system-patterns.md", should_read_entire_file=true)
read_file("[planning_folder_path]/implementation-system-wide-enhancement.md", should_read_entire_file=true)

// Examine system structure as needed
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
3. **Mark Current Position Clearly**: Indicate exactly which step is in progress
4. **Describe Next Steps**: Always outline the next planned actions
5. **Use Status Indicators**: Use checkmarks, status tags, and clear labeling
6. **Preserve Planning Status**: Always preserve the Planning Status section from plan-mode

```typescript
// Update implementation progress after EACH significant change
edit_file("[planning_folder_path]/implementation-progress.md",
          "Update implementation progress - [specific change description]",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [phase]\n- Step: [step]\n- Current Task: [specific task in progress]\n- Next Steps: [next planned actions]\n\n...")
```

## 5. Specialized Implementation Structure

The system-wide enhancement implementation follows this specialized structure:

### Phase 1: Preparation and Dependency Analysis

```typescript
// 1. Analyze system architecture
list_dir("1000xbrain")
list_dir("1000xbrain/core")
list_dir("1000xbrain/workflows")
list_dir("1000xbrain/knowledge")

// 2. Map component dependencies
edit_file("[planning_folder_path]/implementation-progress.md",
          "Document component dependencies",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.2\n- Current Task: Mapping component dependencies\n\n## Component Dependencies\n\n...")

// 3. Create implementation sequence
edit_file("[planning_folder_path]/implementation-progress.md",
          "Document implementation sequence",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.3\n- Current Task: Creating implementation sequence\n\n## Implementation Sequence\n\n1. [First component]\n2. [Second component]\n...")
```

### Phase 2: Core Component Implementation

```typescript
// 1. Update progress before reading file
edit_file("[planning_folder_path]/implementation-progress.md",
          "Beginning core component implementation",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 2\n- Step: 2.1\n- Current Task: Beginning implementation of [component]\n...")

// 2. Implement changes to core components
read_file("1000xbrain/core/[component]/[file_to_modify].md", should_read_entire_file=true)
edit_file("1000xbrain/core/[component]/[file_to_modify].md",
          "Implement core component changes",
          "# [Title]\n\n## [Enhanced Section]\n\n[Enhanced Content]")

// 3. Update implementation progress IMMEDIATELY after change
edit_file("[planning_folder_path]/implementation-progress.md",
          "Update implementation progress - [component] modified",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 2\n- Step: 2.1\n- Current Task: Completed implementation of [component]\n- Next Steps: [next component to modify]\n\n## Detailed Progress\n\n### Phase 2: Core Component Implementation\n- [x] Step 2.1: Modified [component]\n- [ ] Step 2.2: [next component]...")
```

### Phase 3: Dependent Component Implementation

```typescript
// 1. Update progress before reading file
edit_file("[planning_folder_path]/implementation-progress.md",
          "Beginning dependent component implementation",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 3\n- Step: 3.1\n- Current Task: Beginning implementation of [dependent component]\n...")

// 2. Implement changes to dependent components
read_file("1000xbrain/[dependent_path]/[file_to_modify].md", should_read_entire_file=true)
edit_file("1000xbrain/[dependent_path]/[file_to_modify].md",
          "Implement dependent component changes",
          "# [Title]\n\n## [Enhanced Section]\n\n[Enhanced Content]")

// 3. Update implementation progress IMMEDIATELY after change
edit_file("[planning_folder_path]/implementation-progress.md",
          "Update implementation progress - [dependent component] modified",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 3\n- Step: 3.1\n- Current Task: Completed implementation of [dependent component]\n- Next Steps: [next dependent component to modify]\n\n## Detailed Progress\n\n### Phase 3: Dependent Component Implementation\n- [x] Step 3.1: Modified [dependent component]\n- [ ] Step 3.2: [next dependent component]...")
```

### Phase 4: System-Wide Verification

```typescript
// 1. Update progress before verification
edit_file("[planning_folder_path]/implementation-progress.md",
          "Beginning system-wide verification",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.1\n- Current Task: Beginning verification of core components\n...")

// 2. Verify core component changes
read_file("1000xbrain/core/[component]/[modified_file].md", should_read_entire_file=true)

// 3. Update progress after each verification
edit_file("[planning_folder_path]/implementation-progress.md",
          "Update verification progress - [component] verified",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.1\n- Current Task: Completed verification of [component]\n- Next Steps: Verify [next component]\n\n## Detailed Progress\n\n### Phase 4: System-Wide Verification\n- [x] Step 4.1: Verified [component]\n- [ ] Step 4.2: Verify [next component]...")

// 4. Verify dependent component changes
read_file("1000xbrain/[dependent_path]/[modified_file].md", should_read_entire_file=true)

// 5. Update progress after verification
edit_file("[planning_folder_path]/implementation-progress.md",
          "Update verification progress - [dependent component] verified",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.2\n- Current Task: Completed verification of [dependent component]\n- Next Steps: Verify cross-component functionality\n\n## Detailed Progress\n\n### Phase 4: System-Wide Verification\n- [x] Step 4.1: Verified core components\n- [x] Step 4.2: Verified dependent components\n- [ ] Step 4.3: Verify cross-component functionality...")

// 6. Final implementation progress update
edit_file("[planning_folder_path]/implementation-progress.md",
          "Complete implementation progress",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: Complete\n- Current Task: Implementation completed\n\n## Detailed Progress\n\n### Phase 4: System-Wide Verification\n- [x] Step 4.1: Verified core components\n- [x] Step 4.2: Verified dependent components\n- [x] Step 4.3: Verified cross-component functionality\n\n## Implementation Complete\nAll phases and steps have been successfully completed.")
```

## 6. Implementation Progress Structure

For system-wide enhancements, implementation progress tracking follows this specialized structure:

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

## 7. Common System-Wide Implementation Patterns

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

## 8. System Integration Testing

System-wide enhancements require comprehensive integration testing:

### Component Interaction Testing

```typescript
// 1. Update progress before testing
edit_file("[planning_folder_path]/implementation-progress.md",
          "Beginning component interaction testing",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.3\n- Current Task: Testing interaction between [component1] and [component2]\n...")

// 2. Test interaction between components
read_file("1000xbrain/[component1_path]/[interface_file].md", should_read_entire_file=true)
read_file("1000xbrain/[component2_path]/[consumer_file].md", should_read_entire_file=true)

// 3. Document interaction test results
edit_file("[planning_folder_path]/implementation-progress.md",
          "Document component interaction test",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.3\n- Current Task: Completed testing interaction between [component1] and [component2]\n- Next Steps: Test next component interaction\n\n## Component Interaction\n\n- [Component1]-[Component2]: [status]")
```

### End-to-End Flow Testing

```typescript
// 1. Update progress before testing
edit_file("[planning_folder_path]/implementation-progress.md",
          "Beginning end-to-end flow testing",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.4\n- Current Task: Testing end-to-end flow\n...")

// 2. Test each step in the flow
read_file("1000xbrain/[component1_path]/[step1_file].md", should_read_entire_file=true)
read_file("1000xbrain/[component2_path]/[step2_file].md", should_read_entire_file=true)

// 3. Document flow test results
edit_file("[planning_folder_path]/implementation-progress.md",
          "Document flow test results",
          "# Implementation Progress: System-Wide Enhancement\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 4\n- Step: 4.4\n- Current Task: Completed end-to-end flow testing\n- Next Steps: Final implementation verification\n\n## Flow Test Results\n\n- Flow: [status]")
```

## 9. Success Criteria

Successful implementation of system-wide enhancement meets these criteria:

1. **Complete Implementation**: All specified components are enhanced
2. **Architectural Consistency**: Changes follow consistent patterns across the system
3. **Functional Integration**: Components work together seamlessly
4. **Documentation Coherence**: Documentation reflects the enhanced architecture
5. **Verification Thoroughness**: System-wide testing confirms comprehensive functionality
6. **Progress Documentation**: Comprehensive implementation-progress.md with detailed tracking
7. **Clear Domain Separation**: Always preserves planning content while updating implementation content

## 10. Implementation Completion

When system-wide enhancement implementation is complete, 1000xdev:

1. **Verifies System-Wide Requirements**: Ensures all requirements are met across the entire system
2. **Updates Progress**: Marks all phases and steps as complete
3. **Documents System-Wide Changes**: Provides comprehensive documentation of changes
4. **Creates Follow-Up Requirements**: Automatically creates the next sequential requirements folder with initial content
5. **Signals Completion**: Sends `implementation-complete` message-command

### Completion Indicator

```
💻 1000xdev [rules-workflow]

System-Wide Enhancement Implementation complete:
- All components enhanced
- System-wide integration verified
- Cross-component functionality confirmed
- Implementation-progress.md updated with final status
- Follow-up requirements folder created: planning/{next-number}-{follow-up-focus}

implementation-complete
```

### Automatic Follow-Up Requirements Creation

As part of system-wide enhancement completion, the workflow automatically creates the next requirements folder:

```typescript
// 1. Identify the current planning folder number and determine the follow-up focus
list_dir("planning")
// Analyze implementation findings to determine logical follow-up focus

// 2. Create the next sequential planning folder
run_terminal_cmd("mkdir planning/{next-number}-{follow-up-focus}", false)

// 3. Create the initial requirements document
edit_file("planning/{next-number}-{follow-up-focus}/requirements.md",
          "Create follow-up requirements based on system-wide enhancement findings",
          "# Requirements: {follow-up-focus}\n\n[Requirements content based on findings from current implementation]")
```

## 11. Knowledge Access During System-Wide Implementation

When implementing system-wide enhancements, use the `fetch_rules` tool to access specialized knowledge that enables more effective implementation:

```typescript
// Access architecture understanding for system-wide implementation
fetch_rules(["knowledge/rules/guides/architecture"], 
           "Understanding system architecture for comprehensive implementation")

// Access implementation patterns for consistent changes
fetch_rules(["knowledge/rules/patterns/impl/architecture-patterns"], 
           "Implementing consistent architectural patterns across the system")

// Access multiple knowledge components for complex implementations
fetch_rules([
  "knowledge/rules/guides/architecture",
  "knowledge/rules/patterns/impl/architecture-patterns",
  "knowledge/rules/reference/maps/domain-map"
], "Comprehensive architectural understanding for system-wide implementation")
```

### Recommended Knowledge Components

When implementing system-wide enhancements, these knowledge components are particularly valuable:

| Knowledge Component | fetch_rules Path | Usage |
|---------------------|-----------------|-------|
| Architecture Guide | `knowledge/rules/guides/architecture` | Understanding system architecture |
| Architecture Patterns | `knowledge/rules/patterns/impl/architecture-patterns` | Consistent architectural implementation |
| Domain Map | `knowledge/rules/reference/maps/domain-map` | Understanding relationships between components |
| Cognitive Enhancement | `knowledge/rules/guides/cognitive-enhancement` | System-wide enhancement approaches |
| File Standards | `knowledge/rules/patterns/doc/file-standards` | Consistent file structure |

### Knowledge Access Best Practices

For optimal knowledge access during system-wide enhancement implementation:

1. **Start with Architecture Understanding**: Begin with comprehensive architectural knowledge
2. **Access Implementation Patterns**: Ensure consistent implementation
3. **Understand Component Relationships**: Map dependencies between components
4. **Combine Related Knowledge Components**: For complete understanding
5. **Access Cognitive Enhancement Guidelines**: For system improvement approaches 