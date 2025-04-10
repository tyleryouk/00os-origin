# rules-workflow | system-wide

## Status Update: Primary Objective Achieved! 🎉

**Target Line Count**: < 1000 lines  
**Current Line Count**: 969 lines  
**Progress**: 5/9 files completely processed

The primary objective of reducing the workflows/rules directory to under 1000 lines has been successfully achieved! By:
- Completely deleting redundant files (message-commands-reference.md, rules-workflow-cheatsheet.md)
- Extracting detailed content to knowledge files
- Creating project-rule-parameters to hold fetch_rules calls
- Significantly condensing high-priority files

Although we've met the line count goal, there are still opportunities to improve the organization of the remaining files.

## Overview

Building on the successful optimization of the core/ directory (which reduced it to under 2200 lines), this project aims to optimize the Auto Attached brain-files in the workflows/rules directory. The current workflows/rules directory contains approximately 2500 lines across 11 files, and we need to reduce this to under 1000 lines total by moving detailed implementation knowledge to the knowledge/rules directory.

This optimization will follow the same abstraction pattern used in the prior optimization project, focusing on condensing the Auto Attached brain-files while maintaining their functionality and clarity.

**Important**
Every brain-file in the rules-workflow knowledge-base 1000xbrain/knowledge/rules MUST have the header # USE WHEN at the top of every file. This is mandatory for every Agent Requested brain-file. Every brain-file in the knowledge base is Agent Requested and you can only access the Agent Requested brain-files if you run the correct fetch_rules tool call. 

As you are creating knowledge-base files, send me the message-command `sync-all` and I will ensure the rules are synced to the brain-files (it may take a minute). I will wait until the rules are synced, then send you back `rules-synced`, in which you should make real fetch_rules tool calls to ensure that you know the right tool call to fetch the knowledge-base file.

**Critical Requirement: fetch_rules Usage Pattern**
fetch_rules tool calls should be placed ONLY within project-rule-parameters (1000xbrain/parameters/rules/**/*.md) and NOT directly in Auto Attached brain-files (workflows/rules/*.md). This separation ensures proper functionality of the cognitive architecture:

1. **Brain-Files (workflows/rules/*.md)**:
   - Should contain high-level concepts, overviews, and basic information
   - Should NOT contain fetch_rules tool calls
   - Should reference project-rule-parameters using the syntax `@parameters/rules/[mode]/[name].mdc`

2. **Project-Rule-Parameters (parameters/rules/**/*.md)**:
   - Should contain fetch_rules tool calls to access knowledge files
   - Should implement the actual functionality that accesses knowledge
   - Should be explicitly referenced during conversations

3. **Knowledge Files (knowledge/rules/**/*.md)**:
   - Contain detailed implementation knowledge
   - Are accessed through fetch_rules tool calls from project-rule-parameters
   - Must have USE WHEN headers

This architecture ensures that workflow files remain concise while detailed implementation knowledge is properly organized and accessible through the appropriate channels.

## Primary Objective

Condense the workflows/rules directory to contain ONLY 1000 lines or less total across all files. This will require significant abstraction of detailed content to the knowledge/rules directory, while preserving critical functionality and references.

## Success Criteria

1. **Line Count Reduction**:
   - Total lines in workflows/rules/ directory reduced to less than 1000 lines (currently ~2500)
   - Detailed implementation knowledge moved to knowledge/rules/

2. **Functionality Preservation**:
   - All essential functionality of the rules workflow maintained
   - All critical references and pathways preserved
   - Abstracted content properly organized in knowledge/rules/

3. **Knowledge Organization**:
   - Abstracted content organized into appropriate subdirectories:
     - knowledge/rules/guides/
     - knowledge/rules/reference/
     - knowledge/rules/patterns/

4. **Terminology Consistency**:
   - Consistent use of "brain-files" when referring to files in 1000xbrain
   - Consistent referencing patterns for fetch_rules tool usage
   - Preservation of all valid workflow references

