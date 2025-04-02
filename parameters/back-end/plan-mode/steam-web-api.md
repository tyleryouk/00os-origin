# workflow: back-end-workflow | pathway: back-end | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/back-end/plan-mode/steam-web-api.md

## Overview

This project-rule-parameter provides structured guidance for planning Steam Web API integration in the back-end system. It ensures comprehensive documentation, proper separation of concerns, and maintains clear boundaries between Steam authentication and crypto-based systems.

## Implementation Process

### 1. Pre-Planning Validation

1. **Verify Domain Boundaries**:
   - Confirm Steam auth vs crypto auth separation
   - Validate authentication scope
   - Document system boundaries
   - Establish clear interfaces

2. **Planning Requirements**:
   - Identify core authentication components
   - Validate security requirements
   - Verify API endpoint needs
   - Check monitoring requirements

3. **Documentation Structure**:
   - Create planning folder structure
   - Establish document templates
   - Define section requirements
   - Prepare validation framework

### 2. Planning Implementation

1. **Requirements Documentation**:
   - Document authentication flow
   - Define security measures
   - Specify API endpoints
   - Detail error handling

2. **Implementation Planning**:
   - Create file structure plan
   - Document database schema
   - Define service components
   - Plan monitoring system

3. **Testing Strategy**:
   - Define test scenarios
   - Create test cheatsheet
   - Plan security testing
   - Document monitoring tests

### 3. Post-Planning Validation

1. **Structure Validation**:
   ```typescript
   // Validate planning structure
   validatePlanningStructure(planningPath)
   
   // Verify document completeness
   validateDocuments(planningPath)
   
   // Check reference integrity
   validateReferences(planningPath)
   ```

2. **Content Validation**:
   - Verify requirements completeness
   - Check implementation details
   - Validate test coverage
   - Ensure monitoring completeness

3. **Integration Verification**:
   - Test planning coherence
   - Verify system boundaries
   - Check component relationships
   - Validate security measures

## Tool Usage Guidelines

### Planning Mode Commands

```markdown
plan-mode: back-end-workflow
prompt: create planning documentation for Steam Web API integration with:
- Requirements documentation
- Implementation plan
- Test cheatsheet
```

### Required Tool Calls

1. **File Creation**:
   ```typescript
   // Create requirements.md
   edit_file("planning/90-steam-auth/requirements.md")
   
   // Create implementation.md
   edit_file("planning/90-steam-auth/implementation.md")
   
   // Create test-cheatsheet.md
   edit_file("planning/90-steam-auth/test-cheatsheet.md")
   ```

2. **Content Verification**:
   ```typescript
   // Verify file contents
   read_file("planning/90-steam-auth/requirements.md")
   read_file("planning/90-steam-auth/implementation.md")
   read_file("planning/90-steam-auth/test-cheatsheet.md")
   ```

## Success Criteria

1. **Documentation Completeness**:
   - Requirements fully documented
   - Implementation plan detailed
   - Test scenarios comprehensive
   - Security measures specified

2. **System Boundaries**:
   - Clear Steam/crypto separation
   - Well-defined interfaces
   - Explicit authentication scope
   - Proper security isolation

3. **Planning Quality**:
   - Coherent documentation
   - Complete test coverage
   - Comprehensive monitoring
   - Clear error handling

## Error Handling

| Issue | Solution |
|----|----|
| Incomplete requirements | Review and complete missing sections |
| Unclear boundaries | Clarify system separation and interfaces |
| Missing test scenarios | Add comprehensive test cases |
| Insufficient security | Enhance security measures documentation |
| Monitoring gaps | Add detailed monitoring requirements |
| Implementation holes | Complete implementation planning |
| Reference issues | Update and verify references |
| Structure problems | Correct document structure |

## Related Knowledge Components

Access these components for additional guidance:

```typescript
fetch_rules([
  "knowledge/back-end/steam-web-api/authentication",
  "knowledge/back-end/steam-web-api/security",
  "knowledge/rules/back-end-steam-web-api/best-practices"
], "Accessing Steam Web API integration guidance")
``` 