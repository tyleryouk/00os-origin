# Implementation Plan: System-Wide Plan-Mode Enhancement

## Current State Analysis

### File Size Issues
1. **Mode Files Exceeding Limits**:
   - `1000xbrain/core/modes/plan-mode.md`: 474 lines (↓224 needed)
   - `1000xbrain/core/modes/mode-transitions.md`: 328 lines (↓78 needed)
   - `1000xbrain/core/modes/dev-mode.md`: 464 lines (↓214 needed)

### Directory Structure
```
1000xbrain/
├── core/
│   ├── modes/
│   │   ├── plan-mode.md (474 lines)
│   │   ├── mode-transitions.md (328 lines)
│   │   └── dev-mode.md (464 lines)
│   ├── communication/
│   ├── identity/
│   └── core-essentials.md
├── knowledge/
│   ├── guides/
│   ├── patterns/
│   └── reference/
├── parameters/
├── templates/
└── cross-references.md
```

### Detailed Splitting Analysis for plan-mode.md

#### Content Distribution (474 lines total)
1. Core Concepts and Definition (Lines 1-150)
   - File purpose and relationships
   - Mode definition and core responsibilities
   - Essential planning structure

2. Knowledge Access System (Lines 151-250)
   - fetch_rules patterns
   - Knowledge component organization
   - Access best practices

3. Communication Standards (Lines 251-350)
   - Mode indicators
   - Response patterns
   - Verification protocols

4. Implementation Guidelines (Lines 351-474)
   - File modification protocols
   - Tool usage patterns
   - Transition handling

#### Splitting Strategy
1. **plan-mode-core.md** (≤250 lines)
   - Mode definition and purpose
   - Core responsibilities
   - Essential planning structure
   - Basic communication standards

2. **plan-mode-knowledge.md** (≤250 lines)
   - Knowledge access system
   - fetch_rules patterns
   - Knowledge component organization
   - Access best practices

3. **plan-mode-implementation.md** (≤250 lines)
   - File modification protocols
   - Tool usage patterns
   - Verification protocols
   - Transition handling

## Enhancement Scope
This implementation will update the plan-mode system to:
1. Reduce all plan-mode files to 250 lines or less (aligned with read_file tool constraint)
2. Implement intelligent planning folder splitting
3. Maintain system coherence across split planning folders
4. Integrate with Cursor's tool system and constraints
5. Implement context-aware planning management
6. Optimize for tool categories and limits

## Implementation Strategy

### Phase 1: Tool-Aware File Size Reduction

1. Create New Mode Structure in `1000xbrain/core/modes/`:
   ```
   modes/
   ├── plan-mode/
   │   ├── plan-mode-core.md (≤250 lines)
   │   ├── plan-mode-knowledge.md (≤250 lines)
   │   └── plan-mode-implementation.md (≤250 lines)
   ├── dev-mode/
   │   ├── dev-mode-core.md (≤250 lines)
   │   ├── dev-mode-tools.md (≤250 lines)
   │   └── dev-mode-patterns.md (≤250 lines)
   └── transitions/
       ├── mode-transitions-core.md (≤250 lines)
       └── mode-transitions-handlers.md (≤250 lines)
   ```

2. Split `1000xbrain/core/modes/plan-mode.md` (474 lines):

   a. Create `plan-mode-core.md`:
   ```markdown
   # Plan Mode Core

   ## File Purpose
   Core definition and essential operations for Planning Mode.

   ## Mode Definition
   [Core mode definition content]

   ## Core Responsibilities
   [Essential responsibilities content]

   ## Planning Structure
   [Basic planning structure content]

   ## Basic Communication
   [Essential communication standards]
   ```

   b. Create `plan-mode-knowledge.md`:
   ```markdown
   # Plan Mode Knowledge

   ## Knowledge Access System
   [Knowledge system content]

   ## fetch_rules Patterns
   [Access patterns content]

   ## Knowledge Organization
   [Component organization content]

   ## Access Best Practices
   [Best practices content]
   ```

   c. Create `plan-mode-implementation.md`:
   ```markdown
   # Plan Mode Implementation

   ## File Modification
   [Modification protocols content]

   ## Tool Usage
   [Tool patterns content]

   ## Verification
   [Verification protocols content]

   ## Transitions
   [Transition handling content]
   ```

