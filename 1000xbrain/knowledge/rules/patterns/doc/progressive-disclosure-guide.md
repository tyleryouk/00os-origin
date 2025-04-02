# USE WHEN structuring complex information progressively, organizing technical content from simple to complex, or implementing information architecture

# Progressive Disclosure Guide

## File Purpose and Relationship

This file provides standardized patterns for structuring information from simple to complex through progressive disclosure techniques. It establishes strategies for presenting information in a way that enhances readability, reduces cognitive load, and prevents information overload. It should be used when:

- Creating new documentation that contains complex information
- Restructuring existing documentation for clarity
- Organizing technical concepts for better understanding
- Implementing information architecture improvements

This file is part of the documentation patterns in the knowledge/rules/patterns/doc directory and complements the information-chunking-guide.md, hierarchical-relationship-guide.md, reference-architecture-guide.md, and standard-file-template.md.

## Progressive Disclosure Fundamentals

### Core Progressive Disclosure Principles

1. **Simple to Complex**: Present basic concepts before advanced details
2. **Essential First**: Provide must-know information before nice-to-know details
3. **Context Before Details**: Establish context before diving into specifics
4. **Common Before Edge**: Cover common cases before edge cases or exceptions
5. **Layer by Layer**: Reveal information in logical, manageable layers

### Cognitive Load Optimization

Progressive disclosure optimizes cognitive load by:

1. **Reducing Initial Complexity**: Starting with simpler, more digestible concepts
2. **Preventing Information Overload**: Introducing details only when needed
3. **Creating Mental Models**: Building understanding incrementally
4. **Providing Navigational Control**: Allowing readers to access appropriate detail level
5. **Maintaining Focus**: Keeping attention on the most relevant information

### Progressive Disclosure Levels

Structure information using these standard disclosure levels:

1. **Essential Understanding (Level 1)**
   - Audience: All readers (100%)
   - Content: Core concepts, fundamental principles
   - Purpose: Provide basic understanding
   - Example: What is a message-command?

2. **Standard Implementation (Level 2)**
   - Audience: Most readers (80%)
   - Content: Common usage patterns, standard approaches
   - Purpose: Enable basic implementation
   - Example: How to use common message-commands

3. **Advanced Options (Level 3)**
   - Audience: Specialized needs (40-50%)
   - Content: Additional options, configuration alternatives
   - Purpose: Support customization and optimization
   - Example: How to create custom message-command parameters

4. **Edge Cases (Level 4)**
   - Audience: Specific situations (10-20%)
   - Content: Exception handling, rare scenarios
   - Purpose: Address uncommon requirements
   - Example: Error recovery for message-command failures

5. **Technical Details (Level 5)**
   - Audience: Implementation specialists (5-10%)
   - Content: Internal mechanisms, technical specifications
   - Purpose: Support deep technical understanding
   - Example: Message-command validation implementation details

## Progressive Disclosure Implementation

### Progressive Information Structuring

Structure information progressively with these patterns:

1. **Overview-First Pattern**: Start with high-level overview
   ```markdown
   # Message-Command System
   
   ## Overview
   Message-commands provide a structured way to communicate between Tyler and 1000xdev.
   
   ## Basic Concepts
   [Essential understanding for all readers]
   
   ## Standard Usage
   [Common patterns for most readers]
   
   ## Advanced Configuration
   [Specialized options for some readers]
   
   ## Exception Handling
   [Edge cases for specific situations]
   ```

2. **Progressive Headings Pattern**: Use heading levels to indicate depth
   ```markdown
   # Core Concept (Level 1 - Essential)
   
   ## Implementation Approach (Level 2 - Standard)
   
   ### Configuration Options (Level 3 - Advanced)
   
   #### Exception Handling (Level 4 - Edge Cases)
   
   ##### Technical Specifications (Level 5 - Technical Details)
   ```

3. **Explicit Disclosure Pattern**: Clearly mark disclosure levels
   ```markdown
   # Feature X
   
   ## Essential Understanding
   [What everyone needs to know]
   
   ## Standard Implementation
   [What most users need]
   
   ## Advanced Configuration
   [For specialized needs]
   
   ## Edge Cases
   [For specific situations]
   ```

### Progressive Disclosure Signaling

Signal progressive disclosure with these techniques:

1. **Explicit Level Indicators**: Mark information levels clearly
   ```markdown
   ## Basic Concepts [ESSENTIAL]
   
   ## Advanced Options [SPECIALIZED]
   
   ## Technical Details [IMPLEMENTATION]
   ```

