# mode: dev-mode | workflow: rules-workflow | pathway: system-wide-optimization | filepath: @parameters/rules/dev-mode/system-wide-optimization.mdc  | optional-standard-parameter(s): none

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

## 1000x Development Principles Alignment

The system-wide-optimization pathway upholds these core 1000x development principles:

1. **Autonomous Implementation**: Implements changes based on comprehensive planning
2. **Minimal Guidance**: Requires minimal human intervention through self-contained implementation
3. **Clear Role Separation**: Maintains strict separation between planning and implementation
4. **Context Preservation**: Ensures consistent context across memory resets and folder transitions
5. **Continuous Improvement**: Measures and verifies optimization success with clear metrics
6. **Implementation Self-Diagnosis**: Verifies implementation success through quantitative metrics
7. **Cross-Folder Coordination**: Ensures sequential implementation across multiple planning folders

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

## Folder-Specific Implementation Focus

Each planning folder in the system-wide optimization sequence requires specific implementation focus:

1. **93-rules-workflow-system-wide-optimization**: Core Subsystem Optimization
   - Implement core brain-files consolidation and streamlining
   - Meet line count reduction targets (<2000 lines total)
   - Implement message-command format changes
   - Standardize common-words and terminology

2. **94-rules-workflow-system-wide-optimization**: Knowledge & Parameters Optimization
   - Implement pathway-based knowledge organization
   - Standardize project-rule-parameters format
   - Convert README.md files to index.md
   - Improve knowledge accessibility

3. **95-rules-workflow-system-wide-optimization**: Future Enhancements
   - Document additional optimization opportunities
   - Create framework for ongoing enhancement
   - Plan cognitive architecture evolution
   - Establish long-term optimization roadmap

### ⚠️ CRITICAL: Memory Reset Handling

This project-rule-parameter will be repeatedly sent until implementation is complete. Additionally, memory resets may occur during implementation. Therefore:

1. **ALWAYS begin with explicit file reading** in the exact order specified above
2. **FIRST read README.md and implementation-progress.md** to establish context
3. **Update implementation-progress.md frequently** to maintain continuity
4. **Never assume previous context is remembered** - verify current state through explicit file reads
5. **Make each response self-contained** with clear status indicators

## Cross-Folder Transition Handling

When transitioning between planning folders:

1. **Verify Current Folder Completion**: Ensure all implementation tasks in the current folder are complete
2. **Update Final Implementation Status**: Mark all tasks as complete in the current folder's implementation-progress.md
3. **Signal Folder Completion**: Signal implementation-complete with specific folder transition information
4. **Maintain Implementation Continuity**: Reference previous folder's results when starting the next folder
5. **Verify Dependencies**: Ensure all dependencies from previous folders are met before implementing

### Folder Transition Tool Call Sequence

```typescript
// 1. Verify current folder completion
read_file("planning/[current_folder]/implementation-progress.md", should_read_entire_file=true)

// 2. Signal completion and prepare for transition
edit_file("planning/[current_folder]/implementation-progress.md",
          "Update implementation progress - Implementation complete",
          "# Implementation Progress: [Current Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: Complete\n- Last Update: [timestamp]\n- Current Task: Implementation completed\n- Next Steps: Proceed to [next_folder]\n\n## Detailed Progress\n\n- All implementation tasks complete\n- All optimization targets met\n- Ready for transition to [next_folder]\n...")

// 3. Signal completion to Tyler with transition information
// Include specific next folder information for clear transition
```

## 3. Folder-Specific Mandatory Tool Call Sequences

### For 93-rules-workflow-system-wide-optimization

