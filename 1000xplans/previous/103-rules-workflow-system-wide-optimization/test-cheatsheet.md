# Test Cheatsheet: System-Wide Optimization

## Overview

This document provides comprehensive testing procedures to verify the successful implementation of the system-wide optimization. It focuses on ensuring that the single source of truth architecture is properly implemented, project-rule-parameters are correctly restructured, and the tool call process enforces documentation-first implementation.

## Knowledge Structure Testing

### Knowledge File Completeness Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| KS-01 | Verify all required system-structure files exist | `list_dir("1000xbrain/knowledge/system-structure")` | All planned files present |
| KS-02 | Verify system-architecture.md completeness | `read_file("1000xbrain/knowledge/system-structure/system-architecture.md", should_read_entire_file=true)` | Contains all required sections |
| KS-03 | Verify subsystem-core.md completeness | `read_file("1000xbrain/knowledge/system-structure/subsystem-core.md", should_read_entire_file=true)` | Contains all required sections |
| KS-04 | Verify subsystem-knowledge.md completeness | `read_file("1000xbrain/knowledge/system-structure/subsystem-knowledge.md", should_read_entire_file=true)` | Contains all required sections |
| KS-05 | Verify subsystem-parameters.md completeness | `read_file("1000xbrain/knowledge/system-structure/subsystem-parameters.md", should_read_entire_file=true)` | Contains all required sections |
| KS-06 | Verify subsystem-workflows.md completeness | `read_file("1000xbrain/knowledge/system-structure/subsystem-workflows.md", should_read_entire_file=true)` | Contains all required sections |
| KS-07 | Verify workflow-subsystem-relationships.md completeness | `read_file("1000xbrain/knowledge/system-structure/workflow-subsystem-relationships.md", should_read_entire_file=true)` | Contains all required sections |
| KS-08 | Verify pathway-organization.md completeness | `read_file("1000xbrain/knowledge/system-structure/pathway-organization.md", should_read_entire_file=true)` | Contains all required sections |

### Knowledge File Header Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| KH-01 | Verify all knowledge files have proper USE WHEN header | `grep_search("^# USE WHEN", true, "1000xbrain/knowledge/system-structure/**/*.md")` | All files have correct header |
| KH-02 | Verify consistent overview section in all files | `grep_search("^## Overview", true, "1000xbrain/knowledge/system-structure/**/*.md")` | All files have overview section |

### Knowledge Content Consistency Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| KC-01 | Verify consistent subsystem terminology | `grep_search("subsystem-[a-z]+", true, "1000xbrain/knowledge/system-structure/**/*.md")` | Consistent terminology used |
| KC-02 | Verify consistent workflow terminology | `grep_search("workflow[s]?-", true, "1000xbrain/knowledge/system-structure/**/*.md")` | Consistent terminology used |
| KC-03 | Verify cross-references between files | `grep_search("knowledge/system-structure/", true, "1000xbrain/knowledge/system-structure/**/*.md")` | Proper cross-references present |

## Parameter Restructuring Testing

### Parameter Existence Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| PE-01 | Verify all plan-mode parameters exist | `list_dir("1000xbrain/parameters/rules/plan-mode")` | All planned parameters present |
| PE-02 | Verify all dev-mode parameters exist | `list_dir("1000xbrain/parameters/rules/dev-mode")` | All planned parameters present |

### Parameter Header Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| PH-01 | Verify all plan-mode parameters have correct headers | `grep_search("^# mode: plan-mode \\| workflow: rules-workflow \\| pathway:", true, "1000xbrain/parameters/rules/plan-mode/**/*.md")` | All parameters have correct header |
| PH-02 | Verify all dev-mode parameters have correct headers | `grep_search("^# mode: dev-mode \\| workflow: rules-workflow \\| pathway:", true, "1000xbrain/parameters/rules/dev-mode/**/*.md")` | All parameters have correct header |
| PH-03 | Verify all pathway values are consistent | `grep_search("\\| pathway: ([^\\|]+) \\|", true, "1000xbrain/parameters/rules/**/*.md")` | All pathways match planned structure |

### Parameter Content Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| PC-01 | Verify knowledge access sections in parameters | `grep_search("^## Knowledge Access", true, "1000xbrain/parameters/rules/**/*.md")` | All parameters have knowledge access section |
| PC-02 | Verify fetch_rules patterns in parameters | `grep_search("fetch_rules\\(\\[\"knowledge/system-structure/", true, "1000xbrain/parameters/rules/**/*.md")` | All parameters reference system-structure files |
| PC-03 | Verify tool call process sections in parameters | `grep_search("^## Tool Call Process", true, "1000xbrain/parameters/rules/**/*.md")` | All parameters have tool call process section |
| PC-04 | Verify domain access sections in parameters | `grep_search("^## Domain Access", true, "1000xbrain/parameters/rules/**/*.md")` | All parameters have domain access section |

