rules-workflow | rules-workflow-enhancement

# Requirements: Project-Rule-Parameter Add/Remove System Enhancement

## Objective

Enhance the system of adding, removing, and modifying project-rule-parameters across all workflows to eliminate manual path management, reduce errors, and create a centralized management system using an alias-based approach.

## Current Problems

Right now, whenever you create new project-rule-parameters, you have to manually grep the folder for filepath inconsistencies and manually edit all filepaths. Additionally, when you remove project-rule-parameters you have to do the same. Adding and removing project-rule-parameters is a very manual process. 

Explicitly stating the filepaths of project-rule-parameters can be quite tedious, because every time we make changes it seems like we need to manually grep search the 10000xbrain folder and manually change filepaths. We need a system where all of the filepaths are in one concise place so that we just need to edit one file rather than every project-rule-parameter and every README.md.

## Success Criteria

1. **Path Independence**: Parameter references should not break when files are moved or renamed
2. **Workflow Isolation**: Parameters from different workflows should be properly namespaced
3. **Centralized Management**: A single source of truth for all parameter metadata
4. **Automated Reference Management**: References update automatically when parameters change
5. **Simplified Reference Syntax**: More concise and readable than full file paths
6. **Documentation Generation**: Automatically generated documentation for all parameters
7. **Cross-Workflow Functionality**: System works across all workflows consistently
8. **Backward Compatibility**: Smooth migration path from existing references
9. **Error Reduction**: Significantly fewer errors in parameter management

## Technical Requirements

1. **Alias-Based Reference System**:
   - Create a standardized alias format for parameter references
   - Implement namespace isolation between workflows
   - Support metadata for each parameter (description, category, etc.)

2. **Central Registry**:
   - Create a JSON-based registry for all parameter metadata
   - Include paths, descriptions, usage examples, and other metadata
   - Support multiple workflows in a single registry

3. **Management Scripts**:
   - Create scripts for adding, removing, and updating parameters
   - Implement reference verification and conversion tools
   - Support automated documentation generation

4. **Migration Tools**:
   - Create tools to convert existing references to the new format
   - Support both formats during transition
   - Provide verification to ensure all references are valid

5. **Documentation Enhancement**:
   - Generate workflow-specific parameter documentation
   - Create parameter cheatsheets with the new reference format
   - Document the management commands and processes

## Implementation Scope

### Folders to Modify:
1. 1000xbrain/workflows/rules-workflow
2. 1000xbrain/parameters/rules/*/**

### New Components to Create:
1. 1000xscripts/parameters/alias-registry.json
2. 1000xscripts/parameters/Register-ParameterAlias.ps1
3. 1000xscripts/parameters/Remove-ParameterAlias.ps1
4. 1000xscripts/parameters/Update-ParameterAlias.ps1
5. 1000xscripts/parameters/Update-AliasReferences.ps1
6. 1000xscripts/parameters/Convert-ToAliasReferences.ps1
7. 1000xscripts/parameters/Resolve-AliasReference.ps1
8. 1000xscripts/parameters/Update-AliasDocumentation.ps1
9. 1000xbrain/parameters/rules/helpers/parameter-management/cross-workflow-parameter-manager.md

## Future Work

Create a new planning folder and enhance the project-rule-parameter addition/removal system in front-end-workflow after this implementation is complete.

Folders to edit:
1000xbrain/workflows/rules-workflow
1000xbrain/parameters/rules/*/**

Create a note somwhere in the context or implementation-progress that after we are done with this planning folder, you should create a new planning folder and enhance the project-rule-parameter addition/removal system in front-end-workflow. 