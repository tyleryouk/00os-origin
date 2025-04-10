# Requirements: Filepath Migration to New 1000xbrain Structure

## Overview

This enhancement focuses on systematically updating all filepaths within 1000xbrain files to align with the new directory structure. The directory reorganization has created a clear mapping between directories and rule types, requiring comprehensive filepath updates across all brain-files to maintain proper cross-references and ensure all references point to the correct locations.

## Business Requirements

1. **Comprehensive Filepath Updates**
   - Update all filepaths in all brain-files to reflect the new directory structure
   - Ensure all cross-references correctly point to the new file locations
   - Maintain proper relationships between files with updated paths

2. **Consistent Directory Structure References**
   - Update all references to reflect the new four-directory structure:
     - `/core` - Always rule types
     - `/knowledge` - Agent Request rule types
     - `/parameters` - Manual rule types
     - `/workflows` - Auto Attached rule types
   - Remove references to outdated directory structures
   - Update documentation explaining directory organization

3. **Documentation Accuracy**
   - Ensure all explanations of file locations are accurate
   - Update documentation that references the directory structure
   - Provide clear guidance on the new organization pattern

4. **Directory-Purpose Alignment**
   - Align file references with the new purpose of each directory
   - Update terminology to match the new directory-rule type mapping
   - Ensure consistent references to the purpose of each directory

5. **Access Method Clarity**
   - Update file path references to align with their appropriate access methods
   - Clarify which paths should be accessed via fetch_rules tool
   - Distinguish paths accessed via project-rule-parameters

## Technical Requirements

1. **Path Format Standardization**
   - All file paths must use the forward slash format (/), not backslashes
   - Paths should be relative to the 1000xbrain root where appropriate
   - Absolute paths should be used when necessary for clarity

2. **Cross-Reference Updates**
   - Update all cross-references between files to reflect new locations
   - Ensure all "@file.md" references point to correct locations
   - Fix any broken references resulting from the reorganization

3. **Path Migration Patterns**
   - Implement consistent patterns for path updates based on rule types:
     - Manual rules → /parameters directory
     - Always rules → /core directory
     - Auto-Attached rules → /workflows directory
     - Agent-Requested rules → /knowledge directory

4. **Example Updates**
   - Update all examples that reference file paths
   - Ensure code snippets use correct paths
   - Update tutorial paths to match the new structure

5. **Tool Call Path Updates**
   - Update paths used in tool calls (especially fetch_rules)
   - Ensure proper syntax for tool call paths
   - Update path-based conditionals and logic

## Implementation Requirements

1. **Comprehensive File Scan**
   - Scan all .md files in the 1000xbrain directory
   - Identify all filepath references using regex and pattern matching
   - Create an inventory of paths that need updating

2. **Path Mapping Creation**
   - Create a detailed mapping between old paths and new paths
   - Document path transformation patterns
   - Create path conversion reference for complex cases

3. **Systematic Updates**
   - Methodically update each file with proper path references
   - Maintain consistent approach to path updates
   - Implement updates in logical groups (by directory or file type)

4. **Validation and Testing**
   - Verify each updated path points to a valid file
   - Check cross-references for correctness
   - Test path-dependent functionality

## Scope

### Files to Update
- All .md files in the 1000xbrain directory containing file paths
- Special focus on:
  - Files with extensive cross-references
  - Documentation files explaining file structure
  - Examples and tutorials
  - Files containing visual representations of the directory structure

### Key Types of References to Update
- Direct file references (e.g., "see file.md")
- Cross-references (@file.md)
- Path examples in code blocks
- Directory structure explanations
- File relationship diagrams
- Tool call path parameters

### Out of Scope
- Actual movement of files (already completed)
- Changes to file content beyond path references
- Updates to Cursor Rules (.mdc files) - these will be synchronized separately

## Success Criteria

The implementation will be considered successful when:

1. All file paths in brain-files correctly reflect the new directory structure
2. No broken cross-references exist throughout the documentation
3. All directory structure explanations accurately describe the new organization
4. Path-based examples and tutorials are fully updated
5. A comprehensive verification confirms all paths are valid

## Implementation Phases

This enhancement will be implemented in these phases:

1. **Analysis Phase**
   - Scan all files for path references
   - Create complete inventory of paths to update
   - Develop transformation patterns for different path types

2. **Update Phase**
   - Update core reference documentation first
   - Update workflow-specific paths next
   - Update knowledge and parameter paths last
   - Update examples and tutorials

3. **Verification Phase**
   - Validate all updated paths
   - Check for broken cross-references
   - Verify correct tool call paths
   - Ensure comprehensive coverage

4. **Documentation Phase**
   - Update directory structure documentation
   - Create path migration reference
   - Document new path patterns and conventions

## Priority and Timeline

- **High Priority**: Core reference documentation, README files
- **Medium Priority**: Cross-references between files
- **Lower Priority**: Example paths in code blocks

The implementation should be done in a single comprehensive pass to ensure consistency and avoid partial updates that could create confusion.

## Related Enhancements

This enhancement is related to:
- The reorganization of the 1000xbrain directory structure
- Updates to README.md files for the new structure
- Implementation of fetch_rules for Agent Requested rules
- Standardization of rule access methods

## Migration Challenges and Mitigations

### Potential Challenges

1. **Scale of Changes**
   - Challenge: Large number of files to update
   - Mitigation: Systematic approach with clear mapping patterns

2. **Reference Identification**
   - Challenge: Finding all file path references
   - Mitigation: Comprehensive regex patterns, multiple passes

3. **Context-Specific Paths**
   - Challenge: Some paths may need different handling based on context
   - Mitigation: Clear documentation of special cases and exceptions

4. **Validation Complexity**
   - Challenge: Ensuring all new paths are valid
   - Mitigation: Automated validation scripts and systematic checks

5. **Maintaining Consistency**
   - Challenge: Ensuring consistent path formatting across all files
   - Mitigation: Clear standards for path formats and reference styles 