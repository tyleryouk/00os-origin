# Core Subsystem Optimization Implementation Plan

## Implementation Focus

This document outlines the implementation approach for optimizing the core subsystem of 1000xbrain cognitive architecture as part of Phase 2 of the system-wide optimization effort.

## Target Files

The following files will be modified in this implementation:

### Core Files
- `1000xbrain/core/core-essentials.md`
- `1000xbrain/core/index.md`
- `1000xbrain/core/README.md`
- `1000xbrain/core/communication/*.md`
- `1000xbrain/core/identity/*.md`
- `1000xbrain/core/modes/*.md`

## Implementation Strategy

The implementation will follow a systematic approach with these key steps:

### 1. Core File Analysis

Before making changes, we'll first analyze the current state:

```powershell
# Get total line count of core files
(Get-ChildItem -Path "1000xbrain/core/" -Recurse -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum

# Get line count by directory
Get-ChildItem -Path "1000xbrain/core/" -Directory | ForEach-Object {
  $dir = $_.FullName
  $count = (Get-ChildItem -Path $dir -Recurse -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object { Get-Content $_.FullName | Measure-Object -Line } | Measure-Object -Property Lines -Sum).Sum
  "$($_.Name): $count lines"
}

# Get line count for individual files
Get-ChildItem -Path "1000xbrain/core/" -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object {
  $lines = (Get-Content $_.FullName | Measure-Object -Line).Lines
  "$($_.Name): $lines lines"
}
```

The analysis will identify:
- Current line counts for comparison with targets
- Redundant content across files
- Content that can be moved to knowledge files
- Dependencies between components

### 2. Core File Consolidation

#### 2.1 core-essentials.md Optimization

Target: Reduce to under 200 lines while preserving essential identity.

Implementation approach:
1. Focus on absolute essentials only
2. Move all implementation details to knowledge files
3. Maintain clear summaries of critical components
4. Ensure all core functionality remains accessible

```markdown
# Example structure
# Core Essentials: Identity and Mode System

## 1000xdev Identity
* Key identity points
* Primary responsibilities
* Authorization scope

## Brain-Files & Cognitive Architecture
* Relationship overview
* Edit safety essentials
* Critical distinctions

## Mode System
* Mode summaries
* Core indicators
* Primary purposes

## Simplified Message-Commands
* Three command system
* Basic format
* Project-rule-parameters

## Knowledge Access
* fetch_rules overview
* Basic access pattern
```

#### 2.2 Identity Files Optimization

Target: Reduce to under 600 lines total for the identity directory.

Implementation approach:
1. Consolidate redundant identity documentation
2. Focus on core identity aspects
3. Move implementation details to knowledge files
4. Standardize terminology across all files

#### 2.3 Modes Files Optimization

Target: Reduce to under 800 lines total for the modes directory.

Implementation approach:
1. Consolidate mode documentation
2. Create consistent format across all mode files
3. Move implementation details to knowledge
4. Ensure clear mode transitions are documented

#### 2.4 Communication Files Optimization

Target: Reduce to under 400 lines total for the communication directory.

Implementation approach:
1. Consolidate communication standards
2. Update for new message-command format
3. Ensure symbol usage guidelines are clear
4. Move implementation examples to knowledge

### 3. Message-Command Format Enhancement

Implement the updated message-command format with explicit parsing requirements:

#### Plan-mode Syntax
```
plan-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)
```

Required parsing rules:
- Always has exactly 5 components to parse
- `plan-mode` (without colon) is mandatory as first component
- `workflow-type` is mandatory as second component
- `pathway-name` is mandatory as third component and must be explicitly written as "none" if not applicable
- `@project-rule-parameter.mdc` is mandatory as fourth component and must be explicitly written as "none" if not applicable
- `optional-standard-parameter(s)` is mandatory as fifth component and must be explicitly written as "none" if not applicable
- All components are separated by spaces
- Multiple spaces between components are allowed but treated as a single space

Example valid formats:
```
plan-mode rules-workflow system-wide-optimization @parameters/rules/plan-mode/system-wide-optimization.mdc none
plan-mode rules-workflow none @template-basic.mdc none
plan-mode rules-workflow documentation-pathway none parameter1
plan-mode rules-workflow none none none
```

#### Dev-mode Syntax
```
dev-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)
```