2. **Audience Indicators**: Clarify intended audience
   ```markdown
   ## Standard Usage
   *For all users implementing basic functionality*
   
   ## Advanced Configuration
   *For users with specialized requirements*
   ```

3. **Prerequisite Signaling**: Indicate knowledge dependencies
   ```markdown
   ## Advanced Options
   *Requires understanding of basic concepts and standard usage*
   ```

4. **Complexity Indicators**: Signal information complexity
   ```markdown
   ## Basic Implementation (Complexity: Low)
   
   ## Advanced Configuration (Complexity: Medium)
   
   ## Exception Handling (Complexity: High)
   ```

### Progressive Detail Expansion

Expand details progressively with these patterns:

1. **Expandable Sections**: Use visual indicators for expandable content
   ```markdown
   ## Advanced Configuration
   
   <details>
   <summary>Click to expand advanced configuration options</summary>
   
   [Detailed configuration information]
   
   </details>
   ```

2. **Progressive Example Complexity**: Increase example complexity gradually
   ```markdown
   ## Basic Example
   ```
   simple-command: basic-parameter
   ```
   
   ## Standard Example
   ```
   standard-command: parameter-one parameter-two
   ```
   
   ## Advanced Example
   ```
   advanced-command: parameter-one parameter-two @project-rule.mdc
   ```
   ```

3. **Layered Explanations**: Provide explanations in layers
   ```markdown
   ## Basic Concept
   Simple explanation for general understanding.
   
   ### Deeper Understanding
   More detailed explanation for those who need it.
   
   #### Technical Implementation
   Technical details for implementation specialists.
   ```

## Progressive Navigation Implementation

### Navigation Between Disclosure Levels

Provide navigation between disclosure levels with these patterns:

1. **Level Navigation Links**: Provide navigation between levels
   ```markdown
   ## Basic Concepts
   
   [Simple explanation]
   
   For more detail: [Advanced Concepts](#advanced-concepts)
   
   ## Advanced Concepts
   
   [Detailed explanation]
   
   Return to: [Basic Concepts](#basic-concepts)
   ```

2. **Prerequisite Links**: Link to required knowledge
   ```markdown
   ## Advanced Configuration
   
   *Prerequisites: [Basic Setup](#basic-setup), [Standard Configuration](#standard-configuration)*
   
   [Advanced content]
   ```

3. **Related Information Links**: Connect related content across levels
   ```markdown
   ## Standard Implementation
   
   [Standard content]
   
   *Related: [Error Handling](#error-handling), [Advanced Options](#advanced-options)*
   ```

### Visual Progressive Disclosure

Use visual elements to support progressive disclosure:

1. **Information Boxes**: Highlight information by level
   ```markdown
   > **Essential**: This is core information everyone needs.
   
   > **Advanced**: This is specialized information for specific needs.
   
   > **Technical**: This is detailed technical implementation information.
   ```

2. **Visual Hierarchies**: Use visual formatting to indicate levels
   ```markdown
   # Level 1: Most Important
   
   ## Level 2: Very Important
   
   ### Level 3: Important
   
   #### Level 4: Specialized
   
   ##### Level 5: Technical Detail
   ```

3. **Indentation Progressive Disclosure**: Use indentation to show depth
   ```markdown
   Core concept
     |- Standard implementation
         |- Advanced configuration
             |- Edge case handling
                 |- Technical details
   ```

## Progressive Documentation Patterns

### Workflow-Specific Progressive Patterns

Adapt progressive disclosure to different workflows:

1. **Rules Workflow Progressive Pattern**:
   ```markdown
   ## Rules Workflow Message-Commands
   
   ### Basic Message-Commands [ESSENTIAL]
   Commands everyone uses: plan-mode, dev-mode
   
   ### Standard Message-Commands [STANDARD]
   Commands commonly used: continue-planning, continue-implementation
   
   ### Advanced Message-Commands [SPECIALIZED]
   Commands for specific scenarios: subsystem-focused commands
   
   ### Error Recovery Message-Commands [EDGE]
   Commands for error situations: error-recovery-related commands
   ```

2. **Implementation-Focused Progressive Pattern**:
   ```markdown
   ## Implementation Process
   
   ### Basic Implementation [100%]
   Steps everyone follows
   
   ### Standard Extensions [80%]
   Common customizations
   
   ### Advanced Configurations [40%]
   Specialized options
   
   ### Exception Handling [10%]
   Edge case management
   ```

