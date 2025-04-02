# USE WHEN implementing audit processes, executing audit procedures, or conducting rules audits

# Audit Procedures Guide

## Overview

This guide provides comprehensive procedures for auditing project-rule-parameters throughout the 1000xbrain cognitive architecture. It covers the structured approach to verifying consistency, completeness, and compliance with standards across all project-rule-parameters.

## Key Concepts

- **Self-Documenting Headers**: Headers that define relationships to message-commands
- **Audit Phases**: Structured approach to comprehensive auditing
- **Verification Points**: Specific aspects to check during audits
- **Documentation Standards**: Requirements for audit reporting

## Detailed Implementation

### Phase 1: Inventory Creation

1. **List All Project-Rule-Parameters**:
   ```bash
   find parameters/rules -name "*.md" -type f | sort > rules-inventory.txt
   ```

2. **Extract Headers from Project-Rule-Parameters**:
   ```bash
   # Extract the headers from all project-rule-parameter files
   grep -r "^# workflow:" --include="*.md" parameters/rules/ > parameter-headers.txt
   ```

3. **Map Workflows, Pathways, and Message-Commands**:
   ```bash
   # Create a mapping file showing the relationships defined in headers
   python scripts/map_headers_to_relationships.py
   ```

### Phase 2: Consistency Verification

1. **Header Check**:
   - Verify headers follow the standardized format
   - Check for all required components (workflow, pathway, message-command, etc.)
   - Validate consistency in header formatting

2. **Path Verification**:
   - Ensure all project-rule-parameters have correct paths in their headers
   - Verify project-rule-parameter-path matches actual file location

3. **Extension Check**:
   - Confirm all references use `.mdc` extension in the project-rule-parameter-path
   - Verify actual files use `.md` extension

### Phase 3: Alignment Analysis

1. **Workflow Coherence**:
   - Verify each project-rule-parameter is associated with the correct workflow
   - Ensure pathways are consistent with their workflows

2. **Message-Command Alignment**:
   - Verify the message-command in the header matches the file's purpose
   - Ensure consistency between the message-command and project-rule-parameter name

3. **Naming Alignment**:
   - Verify file names properly reflect the message-command they implement
   - Document exceptions and reasons

### Phase 4: Content Review

1. **Structure Verification**:
   - Verify each project-rule-parameter includes required sections
   - Check for consistency in section ordering

2. **Tool Call Verification**:
   - Validate tool call accuracy in each project-rule-parameter
   - Ensure proper function call format

3. **Workflow Alignment**:
   - Verify project-rule-parameters align with correct workflows
   - Check for cross-workflow consistency

### Audit Frequency

The audit process should be conducted:

1. **Quarterly**: Full comprehensive audit
2. **Monthly**: Quick verification audit
3. **After Major Updates**: Targeted audit of affected areas

### Corrective Action Process

When audit issues are identified:

1. **Document Issues**: Create detailed issue reports
2. **Prioritize Fixes**: Rank issues by impact and urgency
3. **Apply Standards**: Update to meet current standards
4. **Verify Changes**: Re-audit after changes
5. **Document Standards**: Update documentation with any new standards

## Examples

### Example Audit Checklist

#### For Each Project-Rule-Parameter:

1. **File exists**: `parameters/rules/verify-planning.md` exists
2. **Referenced correctly**: All references use `@parameters/rules/verify-planning.mdc` format
3. **Wrapped in backticks**: All references are properly protected
4. **Contains required sections**: All 7 required sections present
5. **Used by message-commands**: At least one message-command references it
6. **Naming matches**: File name matches message-command name

#### For Each Message-Command:

1. **Has project-rule-parameter**: `verify-planning:` has corresponding `@parameters/rules/verify-planning.mdc`
2. **Correct format**: Uses proper kebab-case format
3. **Includes colon**: Always has colon after command name
4. **Parameter format**: Parameters properly formatted

### Example Script Commands

```bash
# Find all project-rule-parameters
find parameters/rules -name "*.md" -type f | sort

# Check for missing headers
grep -L "^# workflow:" --include="*.md" parameters/rules/

# Find project-rule-parameters missing required sections
grep -L "## Error Handling" --include="*.md" parameters/rules/
```

## Related Components

- [Audit Validation Criteria](/knowledge/rules/reference/audit-validation-criteria.md)
- [Audit Implementation Patterns](/knowledge/rules/patterns/impl/audit-implementation.md)
- [Audit Reporting Templates](/knowledge/rules/patterns/doc/audit-reporting.md)
- [File Standards Guide](/knowledge/rules/reference/guides/file-standards.md)

## Conclusion

Following these structured audit procedures ensures that all project-rule-parameters maintain consistency, completeness, and compliance with standards. Regular audits are essential for maintaining the integrity of the 1000xbrain cognitive architecture and preventing AI hallucinations from inconsistent configurations. 