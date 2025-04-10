# Rules Development Process

## Overview

This document outlines the comprehensive process for developing new rules within the 1000xbrain cognitive architecture. It provides a structured approach to ensure that new rules are consistent, effective, and well-integrated with the existing system.

## Development Workflow

### 1. Needs Analysis

The first phase involves identifying and analyzing the need for a new rule:

- **Need Identification**: Recognize a gap or opportunity in the current rules system
- **Use Case Analysis**: Define specific use cases for the new rule
- **Impact Assessment**: Evaluate the potential impact on the overall system
- **Priority Determination**: Assess the relative priority of the new rule

### 2. Architectural Planning

Once the need is established, plan how the rule will fit into the architecture:

- **Location Determination**: Identify the appropriate domain and location for the rule
- **Component Classification**: Determine if the rule is core identity, communication, or domain-specific
- **Dependency Mapping**: Identify dependencies on other rules or knowledge components
- **Integration Planning**: Plan how the rule will integrate with existing components

### 3. Content Development

Develop the actual content of the rule:

- **Structure Definition**: Define the structure following established patterns
- **Content Creation**: Write the rule content according to standards
- **Example Creation**: Include clear examples of how the rule is applied
- **Cross-Reference Addition**: Add appropriate cross-references to related rules

### 4. Implementation

Implement the rule in the appropriate location:

- **File Creation**: Create the rule file in the appropriate directory
- **Structure Adherence**: Follow established structural patterns
- **Formatting Consistency**: Maintain consistent formatting
- **Section Completeness**: Ensure all required sections are included

### 5. Validation

Validate the rule against established criteria:

- **Consistency Check**: Ensure consistency with existing rules
- **Standards Compliance**: Verify compliance with rules development standards
- **Use Case Testing**: Test the rule against identified use cases
- **Integration Verification**: Verify proper integration with related components

### 6. Documentation

Document the rule comprehensively:

- **Purpose Documentation**: Clearly document the rule's purpose
- **Usage Guidelines**: Provide clear guidelines for using the rule
- **Example Scenarios**: Include practical examples
- **Related Rules**: Document relationships to other rules

### 7. Activation

Activate the rule within the system:

- **Integration Verification**: Verify integration with the rules system
- **Synchronization**: Ensure synchronization with Cursor Rules
- **Announcement**: Document the new rule's availability
- **Monitoring**: Monitor initial usage and effectiveness

## Rule Types and Development Patterns

### Core Identity Rules

When developing core identity rules:

- **Essential Focus**: Focus on essential identity components
- **Clear Definitions**: Provide clear definitions of identity aspects
- **Role Clarity**: Clearly define roles and responsibilities
- **Enhancement Processes**: Include self-enhancement capabilities
- **Location**: Place in 1000xrules/core/identity/

### Communication Rules

When developing communication rules:

- **Standard Patterns**: Define standard communication patterns
- **Symbol Usage**: Document symbol usage guidelines
- **Format Specifications**: Specify required formats
- **Error Prevention**: Include error prevention guidelines
- **Location**: Place in 1000xrules/core/communication/

### Command Rules

When developing command rules:

- **Purpose Definition**: Clearly define the command's purpose
- **Tool Call Sequence**: Specify the tool call sequence
- **Parameter Standards**: Document parameter formats
- **Usage Examples**: Include clear usage examples
- **Location**: Place in 1000xrules/1000xcommands/(domain)/

### Domain Knowledge Rules

When developing domain knowledge rules:

- **Domain Specificity**: Ensure content is specific to the domain
- **Knowledge Organization**: Organize knowledge logically
- **Cross-Domain Integration**: Document integration with other domains
- **Practical Application**: Include practical application guidelines
- **Location**: Place in 1000xbrain/(domain)/knowledge/

## Development Standards

### File Structure Standards

All rule files should follow these structural standards:

1. **Header**: Start with a clear, descriptive header
2. **Overview**: Include a concise overview section
3. **Main Content**: Organize main content in logical sections
4. **Examples**: Include practical examples
5. **Integration**: Document integration with other components

### Formatting Standards

Maintain consistent formatting:

1. **Markdown Standards**: Follow established markdown standards
2. **Section Hierarchy**: Maintain clear section hierarchy with headers
3. **List Formatting**: Use consistent list formatting
4. **Code Block Usage**: Format code blocks appropriately
5. **Symbol Protection**: Properly protect symbols with backticks

### Content Standards

Content should meet these standards:

1. **Clarity**: Be clear and concise
2. **Completeness**: Cover the topic comprehensively
3. **Consistency**: Maintain consistency with existing rules
4. **Practicality**: Include practical application guidance
5. **Correctness**: Ensure all information is accurate

## Development Tools

### Tool Call Sequences

Standard tool call sequence for rule development:

```typescript
// 1. Understand existing patterns
read_file("similar-rule.md", should_read_entire_file=true)

// 2. Create new rule
edit_file("new-rule.md", "Create new rule", "# New Rule Content\n\n...")

// 3. Verify content
read_file("new-rule.md", should_read_entire_file=true)
```

### Pattern Analysis

Before creating a new rule, analyze existing patterns:

```typescript
// Analyze similar rules
codebase_search("similar rule pattern", ["1000xrules/core"])

// Understand domain-specific patterns
list_dir("1000xrules/core/communication")

// Check integration patterns
grep_search("related concept", false, "1000xrules/core/*.md")
```

## Integration with Other Processes

The rules development process integrates with:

1. **Command Development Process**: For developing related commands
2. **Rules Enhancement Process**: For enhancing existing rules
3. **Validation Process**: For validating new rules
4. **Synchronization Process**: For syncing rules to Cursor Rules

## Development Examples

### Core Identity Rule Development Example

```markdown
# Identity Component

## Overview

This document defines a core identity component for the 1000xdev cognitive architecture.

## Key Concepts

- Concept 1: Description
- Concept 2: Description
- Concept 3: Description

## Integration with Identity

How this component integrates with the overall identity.

## Implementation Guidelines

Guidelines for implementing this identity component.
```

### Command Rule Development Example

```markdown
# Command Name

list_dir("1000xbrain/domain/directory")

read_file("1000xbrain/domain/file.md", should_read_entire_file=true)

codebase_search("search query", ["1000xbrain/domain"])

edit_file("1000xbrain/domain/file.md", "Description of edit", "# Content")
``` 