# mode: plan-mode | workflow: rules-workflow | pathway: system-wide-optimization | filepath: @parameters/rules/plan-mode/system-wide-optimization.mdc  | optional-standard-parameter(s): none

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
3. **Gather Comprehensive Context**: Analyze target subsystem structure, content, and optimization opportunities 
4. **Map Optimization Targets**: Document specific optimization targets for the current planning folder
5. **Design Implementation Approach**: Create optimization implementation plans with specific targets
6. **Set Measurable Success Criteria**: Establish metrics to verify optimization success

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

## Comprehensive Context Gathering Process

Before making any changes to planning folder files, 1000xdev MUST gather comprehensive context through this sequence:

1. **Planning Folder Context**: Understand the current planning context and requirements
2. **Target System Analysis**: Analyze the target subsystem structure, content, and dependencies 
3. **External Knowledge Acquisition**: Gather relevant external knowledge on optimization best practices
4. **Cross-Reference Verification**: Verify relationships between components and impacts of changes
5. **Domain-Specific Pattern Recognition**: Identify common patterns and optimization opportunities

This comprehensive context gathering MUST be performed regardless of the specific optimization phase.

## Intelligence-Based Tool Selection

1000xdev will intelligently select and sequence appropriate tools based on the context gathering needs:

1. **Initial Directory Exploration**:
   - Use `list_dir` to explore planning folder structure
   - Use `list_dir` to examine target subsystem structure (READ ONLY)
   - Use sequential exploration starting with top-level directories and drilling down

2. **Content Analysis**:
   - Use `read_file` for planning folder files to understand requirements
   - Use `read_file` with selection for target system files to analyze content (READ ONLY)
   - Use `grep_search` to identify patterns across files and analyze dependencies

3. **External Knowledge Enhancement**:
   - Use `web_search` to gather latest best practices on system optimization
   - Use `fetch_rules` to access specialized knowledge components
   - Use multiple complementary knowledge sources for comprehensive understanding

4. **Pattern Recognition**:
   - Use `codebase_search` to identify architectural patterns and optimization opportunities
   - Use `grep_search` to find common terminology usage and standardization needs
   - Cross-reference findings to identify redundancies and optimization targets

5. **Quantitative Analysis**:
   - Use `run_terminal_cmd` to gather metrics (line counts, file sizes, etc.)
   - Use sequential commands to gather hierarchical metrics
   - Track metrics consistently across optimization phases

## Phase-Specific Tool Call Sequences

### For 93-rules-workflow-system-wide-optimization