3. Update Cross-References:
   ```markdown
   // In plan-mode-core.md
   See also:
   - plan-mode-knowledge.md for knowledge access
   - plan-mode-implementation.md for implementation details
   ```

4. Implement Tool-Aware File Reading:
   ```typescript
   // File reading strategy
   - Initial line count check
   - Automatic splitting of read operations for files >250 lines
   - Intelligent context preservation across splits
   - Tool call optimization to stay within 25-call limit
   ```

5. Update Documentation Standards:
   - Maximum file size: 250 lines
   - Clear section breaks for split reading
   - Tool-aware cross-referencing system
   - Context preservation markers

### Phase 2: Planning Intelligence Implementation

1. Create Planning Complexity Assessment:
   ```typescript
   // Complexity factors to check:
   - Number of subsystems affected
   - Dependencies between components
   - Implementation phases required
   - Testing complexity
   - Documentation requirements
   ```

2. Implement Folder Splitting Logic:
   ```typescript
   // Folder structure for split plans:
   planning/
   ├── feature-name/
   │   ├── core/
   │   │   └── [core planning files]
   │   ├── subsystem-1/
   │   │   └── [subsystem specific files]
   │   └── subsystem-2/
   │       └── [subsystem specific files]
   ```

3. Create Cross-Folder Reference System:
   ```typescript
   // Reference format:
   ref: ../subsystem-1/implementation.md#section
   ```

### Phase 3: Tool System Integration

1. Search Tool Integration:
   ```typescript
   // Search tool optimization
   - Codebase search: Semantic pattern discovery
     * Primary: knowledge/patterns/
     * Secondary: core/modes/
   - Grep search: Exact pattern matching
     * Focus: core/ directory
   - List directory: Structure exploration
     * Priority: New split directories
   - Search files: Quick file location
     * Target: Split mode files
   - Read file: 250-line compliant reading
     * Implement in all mode files
   - Fetch rules: Knowledge access
     * Update rule paths for splits
   ```

2. Edit Tool Integration:
   ```typescript
   // Edit tool optimization
   - Edit & Reapply: Reliable changes
   - Delete file: Safe removal
   - Auto-fix integration for errors
   ```

3. Run Tool Integration:
   ```typescript
   // Terminal command optimization
   - PowerShell-specific syntax
   - Background task handling
   - Tool call limit management
   ```

4. Advanced Options Integration:
   ```typescript
   // Advanced feature optimization
   - Auto-apply configuration
   - Auto-run settings
   - Guardrail implementation
   - Auto-fix error handling
   ```

### Phase 4: Context Management Implementation

1. Planning Context Management:
   ```typescript
   // Mode-specific context handling
   - Implement tool-aware context monitoring
   - Add support for auto-run workflows
   - Create error-aware context patterns
   - Handle tool-specific contexts
   - Define custom mode context patterns
   - Implement mode-specific context handling
   ```

2. @ Symbol Integration:
   ```typescript
   // Symbol handling for modes
   - Update symbol usage for tools
   - Implement auto-fix patterns
   - Create tool-aware references
   - Define custom mode symbol patterns
   - Create mode-specific reference systems
   ```

3. Model Selection Integration:
   ```typescript
   // Mode-specific model integration
   - Support default model selection
   - Implement tool-specific models
   - Add auto-run optimization
   - Define custom mode model presets
   - Create mode-specific optimization
   ```

### Phase 5: Testing and Verification

1. File Size Verification:
   - Check all plan-mode files are under 250 lines
   - Verify functionality preservation
   - Test cross-file references

2. Planning Intelligence Testing:
   - Test complexity assessment accuracy
   - Verify folder splitting logic
   - Validate cross-folder references

3. System Integration Testing:
   - Test mode transitions with split folders
   - Verify documentation coherence
   - Validate knowledge access patterns