Required parsing rules:
- Always has exactly 5 components to parse
- `dev-mode` (without colon) is mandatory as first component
- `workflow-type` is mandatory as second component
- `pathway-name` is mandatory as third component and must be explicitly written as "none" if not applicable
- `@project-rule-parameter.mdc` is mandatory as fourth component and must be explicitly written as "none" if not applicable
- `optional-standard-parameter(s)` is mandatory as fifth component and must be explicitly written as "none" if not applicable
- All components are separated by spaces
- Multiple spaces between components are allowed but treated as a single space

Example valid formats:
```
dev-mode front-end-workflow component-creation @implementation-strategy.mdc param1
dev-mode back-end-workflow none @direct-implementation.mdc none
dev-mode rules-workflow documentation-pathway none param1
dev-mode rules-workflow none none none
```

#### Direct-mode Syntax

Direct-mode can use either a standard 6-component format or a simplified 3-component format:

Standard format (6 components):
```
direct-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)
prompt:
```

Simplified format (3 components):
```
direct-mode workflow-type
prompt:
```

Required parsing rules:
- `direct-mode` (without colon) is mandatory as first component
- `workflow-type` is mandatory as second component
- In standard format:
  - `pathway-name` is mandatory as third component and must be explicitly written as "none" if not applicable
  - `@project-rule-parameter.mdc` is mandatory as fourth component and must be explicitly written as "none" if not applicable
  - `optional-standard-parameter(s)` is mandatory as fifth component and must be explicitly written as "none" if not applicable
  - `prompt:` must appear on a new line after the components as the sixth component
- In simplified format:
  - `prompt:` must appear on a new line immediately after the workflow-type as the third component
- All components are separated by spaces
- Multiple spaces between components are allowed but treated as a single space

Example valid formats:

Standard format:
```
direct-mode rules-workflow documentation-pathway @template-basic.mdc param1
prompt:

direct-mode back-end-workflow none @direct-implementation.mdc none
prompt:

direct-mode front-end-workflow none none none
prompt:
```

Simplified format:
```
direct-mode rules-workflow
prompt:

direct-mode front-end-workflow
prompt:
```

Implementation steps:
1. Update all message-command documentation with explicit parsing examples
2. Implement parsing logic for the new format 
3. Create clear examples for all modes and workflows
4. Ensure backward compatibility during transition
5. Update project-rule-parameter headers to match:
   ```
   # mode: [mode] | workflow: [workflow-type] | pathway: [pathway-name] | filepath: @[filepath].mdc | optional-standard-parameter(s): [params]
   ```

#### Parsing Implementation

The parsing logic will follow these steps:
1. Identify the mode (plan-mode, dev-mode, direct-mode) as the first component
2. Split by spaces to extract components
3. Validate workflow-type against allowed values
4. Process pathway-name (verifying "none" if not applicable)
5. Process project-rule-parameter (verifying "none" if not applicable)
6. Process optional parameters (verifying "none" if not applicable)
7. For direct-mode, check format and ensure presence of "prompt:" on next line

This space-only delimiter approach provides a more consistent syntax that's easier to parse and maintain while still preserving all functionality.

### Project-Rule-Parameter Verification Implementation

The verification process for project-rule-parameters will follow these detailed steps:

1. **Initial Parsing of Message-Command**:
   - Parse the message-command into its five components
   - Extract mode, workflow-type, pathway-name, project-rule-parameter, and optional-standard-parameter(s)
   - Validate basic syntax of all components

2. **Project-Rule-Parameter File Access**:
   ```typescript
   // Access the project-rule-parameter file
   read_file(".cursor/rules/[parameter_path]", should_read_entire_file=true)
   ```

3. **Header Extraction and Parsing**:
   - Extract the first line of the parameter file (after frontmatter if present)
   - Verify it matches the expected header format:
     ```
     # mode: [mode] | workflow: [workflow-type] | pathway: [pathway-name] | filepath: @[filepath].mdc | optional-standard-parameter(s): [params]
     ```
   - Parse the header into individual components
   - Handle errors for malformed headers

4. **Component-by-Component Verification**:
   - Mode verification: message-command mode must match header mode
   - Workflow-type verification: message-command workflow-type must match header workflow-type
   - Pathway-name verification: message-command pathway-name must match header pathway-name
   - Project-rule-parameter verification: message-command parameter path must match header filepath
   - Optional-standard-parameter(s) verification: See special handling below