```typescript
// 1. PLANNING FOLDER CONTEXT
// Verify planning folder exists and determine current folder context
list_dir("planning")
// Validate working in correct planning folder
list_dir("planning/93-rules-workflow-system-wide-optimization")
// Read requirements and prior implementation results in sequential order
read_file("planning/93-rules-workflow-system-wide-optimization/README.md", should_read_entire_file=true)
read_file("planning/93-rules-workflow-system-wide-optimization/requirements.md", should_read_entire_file=true)
// Check previous phase results if available
list_dir("planning/92-rules-workflow-system-wide")
read_file("planning/92-rules-workflow-system-wide/implementation-progress.md", should_read_entire_file=true)

// 2. TARGET SYSTEM ANALYSIS
// Analyze core structure hierarchy (READ ONLY)
list_dir("1000xbrain/core")
list_dir("1000xbrain/core/identity")
list_dir("1000xbrain/core/modes")
list_dir("1000xbrain/core/communication")
// Gather quantitative metrics for optimization targets
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/core\" -Recurse -Filter \"*.md\" | Where-Object { $_.Name -ne \"README.md\" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum", false)
// Analyze key files for content understanding (READ ONLY)
read_file("1000xbrain/core/core-essentials.md", should_read_entire_file=true)
read_file("1000xbrain/core/index.md", should_read_entire_file=true)
// Sample files from key directories for pattern analysis
read_file("1000xbrain/core/communication/message-commands.md", should_read_entire_file=true)
read_file("1000xbrain/core/modes/dev-mode.md", should_read_entire_file=true)
read_file("1000xbrain/core/identity/global-rules.md", should_read_entire_file=true)

// 3. EXTERNAL KNOWLEDGE ACQUISITION
// Access specialized knowledge for architectural understanding
fetch_rules(["knowledge/rules/guides/architecture"], 
           "Understanding system architecture for optimization planning")
// Access optimization patterns for implementation planning
fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"],
           "Finding optimization patterns for implementation planning")
// Gather external best practices on code organization and optimization
web_search("cognitive architecture optimization best practices file size reduction")
web_search("documentation system optimization minimal redundancy")

// 4. CROSS-REFERENCE VERIFICATION
// Identify redundancies across core files
grep_search("\\b(mode|identity|communication)\\b", true, "1000xbrain/core/*.md")
grep_search("\\bmessage-command\\b", true, "1000xbrain/core/**/*.md")
// Search for terminology inconsistencies
grep_search("\\b(brain-file|cursor-rule)\\b", true, "1000xbrain/core/**/*.md")
// Analyze knowledge access patterns
codebase_search("fetch_rules patterns in core files", ["1000xbrain/core"])

// 5. DOMAIN-SPECIFIC PATTERN RECOGNITION
// Identify common patterns in core file structure
codebase_search("documentation patterns in core files", ["1000xbrain/core"])
// Analyze related structures for improvement opportunities
list_dir("1000xbrain/knowledge/rules/reference/architecture")
// Verify knowledge file organization patterns
list_dir("1000xbrain/knowledge/rules/patterns")

// 6. CREATE PLANNING DOCUMENTS
// Now that comprehensive context is gathered, create or update planning documents
edit_file("planning/93-rules-workflow-system-wide-optimization/implementation-core-optimization.md",
          "Create implementation plan for core optimization based on comprehensive analysis",
          "# Implementation Plan: Core Optimization\n\n## Optimization Targets\n\n- Reduce core files to under 2000 lines total\n- Consolidate redundant content\n- Implement message-command format changes\n- Standardize terminology\n\n## Implementation Phases\n\n...")

// Create test cheatsheet with verification methods based on gathered context
edit_file("planning/93-rules-workflow-system-wide-optimization/test-cheatsheet.md",
          "Create test cheatsheet with verification methods derived from system analysis",
          "# Test Cheatsheet: Core Optimization\n\n## Line Count Verification\n\n...")

// Create quantitative metrics tracking template informed by current metrics
edit_file("planning/93-rules-workflow-system-wide-optimization/implementation-progress.md",
          "Create implementation progress tracking template with metrics derived from current analysis",
          "# Implementation Progress: Core Optimization\n\n## Planning Status\n- Planning Phase: In Progress\n- Last Update: [timestamp]\n- Current Planning Task: Creating core optimization plan\n\n## Implementation Status\n[Implementation will be tracked by dev-mode - left empty in plan-mode]\n\n## Optimization Metrics\n- Current Line Count: [count]\n- Target Line Count: <2000 lines\n- Reduction Goal: [percentage]%\n\n...")
```

### For 94-rules-workflow-system-wide-optimization

