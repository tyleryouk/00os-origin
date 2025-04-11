# Directive System

This knowledge file documents the directive system implemented for cycle management, providing details on available directives and their proper usage.

## Overview

The directive system provides a standardized way to specify:
1. The type of action to be performed (via the `# Directive:` field)
2. The specific cycle to be targeted (via the `# Target Cycle:` field)
3. A brief descriptive name (via the `# Enhancement Name:` field)
4. The priority level (via the `# Priority:` field)

This system improves clarity in user requests and enables more automated processing of cycle-related tasks.

## Available Directives

### Core Directives

| Directive | Purpose | Example Usage |
|-----------|---------|---------------|
| **Enhancement** | Request a new feature or improvement | `# Directive: Enhancement` |
| **Fix** | Request a correction for a problem | `# Directive: Fix` |
| **Refactor** | Request restructuring of existing functionality | `# Directive: Refactor` |
| **Analysis** | Request analysis of a cycle or component | `# Directive: Analysis` |

### When to Use Each Directive

* **Enhancement**: When new capabilities or improvements are needed
  * Example: "Add directive validation to requirement-analysis-process.md"
  * Example: "Improve template formatting in notes.md"
  * Best for: New features, extending existing functionality, performance improvements
  * Key focus: Value addition, feature integration, user experience

* **Fix**: When something is broken or not working as expected
  * Example: "Fix error in cycle-analysis-process.md when analyzing cycle-manager"
  * Example: "Fix incorrect template instructions in notes.md"
  * Best for: Error correction, bug fixing, addressing issues
  * Key focus: Root cause analysis, regression prevention, stability

* **Refactor**: When existing functionality works but needs restructuring
  * Example: "Refactor process files to reduce redundancy"
  * Example: "Reorganize knowledge file structure for better clarity"
  * Best for: Code organization, reducing complexity, improving maintainability
  * Key focus: Maintaining functionality while improving structure, technical debt reduction

* **Analysis**: When assessment or evaluation is needed without necessarily making changes
  * Example: "Analyze process efficiency in cycle-manager"
  * Example: "Evaluate directive system implementation"
  * Best for: Performance evaluation, system assessment, feature exploration
  * Key focus: Thorough examination without implementation bias, data collection

## Target Cycle Specification

The `# Target Cycle:` field accepts cycle identifiers in the format `domain/cycle-name`:

* Domain can be: `system`, `frontend`, or `backend`
* Cycle name is the name of the cycle folder within that domain

Examples:
* `# Target Cycle: system/autonomous`
* `# Target Cycle: system/cycle-manager`
* `# Target Cycle: system/major-changes`

To view all available cycles, users can run:
```
1000xscripts/system/list-cycles.ps1
```

## Enhancement Name and Priority Fields

### Enhancement Name
The `# Enhancement Name:` field should provide a brief, descriptive title for the request:
* Be concise but clear (typically 3-8 words)
* Focus on the primary purpose
* Use action verbs when possible

Examples:
* "Directive System Implementation"
* "Template Format Optimization"
* "Process File Validation Enhancement"

### Priority
The `# Priority:` field accepts one of three values:
* `High`: Urgent or critical changes that should be implemented immediately
* `Medium`: Important changes that should be addressed soon but aren't urgent
* `Low`: Desirable changes that can be deferred if necessary

## Full Directive Format Example

```
# Directive: Enhancement
# Target Cycle: system/cycle-manager
# Enhancement Name: Validation System Implementation
# Priority: High

# Enhancement Details
Implement a comprehensive validation system for cycle-manager processes including:
1. Input validation for all process steps
2. Output validation for critical operations
3. Error handling enhancements
```

## Directive System Implementation

The directive system is implemented through:

1. **Parsing Logic**: The `requirement-analysis-process.md` file contains logic to parse and process the directive fields, including validation of values.

2. **Self-Analysis**: The `cycle-analysis-process.md` file includes specific checks for analyzing the cycle-manager itself, including verification of directive handling.

3. **Cycle Listing**: The `list-cycles.ps1` script provides dynamic discovery of available cycles.

4. **Template Updates**: The USER REQUEST SECTION template in `notes.md` includes clear guidance on directive specification.

## Usage Guidelines

1. **Be Specific**: Choose the most specific directive that matches your intent
2. **Provide Context**: Include clear details about what needs to be done
3. **Specify Target**: Always include the target cycle to be modified
4. **Use Consistent Formatting**: Follow the template format exactly
5. **Set Appropriate Priority**: Assign priority based on urgency and impact
6. **Be Descriptive**: Use clear enhancement names that indicate the purpose

## Benefits

The directive system provides several key benefits:

1. **Clarity**: Explicit specification of intent and target
2. **Automation**: Easier parsing and handling of user requests
3. **Standardization**: Consistent format for all change requests
4. **Discoverability**: Easy to find available cycles and directives
5. **Self-Documentation**: Requests document their own purpose and scope
6. **Process Efficiency**: Streamlined analysis and implementation
7. **Traceability**: Better tracking of changes through the lifecycle

## Integration with Cycle Analysis

The directive system integrates with cycle analysis, allowing for:
1. Directive-specific analysis approaches
2. Targeted verification based on directive type
3. Appropriate success criteria based on directive intent
4. Tailored implementation strategies for each directive type

## Directive-Based Decision Making

Different directives lead to different implementation strategies:

| Directive | Analysis Focus | Implementation Approach | Verification Strategy |
|-----------|---------------|------------------------|------------------------|
| Enhancement | Feature integration, value addition | Progressive implementation, feature testing | Feature validation, user experience testing |
| Fix | Root cause analysis, regression prevention | Targeted correction, regression testing | Error absence, stability testing |
| Refactor | Structure improvement, maintainability | Incremental restructuring, behavior preservation | Functional equivalence testing |
| Analysis | Comprehensive examination, data collection | Information gathering, assessment | Accuracy verification, completeness check | 