### Progressive Terminology Introduction

Introduce terminology progressively:

1. **Basic Terminology First**: Define essential terms before specialized ones
   ```markdown
   ## Basic Terminology
   - **Message-Command**: The basic communication unit
   - **Parameter**: Information provided to a message-command
   
   ## Advanced Terminology
   - **Project-Rule-Parameter**: A specialized parameter that references project rules
   - **Symbol Protection**: Techniques to prevent reference resolution issues
   ```

2. **Contextual Term Definitions**: Define terms when they become relevant
   ```markdown
   ## Basic Usage
   A **message-command** is the basic communication unit.
   
   ## Advanced Usage
   When working with advanced scenarios, you'll use **project-rule-parameters**.
   ```

3. **Progressive Technical Vocabulary**: Increase vocabulary precision with depth
   ```markdown
   ## Level 1: "The system processes commands"
   ## Level 2: "The parser validates message-commands"
   ## Level 3: "The lexical analyzer tokenizes the message-command syntax"
   ```

## Best Practices for Progressive Disclosure

### Document-Level Progressive Disclosure

Implement progressive disclosure across entire documents:

1. **Progressive Document Structure**: Structure whole documents progressively
   ```markdown
   # Document Title
   
   ## Executive Summary [ESSENTIAL]
   
   ## Core Concepts [ESSENTIAL]
   
   ## Standard Implementation [STANDARD]
   
   ## Advanced Configuration [SPECIALIZED]
   
   ## Technical Details [TECHNICAL]
   ```

2. **Progressive Appendices**: Move detailed information to appendices
   ```markdown
   # Main Document
   [Essential and standard information]
   
   ## Appendix A: Advanced Configuration Options
   [Advanced details]
   
   ## Appendix B: Technical Specifications
   [Technical details]
   ```

3. **Progressive Navigation System**: Create navigation based on levels
   ```markdown
   # Table of Contents
   
   ## Essential Information
   - [Core Concepts](#core-concepts)
   - [Basic Usage](#basic-usage)
   
   ## Standard Information
   - [Standard Implementation](#standard-implementation)
   - [Common Patterns](#common-patterns)
   
   ## Advanced Information
   - [Advanced Configuration](#advanced-configuration)
   - [Technical Details](#technical-details)
   ```

### Cross-Document Progressive Disclosure

Implement progressive disclosure across document sets:

1. **Level-Based Document Organization**: Organize documents by level
   ```
   - essential-guide.md (Level 1)
   - standard-implementation.md (Level 2)
   - advanced-configuration.md (Level 3)
   - technical-specifications.md (Level 4)
   ```

2. **Explicit Navigation Between Documents**: Provide clear navigation
   ```markdown
   # Basic Guide
   
   [Basic content]
   
   For advanced information, see the [Advanced Guide](advanced-guide.md).
   ```

3. **Progressive Documentation Map**: Create a map of progressive documentation
   ```markdown
   # Documentation Map
   
   ## Level 1: Essential Guides
   - [Getting Started](getting-started.md)
   - [Core Concepts](core-concepts.md)
   
   ## Level 2: Standard Implementation
   - [Implementation Guide](implementation-guide.md)
   - [Common Patterns](common-patterns.md)
   
   ## Level 3: Advanced Topics
   - [Advanced Configuration](advanced-configuration.md)
   - [Optimization Guide](optimization-guide.md)
   ```

## Verification and Validation

### Progressive Disclosure Quality Checklist

Verify progressive disclosure meets these criteria:

1. **Logical Progression**: Information flows from simple to complex
2. **Clear Level Indicators**: Disclosure levels are clearly marked
3. **Appropriate Detail**: Detail level matches disclosure level
4. **Navigational Support**: Navigation between levels is provided
5. **Context Preservation**: Context is maintained throughout levels

### Progressive Disclosure Validation

Validate progressive disclosure with these techniques:

1. **Level Consistency Check**: Ensure consistent level application
   - Verify that Level 1 information is truly essential
   - Check that Level 2 content builds on Level 1
   - Confirm that deeper levels add appropriate detail

2. **Audience-Focused Testing**: Validate against audience needs
   - Test Level 1 content with all users
   - Verify Level 2 content with standard implementation users
   - Check Level 3+ content with specialized users

3. **Navigation Verification**: Test navigation between levels
   - Verify upward navigation to simpler concepts
   - Test downward navigation to more complex details
   - Confirm cross-references work appropriately 