5. **Standard-Parameter Special Handling**:
   - When the header contains bracketed standard-parameters (e.g., `[brain-file-name]`):
     ```typescript
     // Special handling for bracketed standard-parameters
     if (header_optional.startsWith('[') && header_optional.endsWith(']')) {
       // This is a variable parameter, check if the provided value matches the expected pattern
       const variable_name = header_optional.substring(1, header_optional.length - 1);
       
       // Validate the parameter based on its type
       // For example, if variable is [brain-file-name], check if value ends with .md
       const is_valid = validateParameterPattern(variable_name, optional_parameters);
       
       if (!is_valid) {
         return `${mode_indicator}\n\nError: Optional-standard-parameter(s) mismatch. Message-command specifies '${optional_parameters}' but parameter requires a value matching pattern '${header_optional}'`;
       }
     } else if (optional_parameters !== header_optional) {
       // For non-variable parameters, require exact match
       return `${mode_indicator}\n\nError: Optional-standard-parameter(s) mismatch. Message-command specifies '${optional_parameters}' but parameter requires '${header_optional}'`;
     }
     ```
   - During implementation, these values become variables used throughout parameter processing
   - The brackets in headers indicate placeholders that should be replaced with actual values
   - Values in message-commands are provided without brackets

6. **Error Generation and Handling**:
   - Generate specific error messages for each type of mismatch:
     - Mode mismatch: "Error: Mode mismatch. Message-command specifies '[message_mode]' but parameter requires '[header_mode]'"
     - Workflow-type mismatch: "Error: Workflow-type mismatch. Message-command specifies '[message_workflow]' but parameter requires '[header_workflow]'"
     - Pathway-name mismatch: "Error: Pathway-name mismatch. Message-command specifies '[message_pathway]' but parameter requires '[header_pathway]'"
     - Project-rule-parameter mismatch: "Error: Project-rule-parameter mismatch. Message-command specifies '[message_parameter]' but parameter requires '[header_parameter]'"
     - Optional-standard-parameter(s) mismatch: "Error: Optional-standard-parameter(s) mismatch. Message-command specifies '[message_optional]' but parameter requires '[header_optional]'"
   - For file not found errors: "Error: Project-rule-parameter '[parameter_path]' not found"
   - For malformed header errors: "Error: Malformed header in project-rule-parameter '[parameter_path]'"

7. **Parameter Processing**:
   - If verification succeeds, process the parameter body
   - Extract and execute tool call sequences
   - Apply knowledge access patterns
   - Implement mode-specific processing
   - For standard-parameters, use the provided value in place of the bracketed variable throughout processing

### Tool Call Sequence for Verification