```typescript
// 1. PLANNING FOLDER CONTEXT
// Verify planning folder exists and determine current folder context
list_dir("planning")
// Validate working in correct planning folder
list_dir("planning/94-rules-workflow-system-wide-optimization")
// Read requirements and prior implementation results in sequential order
read_file("planning/94-rules-workflow-system-wide-optimization/README.md", should_read_entire_file=true)
read_file("planning/94-rules-workflow-system-wide-optimization/requirements.md", should_read_entire_file=true)
// Check previous phase results
read_file("planning/93-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)

// 2. TARGET SYSTEM ANALYSIS
// Analyze knowledge hierarchy (READ ONLY)
list_dir("1000xbrain/knowledge")
list_dir("1000xbrain/knowledge/rules")
list_dir("1000xbrain/knowledge/rules/patterns")
list_dir("1000xbrain/knowledge/rules/reference")
// Check parameters structure 
list_dir("1000xbrain/parameters")
list_dir("1000xbrain/parameters/rules")
// Gather quantitative metrics for knowledge files
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/knowledge\" -Recurse -Filter \"*.md\" | Where-Object { $_.Name -ne \"README.md\" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum", false)
// Sample knowledge files for pattern analysis
read_file("1000xbrain/knowledge/rules/reference/architecture/brain-files-cursor-rules.md", should_read_entire_file=true)
read_file("1000xbrain/knowledge/rules/patterns/tool/basic-patterns.md", should_read_entire_file=true)

// 3. EXTERNAL KNOWLEDGE ACQUISITION
// Access specialized knowledge for organizational patterns
fetch_rules(["knowledge/rules/patterns/doc/file-standards"], 
           "Understanding documentation standards for organization optimization")
// Gather information on knowledge management and documentation organization
web_search("knowledge management system organization best practices")
web_search("technical documentation structure optimization")

// 4. CROSS-REFERENCE VERIFICATION
// Analyze knowledge reference patterns
grep_search("fetch_rules\\(\\[\"knowledge/rules/", true, "1000xbrain/**/*.md")
// Verify parameter format consistency
grep_search("^# mode:", true, "1000xbrain/parameters/rules/**/*.md")
// Check README and index file patterns
grep_search("^# .+ Index", true, "1000xbrain/**/*.md")

// 5. DOMAIN-SPECIFIC PATTERN RECOGNITION
// Identify pathway patterns
codebase_search("pathway patterns in knowledge files", ["1000xbrain/knowledge"])
// Analyze knowledge access patterns
codebase_search("fetch_rules patterns in documentation", ["1000xbrain"])

// 6. CREATE PLANNING DOCUMENTS
// Create knowledge-specific implementation plan based on comprehensive analysis
edit_file("planning/94-rules-workflow-system-wide-optimization/implementation-knowledge-parameters.md",
          "Create implementation plan for knowledge and parameters optimization based on comprehensive analysis",
          "# Implementation Plan: Knowledge & Parameters Optimization\n\n## Optimization Targets\n\n- Reorganize knowledge-base-files by pathway\n- Standardize project-rule-parameters\n- Convert README.md files to index.md\n- Improve knowledge accessibility\n\n## Implementation Phases\n\n...")

// Create test cheatsheet with verification methods specific to knowledge organization
edit_file("planning/94-rules-workflow-system-wide-optimization/test-cheatsheet.md",
          "Create test cheatsheet with verification methods for knowledge organization",
          "# Test Cheatsheet: Knowledge & Parameters Optimization\n\n## Organization Verification\n\n...")

// Create pathway organization tracking template based on current structure
edit_file("planning/94-rules-workflow-system-wide-optimization/implementation-progress.md",
          "Create implementation progress tracking template with pathway organization metrics",
          "# Implementation Progress: Knowledge & Parameters Optimization\n\n## Planning Status\n- Planning Phase: In Progress\n- Last Update: [timestamp]\n- Current Planning Task: Creating knowledge organization plan\n\n## Implementation Status\n[Implementation will be tracked by dev-mode - left empty in plan-mode]\n\n## Pathway Organization\n- Current Structure: [description]\n- Target Structure: [description]\n- Organization Progress: 0%\n\n...")
```

### For 95-rules-workflow-system-wide-optimization

