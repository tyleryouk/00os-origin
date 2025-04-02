# USE WHEN defining audit criteria, implementing validation checks, or establishing project-rule standards

# Audit Validation Criteria Reference

## Overview

This reference document establishes the comprehensive validation criteria for auditing project-rule-parameters in the 1000xbrain cognitive architecture. It provides the specific standards, requirements, and formats that should be verified during audit processes.

## Key Concepts

- **Self-Documenting Headers**: Standard header format for project-rule-parameters
- **Validation Categories**: Different aspects of project-rule-parameters to validate
- **Section Requirements**: Mandatory sections for complete documentation
- **Format Standards**: Required formatting for consistency

## Detailed Reference

### Self-Documenting Header System

Each project-rule-parameter file must include a standardized header that explicitly defines its relationship to message-commands:

```
# workflow: [workflow-type] | pathway: [pathway-name] | message-command: [message-command] | standard-parameter(s): [standard-parameter] | project-rule-parameter-filepath: [project-rule-parameter-filepath]
```

This header must include:
- **[workflow-type]**: The workflow type this parameter is designed for
- **[pathway-name]**: The specific use-case pathway
- **[message-command]**: The associated message-command
- **[standard-parameter]**: Required standard parameters
- **[project-rule-parameter-filepath]**: Full path to the parameter file

### Required Project-Rule-Parameter Sections

Each project-rule-parameter must contain these sections:

1. **Purpose**: What the project-rule-parameter is for
2. **Command Format**: Syntax and parameters
3. **Required Context**: What context is needed
4. **Process Steps**: Step-by-step execution instructions
5. **Tool Calls**: Specific tool call examples
6. **Expected Outputs**: What results to expect
7. **Error Handling**: How to handle common issues

### Project-Rule-Parameter Format Standards

Project-rule-parameters must follow these format standards:

1. **File Naming**: kebab-case matching message-command name (e.g., `verify-planning.md`)
2. **Path Structure**: Located in `parameters/rules` directory
3. **Reference Format**: `@parameters/rules/verify-planning.mdc` (note .mdc extension in references)
4. **Backtick Protection**: All references must be wrapped in backticks

### Audit Documentation Standards

The audit process must generate these documents:

1. **Audit Report**: Summary of findings and recommendations
2. **Consistency Matrix**: Analysis of format consistency
3. **Coverage Report**: Message-command to project-rule-parameter mapping
4. **Action Items**: Required changes and enhancements

## Examples

### Example Valid Header

```
# workflow: rules-workflow | pathway: audit | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-path: parameters/rules/plan-mode/rules-audit-process.mdc
```

### Example Valid Reference

When referencing this project-rule-parameter in a conversation:

```
plan-mode: rules-workflow @parameters/rules/plan-mode/rules-audit-process.mdc
```

### Example Audit Report Format

```
# Rules Audit Report - Q2 2023

## Summary
- 47 project-rule-parameters audited
- 45 headers verified
- 2 project-rule-parameters missing proper headers
- 12 format inconsistencies identified

## Critical Issues

1. Missing headers:
   - `parameters/rules/helpers/analysis/analyze-logs.md` - no header found
   - `parameters/rules/helpers/verification/verify-implementation.md` - no header found
   
2. Inconsistent headers:
   - 4 headers missing pathway component
   - 3 headers with incorrect workflow type
   - 2 headers with mismatched message-command vs. filename

## Format Issues

1. Inconsistent paths in headers:
   - 5 project-rule-parameter-paths don't match actual file location
   - 3 project-rule-parameter-paths use `.md` instead of `.mdc` extension
   
2. Header formatting:
   - 4 headers not using standardized separator format with pipe symbol

## Content Issues

1. Missing sections:
   - 3 project-rule-parameters missing Error Handling section
   - 2 project-rule-parameters missing Expected Outputs section

## Recommended Actions

1. Add standardized headers to project-rule-parameters missing them
2. Correct inconsistent header components
3. Standardize project-rule-parameter-paths in headers
4. Fix header formatting issues
5. Add missing sections to incomplete project-rule-parameters
```

## Related Components

- [Audit Procedures Guide](/knowledge/rules/guides/audit-procedures.md)
- [Audit Implementation Patterns](/knowledge/rules/patterns/impl/audit-implementation.md)
- [Audit Reporting Templates](/knowledge/rules/patterns/doc/audit-reporting.md)
- [File Standards Reference](/knowledge/rules/reference/guides/file-standards.md)

## Conclusion

These validation criteria ensure consistency and completeness across all project-rule-parameters in the 1000xbrain cognitive architecture. Adhering to these standards prevents AI hallucinations, maintains architectural integrity, and ensures reliable functionality of the message-command system. 