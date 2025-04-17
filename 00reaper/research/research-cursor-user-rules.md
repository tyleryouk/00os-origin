# Cursor User Rules: Comprehensive Guide

## Overview

User Rules in Cursor are global AI instructions that apply across all projects. Unlike Project Rules, User Rules are not tied to specific codebases but instead define your personal preferences and coding style. They provide a consistent AI experience regardless of which project you're working on.

## Key Characteristics

- **Scope**: Global to your Cursor environment, applying to all projects
- **Location**: Defined in Cursor Settings
- **Format**: Plain text (does not use MDC format)
- **Persistence**: Stored as part of your user settings
- **Application**: Applied to both Chat and Cmd-K AI

## How User Rules Work

User Rules are always included in the AI's context, regardless of which project you're working on. They're applied before any Project Rules, establishing a baseline for how the AI should behave.

When the AI processes a request:
1. User Rules are loaded into the context
2. Project Rules (if any) are then loaded based on relevance
3. The AI responds according to the combined guidance

This layered approach allows for both personal preferences (via User Rules) and project-specific requirements (via Project Rules).

## Setting Up User Rules

To configure User Rules in Cursor:

1. Open Cursor Settings
2. Navigate to "General" > "Rules for AI"
3. Enter your custom instructions in the provided text area
4. Click "Save" to apply your global rules
5. Ensure "Include .cursorrules file" is enabled if you want project-specific rules to also apply

## Example User Rules

```
1. Code Style:
   - Write clean, readable code with meaningful variable names
   - Use 2-space indentation for all code
   - Add appropriate comments for complex logic
   - Follow standard conventions for the language in use

2. Communication Style:
   - Be concise and direct in explanations
   - Prioritize practical solutions over theoretical discussions
   - When suggesting improvements, explain the reasoning
   - Use code examples to illustrate concepts when relevant

3. Problem Solving:
   - Analyze issues thoroughly before proposing solutions
   - Consider edge cases and error handling
   - Prefer simple, maintainable solutions over clever tricks
   - Suggest performance optimizations when appropriate

4. Personal Preferences:
   - Use TypeScript over JavaScript where possible
   - Prefer functional programming patterns
   - Use async/await instead of callbacks or Promises
   - Implement comprehensive error handling
```

## Best Practices for User Rules

- **Focus on personal preferences**: Use User Rules for your coding style and preferences that apply across all projects
- **Keep them general**: Avoid project-specific details that would be better as Project Rules
- **Be consistent**: Ensure your User Rules don't contradict each other
- **Reasonable length**: While there's no strict limit, keep your User Rules concise enough to be effective
- **Update periodically**: Refine your rules as you discover how the AI responds to them
- **Complement Project Rules**: Design User Rules to work well with Project Rules rather than override them

## Use Cases for User Rules

### Setting Default Coding Style

```
- Use meaningful variable names that describe their purpose
- Prefer pure functions over functions with side effects
- Always use strict equality (===) over loose equality (==)
- Write defensive code that handles potential errors
```

### Defining Communication Preferences

```
- Provide concise explanations without unnecessary detail
- Use code examples to illustrate complex concepts
- When suggesting multiple options, list pros and cons
- Point out potential performance issues or edge cases
```

### Establishing Problem-Solving Approach

```
- Start by understanding the problem completely
- Consider the simplest solution first
- Analyze edge cases before finalizing a solution
- Think about maintainability and scalability
- Suggest tests that would verify the solution
```

## Advantages of User Rules

- **Consistency across projects**: Maintain a consistent AI interaction style regardless of which codebase you're working on
- **Personalization**: Tailor the AI's behavior to match your personal coding style and preferences
- **Efficiency**: Avoid repeating the same instructions across multiple projects
- **Quick setup**: Apply your preferences immediately to any new project without creating project-specific rules first

## Combining with Project Rules

User Rules and Project Rules work together in a complementary fashion:

1. User Rules establish your personal baseline preferences
2. Project Rules add project-specific requirements and conventions
3. When conflicts occur, Project Rules typically take precedence

This layered approach allows for flexible yet consistent AI behavior.

## Troubleshooting User Rules

If your User Rules aren't being applied as expected:

- Verify they're properly saved in Cursor Settings
- Check if they conflict with Project Rules (which may take precedence)
- Try restarting Cursor to ensure settings are refreshed
- Consider simplifying complex rules to ensure they're properly understood by the AI

## References

1. [Cursor Official Documentation: Rules](https://docs.cursor.com/context/rules)
2. [Cursor Rules: Customizing AI Behavior](https://cursor101.com/article/cursor-rules-customizing-ai-behavior)
