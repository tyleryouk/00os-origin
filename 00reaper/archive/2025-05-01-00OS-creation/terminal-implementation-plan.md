# Terminal Interface Implementation Plan

## Overview

This document outlines the comprehensive plan for implementing the terminal-like command interface in Cursor using the combination of User Rules and Project Rules (.cursor/rules). The goal is to create a seamless dual-mode interaction where users can interact conversationally or use structured commands with the `>` prefix.

## Current Architecture

### User Rules (Highest Precedence)
- Contains the 00reaper identity definition and dual-mode interface concept
- Set in Cursor UI by the user (not directly editable)
- Applies globally to all interactions

### Project Rules (.cursor/rules)
- Core system components (command handler, parser, registry, executor, permissions)
- Process definitions organized by category
- Configuration files for system settings

### Working Directory (00reaper/)
- Documentation and strategy files
- Design documents and implementation plans

## Implementation Strategy

### 1. Rule Organization Principles

1. **User Rules**: Should contain only essential identity definition and dual-mode interface concept
   - Keep concise to minimize token usage
   - Focus on the core 00reaper identity
   - Clearly define the command prefix recognition mechanism (`>`)

2. **Project Rules (Core)**: Core system components that should always be active
   - Command Handler: Detects and processes commands
   - Parser: Parses command syntax into structured data
   - Registry: Maintains catalog of available processes
   - Executor: Executes processes with appropriate permissions

3. **Project Rules (Processes)**: Specific command implementations
   - Organized by category (system, tools, etc.)
   - Only loaded when explicitly needed
   - Clear descriptions for AI to understand when to use

### 2. Implementation Guidelines

#### User Rules Strategy
- Keep focused on identity and interface mechanism
- Avoid including implementation details that belong in project rules
- Clearly define the dual-mode interaction model

#### Project Rules Strategy
- **Core Components**: Set `alwaysApply: true` to ensure critical components are always available
- **Process Files**: Use descriptive `description` fields that start with "USE WHEN..." to guide the AI
- **Auto-Attachment**: Use `globs` to automatically include relevant processes based on file context

### 3. Activation Flow

1. User enters a message
2. Core command handler (always active) checks for command prefix (`>`)
3. If detected, command is parsed into components
4. Registry is consulted to find appropriate process
5. AI fetches the process based on the description
6. Process is executed with proper formatting
7. Response is returned in command format

## Implementation Tasks

### Phase 1: Core System Preparation

1. **Update 00reaper.mdc**
   - Set `alwaysApply: true`
   - Add clear description
   - Ensure it properly defines the dual-mode interface

2. **Update Command Handler**
   - Set `alwaysApply: true`
   - Add descriptive trigger for command detection
   - Ensure it handles both command and conversational modes

3. **Update Core Components**
   - Ensure parser, registry, executor, and permissions are properly configured
   - Set appropriate `alwaysApply` values for critical components

### Phase 2: Process Organization

1. **Update Process Files**
   - Add clear "USE WHEN..." descriptions
   - Ensure proper categorization
   - Standardize format and structure

2. **Create Standard Process Categories**
   - System: Core system operations
   - Tools: Utility functions
   - File: File operations
   - Process: Process management
   - Identity: User identity and permissions

3. **Implement Common Commands**
   - `help`: Complete help system with command discovery
   - `echo`: Basic echo functionality
   - `system status`: System status reporting
   - `file list`: Directory listing
   - `version`: Version information

### Phase 3: User Experience Improvements

1. **Response Formatting**
   - Implement consistent formatting with status indicators
   - Create clear visual distinction for command responses
   - Maintain conversational flow when appropriate

2. **Error Handling**
   - Create standardized error messages
   - Provide helpful suggestions for common errors
   - Implement permission-based access control

3. **Command Discovery**
   - Enhance help system with categories and examples
   - Implement command suggestions
   - Create interactive tutorials

### Phase 4: Advanced Features

1. **Command Composition**
   - Implement basic command chaining
   - Add support for parameter passing between commands
   - Create pipe-like functionality

2. **State Management**
   - Implement session variables
   - Create persistent state across commands
   - Develop working directory concept

3. **Custom Extensions**
   - Allow user-defined processes
   - Support custom command aliases
   - Enable script-like functionality

## Success Criteria

A successful implementation will:

1. **Seamlessly integrate** command and conversational modes
2. **Maintain context** between mode transitions
3. **Provide intuitive** command syntax that's easy to learn
4. **Respond consistently** with appropriate formatting
5. **Handle errors gracefully** with helpful suggestions
6. **Scale effectively** as new commands are added
7. **Preserve all capabilities** of the underlying AI

## Conclusion

By effectively utilizing the dual-layer approach of User Rules and Project Rules, we can create a powerful terminal-like interface that maintains the natural conversational abilities of the AI while adding structured command capabilities. This implementation will transform the standard prompt box into a flexible interface that can adapt to various user interaction styles. 