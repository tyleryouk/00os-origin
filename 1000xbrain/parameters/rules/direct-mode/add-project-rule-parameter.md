# mode: direct-mode | workflow: rules-workflow | pathway: none | filepath: @parameters/rules/direct-mode/add-project-rule-parameter.mdc  | optional-standard-parameter(s): @[brain-file].md

## Overview

This project-rule-parameter provides structured guidance for creating new project-rule-parameters in the 1000xbrain cognitive architecture. It ensures consistent formatting, proper integration, and adherence to all documentation standards.

## Implementation Process

### 1. Initial Setup

1. **Determine Parameter Location**:
   - Identify correct directory under `/1000xbrain/parameters/rules/`
   - Verify directory exists or create if needed
   - Follow domain boundary rules for parameter creation

2. **File Naming**:
   - Use kebab-case format
   - End with `.md` extension for brain-files
   - Ensure name reflects parameter purpose
   - Verify no naming conflicts exist

3. **Header Format**:
   ```markdown
   # mode: [mode] | workflow: [workflow-type] | pathway: [pathway-name] | filepath: @[filepath].mdc | optional-standard-parameter(s): [params] 
   ```

### 2. Content Structure

1. **Required Sections**:
   - Overview
   - Implementation Process
   - Usage Guidelines
   - Examples
   - Success Criteria
   - Error Handling
   - Related Knowledge Components

2. **Section Content Standards**:
   - Clear, concise descriptions
   - Step-by-step instructions
   - Practical examples
   - Error scenarios and solutions
   - Integration points

3. **Reference Protection**:
   - Wrap @ symbols in backticks
   - Use code blocks for multiple references
   - Maintain clear extension distinction (.md vs .mdc)
   - Follow reference format standards

### 3. Implementation Steps

1. **Tool Usage Sequence**:
   ```typescript
   // Read template and standards
   read_file("knowledge/rules/patterns/doc/parameter-template.md")
   
   // Create parameter file
   edit_file("parameters/rules/[mode]/[name].md")
   
   // Verify structure
   read_file("parameters/rules/[mode]/[name].md")
   ```

2. **Content Creation**:
   - Follow parameter template structure
   - Include all required sections
   - Add domain-specific content
   - Implement proper reference handling

3. **Validation**:
   - Verify header format
   - Check reference formatting
   - Validate content structure
   - Test example commands

### 4. Integration Standards

1. **Knowledge Integration**:
   - Link to relevant knowledge components
   - Follow knowledge access patterns
   - Maintain clear relationships
   - Document dependencies

2. **Documentation Updates**:
   - Update related documentation
   - Add cross-references
   - Document new patterns
   - Track changes

## Usage Guidelines

### Basic Usage

```markdown
direct-mode: rules-workflow
prompt: create a project-rule-parameter in [directory] called [name] for [purpose]
```

### Advanced Usage

```markdown
direct-mode: rules-workflow
prompt: create a project-rule-parameter in [directory] called [name] with custom sections:
- [section1]
- [section2]
- [section3]
```

## Success Criteria

1. **File Structure**:
   - Correct header format
   - All required sections present
   - Proper reference formatting
   - Clear implementation steps

2. **Content Quality**:
   - Clear instructions
   - Practical examples
   - Error handling guidance
   - Integration documentation

3. **Integration**:
   - Proper knowledge links
   - Correct file location
   - Valid references
   - Updated documentation

## Error Handling

| Issue | Solution |
|-------|----------|
| Invalid header format | Follow exact header template with all components |
| Missing sections | Review parameter template and add required sections |
| Reference format issues | Wrap @ symbols in backticks, use proper extensions |
| Integration problems | Verify file location and update related documentation |

## Related Knowledge Components

Access these components for additional guidance:

```typescript
fetch_rules([
  "knowledge/rules/patterns/doc/parameter-template",
  "knowledge/rules/patterns/doc/file-standards",
  "knowledge/rules/patterns/doc/reference-format-template",
  "knowledge/rules/reference/architecture"
], "Accessing parameter creation guidance")
``` 