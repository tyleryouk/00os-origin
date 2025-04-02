# workflow: rules-workflow | pathway: audit | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-path: parameters/rules/plan-mode/rules-audit-process.mdc

## File Purpose and Relationship

This file defines the operation of the `plan-mode: rules-workflow @parameters/rules/plan-mode/rules-audit-process.mdc` message-command, which initializes planning mode with a focus on rules audit process planning. It should be consulted to understand:

- How to plan rules audit processes
- How to design audit validation criteria
- How to structure audit documentation
- How to create audit templates

## Usage as Project-Rule-Parameter

This file contains specialized knowledge access for rules audit planning. It should be referenced as a project-rule-parameter when planning rules audit processes:

```
plan-mode: rules-workflow @parameters/rules/plan-mode/rules-audit-process.mdc
```

## Knowledge Access

When planning rules audit processes, use the `fetch_rules` tool to access specialized knowledge:

```typescript
// Access audit procedures
fetch_rules(["knowledge/rules/guides/audit-procedures"], 
           "Understanding comprehensive audit procedures for planning")

// Access validation criteria
fetch_rules(["knowledge/rules/reference/audit-validation-criteria"], 
           "Understanding validation criteria for rules audits")

// Access implementation patterns
fetch_rules(["knowledge/rules/patterns/impl/audit-implementation"], 
           "Understanding implementation patterns for audit processes")

// Access reporting templates
fetch_rules(["knowledge/rules/patterns/doc/audit-reporting"], 
           "Understanding reporting templates for audit documentation")
```

## Planning Guidance

When planning a rules audit process, focus on these key areas:

1. **Audit Scope Definition**:
   - Determine which project-rule-parameters to audit
   - Define validation criteria and requirements
   - Establish reporting expectations
   - Set timeline and frequency

2. **Validation Criteria Planning**:
   - Define header validation requirements
   - Establish section requirements
   - Set format standards
   - Create validation checklist

3. **Documentation Planning**:
   - Design report template structure
   - Define action item tracking
   - Create consistency matrix format
   - Plan coverage reporting

4. **Implementation Planning**:
   - Design script architecture
   - Plan validation process
   - Structure report generation
   - Outline corrective action process

## Example Usage

```
plan-mode: rules-workflow @parameters/rules/plan-mode/rules-audit-process.mdc

prompt: I need to plan a comprehensive audit process for all project-rule-parameters to ensure they follow the new self-documenting header system
``` 