# Rules Workflow First Tool Call Safety

## Overview

This file provides specialized first tool call safety guidelines specific to rules-workflow. The general concepts of file safety, symbol usage, and mode-specific behavior are covered in the core documentation; this file focuses only on additional rules-workflow specific safety practices.

## Rules Workflow Tool Call Requirements

### Cognitive Architecture Modification Safety

When modifying cognitive architecture files (brain-files), additional safety requirements apply:

1. **Impact Assessment**:
   - Always assess potential system-wide impacts before modifications
   - Consider interface effects across subsystems
   - Evaluate dependant files that may need updates
   - Check for consistency with core system files

2. **Rules-Workflow Verification Pattern**:
   - Verify all cross-references before modifications
   - Double-check knowledge access patterns
   - Confirm all tool usage follows established standards
   - Validate changes maintain cognitive architecture standards

3. **Enhanced Validation Pattern**:
   ```typescript
   // Rules-workflow enhanced validation pattern
   function validateRulesWorkflowChange(file, changes) {
     // Verify file is within cognitive architecture
     validateCognitiveArchitectureScope(file)
     
     // Check interface impact
     assessInterfaceImpact(file, changes)
     
     // Validate cross-references
     validateCrossReferences(changes)
     
     // Confirm knowledge access patterns
     validateKnowledgeAccess(changes)
   }
   ```

## Implementation Guidelines

### Rules-Workflow Specialization

1. **Context-Enhanced Validation**:
   - Always read the full file before modification
   - Understand the file's role in the cognitive architecture
   - Consider system-wide impact of changes
   - Maintain cross-file consistency

2. **Knowledge Integration**:
   - Ensure knowledge references are properly formatted
   - Validate knowledge access patterns
   - Update knowledge components when needed
   - Maintain consistency with knowledge structure

3. **Cognitive Architecture Standards**:
   - Adhere to established cognitive architecture patterns
   - Follow consistent structural organization
   - Maintain clear subsystem boundaries
   - Use standard naming conventions

## Conclusion

When working with rules-workflow, follow these specialized guidelines in addition to the core safety requirements. For general file safety, refer to `core/communication/file-editing-safety.md` and `core/communication/symbol-guidelines.md`. 