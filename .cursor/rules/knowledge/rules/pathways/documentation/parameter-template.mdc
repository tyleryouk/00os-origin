# Parameter Template

## Overview

This file provides a standardized template for creating project-rule-parameters in the 1000xbrain cognitive architecture. Using a consistent parameter format ensures that all parameters are structured the same way and immediately fetch relevant knowledge.

## Standard Parameter Format

Every project-rule-parameter should follow this standardized format:

```markdown
# mode: [mode] | workflow: [workflow-type] | pathway: [pathway-name] | filepath: @[filepath].mdc | optional-standard-parameter(s): [params]

## 1. Purpose

Brief description of this parameter's purpose and when it should be used.

## Knowledge Access

```typescript
// Access essential knowledge components immediately
fetch_rules(["knowledge/rules/pathways/pathway-name/component-1"], 
           "Primary knowledge for this parameter")
fetch_rules(["knowledge/rules/pathways/pathway-name/component-2"], 
           "Secondary knowledge for this parameter")
```

## 2. Core Command Operation

When the `[mode] [workflow-type] [pathway-name] @[filepath].mdc [params]` message-command is received, 1000xdev will:

1. **Initialize [Mode] Mode**: Enter or remain in [Mode] Mode with the [emoji] 1000xdev [workflow-type] indicator
2. **Access Essential Knowledge**: Fetch required knowledge components through fetch_rules
3. **Execute Primary Function**: [Description of primary function]
4. **Verify Outcomes**: [Description of verification steps]

## 3. Implementation Structure

### Phase 1: [Phase Name]
- Detailed implementation instructions for phase 1
- Tool call patterns for this phase
- Expected outcomes

### Phase 2: [Phase Name]
- Detailed implementation instructions for phase 2
- Tool call patterns for this phase
- Expected outcomes

## 4. Tool Call Sequences

```typescript
// Example tool call sequence for this parameter
// 1. First tool call
list_dir("[directory]")

// 2. Second tool call
read_file("[file]", should_read_entire_file=true)

// 3. Third tool call
edit_file("[file]",
          "[purpose]",
          "[content]")
```

## 5. Completion Criteria

The implementation is complete when:
1. [Completion criterion 1]
2. [Completion criterion 2]
3. [Completion criterion 3]

## 6. Error Handling

If errors are encountered during implementation:
1. [Error handling step 1]
2. [Error handling step 2]
3. [Error handling step 3]
```

## Component Descriptions

Each standardized parameter component serves a specific purpose:

1. **Header**: Contains metadata about the parameter, including mode, workflow-type, pathway-name, filepath, and optional parameters.
2. **Purpose**: Briefly describes the parameter's purpose and when it should be used.
3. **Knowledge Access**: Immediately fetches essential knowledge components for implementation.
4. **Core Command Operation**: Describes the high-level operation when the parameter is used.
5. **Implementation Structure**: Provides detailed implementation instructions organized by phase.
6. **Tool Call Sequences**: Shows example tool call sequences for implementation.
7. **Completion Criteria**: Defines when the implementation is considered complete.
8. **Error Handling**: Provides guidance for handling errors during implementation.

## Usage Guidelines

1. **Create the Header First**: Always start with the standardized header format.
2. **Fetch Essential Knowledge**: Include fetch_rules calls to immediately load relevant knowledge.
3. **Organize by Phases**: Structure the implementation into clear phases.
4. **Include Tool Call Examples**: Provide clear tool call patterns.
5. **Define Completion Criteria**: Clearly state when implementation is complete.
6. **Add Error Handling**: Include guidance for handling common errors.

## Example Parameter

Here's a simplified example of a parameter using this template:

```markdown
# mode: dev-mode | workflow: front-end-workflow | pathway: component-creation | filepath: @parameters/rules/dev-mode/component-creation.mdc | optional-standard-parameter(s): component-name

## 1. Purpose

This parameter guides the creation of a new React component in the front-end application, following best practices and established patterns.

## Knowledge Access

```typescript
// Access essential knowledge components immediately
fetch_rules(["knowledge/rules/pathways/development/react-components"], 
           "Understanding React component creation patterns")
fetch_rules(["knowledge/rules/pathways/development/typescript-patterns"], 
           "Understanding TypeScript patterns for component development")
```

## 2. Core Command Operation

When the `dev-mode front-end-workflow component-creation @parameters/rules/dev-mode/component-creation.mdc component-name` message-command is received, 1000xdev will:

1. **Initialize Developer Mode**: Enter or remain in Developer Mode with the 💻 1000xdev [front-end-workflow] indicator
2. **Access Essential Knowledge**: Fetch React component and TypeScript patterns
3. **Execute Component Creation**: Create a new React component with the specified name
4. **Verify Component**: Ensure the component follows best practices and established patterns

// Additional sections would follow...
``` 