```typescript
// 1. PLANNING FOLDER CONTEXT
// Verify planning folder exists and determine current folder context
list_dir("planning")
// Validate working in correct planning folder
list_dir("planning/95-rules-workflow-system-wide-optimization")
// Read requirements and all prior implementation results 
read_file("planning/95-rules-workflow-system-wide-optimization/README.md", should_read_entire_file=true)
read_file("planning/95-rules-workflow-system-wide-optimization/requirements.md", should_read_entire_file=true)
// Read implementation progress in reverse chronological order
read_file("planning/94-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)
read_file("planning/93-rules-workflow-system-wide-optimization/implementation-progress.md", should_read_entire_file=true)

// 2. TARGET SYSTEM ANALYSIS
// Analyze entire optimized system (READ ONLY)
list_dir("1000xbrain")
// Examine optimized core structure
list_dir("1000xbrain/core")
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/core\" -Recurse -Filter \"*.md\" | Where-Object { $_.Name -ne \"README.md\" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum", false)
// Examine optimized knowledge structure
list_dir("1000xbrain/knowledge")
list_dir("1000xbrain/knowledge/rules")
run_terminal_cmd("(Get-ChildItem -Path \"1000xbrain/knowledge\" -Recurse -Filter \"*.md\" | Where-Object { $_.Name -ne \"README.md\" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum", false)
// Examine optimized parameters structure
list_dir("1000xbrain/parameters")
list_dir("1000xbrain/parameters/rules")

// 3. EXTERNAL KNOWLEDGE ACQUISITION
// Access specialized knowledge for cognitive enhancement
fetch_rules(["knowledge/rules/guides/cognitive-enhancement"], 
           "Understanding cognitive enhancement opportunities for future planning")
// Access architecture evolution patterns
fetch_rules(["knowledge/rules/patterns/impl/architecture-patterns"],
           "Understanding architectural evolution patterns for future enhancements")
// Research future trends and optimization opportunities
web_search("cognitive architecture future trends and enhancements")
web_search("AI system self-improvement mechanisms")

// 4. CROSS-REFERENCE VERIFICATION
// Identify enhancement opportunities in current architecture
codebase_search("enhancement opportunities in core", ["1000xbrain/core"])
codebase_search("enhancement opportunities in knowledge", ["1000xbrain/knowledge"])
// Analyze potential optimization areas
grep_search("optimization|enhancement|future", true, "1000xbrain/**/*.md")

// 5. DOMAIN-SPECIFIC PATTERN RECOGNITION
// Identify cognitive enhancement patterns
codebase_search("cognitive loop patterns", ["1000xbrain"])
// Analyze self-improvement mechanisms
codebase_search("self-improvement mechanisms", ["1000xbrain"])

// 6. CREATE PLANNING DOCUMENTS
// Create future enhancement plan based on comprehensive system analysis
edit_file("planning/95-rules-workflow-system-wide-optimization/implementation-future-enhancements.md",
          "Create implementation plan for future enhancements based on comprehensive system analysis",
          "# Implementation Plan: Future Enhancements\n\n## Enhancement Categories\n\n- Advanced cognitive capabilities\n- Self-enhancement mechanisms\n- Learning optimization\n- Performance improvements\n\n## Implementation Approach\n\n...")

// Create test cheatsheet for enhancement verification
edit_file("planning/95-rules-workflow-system-wide-optimization/test-cheatsheet.md",
          "Create test cheatsheet for enhancement verification",
          "# Test Cheatsheet: Future Enhancements\n\n## Enhancement Verification\n\n...")

// Create enhancement categorization template based on identified opportunities
edit_file("planning/95-rules-workflow-system-wide-optimization/implementation-progress.md",
          "Create implementation progress tracking template with enhancement categories",
          "# Implementation Progress: Future Enhancements\n\n## Planning Status\n- Planning Phase: In Progress\n- Last Update: [timestamp]\n- Current Planning Task: Categorizing enhancement opportunities\n\n## Implementation Status\n[Implementation will be tracked by dev-mode - left empty in plan-mode]\n\n## Enhancement Categories\n- Category 1: [description]\n- Category 2: [description]\n- Category 3: [description]\n\n...")
```