```typescript
// Example verification process for a message-command
// 1. Parse the message-command
const components = message_command.split(' ');
const mode = components[0];                    // Example: "plan-mode"
const workflow_type = components[1];           // Example: "rules-workflow"
const pathway_name = components[2];            // Example: "system-wide-optimization"
const project_rule_parameter = components[3];  // Example: "@parameters/rules/plan-mode/system-wide-optimization.mdc"
const optional_parameters = components[4];     // Example: "none"

// 2. Access the project-rule-parameter file
try {
  // Example path: .cursor/rules/parameters/rules/plan-mode/system-wide-optimization.mdc
  const parameter_content = read_file(`.cursor/rules/${project_rule_parameter.substring(1)}`, should_read_entire_file=true);
  
  // 3. Extract and parse the header
  const header_line = parameter_content.split('\n')[0];
  if (!header_line.startsWith('# mode:')) {
    return "Error: Malformed header in project-rule-parameter";
  }
  
  // 4. Parse header components
  const header_mode = extractHeaderComponent(header_line, 'mode');                  // Example: "plan-mode"
  const header_workflow = extractHeaderComponent(header_line, 'workflow');          // Example: "rules-workflow"
  const header_pathway = extractHeaderComponent(header_line, 'pathway');            // Example: "system-wide-optimization"
  const header_filepath = extractHeaderComponent(header_line, 'filepath');          // Example: "@parameters/rules/plan-mode/system-wide-optimization.mdc"
  const header_optional = extractHeaderComponent(header_line, 'optional-standard-parameter(s)'); // Example: "none"
  
  // 5. Verify components match
  if (mode !== header_mode) {
    return `Error: Mode mismatch. Message-command specifies '${mode}' but parameter requires '${header_mode}'`;
  }
  
  if (workflow_type !== header_workflow) {
    return `Error: Workflow-type mismatch. Message-command specifies '${workflow_type}' but parameter requires '${header_workflow}'`;
  }
  
  if (pathway_name !== header_pathway) {
    return `Error: Pathway-name mismatch. Message-command specifies '${pathway_name}' but parameter requires '${header_pathway}'`;
  }
  
  if (project_rule_parameter !== header_filepath) {
    return `Error: Project-rule-parameter mismatch. Message-command specifies '${project_rule_parameter}' but parameter requires '${header_filepath}'`;
  }
  
  // 6. Special handling for standard-parameters
  if (header_optional.startsWith('[') && header_optional.endsWith(']')) {
    // This is a variable parameter, validate it matches the expected pattern
    const variable_name = header_optional.substring(1, header_optional.length - 1);
    const is_valid = validateParameterPattern(variable_name, optional_parameters);
    
    if (!is_valid) {
      return `Error: Optional-standard-parameter(s) mismatch. Message-command specifies '${optional_parameters}' but parameter requires a value matching pattern '${header_optional}'`;
    }
    
    // If valid, we would use the provided value as a variable during processing
  } else if (optional_parameters !== header_optional) {
    // For non-variable parameters, require exact match
    return `Error: Optional-standard-parameter(s) mismatch. Message-command specifies '${optional_parameters}' but parameter requires '${header_optional}'`;
  }
  
  // 7. Process parameter if verification succeeds
  return "Verification successful. Processing parameter...";
  
} catch (error) {
  return `Error: Project-rule-parameter '${project_rule_parameter}' not found`;
}
```

This verification process ensures that all message-commands are correctly aligned with their corresponding project-rule-parameters, preventing implementation errors and improving system reliability.

### 4. Common-Words Registry Implementation

Create a comprehensive common-words registry to standardize terminology:

1. Review all core files for terminology variations
2. Create a standardized registry in knowledge/rules/reference/
3. Implement consistent terminology across all files
4. Document relationships between terms

Example structure:
```markdown
# Common Words Registry

## File Terminology
- **brain-file**: Editable .md file in 1000xbrain directory
- **cursor-rule**: Applied .mdc file in .cursor/rules directory
- **knowledge-file**: Specialized domain knowledge in knowledge directory

## Process Terminology
- **cognitive-loop**: The perception-reasoning-action-learning process
- **fetch-rules**: Knowledge access process using the fetch_rules tool
- **synchronization-process**: Process for syncing brain-files to cursor-rules
```

### 5. Knowledge Migration

Move implementation details to knowledge files:

1. Create or update knowledge files for all implementation details
2. Ensure proper fetch_rules access patterns
3. Document all knowledge file creation
4. Verify knowledge accessibility

Example knowledge file creation:
```markdown
# Detailed Mode System Implementation

This knowledge file contains detailed implementation guidance for the mode system that has been moved from core files to reduce cognitive load.

## Detailed Mode Implementations

### Planning Mode
Detailed implementation guidance...

### Developer Mode
Detailed implementation guidance...

### Direct Mode
Detailed implementation guidance...
```

## Success Criteria

1. Core files total under 2000 lines
2. All core files consolidated and organized
3. Message-command format updated and documented
4. Standard-parameter handling implemented with clear verification rules
5. Common-words registry created with standardized terminology
6. Implementation details moved to knowledge files
7. Documentation clear and concise

## Implementation Verification

After implementation, we'll verify success by:

1. Counting total lines to ensure they're under target
2. Testing the message-command parsing system
3. Verifying the common-words registry completeness
4. Testing knowledge file accessibility
5. Ensuring all standard-parameters are handled correctly
6. Verifying backward compatibility

## Documentation Updates

Implementation will include updates to these documentation files:

1. Core files (as described above)
2. Message-command processing documentation
3. Common-words registry
4. Knowledge file creation and organization

## Implementation Timeline

1. Core file analysis
2. Consolidation of mode documentation
3. Consolidation of identity documentation
4. Implementation of message-command format updates
5. Creation of common-words registry
6. Migration of implementation details to knowledge
7. Final verification and testing