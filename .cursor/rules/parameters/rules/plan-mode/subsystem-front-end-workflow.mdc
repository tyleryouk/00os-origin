# workflow: rules-workflow | pathway: subsystem-front-end-workflow | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter: parameters/rules/plan-mode/subsystem-front-end-workflow.mdc

## Domain

To maintain strict domain between workflows:

1. **Read-Only Front-End Access**: Tool calls to front-end files must use read-only operations:
   - `read_file()`
   - `list_dir()`
   - `grep_search()`
   - `codebase_search()`

2. **Modification Restriction**: Only 1000xbrain files can be modified:
   - `edit_file()` must only target 1000xbrain files and planning folder files
   - No modifications to front-end/ directory files
   - No terminal commands that modify front-end files

3. **Path Validation**: All file paths must be validated:
   - For reading: Ensure path is in front-end/ directory
   - For writing: Ensure path is in 1000xbrain/ directory or planning/ directory
   - No access to sensitive configuration files

4. **Tool Call Verification**: Verify each tool call follows the proper pattern:
   - Read operations for front-end files
   - Write operations for 1000xbrain files and planning files only
   - No terminal commands that start servers or modify front-end environment

5. **Cross-Workflow Reference Integrity**:
   - Ensure all references to front-end files use correct paths
   - Validate existence of referenced files before brain-file
   - Maintain consistent naming between code and brain-file

### Tool Call Sequence

```typescript
// 1. Explore front-end directory structure
list_dir("front-end/src")
list_dir("front-end/src/components")
list_dir("front-end/src/hooks")
list_dir("front-end/src/contexts")
list_dir("front-end/src/utils")
list_dir("front-end/src/pages")

// 2. Examine representative front-end files
read_file("front-end/src/components/[component_name].tsx", should_read_entire_file=true)
read_file("front-end/src/hooks/[hook_name].ts", should_read_entire_file=true)
read_file("front-end/src/contexts/[context_name].tsx", should_read_entire_file=true)

// 3. Analyze front-end patterns
codebase_search("component pattern", ["front-end/src/components"])
grep_search("import.*from.*hooks", false, "front-end/src/components/*.tsx")
grep_search("useEffect|useState|useCallback|useMemo", false, "front-end/src/components/*.tsx")
grep_search("import.*from.*contexts", false, "front-end/src/components/*.tsx")

// 4. Examine current front-end-workflow brain-file
read_file("1000xbrain/workflows/front-end-workflow/README.md", should_read_entire_file=true)
read_file("1000xbrain/workflows/front-end-workflow/[document_name].md", should_read_entire_file=true)

// 5. Create context and implementation plan files
edit_file("planning/[number]-front-end-workflow-enhancement/context-front-end-enhancement.md",
          "Create front-end enhancement context",
          "# Context Analysis: Front-End Enhancement\n\n...")

edit_file("planning/[number]-front-end-workflow-enhancement/context-front-end-patterns.md",
          "Create front-end patterns analysis",
          "# Context Analysis: Front-End Patterns\n\n...")

edit_file("planning/[number]-front-end-workflow-enhancement/implementation-front-end-enhancement.md",
          "Create front-end enhancement implementation plan",
          "# Implementation Plan: Front-End Enhancement\n\n...")
```

1. **Initialize Planning Mode**: Enter or remain in Planning Mode with the 📋 1000xdev [rules-workflow] indicator
2. **Create Planning Context Files**: Create specialized context files for front-end enhancement
3. **Create Implementation Plan**: Develop a plan for enhancing front-end-workflow brain-file
4. **Define Tool Call Sequences**: Document safe tool call sequences for implementation
5. **Analyze Existing brain-file**: Evaluate current front-end-workflow brain-file
6. **Identify Pattern Gaps**: Identify missing or outdated pattern brain-file

## Analysis Patterns

The subsystem-front-end-workflow project-rule-parameter follows a structured analysis pattern:

### Front-End Structure Analysis
1. Examine directory structure using `list_dir()`
2. Identify key component files using `list_dir()` and `grep_search()`
3. Analyze file organization and naming patterns
4. Document project structure conventions

### Component Pattern Analysis
1. Read representative component files using `read_file()`
2. Identify component structure and patterns using `codebase_search()`
3. Document component architecture and best practices
4. Analyze component composition patterns
5. Identify reusable component patterns

### Hook and Context Analysis
1. Identify hooks and contexts using `grep_search()`
2. Read hook and context implementations using `read_file()`
3. Document hook and context patterns and usage
4. Analyze custom hook patterns
5. Identify context provider patterns

