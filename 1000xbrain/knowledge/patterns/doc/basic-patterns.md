# USE WHEN creating documentation, implementing documentation standards, or organizing knowledge content

# Basic Documentation Patterns

## Overview

This document provides fundamental patterns for effective documentation in the 1000xbrain cognitive architecture. These patterns represent the core approach to creating, structuring, and organizing documentation across different contexts.

## Pattern: Clear Structure Documentation Pattern

### Overview
Pattern for creating documentation with a clear, consistent structure.

### Context
Use this pattern when creating any type of documentation to ensure clarity and consistency.

### Pattern Structure

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│           Clear Structure Documentation Pattern         │
│                                                        │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐     │
│  │           │     │           │     │           │     │
│  │ Define    │     │ Organize  │     │ Maintain  │     │
│  │ Sections  │────▶│ Content   │────▶│ Consistent│     │
│  │           │     │ Hierarchy │     │ Structure  │     │
│  └───────────┘     └───────────┘     └───────────┘     │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Implementation Guide

1. **Define Sections**:
   - Identify the key sections needed for the documentation
   - Include standard sections (Overview, Purpose, Implementation, etc.)
   - Tailor sections to the specific documentation type

2. **Organize Content Hierarchy**:
   - Use consistent header levels (H1, H2, H3, etc.)
   - Ensure logical progression from general to specific
   - Group related information together

3. **Maintain Consistent Structure**:
   - Apply the same structure across similar documentation
   - Use consistent formatting and styling
   - Ensure predictable information flow

### Examples

```markdown
# Component Name

## Overview
Brief description of the component's purpose and function.

## Core Concepts
Key concepts necessary to understand the component.

## Implementation Guide
Step-by-step instructions for implementing or using the component.

## Examples
Practical examples showing the component in use.

## Related Components
Links to related components or documentation.
```

### Related Patterns
- [Information Density Pattern](#pattern-information-density-pattern)
- [Visual Aid Pattern](visual-aid.md)

## Pattern: Information Density Pattern

### Overview
Pattern for optimizing the information density in documentation.

### Context
Use this pattern to create documentation that maximizes information value while minimizing content volume.

### Pattern Structure

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│               Information Density Pattern               │
│                                                        │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐     │
│  │           │     │           │     │           │     │
│  │ Prioritize│     │ Optimize  │     │ Use       │     │
│  │ Essential │────▶│ Expression│────▶│ Visual    │     │
│  │ Content   │     │           │     │ Elements  │     │
│  └───────────┘     └───────────┘     └───────────┘     │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Implementation Guide

1. **Prioritize Essential Content**:
   - Identify the most important information to convey
   - Eliminate unnecessary background or context
   - Focus on actionable information

2. **Optimize Expression**:
   - Use concise, direct language
   - Avoid redundancy and verbosity
   - Employ bullet points and lists for clarity

3. **Use Visual Elements**:
   - Employ tables for structured information
   - Use diagrams for complex relationships
   - Implement code blocks for implementation examples

### Examples

**Low Density:**
```markdown
The message-command system is a very important part of the cognitive architecture. It allows for communication between the human user and the AI assistant. When the user wants to communicate with the assistant, they can use a message-command. Message-commands are special commands that have specific formatting. They always use lowercase and kebab-case formatting. They include a colon before any parameters.
```

**High Density:**
```markdown
## message-command System

- **Purpose**: Enables structured communication between user and AI
- **Format**: `message-command: parameter1 parameter2`
- **Rules**:
  - Always lowercase
  - Always kebab-case
  - Includes colon before parameters
```

### Related Patterns
- [Clear Structure Documentation Pattern](#pattern-clear-structure-documentation-pattern)
- [Example Pattern](example.md)

## Pattern: Cross-Reference Documentation Pattern

### Overview
Pattern for creating effective cross-references between related documentation.

### Context
Use this pattern to connect related information across different documentation files.

### Pattern Structure

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│           Cross-Reference Documentation Pattern         │
│                                                        │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐     │
│  │           │     │           │     │           │     │
│  │ Identify  │     │ Create    │     │ Maintain  │     │
│  │ Related   │────▶│ Explicit  │────▶│ Reference │     │
│  │ Content   │     │ Links     │     │ Integrity │     │
│  └───────────┘     └───────────┘     └───────────┘     │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Implementation Guide

1. **Identify Related Content**:
   - Determine which other documentation is related
   - Categorize relationships (prerequisite, alternative, extension, etc.)
   - Prioritize the most important relationships

2. **Create Explicit Links**:
   - Use clear, descriptive link text
   - Provide context for why the link is relevant
   - Group related links together

3. **Maintain Reference Integrity**:
   - Ensure links remain valid when content changes
   - Update cross-references when documentation is modified
   - Verify bidirectional references where appropriate

### Examples

```markdown
## Related Knowledge

- [Tool Knowledge Domain](../../reference/domains/tool.md): Provides comprehensive information about available tools
- [Implementation Patterns](../impl/basic-patterns.md): Contains patterns for implementing the concepts described here
- [Quick Reference Guide](../../reference/guides/quick-reference.md): Offers a condensed reference for rapid lookup
```

### Related Patterns
- [Related Knowledge Section Pattern](related-knowledge.md)
- [Documentation Navigation Pattern](navigation.md)

## Pattern: Example Documentation Pattern

### Overview
Pattern for creating effective examples in documentation.

### Context
Use this pattern when including examples to illustrate concepts or implementation approaches.

### Pattern Structure

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│              Example Documentation Pattern              │
│                                                        │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐     │
│  │           │     │           │     │           │     │
│  │ Provide   │     │ Show      │     │ Explain   │     │
│  │ Context   │────▶│ Complete  │────▶│ Key       │     │
│  │           │     │ Example   │     │ Points    │     │
│  └───────────┘     └───────────┘     └───────────┘     │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Implementation Guide

1. **Provide Context**:
   - Explain when and why to use the example
   - Identify the problem the example solves
   - Set any necessary prerequisites

2. **Show Complete Example**:
   - Provide a fully functional example
   - Use realistic variable names and data
   - Follow best practices in the example itself

3. **Explain Key Points**:
   - Highlight the most important aspects
   - Explain non-obvious decisions
   - Connect example back to concepts

### Examples

```markdown
### Example: User Authentication Implementation

**Context:** This example shows how to implement user authentication using the authentication service.

**Complete Example:**
```typescript
// AUTHENTICATION IMPLEMENTATION
const authService = new AuthenticationService();

// 1. Configure authentication options
const authOptions = {
  tokenExpiration: '24h',
  refreshTokenEnabled: true,
  maximumAttempts: 5
};

// 2. Initialize authentication
authService.initialize(authOptions);

// 3. Add authentication middleware
app.use('/api', authService.createAuthMiddleware());

// 4. Implement login endpoint
app.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const authResult = await authService.authenticate(email, password);
    
    if (authResult.success) {
      res.json({
        success: true,
        token: authResult.token,
        refreshToken: authResult.refreshToken
      });
    } else {
      res.status(401).json({
        success: false,
        message: authResult.message
      });
    }
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Authentication error'
    });
  }
});
```

**Key Points:**
- Authentication service is initialized with specific options
- Middleware is applied to protect API routes
- Login endpoint handles both successful and failed authentication
- Error handling is implemented for unexpected errors
```

