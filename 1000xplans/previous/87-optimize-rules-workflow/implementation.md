# Implementation Plan for Rules Workflow Optimization

This document provides the detailed implementation approach for optimizing the workflows/rules directory by abstracting detailed content to the knowledge/rules directory, with a primary focus on moving fetch_rules tool calls to project-rule-parameters.

## Target Files

### High-Priority Files (To Be Processed First)
1. scanning-automation.md (~404 lines) - Already optimized and twice revised
2. validation-script.md (~350 lines) - Already optimized but needs revision
3. message-commands-reference.md (~344 lines) - Deleted as redundant
4. rules-audit-process.md (~304 lines)
5. rules-workflow.md (~286 lines)

### Medium-Priority Files (To Be Processed Second)
6. scanning-process.md (~228 lines)
7. scenario-selection.md (~177 lines)
8. sync-cursor-rules.md (~134 lines)
9. context-first-implementation.md (~128 lines)
10. direct-implementation.md (~110 lines)
11. rules-workflow-cheatsheet.md (~47 lines)

## Line Budget Allocation

To meet the 1000-line limit, we'll allocate an approximate line budget for each file:

| File | Current Lines | Target Lines | Reduction |
|------|--------------|-------------|-----------|
| scanning-automation.md | 404 | 100 | -304 |
| validation-script.md | 350 | 100 | -250 |
| message-commands-reference.md | 344 | 120 | -224 |
| rules-audit-process.md | 304 | 100 | -204 |
| rules-workflow.md | 286 | 120 | -166 |
| scanning-process.md | 228 | 90 | -138 |
| scenario-selection.md | 177 | 80 | -97 |
| sync-cursor-rules.md | 134 | 70 | -64 |
| context-first-implementation.md | 128 | 80 | -48 |
| direct-implementation.md | 110 | 80 | -30 |
| rules-workflow-cheatsheet.md | 47 | 47 | 0 |
| **TOTAL** | **2512** | **987** | **-1525** |

This budget ensures we stay under the 1000-line target while allocating more lines to files with more complex concepts that need to be preserved.

## Revised Implementation Approach

### Critical Revision to Prior Work

The current implementation incorrectly placed fetch_rules tool calls directly in brain-files (Auto Attached files) like scanning-automation.md, rather than in project-rule-parameters. We need to revise this approach to follow the correct pattern:

1. **Brain-Files (workflows/rules/*.md)**:
   - Should contain high-level concepts, overviews, and basic information
   - Should NOT contain fetch_rules tool calls
   - Should reference project-rule-parameters with the correct syntax
   - Should NOT contain filepath references outside of tool calls

2. **Project-Rule-Parameters (parameters/rules/**/*.md)**:
   - Should contain fetch_rules tool calls to access knowledge files
   - Should implement the actual functionality that accesses knowledge
   - Should be explicitly referenced during conversations
   - Should contain detailed mode-specific instructions
   - Should NOT contain filepath references unless directly used in tool calls

### Phase 1: Content Analysis and Mapping

For each file, we'll systematically analyze the content and create a mapping document:

1. **Content Categorization**
   - Identify major sections and categorize them (concepts, examples, patterns, references)
   - Map related content across files to identify duplication
   - Identify natural groupings for knowledge organization
   - Document critical cross-references that must be preserved

2. **Knowledge Structure Design**
   - Design knowledge subdirectory structure for abstracted content
   - Create file mapping showing source and destination for each section
   - Identify naming patterns for new knowledge files
   - Plan consolidated fetch_rules references

3. **Project-Rule-Parameter Structure Design**
   - Identify which project-rule-parameters should contain fetch_rules calls
   - Design new project-rule-parameters if needed
   - Plan how to reference these parameters from brain-files

4. **Line Budget Planning**
   - Identify sections to keep vs. abstract based on line budget
   - Prioritize content for abstraction based on detail level
   - Plan consolidated fetch_rules references in project-rule-parameters
   - Create a line allocation spreadsheet for each file

#### Detailed Content Analysis Tool Sequence

For efficient content analysis of each file:

