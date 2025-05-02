# Implementation Plan: REQ-SIMP-001

## Implementation Phases
### Phase 1: Documentation Updates
1. **README.md Enhancement**
   - Add 3-step pattern explanation at the top
   - Maintain cyclical workflow process description
   - Add clarification on architecture vs. implementation
   - Ensure consistency with the simplified approach

2. **Command Template Simplification**
   - Review current command-template-core.md
   - Create simplified template focusing on direct tool calls
   - Add examples for different command types
   - Remove complex validation sections

### Phase 2: Command Simplification
1. **reaper-sync Conversion**
   - Analyze current implementation structure
   - Convert to direct execution format
   - Focus on single terminal command execution
   - Add clear examples
   - Test functionality after conversion

2. **reaper-init Enhancement**
   - Simplify while preserving context loading functionality
   - Update to read final-goal.md and roadmap documents
   - Ensure proper categorization
   - Test comprehensive functionality

## Implementation Details

### README.md Update
- **Purpose**: Establish 3-step pattern at the beginning of documentation
- **Changes**: Add new section at the top explaining the pattern
- **Key Points**:
  - Maintain existing workflow process explanation
  - Add clear distinction between architecture (sound) and implementation (simplified)
  - Ensure consistency with final-goal.md vision

### Command Template Revision
- **Purpose**: Provide simplified template for all command processes
- **Changes**: Complete replacement with new minimalist template
- **Key Points**:
  - Focus on direct tool call sequences
  - Remove unnecessary validation and error handling
  - Provide clear examples for different command types
  - Follow the structure outlined in final-goal.md

### reaper-sync Implementation
- **Purpose**: Create first simplified command example
- **Changes**: Convert to direct execution of script
- **Key Points**:
  - Replace complex structure with single tool call
  - Focus on running the sync script directly
  - Maintain proper documentation and examples
  - Test thoroughly to ensure functionality

### reaper-init Enhancement
- **Purpose**: Ensure proper context loading with simplified approach
- **Changes**: Streamline while preserving essential functionality
- **Key Points**:
  - Keep context loading for all critical files
  - Add loading of new vision and roadmap documents
  - Follow the 3-step pattern for implementation
  - Ensure comprehensive testing

## Testing Strategy
- **Basic Testing**: Execute each command and verify correct operation
- **Integration**: Ensure modified commands work within the workflow
- **Success Criteria**:
  - Commands follow the 3-step pattern
  - Documentation clearly explains the simplified approach
  - All commands function correctly when executed

## Dependencies and Blockers
- **Dependencies**: Current 00OS architecture and command structure
- **Blockers**: None identified
- **Mitigation**: Thorough testing before final implementation

## Workflow Mapping
| Workflow Step | Implementation Phases |
|---------------|------------------------|
| 4. Make Changes to 00OS | Phases 1-2 |
| 5. Update Materials | Documentation Updates |
| 6. Reset & Sync | Final Verification |

## Status
- **Current Status**: Implementation progress tracked in `cycle-status.md`
- **Cross-References**: See `active-request.md` for requirements
- **Last Updated**: 2024-07-08

## Tool Call Sequences
### Phase 1 Tools
```javascript
// README.md Update
read_file("00reaper/00OS-commands/README.md")
edit_file("00reaper/00OS-commands/README.md")

// Command Template Update
read_file("00reaper/00OS-commands/documentation/command-template-core.md")
edit_file("00reaper/00OS-commands/documentation/command-template-core.md")
```

### Phase 2 Tools
```javascript
// reaper-sync Conversion
read_file("00OS/processes/00reaper/reaper-sync.md")
edit_file("00OS/processes/00reaper/reaper-sync.md")

// reaper-init Enhancement
read_file("00OS/processes/00reaper/reaper-init.md")
edit_file("00OS/processes/00reaper/reaper-init.md")
```

## Validation Steps
1. **Documentation Updates**
   - [ ] README.md includes 3-step pattern at the top
   - [ ] command-template-core.md follows simplified approach
   - [ ] All documentation is internally consistent

2. **Command Implementation**
   - [ ] reaper-sync follows the simplified template
   - [ ] reaper-init follows the simplified template
   - [ ] Both commands execute successfully

## Success Criteria
- [ ] All documentation updates completed according to requirements
- [ ] reaper-sync converted to simplified format and functional
- [ ] reaper-init converted to simplified format and functional
- [ ] All implementations follow the 3-step pattern

## Status Snapshot
- **Cycle ID**: REQ-SIMP-001
- **Cycle Stage**: Step 3 - Update Core Workflow Files
- **Plan Version**: 1.0
- **Last Substantive Update**: 2024-07-08
- **Implementation Status**: Current implementation progress is tracked in `cycle-status.md`
- **Cross-Reference**:
  - Active Request: See `active-request.md`
  - Cycle Status: See `cycle-status.md` (Source of truth for current progress)

## 00OS Command Simplification Initiative - Cycle 1

### Overview
This implementation plan addresses the first cycle of the 00OS Command Simplification Initiative, focusing on establishing the foundation for simplified commands. It includes updating core documentation to explain the 3-step pattern and converting two high-impact commands (reaper-sync and reaper-init) to the simplified format.

### Current State Assessment
The current 00OS command system has evolved a robust architecture but with unnecessarily complex implementations:

- Process implementations have excessive validation and error handling
- Documentation is verbose and sometimes contradictory
- Command processes often don't follow consistent patterns
- Some commands attempt to execute other commands through terminal calls

### Implementation Details

#### README.md Update
```markdown
# 00OS Commands Workflow

## Core Command Pattern

Every 00OS command follows this simple pattern:

1. **User sends a command**: `> command-name [arguments] [--flags]`
2. **AI fetches the process rule**: Makes a single `fetch_rules` call to get the process definition
3. **AI executes the defined tool calls**: Follows exactly what's in the process rule, no more, no less

This simplified pattern maintains the architectural integrity of 00OS while reducing implementation complexity.

## Cyclical Workflow Process

[Existing cyclical workflow process documentation]
```

#### command-template-core.md Update
```markdown
# 00OS Command Process Template

Use this template when creating new command processes or updating existing ones.

```markdown
---
name: command-name
description: Simple description of what the command does
category: [system|00reaper|1000xdev]
author: 00reaper
version: 1.0
---

# Process: command-name

USE WHEN you want to execute command-name

## Execution

This process executes the following tool calls:

1. FIRST TOOL CALL (e.g., read_file, list_dir, etc.)
2. SECOND TOOL CALL (if needed)
3. TERMINAL COMMAND (if appropriate)

## Examples

> command-name arg1 --flag1
> command-name arg2 --flag2
```

## Example Implementations

### Information Retrieval Command
[Example of information retrieval command]

### File Modification Command
[Example of file modification command]

### Command Execution
[Example of command execution]
```

### Testing and Verification Strategy
- **Command Functionality**: Execute each modified command and verify it performs correctly
- **Context Preservation**: Ensure reaper-init still loads all necessary context
- **Documentation Clarity**: Review documentation changes for clarity and consistency

### Rollback Plan
If implementation causes issues:
1. Revert modified files to previous versions
2. Execute reaper-sync to update .cursor/rules
3. Document issues encountered for future resolution

### Plan Changes Log
- **Version 1.0** [2024-07-08]: Initial implementation plan