## Additional Tool Calls for Intelligent Context Gathering

1000xdev should intelligently determine and execute additional tool calls based on the specific optimization context. Examples include:

### For Line Count Analysis

```typescript
// Get detailed line counts by directory
run_terminal_cmd("Get-ChildItem -Path \"1000xbrain/core/\" -Directory | ForEach-Object { $dir = $_.FullName; $count = (Get-ChildItem -Path $dir -Recurse -Filter \"*.md\" | Where-Object { $_.Name -ne \"README.md\" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum; \"$($_.Name): $count lines\" }", false)

// Identify largest files for targeted optimization
run_terminal_cmd("Get-ChildItem -Path \"1000xbrain/core/\" -Recurse -Filter \"*.md\" | Where-Object { $_.Name -ne \"README.md\" } | ForEach-Object { $lines = (Get-Content $_.FullName | Measure-Object -Line).Lines; [PSCustomObject]@{File=$_.FullName; Lines=$lines} } | Sort-Object -Property Lines -Descending | Select-Object -First 10", false)
```

### For Content Redundancy Analysis

```typescript
// Identify common patterns across files
grep_search("^## [A-Z]", true, "1000xbrain/core/**/*.md")

// Identify redundant content sections
grep_search("(Mode System|Identity|Communication)", true, "1000xbrain/core/**/*.md")

// Search for specific terms with inconsistent usage
grep_search("\\b(brain[- ]file|cursor[- ]rule)\\b", true, "1000xbrain/**/*.md")
```

### For Knowledge Organization Analysis

```typescript
// Analyze knowledge directory structure
list_dir("1000xbrain/knowledge/rules/patterns")
list_dir("1000xbrain/knowledge/rules/reference")

// Map knowledge access patterns
grep_search("fetch_rules\\(\\[\"knowledge/rules/", true, "1000xbrain/**/*.md")

// Identify potential knowledge areas for reorganization
codebase_search("knowledge organization patterns", ["1000xbrain/knowledge"])
```

### For Parameters Standardization

```typescript
// Check parameter format consistency
grep_search("^# mode:", true, "1000xbrain/parameters/**/*.md")

// Analyze parameter structure
grep_search("\\| pathway: ", true, "1000xbrain/parameters/**/*.md")

// Identify parameter usage patterns
grep_search("@parameters/", true, "1000xbrain/**/*.md")
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
// Access system-wide knowledge components
fetch_rules(["knowledge/rules/system-wide/brain-files-cursor-rules"], 
           "Understanding brain-files and cursor-rules relationship")
fetch_rules(["knowledge/rules/system-wide-optimization/cognitive-load-optimization"], 
           "Understanding cognitive load optimization strategies")

// Access performance knowledge components
fetch_rules(["knowledge/rules/performance/implementation-performance"], 
           "Understanding implementation performance optimization")
fetch_rules(["knowledge/rules/system-wide-optimization/tool-optimization"], 
           "Understanding tool optimization techniques")
```

### Phase-Specific Knowledge Access

For 93-rules-workflow-system-wide-optimization:
```typescript
fetch_rules([
  "knowledge/rules/patterns/impl/consolidation-patterns",
  "knowledge/rules/reference/architecture"
], "Finding patterns for core file consolidation and architectural understanding")
```

For 94-rules-workflow-system-wide-optimization:
```typescript
fetch_rules([
  "knowledge/rules/patterns/impl/organization-patterns",
  "knowledge/rules/reference/maps/domain-map"
], "Finding patterns for knowledge organization and domain relationships")
```

For 95-rules-workflow-system-wide-optimization:
```typescript
fetch_rules([
  "knowledge/rules/guides/cognitive-enhancement",
  "knowledge/rules/patterns/impl/architecture-patterns"
], "Understanding cognitive enhancement opportunities and architectural evolution")
``` 