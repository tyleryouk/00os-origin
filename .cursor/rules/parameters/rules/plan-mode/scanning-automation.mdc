# workflow: rules-workflow | pathway: scanning | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/plan-mode/scanning-automation.mdc

## File Purpose and Relationship

This file defines the operation of the `plan-mode: rules-workflow @parameters/rules/plan-mode/scanning-automation.mdc` message-command, which initializes planning mode with a focus on scanning automation planning. It should be consulted to understand:

- How to plan scanning automation processes
- Tool call sequences for scanning implementation
- Error resolution strategies for scanning issues
- Output interpretation for scanning results

This file complements:
- `@parameters/rules/dev-mode/scanning-automation.mdc`: Implementation of scanning automation
- `@parameters/rules/plan-mode/system-wide.mdc`: System-wide planning capabilities
- `@parameters/rules/direct-mode/check-extension-format.mdc`: Related extension checking functionality

## Usage as Project-Rule-Parameter

This file contains specialized knowledge access for scanning automation. It should be referenced as a project-rule-parameter when planning scanning automation:

```
plan-mode: rules-workflow @parameters/rules/plan-mode/scanning-automation.mdc
```

For other enhancement pathways, see the alternative pathway-specific project-rule-parameters in `@parameters/rules/plan-mode/`.

## Knowledge Access

When planning scanning automation, use the `fetch_rules` tool to access specialized knowledge:

```typescript
// Access scanning automation patterns
fetch_rules(["knowledge/rules/patterns/impl/scanning-automation-patterns"], 
           "Understanding scanning automation patterns and implementation")

// Access implementation approaches
fetch_rules(["knowledge/rules/patterns/impl/scanning-implementation"], 
           "Understanding scanning implementation approach and integration points")

// Access error resolution strategies
fetch_rules(["knowledge/rules/guides/scanning-error-resolution"], 
           "Understanding scanning error resolution approaches and fixes")

// Access output interpretation guides
fetch_rules(["knowledge/rules/reference/scanning-output-reference"], 
           "Viewing example scanning outputs and interpretation guides")
```

## Planning Approach

When planning scanning automation implementations, follow these key principles:

### Phase 1: Requirement Analysis
1. **Consistency**: Define required format consistency standards
2. **Accuracy**: Establish reference format requirements
3. **Backtick Safety**: Document @ symbol protection requirements
4. **Validation**: Plan systematic verification approaches

### Phase 2: Implementation Planning
1. **Script Design**: Plan automation script architecture
2. **Integration Points**: Identify workflow integration points
3. **Reporting Format**: Design reporting structure and formats
4. **Error Handling**: Plan error identification and resolution approaches

### Phase 3: Deployment Strategy
1. **Implementation Phases**: Define phased implementation approach
2. **Testing Strategy**: Plan testing methodology
3. **Production Requirements**: Document deployment requirements
4. **Maintenance Plan**: Establish regular scanning procedures

## Tool Call Sequences

For efficient scanning automation planning, use these tool call sequences:

```typescript
// Analyze current reference patterns
grep_search("@parameters/rules/[a-z0-9-]+\\.[a-z]+", false, "1000xbrain/**/*.md")

// Check for unwrapped @ symbols
grep_search("@[^`]", false, "1000xbrain/**/*.md")

// Check file organization
list_dir("1000xbrain/parameters/rules")
list_dir("1000xbrain/knowledge/rules")

// Analyze existing patterns
read_file("1000xbrain/workflows/rules/scanning-automation.md", should_read_entire_file=true)
```

## Error Resolution

When planning error resolution strategies for scanning issues, consider these approaches:

1. **Format Errors**: Plan automatic correction of incorrect reference formats
2. **Missing Backticks**: Design solutions for adding proper backtick wrapping
3. **Extension Issues**: Create strategies for fixing .md vs .mdc extension problems
4. **Path Problems**: Develop approaches for resolving incorrect path references

## Example Usage

```
plan-mode: rules-workflow @parameters/rules/plan-mode/scanning-automation.mdc

prompt: I need to plan an automated scanning system for project-rule-parameter references
```

This will initiate Planning Mode focused on scanning automation planning, providing access to specialized knowledge components and implementation guidance. 