### Related Patterns
- [Information Density Pattern](#pattern-information-density-pattern)
- [Progressive Disclosure Pattern](progressive-disclosure.md)

## Pattern: Visual Aid Documentation Pattern

### Overview
Pattern for incorporating effective visual aids in documentation.

### Context
Use this pattern when complex concepts or relationships need visual representation.

### Pattern Structure

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│             Visual Aid Documentation Pattern            │
│                                                        │
│  ┌───────────┐     ┌───────────┐     ┌───────────┐     │
│  │           │     │           │     │           │     │
│  │ Select    │     │ Create    │     │ Integrate │     │
│  │ Appropriate│────▶│ Clear     │────▶│ with      │     │
│  │ Visual Type│     │ Visual    │     │ Text      │     │
│  └───────────┘     └───────────┘     └───────────┘     │
│                                                        │
└────────────────────────────────────────────────────────┘
```

### Implementation Guide

1. **Select Appropriate Visual Type**:
   - Choose the right visual format (diagram, table, flowchart, etc.)
   - Match visual complexity to concept complexity
   - Consider the documentation medium

2. **Create Clear Visual**:
   - Design for immediate comprehension
   - Use consistent visual language
   - Label important elements

3. **Integrate with Text**:
   - Reference the visual in the text
   - Explain what the visual illustrates
   - Place visual near relevant text

### Examples

**Relationship Diagram:**
```
┌────────────────────────────────────────────┐
│                                            │
│           Component Relationships           │
│                                            │
│  ┌──────────┐          ┌──────────┐        │
│  │          │          │          │        │
│  │  Auth    │◄─────────┤  User    │        │
│  │ Service  │          │ Service  │        │
│  │          │          │          │        │
│  └──────────┘          └──────────┘        │
│       ▲                      ▲             │
│       │                      │             │
│       │                      │             │
│       │                      │             │
│       │                      │             │
│  ┌──────────┐          ┌──────────┐        │
│  │          │          │          │        │
│  │  Token   │◄─────────┤ Profile  │        │
│  │ Service  │          │ Service  │        │
│  │          │          │          │        │
│  └──────────┘          └──────────┘        │
│                                            │
└────────────────────────────────────────────┘
```

**Process Flowchart:**
```
┌─────────────────────────────────────────────────────┐
│                                                     │
│                Authentication Flow                  │
│                                                     │
│  ┌─────────┐     ┌─────────┐     ┌─────────┐       │
│  │         │     │         │     │         │       │
│  │ Validate│────▶│ Generate│────▶│ Return  │       │
│  │ Credentials │  │ Token   │     │ Response│       │
│  │         │     │         │     │         │       │
│  └─────────┘     └─────────┘     └─────────┘       │
│       │                                            │
│       │ Invalid                                    │
│       ▼                                            │
│  ┌─────────┐                                       │
│  │         │                                       │
│  │ Handle  │                                       │
│  │ Error   │                                       │
│  │         │                                       │
│  └─────────┘                                       │
│                                                     │
└─────────────────────────────────────────────────────┘
```

### Related Patterns
- [Information Density Pattern](#pattern-information-density-pattern)
- [Clear Structure Documentation Pattern](#pattern-clear-structure-documentation-pattern)

## Related Knowledge

- [Meta Knowledge Domain](../../reference/domains/meta.md): Comprehensive documentation knowledge
- [Tool Documentation](../tool/documentation.md): Patterns for documenting tools
- [Documentation Standards](../../reference/guides/documentation-standards.md): Standards for documentation 