```typescript
// 1. Read the entire file to understand structure and content
read_file("1000xbrain/workflows/rules/[target_file].md", should_read_entire_file=true);

// 2. Check for related files to identify duplication
grep_search("pattern found in target file", false, "1000xbrain/workflows/rules/*.md");

// 3. Check existing knowledge structure
list_dir("1000xbrain/knowledge/rules/patterns");
list_dir("1000xbrain/knowledge/rules/guides");
list_dir("1000xbrain/knowledge/rules/reference");

// 4. Check existing project-rule-parameter structure
list_dir("1000xbrain/parameters/rules/plan-mode");
list_dir("1000xbrain/parameters/rules/dev-mode");
list_dir("1000xbrain/parameters/rules/direct-mode");

// 5. Review similar abstractions from previous optimization
grep_search("fetch_rules", false, "1000xbrain/parameters/rules/**/*.md");

// 6. Document findings in content-tracking.md
edit_file("planning/87-optimize-rules-workflow/content-tracking.md", 
          "Update content mapping for [target_file]",
          "// ... existing content ...\n\n### [target_file]\n\n| Section | Original Lines | Destination File | Status |\n|---------|---------------|-----------------|--------|\n| [Section 1] | [line range] | [destination path] | ❌ Pending |\n// ... existing content ...");
```

### Phase 2: High-Priority File Processing

We'll process the high-priority files in order, starting with revising the already processed files:

#### 1. scanning-automation.md - Double Revision

**Current (Incorrect) Approach**:
- Detailed content moved to knowledge files
- Direct filepath references to project-rule-parameters in the file

**Revised (Correct) Approach**:
1. Keep scanning-automation.md as a high-level overview without fetch_rules calls
2. Remove direct filepath references to project-rule-parameters
3. Create/update parameters/rules/plan-mode/scanning-automation.md with fetch_rules references
4. Create/update parameters/rules/dev-mode/scanning-automation.md with fetch_rules references

**Implementation Tool Sequence**:

```typescript
// 1. Create or update project-rule-parameter
edit_file("1000xbrain/parameters/rules/plan-mode/scanning-automation.md",
          "Create project-rule-parameter for scanning automation",
          "# workflow: rules-workflow | pathway: scanning | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/plan-mode/scanning-automation.mdc\n\n## File Purpose and Relationship\n\nThis file defines the operation of the `plan-mode: rules-workflow @parameters/rules/plan-mode/scanning-automation.mdc` message-command, which initializes planning mode with a focus on scanning automation planning. It should be consulted to understand:\n\n- How to plan scanning automation processes\n- Tool call sequences for scanning implementation\n- Error resolution strategies for scanning issues\n- Output interpretation for scanning results\n\n## Usage as Project-Rule-Parameter\n\nThis file contains specialized knowledge access for scanning automation. It should be referenced as a project-rule-parameter when planning scanning automation:\n\n```\nplan-mode: rules-workflow @parameters/rules/plan-mode/scanning-automation.mdc\n```\n\n## Knowledge Access\n\nWhen implementing scanning automation, use the `fetch_rules` tool to access specialized knowledge:\n\n```typescript\n// Access scanning automation patterns\nfetch_rules([\"knowledge/rules/patterns/impl/scanning-automation-patterns\"], \n           \"Understanding scanning automation patterns and implementation\")\n\n// Access implementation approaches\nfetch_rules([\"knowledge/rules/patterns/impl/scanning-implementation\"], \n           \"Understanding scanning implementation approach and integration points\")\n\n// Access error resolution strategies\nfetch_rules([\"knowledge/rules/guides/scanning-error-resolution\"], \n           \"Understanding scanning error resolution approaches and fixes\")\n\n// Access output interpretation guides\nfetch_rules([\"knowledge/rules/reference/scanning-output-reference\"], \n           \"Viewing example scanning outputs and interpretation guides\")\n```\n\n## Implementation Guidance\n\nWhen implementing scanning automation, follow these key principles:\n\n1. **Consistency**: Ensure all project-rule-parameter references follow the same format\n2. **Accuracy**: Verify references correctly use the `@parameters/rules/*.mdc` format\n3. **Backtick Safety**: Check that no unwrapped @ symbols appear in documentation\n4. **Regular Validation**: Implement systematic verification of reference integrity\n\n## Error Resolution\n\nWhen resolving scanning errors, follow these approaches:\n\n1. **Format Errors**: Address incorrect reference formats\n2. **Missing Backticks**: Fix unwrapped @ symbols\n3. **Extension Issues**: Correct .md vs .mdc extension problems\n4. **Path Problems**: Resolve incorrect path references\n\n## Example Usage\n\n```\nplan-mode: rules-workflow @parameters/rules/plan-mode/scanning-automation.mdc\n\nprompt: I need to implement an automated scanning system for project-rule-parameter references\n```");