```typescript
// MANDATORY: Verify folder existence and context first
list_dir("planning/93-rules-workflow-system-wide-optimization")

// MANDATORY: ALWAYS start by reading README.md FIRST
read_file("planning/93-rules-workflow-system-wide-optimization/README.md", should_read_entire_file=true)

// MANDATORY: ALWAYS read implementation-progress.md SECOND to determine current state
read_file("planning/93-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)

// Read core optimization plan and requirements
read_file("planning/93-rules-workflow-system-wide-optimization/implementation-core-optimization.md", should_read_entire_file=true)
read_file("planning/93-rules-workflow-system-wide-optimization/requirements.md", should_read_entire_file=true)

// Conditional: Only read test-cheatsheet if it exists
list_dir("planning/93-rules-workflow-system-wide-optimization")
// If test-cheatsheet.md exists in the directory listing, read it
read_file("planning/93-rules-workflow-system-wide-optimization/test-cheatsheet.md", should_read_entire_file=true)

// Read previous folder's implementation results
read_file("planning/92-rules-workflow-system-wide/implementation-progress.md", should_read_entire_file=true)

// Analyze core file structure with hierarchy and performance optimized commands
list_dir("1000xbrain/core")
// Use more precise line count measurement with exclusions for accurate metrics
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/core\" -Recurse -Filter \"*.md\" | Where-Object { $_.Name -ne \"README.md\" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum", false)

// Examine specific subsystem directories for detailed analysis
list_dir("1000xbrain/core/identity")
list_dir("1000xbrain/core/modes")
list_dir("1000xbrain/core/communication")

// Continue implementation from current progress point
// Implementation based on current state in implementation-progress.md
```

### For 94-rules-workflow-system-wide-optimization

```typescript
// MANDATORY: Verify folder existence and context first
list_dir("planning/94-rules-workflow-system-wide-optimization")

// MANDATORY: ALWAYS start by reading README.md FIRST
read_file("planning/94-rules-workflow-system-wide-optimization/README.md", should_read_entire_file=true)

// MANDATORY: ALWAYS read implementation-progress.md SECOND to determine current state
read_file("planning/94-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)

// Read knowledge optimization plan and requirements
read_file("planning/94-rules-workflow-system-wide-optimization/implementation-knowledge-parameters.md", should_read_entire_file=true)
read_file("planning/94-rules-workflow-system-wide-optimization/requirements.md", should_read_entire_file=true)

// Conditional: Only read test-cheatsheet if it exists
list_dir("planning/94-rules-workflow-system-wide-optimization")
// If test-cheatsheet.md exists in the directory listing, read it
read_file("planning/94-rules-workflow-system-wide-optimization/test-cheatsheet.md", should_read_entire_file=true)

// Read previous folder's implementation results
read_file("planning/93-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)

// Analyze knowledge structure in hierarchical order
list_dir("1000xbrain/knowledge")
list_dir("1000xbrain/knowledge/rules")
// Analyze parameters structure
list_dir("1000xbrain/parameters")
list_dir("1000xbrain/parameters/rules")

// Count files for organization metrics
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/knowledge/rules\" -Recurse -Filter \"*.md\" | Measure-Object).Count", false)

// Continue implementation from current progress point
// Implementation based on current state in implementation-progress.md
```

### For 95-rules-workflow-system-wide-optimization

```typescript
// MANDATORY: Verify folder existence and context first
list_dir("planning/95-rules-workflow-system-wide-optimization")

// MANDATORY: ALWAYS start by reading README.md FIRST
read_file("planning/95-rules-workflow-system-wide-optimization/README.md", should_read_entire_file=true)

// MANDATORY: ALWAYS read implementation-progress.md SECOND to determine current state
read_file("planning/95-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)

// Read future enhancements plan and requirements
read_file("planning/95-rules-workflow-system-wide-optimization/implementation-future-enhancements.md", should_read_entire_file=true)
read_file("planning/95-rules-workflow-system-wide-optimization/requirements.md", should_read_entire_file=true)

// Conditional: Only read test-cheatsheet if it exists
list_dir("planning/95-rules-workflow-system-wide-optimization")
// If test-cheatsheet.md exists in the directory listing, read it
read_file("planning/95-rules-workflow-system-wide-optimization/test-cheatsheet.md", should_read_entire_file=true)

// Read ALL previous folder's implementation results in reverse chronological order
read_file("planning/94-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)
read_file("planning/93-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)
read_file("planning/92-rules-workflow-system-wide/implementation-progress.md", should_read_entire_file=true)

// Analyze optimized system structure in hierarchical order
list_dir("1000xbrain")
// Examine core structure with metrics
list_dir("1000xbrain/core")
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/core\" -Recurse -Filter \"*.md\" | Where-Object { $_.Name -ne \"README.md\" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum", false)
// Examine knowledge structure with metrics
list_dir("1000xbrain/knowledge")
list_dir("1000xbrain/knowledge/rules")
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/knowledge/rules\" -Recurse -Filter \"*.md\" | Measure-Object).Count", false)
// Examine parameters structure
list_dir("1000xbrain/parameters")
list_dir("1000xbrain/parameters/rules")

// Continue implementation from current progress point
// Implementation based on current state in implementation-progress.md
```