### State Management Analysis
1. Identify state management approach using `codebase_search()`
2. Analyze state flow patterns using `read_file()`
3. Document state management architecture and best practices
4. Identify global vs. local state patterns
5. Document state synchronization approaches

### API Integration Analysis
1. Identify API integration patterns using `grep_search()`
2. Analyze API usage patterns using `read_file()`
3. Document API integration approaches and best practices
4. Identify data fetching and caching strategies
5. Document error handling patterns

### Routing and Navigation Analysis
1. Identify routing implementation using `grep_search()`
2. Analyze page structure using `list_dir()` and `read_file()`
3. Document routing and navigation patterns
4. Identify route protection strategies
5. Document navigation state management

### Performance Optimization Analysis
1. Identify performance optimization patterns using `codebase_search()`
2. Analyze code-splitting and lazy-loading approaches
3. Document performance optimization strategies
4. Identify memoization patterns
5. Document render optimization techniques

## brain-file guidelines

For effective front-end-workflow brain-file enhancement:

### Component brain-file Enhancement
1. Analyze actual component implementation
2. Update component-patterns.md to reflect actual patterns
3. Add missing patterns or update outdated ones
4. Include code snippets from actual implementation
5. Document component composition patterns
6. Add visual component hierarchy diagrams

### Hook brain-file Enhancement
1. Analyze hook implementation and usage patterns
2. Document hook patterns and best practices
3. Create or update hook-specific brain-file
4. Document custom hook creation patterns
5. Provide real-world hook usage examples
6. Include dependency management guidance

### State Management brain-file Enhancement
1. Analyze state management approach
2. Document state flow patterns
3. Enhance context brain-file based on implementation
4. Document state initialization patterns
5. Include state update lifecycle brain-file
6. Add state debugging guidance

### API Integration brain-file Enhancement
1. Analyze API integration patterns
2. Document API usage patterns
3. Enhance API brain-file based on implementation
4. Document error handling strategies
5. Include loading state management patterns
6. Document retry and recovery strategies

### Performance brain-file Enhancement
1. Analyze performance optimization techniques
2. Document code-splitting strategies
3. Enhance render optimization brain-file
4. Include memory management best practices
5. Document bundle size optimization approaches
6. Add performance measurement guidance

### Planning Folder Structure

```
planning/[number]-front-end-workflow-enhancement/
├── requirements.md                              # Core requirements and objectives
├── README.md                                    # Overview and navigation guide
├── context-front-end-enhancement.md             # Front-end analysis context
├── context-front-end-patterns.md                # Front-end patterns analysis
├── context-helper-commands.md                   # Helper command context (if relevant)
├── implementation-front-end-enhancement.md      # Implementation plan
├── implementation-front-end-analytics.md        # Analytics implementation plan (if needed)
└── test-cheatsheet.md                           # Testing scenarios
```

## Success Criteria

subsystem-front-end-workflow pathway-specific planning is successful when:

1. **Front-End Architecture Understanding**: Clear understanding of front-end architecture is documented
2. **Pattern brain-file**: Key patterns from front-end code are documented
3. **Enhancement Targets**: Specific enhancement targets in front-end-workflow brain-file are identified
4. **Implementation Plan**: A clear, phased implementation plan is created
5. **Boundary Guidelines**: Clear boundary enforcement guidelines are established
6. **Tool Call Sequences**: Safe tool call sequences for implementation are documented
7. **Pattern Evolution**: brain-file captures evolution of patterns over time
8. **Cross-Workflow Integration**: Clear brain-file of relationships between workflows
9. **Implementation Metrics**: Defined metrics for measuring brain-file quality

## Usage Notes

1. This project-rule-parameter is specifically designed for enhancing front-end-workflow brain-file based on analysis of front-end code.
2. It should not be used for making changes to front-end code directly - use front-end-workflow for that purpose.
3. The focus is on improving brain-file accuracy and completeness, not modifying implementation.
4. It can be combined with other planning parameters for specialized needs.
5. It establishes the foundation for the corresponding `dev-mode: rules-workflow @parameters/rules/dev-mode/dev-mode-front-end-workflow-enhancement.mdc` implementation command.
6. For direct implementation without planning phase, use `direct-mode: rules-workflow @parameters/rules/direct-mode/direct-mode-front-end-workflow-enhancement.mdc`.
7. When planning enhancement for specific front-end patterns, focus planning on those specific patterns rather than attempting comprehensive brain-file in a single cycle.