## Verification Approach

### 1. File Size Compliance
- Use line counting tools to verify file sizes
- Check functionality preservation after splitting
- Verify cross-reference accuracy

### 2. Planning Intelligence
- Test with varying complexity levels
- Verify appropriate folder splitting
- Check cross-folder coordination

### 3. System Integration
- Verify mode transitions work correctly
- Test documentation cross-references
- Validate knowledge access patterns

## Success Criteria

1. **File Size**
   - All plan-mode related files ≤ 250 lines
   - Functionality fully preserved
   - Clear file organization

2. **Planning Intelligence**
   - Accurate complexity assessment
   - Appropriate folder splitting
   - Effective cross-folder references

3. **System Integration**
   - Seamless mode transitions
   - Clear documentation structure
   - Efficient knowledge access

4. **Context Management**
   - Effective context window usage
   - Proper @ symbol handling
   - Efficient conversation management
   - Appropriate model selection

## Agent Mode Specific Enhancements

1. Tool Integration:
   ```typescript
   // Tool optimization
   - Configure available tools
   - Set up auto-run preferences
   - Implement error auto-fix
   - Create tool-specific workflows
   ```

2. Model Configuration:
   ```typescript
   // Model settings
   - Set default models
   - Configure model preselection
   - Optimize for tool usage
   ```

3. Keybinding Setup:
   ```typescript
   // Custom keybindings
   - Define mode-specific bindings
   - Set up tool shortcuts
   - Create workflow accelerators
   ```

## Custom Mode Enhancements

1. Mode Definition:
   ```typescript
   // Custom mode creation
   - Define mode configuration structure
   - Implement tool selection options based on UI categories:
     * Search: Codebase, Web, Grep, List directory, Search files, Read file, Fetch rules
     * Edit: Edit & Reapply, Delete file
     * Run: Terminal
     * MCP Servers
   - Create mode-specific settings
   - Define transition protocols
   - Support name configuration ("Enter a name" field)
   - Enable custom instructions configuration via "Add custom instructions" button
   ```

2. Mode-Specific Workflows:
   ```typescript
   // Custom workflow patterns
   - Create specialized workflow templates
   - Implement mode-specific tool combinations
   - Define interaction patterns
   - Enable context customization
   - Support for toggle options:
     * Auto-apply edits
     * Auto-run
     * Auto-fix errors
   - Support predefined example modes with appropriate tool selections
   ```

3. Mode Configuration:
   ```typescript
   // Mode settings
   - Set model via "Model" dropdown
   - Configure keybindings via "Set keys" button
   - Create tool selection templates based on UI categories
   - Implement persistent settings
   - Support granular tool selection via checkboxes
   - Enable custom instructions
   ```

## Tool Usage Guidelines

### Search Tools
1. **Codebase Search**
   - Use for semantic pattern discovery
   - Optimize query construction
   - Target specific directories

2. **Grep Search**
   - Use for exact pattern matching
   - Optimize regex patterns
   - Include/exclude file filtering

3. **File Operations**
   - List directory for structure exploration
   - Search files for quick location
   - Read file with 250-line awareness

4. **Knowledge Access**
   - Fetch rules for specialized knowledge
   - Optimize rule combinations
   - Clear explanation parameters

### Edit Tools
1. **Edit & Reapply**
   - Clear edit instructions
   - Context preservation
   - Verification steps

2. **Delete Operations**
   - Safe deletion checks
   - Dependency verification
   - Backup considerations

### Run Tools
1. **Terminal Commands**
   - PowerShell syntax compliance
   - Background task handling
   - Tool call optimization

### Advanced Features
1. **Auto Operations**
   - Configure auto-apply settings
   - Set up auto-run conditions
   - Implement guardrails
   - Configure auto-fix behavior

## Tool Call Optimization

1. **Session Management**
   - Track tool call count
   - Optimize call sequences
   - Batch operations when possible
   - Plan for continuation points

2. **Call Priority**
   - Essential operations first
   - Batch similar operations
   - Defer non-critical calls
   - Smart continuation handling 