### Domain Access Specification Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| DA-01 | Verify system-wide domain access specification | `grep_search("Domain Access.*\\ball of 1000xbrain/\\*\\*\\b", true, "1000xbrain/parameters/rules/**/system-wide*.md")` | Correct domain access specified |
| DA-02 | Verify subsystem-core domain access specification | `grep_search("knowledge/system-structure/.*core", true, "1000xbrain/parameters/rules/**/subsystem-core.md")` | Correct domain access specified |
| DA-03 | Verify subsystem-knowledge domain access specification | `grep_search("knowledge/system-structure/.*knowledge", true, "1000xbrain/parameters/rules/**/subsystem-knowledge.md")` | Correct domain access specified |
| DA-04 | Verify subsystem-parameters domain access specification | `grep_search("knowledge/system-structure/.*parameters", true, "1000xbrain/parameters/rules/**/subsystem-parameters.md")` | Correct domain access specified |
| DA-05 | Verify subsystem-workflows domain access specification | `grep_search("knowledge/system-structure/.*workflows", true, "1000xbrain/parameters/rules/**/subsystem-workflows.md")` | Correct domain access specified |
| DA-06 | Verify workflows domain access specification | `grep_search("workflow-type.*subsystem", true, "1000xbrain/parameters/rules/**/workflows.md")` | Correct domain access specified |

## Tool Call Process Testing

### Knowledge Access Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| TA-01 | Verify all parameters reference appropriate knowledge files | `grep_search("fetch_rules\\(\\[\"knowledge/system-structure/[^\"]+\"\\]", true, "1000xbrain/parameters/rules/**/*.md")` | All parameters have correct fetch_rules patterns |
| TA-02 | Verify knowledge access explanations are clear | `grep_search("\"Understanding [^\"]+\"\\)", true, "1000xbrain/parameters/rules/**/*.md")` | All fetch_rules have clear explanations |

### Documentation-First Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| DF-01 | Verify documentation update comes before implementation | `grep_search("edit_file\\(\"1000xbrain/knowledge/system-structure/[^\"]+\\.md\"", true, "1000xbrain/parameters/rules/**/*.md")` | Documentation edited first in all parameters |
| DF-02 | Verify implementation follows documentation update | Check sequential order of edit_file calls in parameters | Documentation edits always precede implementation |

### Domain Access Enforcement Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| DE-01 | Verify system-wide parameters allow full domain access | Read tool call processes in system-wide parameters | Edit operations allowed for all subsystems |
| DE-02 | Verify subsystem-core parameters limit domain access | Read tool call processes in subsystem-core parameters | Edit operations limited to knowledge/system-structure and core |
| DE-03 | Verify subsystem-knowledge parameters limit domain access | Read tool call processes in subsystem-knowledge parameters | Edit operations limited to knowledge/system-structure and knowledge |
| DE-04 | Verify subsystem-parameters parameters limit domain access | Read tool call processes in subsystem-parameters parameters | Edit operations limited to knowledge/system-structure and parameters |
| DE-05 | Verify subsystem-workflows parameters limit domain access | Read tool call processes in subsystem-workflows parameters | Edit operations limited to knowledge/system-structure and workflows |
| DE-06 | Verify domain access verification steps are included | `grep_search("domain access", true, "1000xbrain/parameters/rules/**/*.md")` | Domain access verification steps present |

### Verification Process Confirmation

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| VP-01 | Verify documentation verification steps present | `grep_search("read_file\\(\"1000xbrain/knowledge/system-structure/", true, "1000xbrain/parameters/rules/**/*.md")` | Verification steps present in all parameters |
| VP-02 | Verify implementation verification steps present | `grep_search("consistency|verification|verify", true, "1000xbrain/parameters/rules/**/*.md")` | Verification steps present in all parameters |
| VP-03 | Verify domain access verification steps present | `grep_search("domain access verification", true, "1000xbrain/parameters/rules/**/*.md")` | Domain verification steps present in all parameters |

## System-Wide Consistency Testing

