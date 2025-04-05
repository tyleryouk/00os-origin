# Message Command Prompt Component

## Overview

The prompt component is an optional addition to plan-mode and dev-mode message-commands that allows providing additional guidance or context while maintaining the current mode. This feature enables more direct communication without the need to switch to direct-mode for minor adjustments.

## Purpose and Benefits

The prompt component addresses several important needs:

1. **Mode Persistence**: Allows providing guidance without switching to direct-mode
2. **Context Preservation**: Maintains existing context and workflow
3. **Implementation Guidance**: Provides specific direction for current tasks
4. **Hallucination Prevention**: Reduces context switching that can lead to hallucinations
5. **Workflow Efficiency**: Streamlines communication within established workflows

## Syntax and Format

The prompt component follows a specific format:

```
plan-mode workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)
prompt: Your additional guidance or instructions here
```

Key format requirements:

1. **Newline Requirement**: Must begin on a new line after the standard components
2. **Prefix Requirement**: Must start with "prompt:" followed by a space
3. **Content Freedom**: No special formatting required for content
4. **Multiline Support**: Can span multiple lines if needed

## Usage Examples

### Basic Example

```
plan-mode rules-workflow system-wide-optimization @parameters/rules/plan-mode/system-wide-optimization.mdc none
prompt: Focus on improving the message-command parsing logic first, as it has the highest impact.
```

### With Specific Implementation Guidance

```
dev-mode front-end-workflow component-implementation @parameters/front-end/dev-mode/component-implementation.mdc button
prompt: Make sure to implement keyboard navigation and focus states. The component should be fully accessible.
```

### With Additional Context

```
plan-mode back-end-workflow api-design @parameters/back-end/plan-mode/api-design.mdc authentication
prompt: Our team has decided to use JWT tokens with a 24-hour expiration. Please incorporate this into the design.
```

### With Multiple Lines

```
dev-mode rules-workflow system-wide-optimization @parameters/rules/dev-mode/system-wide-optimization.mdc none
prompt: Focus on these key areas:
1. Message-command parsing efficiency
2. Project-rule-parameter handling
3. Mode transition logic
```

## Processing Behavior

When a message-command includes a prompt component:

1. **Standard Processing**: The five standard components are processed normally
2. **Additional Context**: The prompt content is processed as additional guidance
3. **Mode Preservation**: The current mode and workflow remain unchanged
4. **Contextual Integration**: Prompt guidance is integrated with project-rule-parameter guidance
5. **Temporary Effect**: Prompt is relevant only for the current message-command

## When to Use Prompts

The prompt component is particularly useful in these scenarios:

1. **Implementation Adjustments**: When you need to adjust the focus of implementation
2. **Clarifications**: When providing clarification about requirements
3. **Contextual Information**: When adding relevant information for the current task
4. **Emphasis**: When emphasizing specific aspects of the project-rule-parameter
5. **Constraint Addition**: When adding constraints or requirements not in the project-rule-parameter

## When Not to Use Prompts

The prompt component is not a replacement for:

1. **Major Direction Changes**: Use direct-mode for significant changes in direction
2. **New Tasks**: Use a new message-command for entirely new tasks
3. **Mode Transitions**: Use appropriate message-commands for switching modes
4. **Project-Rule-Parameters**: Don't use prompts to replace project-rule-parameters
5. **Long-Term Requirements**: Don't use prompts for permanent requirements (update project-rule-parameters instead)

## Best Practices

For effective use of the prompt component:

1. **Conciseness**: Keep prompts focused and concise
2. **Specificity**: Be specific about what guidance you're providing
3. **Context-Awareness**: Ensure prompts align with the current context
4. **Supplement Not Replace**: Use prompts to supplement project-rule-parameters, not replace them
5. **One Purpose Per Prompt**: Focus each prompt on a single purpose or guidance
6. **Clear Language**: Use clear, unambiguous language in prompts

## Prompt vs. Direct-Mode

Understanding when to use prompts versus switching to direct-mode:

| Scenario | Use Prompt When | Use Direct-Mode When |
|----------|----------------|---------------------|
| Adjusting Implementation | Minor adjustments needed | Major redirection required |
| Providing Context | Adding relevant information | Completely changing context |
| Clarifying Requirements | Minor clarifications | Substantial requirement changes |
| Task Scope | Within current task boundaries | Shifting to a new task |
| Duration | Short-term guidance | Long-term direction change |

## Implementation Notes

The prompt component is implemented through modifications to:

1. **Message Command Parsing**: Updated to recognize and process the prompt component
2. **Mode System Integration**: Maintains current mode while processing prompts
3. **Context Management**: Integrates prompt guidance into the current context
4. **Project-Rule-Parameter Interaction**: Supplements project-rule-parameters without overriding

## Conclusion

The prompt component enhances the message-command system by allowing more flexible guidance while maintaining mode stability and context preservation. By reducing unnecessary mode switching, it helps prevent hallucinations and improves workflow efficiency. 