// 2. Run sync-all to synchronize changes
run_terminal_cmd("echo 'sync-all'", false);

// 3. Wait for rules-synced confirmation
// [wait for confirmation]

// 4. Update the workflow file to remove fetch_rules calls and direct filepath references
edit_file("1000xbrain/workflows/rules/scanning-automation.md",
          "Update scanning-automation.md to remove all direct filepath references",
          "# Automated Scanning Implementation\n\nThis document provides the implementation plan for automating the scanning of project-rule-parameter references in the 1000xbrain cognitive architecture.\n\n## Purpose\n\nAutomated scanning ensures:\n\n1. **Consistency**: All project-rule-parameter references follow the same format\n2. **Accuracy**: All references correctly use the `@parameters/rules/*.mdc` format\n3. **Backtick Safety**: No unwrapped @ symbols appear in documentation\n4. **Regular Validation**: Systematic verification of reference integrity\n\n## Implementation Approach\n\nThe scanning automation will follow a systematic implementation process with defined integration points and maintenance protocols.\n\n## Error Resolution Standards\n\nWhen resolving issues found by the scanning system, follow standardized resolution procedures. The error resolution approach includes format correction, backtick wrapping, extension fixing, and path reference validation.\n\n## Example Scanning Output\n\nThe scanning system generates standardized reports that identify different categories of issues. These reports include summary overviews, detailed line-by-line issues, and trend analysis data.\n\n## Conclusion\n\nThe automated scanning implementation significantly improves the consistency and accuracy of project-rule-parameter references throughout the 1000xbrain cognitive architecture. By systematically identifying and fixing reference issues, we can prevent AI hallucinations and ensure reliable operation of the message-command system.\n\nConsistent project-rule-parameter references using the `@parameters/rules/*.mdc` format and properly wrapped @ symbols maintain the integrity of the development workflow.");

