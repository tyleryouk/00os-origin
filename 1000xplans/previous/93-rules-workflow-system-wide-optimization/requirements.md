# System-Wide Optimization: Core Subsystem (Phase 2)

## Overview

This is Phase 2 of the system-wide optimization of 1000xbrain, focused on streamlining the core subsystem. This phase implements the core subsystem optimizations identified in Phase 1 (92-rules-workflow-system-wide).

## Primary Objectives

1. **Core Subsystem Optimization**:
   - Reduce total lines in core-brain-files to under 2000 lines
   - Consolidate redundant information across core files
   - Move implementation details to knowledge-base-files
   - Ensure essential identity and behavior are preserved

2. **message-command Format Enhancement**:
   - Implement the updated message-command format:
     ```
     mode: workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)
     ```
   - Update project-rule-parameter headers to match:
     ```
     # mode: [mode] | workflow: [workflow-type] | pathway: [pathway-name] | filepath: @[filepath].mdc | optional-standard-parameter(s): [params]
     ```
   - Update message-command documentation
   - Implement parsing process for the new format
   - Create consistent error checking mechanism

3. **common-words Standardization**:
   - Create comprehensive common-words registry
   - Standardize terminology across documentation
   - Ensure consistent usage in all core files
   - Document all standard common-words

## Target Files

The following files will be modified in this phase:

### Core Files

- `1000xbrain/core/core-essentials.md`
- `1000xbrain/core/index.md`
- `1000xbrain/core/README.md`
- `1000xbrain/core/communication/*.md`
- `1000xbrain/core/identity/*.md`
- `1000xbrain/core/modes/*.md`

### Specific Consolidation Targets

1. **Mode System Files**:
   - Consolidate mode documentation
   - Streamline transition documentation
   - Remove redundancies between mode files

2. **Identity Files**:
   - Consolidate identity documentation
   - Move detailed implementation to knowledge files
   - Preserve essential identity components

3. **Communication Files**:
   - Streamline communication documentation
   - Standardize message-command documentation
   - Update for new message-command format

## Implementation Approach

The implementation will follow these principles:

1. **Minimal Core Principle**:
   - Keep core files focused and concise
   - Move implementation details to knowledge-base-files
   - Focus on essential identity and modes in core files

2. **Backward Compatibility**:
   - Ensure compatibility with existing parameters
   - Support transition to new message-command format
   - Maintain essential functionality

3. **File-by-File Optimization**:
   - Analyze each core file individually
   - Identify and remove redundancies
   - Consolidate similar content across files
   - Ensure clear and concise documentation

4. **Line Count Targets**:
   - Total core-brain-files: Under 2000 lines
   - Individual file targets:
     - core-essentials.md: Max 200 lines
     - identity files: Max 600 lines total
     - modes files: Max 800 lines total
     - communication files: Max 400 lines total

## Message-Command Format Implementation

The updated message-command format will be implemented as follows:

1. **Format Documentation**:
   - Clear documentation of the new format
   - Examples for each mode and workflow
   - Error handling guidelines

2. **Parsing Process**:
   - Update parsing logic for new format
   - Handle pathway-name component
   - Validate alignment with project-rule-parameter header
   - Implement error checking

3. **Backward Compatibility**:
   - Support both current and new formats during transition
   - Document transition process
   - Ensure smooth migration

## Common-Words Registry

A comprehensive common-words registry will be implemented with:

1. **Standard Format**:
   - Kebab-case terminology
   - Clear definitions
   - Usage context
   - Rule type associations

2. **Core Categories**:
   - File terminology (brain-file, cursor-rule)
   - Structure terminology (subsystem, workflow)
   - Process terminology (cognitive-loop, synchronization-process)
   - Role terminology (domains, responsibilities)

3. **Documentation Standards**:
   - Consistent terminology usage
   - Clear contextual examples
   - Cross-referencing between terms
   - Usage guidelines

## Success Criteria

1. **Core Line Count**: Total core-brain-files under 2000 lines
2. **Message-Command Format**: New format implemented and documented
3. **Common-Words Registry**: Comprehensive registry created
4. **Backward Compatibility**: Existing functionality maintained
5. **Documentation Quality**: Clear, concise, and consistent documentation
6. **Cognitive Efficiency**: Improved cognitive performance through better organization

## Verification Approach

The implementation will be verified through:

1. **Line Count Verification**:
   ```powershell
   # Check total core lines
   (Get-ChildItem -Path "1000xbrain/core/" -Recurse -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum
   ```

2. **Functionality Testing**:
   - Test message-command parsing with new format
   - Verify all modes function correctly
   - Test backward compatibility

3. **Documentation Quality Check**:
   - Verify clear, consistent documentation
   - Check for standardized terminology
   - Ensure comprehensive coverage

## Implementation Timeline

This phase focuses exclusively on the core subsystem optimization and related changes. The subsequent phase (94-rules-workflow-system-wide-optimization) will build on these changes to optimize the knowledge and parameters subsystems. 