### Path Validation Before File Operations

Before any file operation, ALWAYS validate the target file path to ensure it exists:

```typescript
// Example path validation pattern for file operations
// 1. List directory first to confirm parent directory exists
list_dir("1000xbrain/core/")

// 2. Check for file existence before reading
list_dir("1000xbrain/core/")
// If file exists in directory listing, proceed with read
read_file("1000xbrain/core/[target_file].md", should_read_entire_file=true)

// 3. Check for file existence before editing
list_dir("1000xbrain/core/")
read_file("1000xbrain/core/[target_file].md", should_read_entire_file=true)
// Only after confirming file contents, proceed with edit
edit_file("1000xbrain/core/[target_file].md",
          "Update file with specific purpose",
          "# [Title]\n\n## [Modified Section]\n\n[Modified Content]")

// 4. Verify directory existence before creating file in new directory
list_dir("1000xbrain/knowledge/rules")
// If directory doesn't exist, create it first
run_terminal_cmd("New-Item -Path \"1000xbrain/knowledge/rules/[new_pathway]\" -ItemType Directory -Force", false)
// Verify directory creation
list_dir("1000xbrain/knowledge/rules/[new_pathway]")
// Then create file
edit_file("1000xbrain/knowledge/rules/[new_pathway]/[new_file].md",
          "Create new file in verified directory",
          "# [Title]\n\n## [Section]\n\n[Content]")
```

## 5. Specialized Implementation Structure

The system-wide-optimization implementation follows a structured phase approach specific to each planning folder. Each folder corresponds to one of the major optimization phases:

### 93-rules-workflow-system-wide-optimization: Core Subsystem Optimization

```typescript
// 1. Validate target file paths before analyzing
list_dir("1000xbrain/core")
// Check for specific file existence
list_dir("1000xbrain/core/identity")
read_file("1000xbrain/core/identity/[file_to_analyze].md", should_read_entire_file=true)

// 2. Record line counts before optimization with precise metrics
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/core\" -Recurse -Filter \"*.md\" | Where-Object { $_.Name -ne \"README.md\" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum", false)
edit_file("planning/93-rules-workflow-system-wide-optimization/implementation-progress.md",
          "Document current line count with precise metrics",
          "# Implementation Progress: Core Optimization\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.1\n- Last Update: [timestamp]\n- Current Task: Recording baseline metrics\n- Current Folder: 93-rules-workflow-system-wide-optimization\n\n## Optimization Metrics\n- Starting Line Count: [count] lines\n- Target Line Count: <2000 lines\n- Current Reduction: 0%\n\n...")

// 3. Consolidate core files with validation
list_dir("1000xbrain/core")
// Validate specific file existence
list_dir("1000xbrain/core/[specific_directory]")
read_file("1000xbrain/core/[specific_directory]/[file_to_optimize].md", should_read_entire_file=true)
// Only edit after validation
edit_file("1000xbrain/core/[specific_directory]/[file_to_optimize].md",
          "Optimize core file with specific purpose",
          "# [Title]\n\n## [Optimized Section]\n\n[Optimized Content]")

// 4. Update implementation progress with precise line count metrics
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/core\" -Recurse -Filter \"*.md\" | Where-Object { $_.Name -ne \"README.md\" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum", false)
edit_file("planning/93-rules-workflow-system-wide-optimization/implementation-progress.md",
          "Update line count reduction metrics with precise measurements",
          "# Implementation Progress: Core Optimization\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.2\n- Last Update: [timestamp]\n- Current Task: Completed optimization of [file]\n- Next Steps: [next file to optimize]\n- Current Folder: 93-rules-workflow-system-wide-optimization\n\n## Optimization Metrics\n- Starting Line Count: [original_count] lines\n- Current Line Count: [current_count] lines\n- Target Line Count: <2000 lines\n- Current Reduction: [percentage]%\n\n## Line Count Reduction\n\n- [file]: [before] → [after] lines ([reduction]% reduction)\n...")
```