// 5. Create/update parameters/rules/dev-mode/scanning-automation.md for implementation
edit_file("1000xbrain/parameters/rules/dev-mode/scanning-automation.md",
          "Create dev-mode project-rule-parameter for scanning automation",
          "# workflow: rules-workflow | pathway: scanning | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/dev-mode/scanning-automation.mdc\n\n## File Purpose and Relationship\n\nThis file defines the operation of the `dev-mode: rules-workflow @parameters/rules/dev-mode/scanning-automation.mdc` message-command, which initializes developer mode with a focus on scanning automation implementation. It should be consulted to understand:\n\n- How to implement scanning automation\n- Tool call sequences for scanning implementation\n- Error handling for scanning processes\n- Output generation for scanning results\n\n## Usage as Project-Rule-Parameter\n\nThis file contains specialized knowledge access for scanning automation implementation. It should be referenced as a project-rule-parameter when implementing scanning automation:\n\n```\ndev-mode: rules-workflow @parameters/rules/dev-mode/scanning-automation.mdc\n```\n\n## Knowledge Access\n\nWhen implementing scanning automation, use the `fetch_rules` tool to access specialized knowledge:\n\n```typescript\n// Access scanning automation patterns\nfetch_rules([\"knowledge/rules/patterns/impl/scanning-automation-patterns\"], \n           \"Understanding scanning automation patterns for implementation\")\n\n// Access implementation approaches\nfetch_rules([\"knowledge/rules/patterns/impl/scanning-implementation\"], \n           \"Implementing scanning approach and integration points\")\n\n// Access error resolution strategies\nfetch_rules([\"knowledge/rules/guides/scanning-error-resolution\"], \n           \"Implementing error resolution for scanning issues\")\n\n// Access output interpretation guides\nfetch_rules([\"knowledge/rules/reference/scanning-output-reference\"], \n           \"Implementing output formats for scanning results\")\n```\n\n## Implementation Guidance\n\nWhen implementing scanning automation, follow these key procedures:\n\n1. **Pattern Selection**: Choose appropriate scanning patterns based on requirements\n2. **Automation Integration**: Integrate scanning with validation processes\n3. **Output Generation**: Create standardized scanning reports\n4. **Error Handling**: Implement robust error handling\n\n## Tool Call Sequences\n\n```typescript\n// Initialize scanning implementation\nlist_dir(\"1000xbrain/workflows/rules\")\n\n// Analyze reference formats\ngrep_search(\"@parameters/rules/[a-z0-9-]+\\\\.[a-z]+\", false, \"1000xbrain/**/*.md\")\n\n// Check for unwrapped @ symbols\ngrep_search(\"@[^`]\", false, \"1000xbrain/**/*.md\")\n\n// Implement scanning functionality\nedit_file(\"path/to/scanning/implementation.js\",\n          \"Implement automated scanning functionality\",\n          \"// Implementation code...\")\n```\n\n## Example Usage\n\n```\ndev-mode: rules-workflow @parameters/rules/dev-mode/scanning-automation.mdc\n\nprompt: Implement the automated scanning system for project-rule-parameter references\n```");

// 6. Verify line count of optimized file
run_terminal_cmd("wc -l 1000xbrain/workflows/rules/scanning-automation.md | cat", false);

// 7. Update tracking document
edit_file("planning/87-optimize-rules-workflow/content-tracking.md",
          "Update tracking for scanning-automation.md revision",
          "// ... existing content ...\n\n## Progress Summary\n\n| File | Current Lines | Target Lines | Processed | Line Count After | Revision Status |\n|------|--------------|-------------|-----------|-----------------|----------------|\n| scanning-automation.md | 404 | 100 | ✅ | [actual count] | ✅✅ Double Revised |\n// ... rest of existing content ...");
```

#### 2. validation-script.md - Revision

**Current (Incorrect) Approach**:
- Detailed content moved to knowledge files
- fetch_rules tool calls potentially added directly to validation-script.md

**Revised (Correct) Approach**:
- Keep validation-script.md as a high-level overview without fetch_rules calls
- Remove any direct filepath references to project-rule-parameters
- Create/update parameters/rules/plan-mode/validation-script.md with fetch_rules references
- Create/update parameters/rules/dev-mode/validation-script.md with fetch_rules references

**Implementation Tool Sequence**:
Similar to scanning-automation.md, with appropriate file paths and content.

#### 3. message-commands-reference.md

**Content Mapping**:
- Move detailed command formats → knowledge/rules/reference/syntax/message-command-syntax.md
- Move example usages → knowledge/rules/reference/examples/message-command-examples.md
- Move validation rules → knowledge/rules/patterns/communication/message-command-validation.md
- Move parameter format details → knowledge/rules/reference/syntax/parameter-syntax.md

**Knowledge Access Implementation**:
1. Create knowledge files with detailed content
2. Create/update parameters/rules/plan-mode/message-commands-reference.md with fetch_rules calls
3. Keep message-commands-reference.md as high-level overview without fetch_rules calls

**Tool Sequence**:
Similar to scanning-automation.md, with appropriate file paths and content.

#### 4-11. Remaining Files

Follow the same approach for the rest of the files:
1. Move detailed content to knowledge files
2. Create/update corresponding project-rule-parameters with fetch_rules calls
3. Keep workflow files as high-level overviews without fetch_rules calls
4. Remove any direct filepath references except in tool calls

### Phase 3: Medium-Priority File Processing

Process medium-priority files following the same approach used for high-priority files.

### Phase 4: Line Count Verification and Optimization

After processing all files:

1. **Line Count Verification**
   - Verify the total line count across all workflow files
   - Make additional optimizations if needed to meet the 1000-line target
   - Ensure no individual file exceeds its line budget

2. **Cross-Reference Verification**
   - Verify all critical cross-references are maintained
   - Ensure knowledge files are properly connected
   - Create index files for knowledge directories if needed
   - Update README files to reflect the new organization

3. **Functionality Verification**
   - Test all fetch_rules references from project-rule-parameters
   - Verify all essential concepts remain accessible
   - Confirm no critical information was lost
   - Generate a comprehensive verification report

4. **Project-Rule-Parameter Verification**
   - Verify all project-rule-parameters have correct format
   - Ensure workflow files correctly reference project-rule-parameters
   - Verify fetch_rules calls in project-rule-parameters access correct knowledge files
   - Confirm project-rule-parameters follow naming conventions

## Knowledge File Creation Guidelines

For each new knowledge file:

### 1. USE WHEN Header Creation

Create specific, action-oriented USE WHEN headers that clearly indicate when to use the file:

**Format**: `# USE WHEN <verb> <subject>, <verb> <subject>, or <verb> <subject>`

