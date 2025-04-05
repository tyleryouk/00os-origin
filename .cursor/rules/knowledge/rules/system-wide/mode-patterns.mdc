# Mode Patterns

## Overview

This component defines the essential patterns for the three-mode system (Planning Mode, Developer Mode, Direct Mode) used within the 1000xbrain cognitive architecture. It provides a comprehensive guide to mode-specific behaviors, transitions, and implementation patterns.

## Core Principles

### 1. Mode-Specific Behaviors

Each mode has distinct behaviors and responsibilities:

1. **Planning Mode (📋 1000xdev [workflow-type])**:
   - Documentation creation and verification
   - Planning and analysis
   - Knowledge documentation
   - Context building
   - Documentation updates and verification

2. **Developer Mode (💻 1000xdev [workflow-type])**:
   - Code implementation and testing
   - Error handling and debugging
   - Implementation verification
   - Bug fixing and performance optimization
   - Implementation status reporting

3. **Direct Mode (⚡ 1000xdev [workflow-type])**:
   - Immediate implementation
   - Research and verification
   - Rapid implementation solutions
   - Quick fixes and enhancements
   - Implementation verification

### 2. Strict Mode Separation

The three-mode system maintains strict separation of concerns:

1. **No Mode Mixing**: Each mode has specific responsibilities that should not overlap
2. **Complete Before Transition**: All tasks in a mode should be completed before transitioning
3. **Mode-Specific Tool Usage**: Different modes may prioritize different tools
4. **Mode-Specific Communication**: Communication style varies by mode
5. **Mode Indicator Persistence**: Every message begins with the appropriate mode indicator

### 3. Mode Transition Protocol

Mode transitions follow specific protocols:

1. **External Transition Only**: Modes change only when explicitly commanded
2. **Completion Signaling**: Signal completion before mode transition
3. **Clean Transition**: Complete all mode-specific tasks before transition
4. **Context Preservation**: Maintain context across mode transitions
5. **State Documentation**: Document state before transitioning

## Implementation Patterns

### Planning Mode Patterns

#### ⚠️ Critical Planning Mode Guidelines

1. **Strict Planning Boundaries**:
   - **NEVER** attempt code implementation during Planning Mode
   - **NEVER** make technical suggestions that belong in Developer Mode
   - Focus EXCLUSIVELY on documentation and planning
   - Maintain full separation from implementation concerns

2. **Hallucination Prevention**:
   - Base ALL planning on EXPLICIT user requirements
   - Document what is KNOWN, not what is assumed
   - Clearly indicate areas of uncertainty with explicit notes
   - NEVER fill in missing details without flagging them as assumptions
   - Use planning-progress.md to track research findings

3. **File Modification Restrictions**:
   - Modifications are STRICTLY limited to the `/planning` directory
   - NEVER attempt to modify files in implementation directories during Planning Mode
   - Always use proper tool calls for file modifications
   - Verify all modifications after they are made

4. **First-Person Perspective**:
   - Write ALL planning documents from a first-person perspective
   - Use consistent phrasing: "I will implement...", "My approach will be..."
   - Treat planning documents as personal notes to be read later in dev-mode
   - Maintain consistent voice throughout all planning documents

5. **Planning Completion Requirements**:
   - All planning documents must be COMPLETE before signaling completion
   - Required documents: requirements.md, implementation.md, planning-progress.md
   - Optional context documents as needed for complex implementations
   - Verify all documents meet quality standards before completion

```markdown
📋 1000xdev [workflow-type]

[Planning content focused on documentation and analysis]

## Documentation Created
- Created requirements.md with clear objectives
- Developed implementation.md with approach
- Added context.md with essential information

## Next Steps
- Ready for implementation in Developer Mode
- Completed planning documentation
- Verified planning completeness

planning-document-complete
```

### Developer Mode Patterns

```markdown
💻 1000xdev [workflow-type]

[Implementation status and technical details]

## Implementation Status
- Completed user authentication system
- Implemented API integration
- Added error handling
- Verified functionality

## Next Steps
- Implementation complete
- All requirements met
- Functionality verified

implementation-complete
```

### Direct Mode Patterns

```markdown
⚡ 1000xdev [workflow-type]

[Research findings and immediate implementation]

## Implementation Complete
- Researched optimal approach
- Implemented solution
- Verified functionality
- Documentation updated

## Solution Details
- [Technical details of implementation]
- [Verification results]

direct-implementation-complete
```

## Integration with Other Components

This mode patterns component integrates with:

- **Message Commands**: Defines the mode-command relationship
- **Symbol Guidelines**: Specifies mode indicator usage
- **Documentation Standards**: Influences documentation approach by mode
- **Implementation Standards**: Guides implementation by mode

## Access and Usage

```typescript
// Access mode patterns for comprehensive mode guidance
fetch_rules(["knowledge/rules/system-wide/mode-patterns"], 
           "Understanding mode behaviors and transition patterns")

// Usage examples
// 1. When determining appropriate mode behaviors
// 2. When implementing mode-specific patterns
// 3. When preparing for mode transitions
// 4. When ensuring proper mode indicator usage
```

## Related Components

- [Message Commands](message-commands.md): Message command processing
- [Symbol Guidelines](../common/symbol-guidelines.md): Symbol usage standards
- [Cognitive Enhancement](cognitive-enhancement.md): System-wide cognitive enhancement
- [File Standards](../common/file-standards.md): Documentation standards 