### 94-rules-workflow-system-wide-optimization: Knowledge & Parameters Optimization

```typescript
// 1. Validate knowledge structure before analyzing
list_dir("1000xbrain/knowledge")
list_dir("1000xbrain/knowledge/rules")

// 2. Document current knowledge organization
edit_file("planning/94-rules-workflow-system-wide-optimization/implementation-progress.md",
          "Document current knowledge organization",
          "# Implementation Progress: Knowledge Optimization\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.1\n- Last Update: [timestamp]\n- Current Task: Analyzing current knowledge structure\n- Current Folder: 94-rules-workflow-system-wide-optimization\n\n## Pathway Organization\n- Current Structure: [description]\n- Target Structure: [description]\n- Organization Progress: 0%\n\n...")

// 3. Validate target file before reorganization
list_dir("1000xbrain/knowledge/rules")
read_file("1000xbrain/knowledge/rules/[file_to_reorganize].md", should_read_entire_file=true)

// 4. Ensure target directory exists before moving file 
list_dir("1000xbrain/knowledge/rules")
run_terminal_cmd("New-Item -Path \"1000xbrain/knowledge/rules/[new_pathway]\" -ItemType Directory -Force", false)

// 5. Move file to new pathway structure
edit_file("1000xbrain/knowledge/rules/[new_pathway]/[file_to_reorganize].md",
          "Reorganize knowledge file",
          "# [Title]\n\n## [Reorganized Section]\n\n[Reorganized Content]")

// 6. Update implementation progress with pathway metrics
edit_file("planning/94-rules-workflow-system-wide-optimization/implementation-progress.md",
          "Update pathway reorganization metrics",
          "# Implementation Progress: Knowledge Optimization\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.2\n- Last Update: [timestamp]\n- Current Task: Completed reorganization of [file]\n- Next Steps: [next file to reorganize]\n- Current Folder: 94-rules-workflow-system-wide-optimization\n\n## Pathway Organization\n- Current Structure: [description]\n- Target Structure: [description]\n- Organization Progress: [percentage]%\n\n## Reorganization Progress\n\n- [file]: Moved to [new_pathway] pathway\n...")
```

### 95-rules-workflow-system-wide-optimization: Future Enhancements

```typescript
// 1. Ensure target directory exists
list_dir("1000xbrain/knowledge/rules")
run_terminal_cmd("New-Item -Path \"1000xbrain/knowledge/rules/futures\" -ItemType Directory -Force", false)

// 2. Document enhancement opportunities
edit_file("1000xbrain/knowledge/rules/futures/enhancement-opportunities.md",
          "Document future enhancement opportunities",
          "# Future Enhancement Opportunities\n\n## [Enhancement Category]\n\n...")

// 3. Update implementation progress with categorization metrics
edit_file("planning/95-rules-workflow-system-wide-optimization/implementation-progress.md",
          "Update enhancement categorization metrics",
          "# Implementation Progress: Future Enhancements\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: 1\n- Step: 1.1\n- Last Update: [timestamp]\n- Current Task: Documented enhancement category [category]\n- Next Steps: Document next enhancement category\n- Current Folder: 95-rules-workflow-system-wide-optimization\n\n## Enhancement Categories\n- [category]: [count] opportunities documented\n- Total Categories: [total_count]\n- Total Opportunities: [opportunity_count]\n\n...")
```