**Examples**:
- `# USE WHEN implementing scanning automation, creating validation scripts, or optimizing scanning processes`
- `# USE WHEN understanding message command syntax, documenting communication standards, or troubleshooting command issues`

### 2. File Structure

Organize each knowledge file with this consistent structure:

```markdown
# USE WHEN <verb> <subject>, <verb> <subject>, or <verb> <subject>

# [Title of Knowledge Component]

## Overview
Brief explanation of the component's purpose and context.

## Key Concepts
Essential concepts and definitions for understanding the component.

## Detailed Implementation
Step-by-step implementation guidance or detailed explanation.

## Examples
Practical examples with explanations.

## Related Components
References to related knowledge components.

## Conclusion
Summary of key points.
```

## Project-Rule-Parameter Creation Guidelines

For each project-rule-parameter file:

### 1. Header Format

Use consistent header format for all project-rule-parameters:

```markdown
# workflow: rules-workflow | pathway: [pathway] | message-command: [mode] | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/[mode]/[name].mdc
```

### 2. File Structure

Organize each project-rule-parameter with this structure:

```markdown
# workflow: [workflow] | pathway: [pathway] | message-command: [mode] | standard-parameter(s): [params] | project-rule-parameter-filepath: parameters/rules/[mode]/[name].mdc

## File Purpose and Relationship

This file defines the operation of the `[mode]: [workflow] @parameters/rules/[mode]/[name].mdc` message-command, which initializes [mode] mode with a focus on [purpose]. It should be consulted to understand:

- How to [purpose 1]
- How to [purpose 2]
- How to [purpose 3]
- How to [purpose 4]

## Usage as Project-Rule-Parameter

This file contains specialized knowledge access for [purpose]. It should be referenced as a project-rule-parameter when [usage scenario]:

```
[mode]: [workflow] @parameters/rules/[mode]/[name].mdc
```

## Knowledge Access

When [implementing/planning] [purpose], use the `fetch_rules` tool to access specialized knowledge:

```typescript
// Access [knowledge type 1]
fetch_rules(["knowledge/rules/[path/to/knowledge1]"], 
           "[explanation1]")

// Access [knowledge type 2]
fetch_rules(["knowledge/rules/[path/to/knowledge2]"], 
           "[explanation2]")
```

## Implementation Guidance

[Key implementation guidance]

## Example Usage

```
[mode]: [workflow] @parameters/rules/[mode]/[name].mdc

prompt: [example prompt]
```
```

### 3. Content Guidelines

Project-rule-parameters must follow these essential content guidelines:

1. **Detailed Mode-Specific Instructions**: 
   - Should contain very detailed plan-mode, dev-mode, or direct-mode instructions
   - Focus exclusively on implementation guidance and knowledge access
   - Provide specific execution patterns for the associated mode