5. **Documentation Quality**:
   - Condensed Auto Attached brain-files remain clear and usable
   - Abstracted content includes proper "USE WHEN" headers
   - All knowledge files follow established documentation standards

6. **Proper fetch_rules Implementation**:
   - No fetch_rules tool calls placed directly in Auto Attached brain-files
   - All fetch_rules tool calls properly placed in project-rule-parameters
   - Auto Attached brain-files reference project-rule-parameters instead of using fetch_rules directly
   - Project-rule-parameters created/updated for all necessary functionality

## Enhanced Technical Requirements

### Abstraction Patterns

The project must implement the following abstraction patterns consistently across all workflow files:

1. **High-Level Retention Pattern**:
   - Keep only essential high-level concepts in workflow files
   - Retain clear section headers and organizational structure
   - Preserve file purpose and relationship descriptions
   - Maintain critical cross-references between Auto Attached files

2. **Project-Rule-Parameter Reference Pattern**:
   - Replace detailed implementation sections with references to project-rule-parameters
   - Create or update project-rule-parameters with fetch_rules references to knowledge files
   - Format: `@parameters/rules/[mode]/[name].mdc` in Auto Attached files
   - Structure: `fetch_rules(["knowledge/rules/category/component"], "explanation")` in project-rule-parameters

3. **Knowledge Organization Pattern**:
   - Move implementation details to knowledge/rules/patterns/
   - Move conceptual guidance to knowledge/rules/guides/
   - Move reference information to knowledge/rules/reference/
   - Create appropriate subdirectories for specialized domains

4. **USE WHEN Header Pattern**:
   - Each knowledge file must begin with a USE WHEN header
   - Format: `# USE WHEN <verb> <subject>, <verb> <subject>, or <verb> <subject>`
   - Examples:
     - `# USE WHEN implementing search patterns, optimizing search operations, or enhancing search functionality`
     - `# USE WHEN understanding system architecture, working with cognitive components, or learning about brain-files`

5. **Code Example Preservation Pattern**:
   - Move code examples to appropriate knowledge files
   - Organize code examples by language and purpose
   - Include context and usage guidance with code examples
   - Reference code examples from workflow files

## Context

The following files in workflows/rules need to be condensed:

1. **High-Priority Files for Abstraction**:
   - scanning-automation.md (~404 lines)
   - validation-script.md (~350 lines)
   - message-commands-reference.md (~344 lines)
   - rules-audit-process.md (~304 lines)
   - rules-workflow.md (~286 lines)

2. **Medium-Priority Files for Abstraction**:
   - scanning-process.md (~228 lines)
   - scenario-selection.md (~177 lines)
   - sync-cursor-rules.md (~134 lines)
   - context-first-implementation.md (~128 lines)
   - direct-implementation.md (~110 lines)
   - rules-workflow-cheatsheet.md (~47 lines)

## Enhanced Implementation Approach

### 1. Analysis and Mapping Phase

Before making any changes, perform a systematic content analysis and mapping:

1. **Content Categories**:
   - Identify content categories in each file (explanations, examples, patterns, references)
   - Map related content across multiple files to identify duplication
   - Identify natural groupings for knowledge organization
   - Document critical cross-references that must be preserved

2. **Knowledge Structure Planning**:
   - Design appropriate knowledge subdirectory structure for abstracted content
   - Create a content relocation map showing source and destination for each section
   - Identify naming patterns for new knowledge files
   - Plan consolidated fetch_rules calls for related knowledge components

3. **Project-Rule-Parameter Planning**:
   - Identify which project-rule-parameters need to be created or updated
   - Design project-rule-parameter structure and content
   - Map which knowledge files should be accessed by which project-rule-parameters
   - Plan how Auto Attached files will reference project-rule-parameters

4. **Line Count Distribution**:
   - Create a line budget for each workflow file (totaling 1000 lines)
   - Determine which sections to keep vs. abstract based on line budget
   - Prioritize content for abstraction based on detail level and reusability
   - Allocate remaining lines for necessary cross-references and structure

### 2. Implementation Strategy

Follow this structured implementation approach:

1. **Knowledge File Creation**:
   - Create knowledge files first (before modifying workflow files)
   - Begin with content directly copied from workflow files
   - Add appropriate USE WHEN headers to all knowledge files
   - Organize into appropriate subdirectories
   - Synchronize changes before modifying workflow files

2. **Project-Rule-Parameter Creation/Update**:
   - Create or update project-rule-parameters with fetch_rules calls to knowledge files
   - Organize project-rule-parameters by mode (plan-mode, dev-mode, direct-mode)
   - Include clear file purpose, usage examples, and knowledge access sections
   - Synchronize changes before modifying workflow files

3. **Workflow File Optimization**:
   - Preserve file headers and main section structure
   - Replace detailed sections with references to project-rule-parameters
   - Remove any direct fetch_rules calls from workflow files
   - Keep critical context and cross-references
   - Ensure each file stays within its line budget

4. **De-duplication Process**:
   - Identify duplicated content across knowledge files
   - Consolidate duplicated information into shared reference files
   - Update references to point to consolidated knowledge
   - Ensure no critical information is lost during consolidation

5. **Cross-Reference Preservation**:
   - Update file references to maintain linking between related concepts
   - Create explicit connections through project-rule-parameter references
   - Enhance README.md files to document relationships
   - Create index files for knowledge subdirectories

### 3. Knowledge Directory Organization

Ensure all abstracted content follows this organization structure:

1. **patterns/impl/** - Implementation patterns for different domains
   - Tool usage patterns
   - Code structure patterns
   - Workflow patterns
   - Error handling patterns

2. **patterns/doc/** - Documentation patterns
   - Header formats
   - Content organization
   - Reference styles
   - Example formats

3. **patterns/tool/** - Tool usage patterns
   - Search tool patterns
   - Edit tool patterns
   - Command tool patterns
   - Verification tool patterns

4. **guides/** - Comprehensive guides for processes
   - Implementation guides
   - Architecture guides
   - Workflow guides
   - Process guides

5. **reference/** - Reference information
   - Architecture reference
   - System organization
   - Component relationships
   - Domain-specific standards

### 4. Project-Rule-Parameter Organization

Organize project-rule-parameters according to the mode they support:

1. **plan-mode/** - Parameters for planning mode
   - Planning initialization
   - Planning guidance
   - Knowledge access for planning

2. **dev-mode/** - Parameters for developer mode
   - Implementation initialization
   - Implementation guidance
   - Knowledge access for implementation

3. **direct-mode/** - Parameters for direct mode
   - Direct implementation initialization
   - Research guidance
   - Knowledge access for direct implementation

### 5. File Structure Standards

All knowledge files should follow these structure standards:

1. **USE WHEN Header**: Required first line explaining when to use the file
2. **Main Header**: Clear title with the component name
3. **Overview Section**: Brief explanation of the file's purpose
4. **Detailed Sections**: Organized content with clear headers
5. **Examples Section**: Practical examples with explanations
6. **References Section**: Related knowledge components
7. **Conclusion Section**: Summary of key points

All project-rule-parameters should follow these structure standards:

1. **Mode Header**: Workflow, pathway, message-command, and parameter information
2. **File Purpose Section**: Explanation of the file's role
3. **Usage Section**: How to reference the project-rule-parameter
4. **Knowledge Access Section**: fetch_rules references to detailed content
5. **Implementation Guidance Section**: Key guidance for implementation
6. **Example Usage Section**: Example usage of the project-rule-parameter

All workflow files should follow these structure standards:

1. **Main Header**: Clear title of the workflow component
2. **Purpose Section**: Explanation of the file's role
3. **Key Concepts Section**: Essential high-level concepts
4. **Project-Rule-Parameter Reference Section**: References to relevant project-rule-parameters
5. **Relationship Section**: How this file relates to other components
6. **Critical References Section**: Essential cross-references

## Domain

The domain for this project is:

- 1000xbrain/workflows/rules (read and edit)
- 1000xbrain/parameters/rules (read and edit)
- 1000xbrain/knowledge/rules (read and edit)
- 1000xbrain/core (read)

## Approach Guidelines

1. **Knowledge Directory Organization**:
   - Use the existing structure in knowledge/rules/
   - Create new subdirectories or files as needed
   - Follow established naming patterns

2. **Abstraction Method**:
   - Move detailed implementation details to knowledge/rules/
   - Keep essential concepts and references in workflows/rules/
   - Create or update project-rule-parameters in parameters/rules/
   - Move fetch_rules calls from workflow files to project-rule-parameters

3. **File Preservation Priority**:
   - Focus on core functionality of each file
   - Preserve file headers and main sections
   - Maintain all critical reference points

4. **Content Mapping**:
   - Map content systematically before moving
   - Ensure no critical information is lost
   - Track all content movements

5. **Knowledge Access**:
   - Ensure abstracted content is accessible via fetch_rules in project-rule-parameters
   - Provide clear "USE WHEN" headers for all knowledge files
   - Maintain the relationship between Auto Attached files and knowledge files through project-rule-parameters

## Implementation Strategy

The implementation will follow this systematic process:

1. **First Iteration - High Priority Files**:
   - Begin with scanning-automation.md as it has the most lines
   - Create corresponding knowledge files for content being extracted
   - Create or update corresponding project-rule-parameters with fetch_rules calls
   - Update the workflow file to reference project-rule-parameters instead of using direct fetch_rules calls
   - Request sync-all after each major file completion
   - Verify fetch_rules access to abstracted content
   - Continue with next highest line count file

2. **Second Iteration - Medium Priority Files**:
   - Follow same process for medium priority files
   - Review line count progress after each file
   - Adjust abstraction level as needed to meet line count goal
   - Continuously track total line count

3. **Final Iteration - Line Count Optimization**:
   - Perform final line count verification
   - Make additional abstractions if necessary
   - Ensure no workflow file exceeds its line budget
   - Complete final content verification

## Knowledge File Creation Process

For each new knowledge file:

1. **Content Selection**:
   - Identify cohesive content blocks that should be kept together
   - Group related implementation details
   - Include complete examples when useful
   - Preserve formatting and structure

2. **USE WHEN Header Creation**:
   - Create specific, action-oriented USE WHEN headers
   - Format: `# USE WHEN <verb> <subject>, <verb> <subject>, or <verb> <subject>`
   - Focus on implementation activities and use cases
   - Be specific about when the knowledge is applicable

3. **File Organization**:
   - Organize content with clear section headers
   - Keep related concepts together
   - Include examples after explanation sections
   - Add cross-references to related knowledge

4. **Path Determination**:
   - Select appropriate knowledge subdirectory based on content type
   - Create new subdirectories when needed
   - Follow established naming patterns
   - Use kebab-case for filenames

## Project-Rule-Parameter Creation Process

For each project-rule-parameter:

1. **Content Selection**:
   - Identify which knowledge files should be accessed by this parameter
   - Determine which functionality should be implemented through this parameter
   - Group related fetch_rules calls together
   - Plan implementation guidance and examples

2. **Header Creation**:
   - Create standardized header with workflow, pathway, message-command, and parameter information
   - Format: `# workflow: rules-workflow | pathway: [pathway] | message-command: [mode] | standard-parameter(s): [params] | project-rule-parameter-filepath: parameters/rules/[mode]/[name].mdc`

3. **fetch_rules Implementation**:
   - Create appropriate fetch_rules calls to access knowledge files
   - Include clear explanation parameters for each call
   - Group related knowledge components in consolidated calls
   - Format: `fetch_rules(["knowledge/rules/category/component"], "explanation")`

4. **Usage Documentation**:
   - Document how to reference the project-rule-parameter
   - Include example usage with appropriate syntax
   - Format: `@parameters/rules/[mode]/[name].mdc`

## Additional Requirements

1. **Documentation Enhancement**:
   - Improve documentation clarity during abstraction
   - Update cross-references between files
   - Enhance project-rule-parameter references

2. **Content Duplication Elimination**:
   - Identify and eliminate duplicated content
   - Consolidate similar patterns across files
   - Create centralized references for common patterns

3. **Knowledge File Standards**:
   - Ensure all new knowledge files have "USE WHEN" headers
   - Follow established formatting standards
   - Include proper fetch_rules access patterns

4. **Project-Rule-Parameter Standards**:
   - Follow established header format
   - Include clear file purpose sections
   - Document usage examples
   - Include fetch_rules calls to knowledge files

5. **Implementation Verification**:
   - Create comprehensive tracking of content movements
   - Verify fetch_rules access to all abstracted content
   - Confirm total line count is under 1000 lines
   - Verify workflow files reference project-rule-parameters correctly

## Technical Constraints and Considerations

1. **Line Count Calculation**:
   - Line count includes all lines in the file, including whitespace and comments
   - Empty lines count toward the total
   - Code blocks count toward the total
   - The target of 1000 lines is a hard limit, not a guideline

2. **fetch_rules Considerations**:
   - fetch_rules calls should ONLY be in project-rule-parameters, NOT in workflow files
   - Consolidated fetch_rules calls are preferred over multiple single calls
   - Each fetch_rules call must include a clear explanation parameter
   - Knowledge files should be organized to support logical grouping in fetch_rules calls

3. **Content Preservation**:
   - No information should be lost during abstraction
   - All concepts must remain accessible through project-rule-parameters and fetch_rules
   - Essential guidance must be preserved
   - Critical examples must be maintained

4. **Verification Process**:
   - All project-rule-parameter references must be tested
   - All fetch_rules references must be tested
   - Line count must be verified with actual counts
   - Functionality must be confirmed
   - Content accessibility must be validated

This systematic optimization will significantly enhance the efficiency of the rules workflow by streamlining the Auto Attached brain-files while maintaining full functionality through project-rule-parameters and the knowledge system.

## Acceptance Criteria

The completed project must meet these specific criteria to be considered successful:

1. **Line Count Requirement**:
   - Total lines across all files in workflows/rules is ≤ 1000 lines
   - No individual file exceeds 150 lines
   - Line count includes all whitespace and comments

2. **Functionality Verification**:
   - All essential concepts remain accessible
   - All process descriptions are preserved
   - All examples are accessible
   - All critical references are maintained

3. **Knowledge Organization**:
   - All abstracted content has appropriate USE WHEN headers
   - Content is organized into logical directory structure
   - Related concepts are grouped together
   - Directory structure follows established patterns

4. **fetch_rules Implementation**:
   - No fetch_rules calls in workflow files
   - All fetch_rules calls properly placed in project-rule-parameters
   - Workflow files reference project-rule-parameters instead
   - Project-rule-parameters contain comprehensive knowledge access

5. **Documentation Quality**:
   - Auto Attached files remain clear and usable
   - Knowledge files are well-organized
   - Cross-references are maintained
   - Examples are properly contextualized

6. **Implementation Documentation**:
   - Content movement is tracked and documented
   - Line count progress is documented
   - Knowledge file creation is documented
   - Project-rule-parameter creation is documented
   - Verification results are documented

## Risk Assessment

1. **Information Loss Risk**:
   - Potential loss of critical information during abstraction
   - Mitigation: Systematic tracking of all content movements

2. **Reference Breakage Risk**:
   - Potential breakage of references between files
   - Mitigation: Careful preservation of cross-references

3. **Excessive Abstraction Risk**:
   - Potential over-abstraction making content hard to find
   - Mitigation: Logical organization and clear USE WHEN headers

4. **Line Count Risk**:
   - Potential difficulty meeting 1000 line target
   - Mitigation: Staged abstraction with progressive line count tracking

5. **Functionality Risk**:
   - Potential loss of critical functionality
   - Mitigation: Thorough verification of abstracted content

6. **Architecture Compliance Risk**:
   - Potential misplacement of fetch_rules calls
   - Mitigation: Strict adherence to the pattern of keeping fetch_rules calls only in project-rule-parameters