### Cross-Referencing Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| CR-01 | Verify README.md references knowledge/system-structure/ | `grep_search("knowledge/system-structure", true, "1000xbrain/README.md")` | README properly references system-structure |
| CR-02 | Verify consistent terminology across system | `grep_search("subsystem-[a-z]+", true, "1000xbrain/**/*.md")` | Consistent terminology used |
| CR-03 | Verify consistent pathway references | `grep_search("pathway: [a-z-]+", true, "1000xbrain/**/*.md")` | Consistent pathway terminology used |
| CR-04 | Verify consistent domain access documentation | `grep_search("domain access", true, "1000xbrain/parameters/rules/**/*.md")` | Consistent domain access documentation |

### Duplication Elimination Verification

| Test ID | Test Description | Verification Method | Success Criteria |
|---------|-----------------|---------------------|------------------|
| DE-01 | Verify system structure information not duplicated | Compare content across parameters and knowledge files | No unnecessary duplication of system structure info |
| DE-02 | Verify all parameters reference knowledge rather than duplicate | `grep_search("fetch_rules\\(\\[\"knowledge/system-structure/", true, "1000xbrain/parameters/rules/**/*.md")` | Parameters reference knowledge rather than duplicate |

## Implementation Verification Process

To perform a complete verification of the implementation, follow these steps:

1. **Knowledge Structure Verification**:
   - Check that all required knowledge/system-structure/ files exist
   - Verify all files have proper headers and structure
   - Confirm content is comprehensive and accurate
   - Validate cross-references between files

2. **Parameter Restructuring Verification**:
   - Check that all required parameters exist in both modes
   - Verify all parameters have correct headers
   - Confirm pathways match the planned structure
   - Validate content structure is consistent
   - Verify domain access specifications are correct and consistent

3. **Tool Call Process Verification**:
   - Check that all parameters reference appropriate knowledge files
   - Verify documentation update comes before implementation
   - Confirm verification steps are included
   - Validate process is consistent across parameters
   - Verify domain access restrictions are properly enforced

4. **System-Wide Consistency Verification**:
   - Check cross-references between knowledge and other files
   - Verify terminology is consistent across the system
   - Confirm no unnecessary duplication of information
   - Validate overall system coherence
   - Verify domain access documentation is consistent

## Domain Access Verification Process

To verify domain access enforcement, follow these steps:

1. **Parameter Structure Verification**:
   - Check that all parameters have a Domain Access section
   - Verify the domain access specifications match the requirements
   - Confirm read/edit access is clearly specified

2. **Tool Call Process Verification**:
   - Check that edit operations respect domain access restrictions
   - Verify domain access verification steps are included
   - Confirm error handling for domain access violations is documented

3. **Access Testing Approach**:
   - For system-wide parameters: Verify full access is allowed
   - For subsystem-core: Verify edits limited to knowledge/system-structure and core
   - For subsystem-knowledge: Verify edits limited to knowledge/system-structure and knowledge
   - For subsystem-parameters: Verify edits limited to knowledge/system-structure and parameters
   - For subsystem-workflows: Verify edits limited to knowledge/system-structure and workflows
   - For workflows: Verify edits follow relevant subsystem patterns

## Failure Scenarios and Recovery

| Scenario | Detection Method | Recovery Approach |
|----------|------------------|-------------------|
| Missing knowledge file | KS-01 fails | Create the missing file according to template |
| Incorrect parameter header | PH-01 or PH-02 fails | Update the parameter header to match standard format |
| Missing fetch_rules reference | TA-01 fails | Add appropriate fetch_rules pattern to parameter |
| Documentation edit missing | DF-01 fails | Modify parameter to include documentation edit first |
| Inconsistent terminology | KC-01 or KC-02 fails | Standardize terminology across all files |
| Duplication not eliminated | DE-01 fails | Replace duplicated content with fetch_rules references |
| Domain access violation | DE-02 through DE-05 fail | Correct tool call process to respect domain restrictions |
| Missing domain access section | PC-04 fails | Add domain access section to parameter |

## Success Criteria Summary

The system-wide optimization will be considered successfully implemented when:

1. **Knowledge Structure**:
   - All required knowledge/system-structure/ files exist and are complete
   - Files have proper headers and structure
   - Content is comprehensive, accurate, and consistent

2. **Parameter Restructuring**:
   - All required parameters exist with correct pathways
   - Parameters have proper headers and structure
   - Content follows the standardized format
   - Domain access specifications are clearly documented

3. **Tool Call Process**:
   - All parameters reference appropriate knowledge files
   - Documentation updates always precede implementation
   - Verification steps are included in the process
   - Domain access restrictions are properly enforced

4. **System-Wide Consistency**:
   - Terminology is consistent across the system
   - No unnecessary duplication of information
   - Clear cross-references between components
   - Domain access documentation is consistent

When all verification tests pass, the system-wide optimization can be considered complete and successful. 