2. **Explicit Reference Only**: 
   - Only used when explicitly referenced in a message-command
   - Not automatically attached to conversations
   - Loaded on-demand for specific implementation purposes

3. **Filepath Restrictions**:
   - Should NOT contain any filepaths unless they are used directly in tool calls
   - Avoid hardcoded paths since filesystem organization often changes
   - Use relative references when paths are absolutely necessary

4. **Knowledge Access Focus**:
   - Should contain fetch_rules tool calls to access detailed knowledge
   - Serve as the bridge between message-commands and the knowledge system
   - Implement appropriate knowledge access patterns

## Verification Approach

### 1. Line Count Verification

After processing each file, use this command to check the current line count:

```bash
# Count total lines in workflows/rules directory
find 1000xbrain/workflows/rules -name "*.md" | xargs wc -l | grep total
```

### 2. fetch_rules Reference Testing

Test each fetch_rules reference in project-rule-parameters to ensure knowledge is accessible:

1. Run the `sync-all` command after creating new knowledge files
2. Wait for confirmation that rules are synced
3. Execute fetch_rules tool calls from project-rule-parameters to verify access
4. Document any issues and resolve them

### 3. Project-Rule-Parameter Reference Verification

Verify that workflow files correctly reference project-rule-parameters:

1. Check that references use the correct format: `@parameters/rules/[mode]/[name].mdc`
2. Ensure all references are to .mdc files (not .md)
3. Verify each project-rule-parameter exists and contains appropriate fetch_rules calls
4. Document any issues and resolve them

## Recent Enhancements

### 1. Scanning-Automation.md Improvement

**Original Issue**:
- The scanning-automation.md file contained direct filepath references to project-rule-parameters
- These filepath references were outside of tool calls, creating dependency on specific file paths

**Changes Made**:
- Removed all direct filepath references to project-rule-parameters from scanning-automation.md
- Streamlined the file to maintain a high-level overview without specific filepath references
- Made the content more resilient to potential filesystem reorganization

**Benefits**:
- Reduced dependency on specific file paths that might change
- Made the workflow file more concise and focused on high-level concepts
- Aligned with cognitive architecture design principles

### 2. Project-Rule-Parameter Guidelines Enhancement

**Original Issue**:
- Guidelines for project-rule-parameters lacked clarity on filepath usage restrictions
- There was potential confusion about what content should be in project-rule-parameters

**Changes Made**:
- Enhanced knowledge/rules/guides/parameter-standardization.md with a new "Project-Rule-Parameter Content Guidelines" section
- Enhanced knowledge/rules/reference/guides/project-rule-parameter.md with a clear "Content Guidelines" section
- Added explicit guidelines stating that project-rule-parameters:
  - Are manual rule types only used when explicitly referenced
  - Should contain detailed mode-specific instructions
  - Should NOT contain filepaths unless used in tool calls (since filepaths change often)
  - Should serve as bridges to detailed knowledge through fetch_rules calls

**Benefits**:
- Clearer guidelines for creating project-rule-parameters
- Explicit rules about filepath usage to prevent future issues
- Better understanding of the role of project-rule-parameters in the system
- Standardized approach to knowledge access through project-rule-parameters

### 3. Future Guidelines Application

These enhanced guidelines will be consistently applied to all remaining files during the optimization process:

1. Remove all direct filepath references not in tool calls
2. Ensure project-rule-parameters follow content guidelines
3. Keep workflow files focused on high-level concepts
4. Bridge to detailed knowledge through project-rule-parameters and fetch_rules

## Conclusion

This revised implementation plan corrects the approach by ensuring:

1. Brain-files (workflows/rules/*.md) provide high-level concepts without direct filepath references
2. Project-rule-parameters (parameters/rules/**/*.md) contain fetch_rules tool calls and detailed mode-specific instructions
3. Knowledge files (knowledge/rules/**/*.md) contain detailed implementation knowledge
4. No filepath references exist outside of tool calls to make the system resilient to filesystem changes

By following this pattern, we ensure that the cognitive architecture operates correctly with proper separation of concerns between different types of files. 