## 6. Error Handling Patterns

When encountering errors during implementation, follow these structured error handling patterns:

### Path Not Found Handling

```typescript
// 1. Attempt to access path with try-catch logic
list_dir("1000xbrain/[path]")

// 2. If path not found, check parent directories in hierarchical order
list_dir("1000xbrain")
// Document path issue for error tracking
edit_file("planning/[current_folder]/implementation-progress.md",
          "Document path error encountered",
          "# Implementation Progress: [Optimization Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [phase]\n- Step: [step]\n- Last Update: [timestamp]\n- Current Task: Encountered missing path [path]\n- Next Steps: Resolve path issue\n- Current Folder: [current_folder]\n\n## Error Tracking\n- Error: Path not found: [path]\n- Resolution Approach: Create directory\n- Status: In Progress\n\n...")

// 3. Create directory with explicit error handling
run_terminal_cmd("New-Item -Path \"1000xbrain/[path]\" -ItemType Directory -Force -ErrorAction SilentlyContinue; $?", false)

// 4. Verify directory creation with explicit check
list_dir("1000xbrain/[path]")

// 5. Document error resolution with verification
edit_file("planning/[current_folder]/implementation-progress.md",
          "Update implementation progress - Directory creation verification",
          "# Implementation Progress: [Optimization Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [phase]\n- Step: [step]\n- Last Update: [timestamp]\n- Current Task: Resolved missing directory [path]\n- Next Steps: [next steps]\n- Current Folder: [current_folder]\n\n## Error Resolution\n- Error: Path not found: [path]\n- Resolution: Created directory [path]\n- Verification: Directory exists and is accessible\n- Status: Resolved\n\n...")
```

### File Content Validation

```typescript
// 1. Check directory before reading file
list_dir("1000xbrain/[path]")

// 2. Read file to validate content with error anticipation
read_file("1000xbrain/[path]/[file].md", should_read_entire_file=true)

// 3. If content has issues, document with specific issue type
edit_file("planning/[current_folder]/implementation-progress.md",
          "Update implementation progress - Content validation issue with specific error type",
          "# Implementation Progress: [Optimization Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [phase]\n- Step: [step]\n- Last Update: [timestamp]\n- Current Task: Addressing content issue in [file]\n- Issue Type: [formatting|structure|reference|missing section]\n- Next Steps: [resolution steps]\n- Current Folder: [current_folder]\n\n## Error Resolution\n- Error: [specific content issue with details]\n- Resolution Approach: [planned resolution with specific fix]\n- Status: In Progress\n\n...")

// 4. Implement fix with explicit purpose
edit_file("1000xbrain/[path]/[file].md",
          "Fix [specific issue type] in [specific section]",
          "# [Title]\n\n## [Section]\n\n[Fixed Content with specific corrections]")

// 5. Verify fix with full content check
read_file("1000xbrain/[path]/[file].md", should_read_entire_file=true)

// 6. Document resolution with verification details
edit_file("planning/[current_folder]/implementation-progress.md",
          "Update implementation progress - Content issue resolved with verification",
          "# Implementation Progress: [Optimization Focus]\n\n## Planning Status\n[PRESERVE EXISTING PLANNING STATUS CONTENT]\n\n## Implementation Status\n- Phase: [phase]\n- Step: [step]\n- Last Update: [timestamp]\n- Current Task: Resolved content issue in [file]\n- Next Steps: [next steps]\n- Current Folder: [current_folder]\n\n## Error Resolution\n- Error: [specific content issue]\n- Resolution: [implemented fix with specific details]\n- Verification: Content validated and issue confirmed fixed\n- Status: Resolved\n\n...")
```

## 7. Folder-Specific Implementation Progress Structures

Each planning folder requires specialized implementation progress tracking:

### For 93-rules-workflow-system-wide-optimization

```markdown
# Implementation Progress: Core Optimization

## Planning Status
[PRESERVE EXISTING PLANNING STATUS CONTENT]

## Implementation Status
- Phase: [current phase number]
- Step: [current step number]
- Last Update: [timestamp]
- Current Task: [specific task currently in progress]
- Next Steps: [upcoming tasks]
- Current Folder: 93-rules-workflow-system-wide-optimization

## Optimization Metrics
- Starting Line Count: [original_count] lines
- Current Line Count: [current_count] lines
- Target Line Count: <2000 lines
- Current Reduction: [percentage]%

## Phase Overview
- Planning: [status]
- Core File Analysis: [status]
- Consolidation Implementation: [status]
- Message-Command Format: [status]
- Terminology Standardization: [status]
- Verification: [status]

## Detailed Progress

### Phase 1: Core File Analysis
- [x] Step 1.1: [completed step]
- [x] Step 1.2: [completed step]
- [ ] Step 1.3: [pending step]

### Phase 2: File Consolidation
- [ ] Step 2.1: [pending step]
- [ ] Step 2.2: [pending step]

## Line Count Reduction
- [file1]: [before] → [after] lines ([reduction]% reduction)
- [file2]: [before] → [after] lines ([reduction]% reduction)
- Total: [total_before] → [total_after] lines ([total_reduction]% reduction)

## Recent Updates
- [timestamp]: [specific update detail]
- [timestamp]: [specific update detail]
```

### For 94-rules-workflow-system-wide-optimization

```markdown
# Implementation Progress: Knowledge & Parameters Optimization

## Planning Status
[PRESERVE EXISTING PLANNING STATUS CONTENT]

## Implementation Status
- Phase: [current phase number]
- Step: [current step number]
- Last Update: [timestamp]
- Current Task: [specific task currently in progress]
- Next Steps: [upcoming tasks]
- Current Folder: 94-rules-workflow-system-wide-optimization

## Pathway Organization
- Current Structure: [description]
- Target Structure: [description]
- Organization Progress: [percentage]%

## Phase Overview
- Planning: [status]
- Knowledge Structure Analysis: [status]
- Pathway Reorganization: [status]
- Parameter Standardization: [status]
- README-to-Index Conversion: [status]
- Verification: [status]

## Detailed Progress

### Phase 1: Knowledge Structure Analysis
- [x] Step 1.1: [completed step]
- [x] Step 1.2: [completed step]
- [ ] Step 1.3: [pending step]

### Phase 2: Pathway Reorganization
- [ ] Step 2.1: [pending step]
- [ ] Step 2.2: [pending step]

## Reorganization Progress
- [file1]: Moved to [new_pathway1]
- [file2]: Moved to [new_pathway2]
- Total Files Reorganized: [count]/[total]

## Recent Updates
- [timestamp]: [specific update detail]
- [timestamp]: [specific update detail]
```

### For 95-rules-workflow-system-wide-optimization

```markdown
# Implementation Progress: Future Enhancements

## Planning Status
[PRESERVE EXISTING PLANNING STATUS CONTENT]

## Implementation Status
- Phase: [current phase number]
- Step: [current step number]
- Last Update: [timestamp]
- Current Task: [specific task currently in progress]
- Next Steps: [upcoming tasks]
- Current Folder: 95-rules-workflow-system-wide-optimization

## Enhancement Categories
- [category1]: [count1] opportunities
- [category2]: [count2] opportunities
- [category3]: [count3] opportunities
- Total Categories: [total_categories]
- Total Opportunities: [total_opportunities]

## Phase Overview
- Planning: [status]
- Enhancement Identification: [status]
- Opportunity Documentation: [status]
- Architecture Evolution: [status]
- Roadmap Creation: [status]
- Verification: [status]

## Detailed Progress

### Phase 1: Enhancement Identification
- [x] Step 1.1: [completed step]
- [x] Step 1.2: [completed step]
- [ ] Step 1.3: [pending step]

### Phase 2: Documentation
- [ ] Step 2.1: [pending step]
- [ ] Step 2.2: [pending step]

## Recent Updates
- [timestamp]: [specific update detail]
- [timestamp]: [specific update detail]
```

## 8. Completion Indicators

### Folder-Specific Completion Indicators

#### 93-rules-workflow-system-wide-optimization Completion

```
💻 1000xdev [rules-workflow]

Core Subsystem Optimization complete:
- Line count reduced from [original] to [final] lines ([percentage]% reduction)
- Target of <2000 lines achieved: [Yes/No]
- Core files consolidated and streamlined
- Message-command format implemented
- Common-words standardized
- Implementation-progress.md updated with final metrics
- Ready to proceed to Knowledge & Parameters Optimization (94-rules-workflow-system-wide-optimization)

implementation-complete
```

#### 94-rules-workflow-system-wide-optimization Completion

```
💻 1000xdev [rules-workflow]

Knowledge & Parameters Optimization complete:
- [count] files reorganized by pathway
- [count] project-rule-parameters standardized
- [count] README.md files converted to index.md
- Knowledge accessibility improved through pathway organization
- Implementation-progress.md updated with final metrics
- Ready to proceed to Future Enhancements (95-rules-workflow-system-wide-optimization)

implementation-complete
```

#### 95-rules-workflow-system-wide-optimization Completion

```
💻 1000xdev [rules-workflow]

Future Enhancements documentation complete:
- [count] enhancement categories identified
- [count] total enhancement opportunities documented
- Cognitive architecture evolution roadmap created
- Implementation-progress.md updated with final metrics
- System-wide optimization pathway completed across all planning folders

implementation-complete
```

### System-Wide Optimization Final Completion

When all three planning folders (93, 94, and 95) have been completed:

```
💻 1000xdev [rules-workflow]

System-Wide Optimization pathway fully implemented:
- Core optimization: Line count reduced to [count] lines ([percentage]% reduction)
- Knowledge organization: Reorganized by pathway structure
- Parameter standardization: All parameters follow consistent format
- Future enhancements: [count] opportunities documented across [count] categories
- All planning folders completed: 93, 94, and 95

system-wide-optimization-complete
```

## 9. Knowledge Access During System-Wide Optimization

When implementing system-wide optimizations, use the `fetch_rules` tool to access specialized knowledge:

```typescript
// Access architecture understanding for optimization with focused purpose
fetch_rules(["knowledge/rules/guides/architecture"], 
           "Understanding system architecture for precise optimization targets")

// Access implementation patterns with specific optimization focus
fetch_rules(["knowledge/rules/patterns/impl/optimization-patterns"], 
           "Finding specific optimization patterns for [current optimization focus]")

// Access multiple knowledge components for complex optimizations with task-specific focus
fetch_rules([
  "knowledge/rules/guides/architecture",
  "knowledge/rules/patterns/impl/optimization-patterns",
  "knowledge/rules/reference/maps/domain-map",
  "knowledge/rules/reference/architecture"
], "Comprehensive architectural understanding for [specific optimization task]")
```

### Folder-Specific Knowledge Access

For 93-rules-workflow-system-wide-optimization:
```typescript
fetch_rules([
  "knowledge/rules/patterns/impl/consolidation-patterns",
  "knowledge/rules/reference/architecture",
  "knowledge/rules/patterns/impl/file-standards"
], "Understanding core file consolidation patterns, architecture, and file standards for core optimization")
```

For 94-rules-workflow-system-wide-optimization:
```typescript
fetch_rules([
  "knowledge/rules/patterns/impl/organization-patterns",
  "knowledge/rules/reference/maps/domain-map",
  "knowledge/rules/patterns/doc/hierarchical-relationship-guide"
], "Understanding knowledge organization patterns, domain relationships, and hierarchical structures for knowledge optimization")
```

For 95-rules-workflow-system-wide-optimization:
```typescript
fetch_rules([
  "knowledge/rules/guides/cognitive-enhancement",
  "knowledge/rules/patterns/impl/architecture-patterns",
  "knowledge/rules/guides/architecture"
], "Understanding cognitive enhancement opportunities, architectural evolution patterns, and system architecture for future planning")
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