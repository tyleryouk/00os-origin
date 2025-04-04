#  mode: dev-mode| workflow: rules-workflow | pathway: none | filepath: @parameters/rules/dev-mode/continue-implementation.mdc | optional-standard-parameter(s): none

## Overview

This project-rule-parameter provides structured guidance for continuing implementation based on planning folder content. It ensures consistent progress tracking and implementation across complex features.

## Implementation Process

### 1. Planning Folder Analysis

First, analyze the planning folder structure and content:

1. **Read Core Planning Files**:
   - `README.md` for overall context and objectives
   - `implementation-progress.md` for current status
   - Any additional context files mentioned in README.md

2. **Identify Current Phase**:
   - Check implementation progress tracking
   - Note completed and in-progress tasks
   - Identify next steps and blockers

3. **Access Required Knowledge**:
   - Use fetch_rules to access relevant knowledge components
   - Follow knowledge access patterns from planning docs
   - Verify knowledge component availability

### 2. Implementation Continuation

Based on the planning folder analysis:

1. **Tool Usage Sequence**:
   ```typescript
   // Read planning folder files
   read_file("planning/[folder]/README.md")
   read_file("planning/[folder]/implementation-progress.md")
   
   // Access relevant knowledge
   fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"])
   
   // Search for related patterns
   codebase_search("similar implementation patterns")
   
   // Read and modify target files
   read_file("[target_file]")
   edit_file("[target_file]", "Implementation changes")
   ```

2. **Progress Tracking**:
   - Update implementation-progress.md after significant changes
   - Document any issues or blockers encountered
   - Track completion of planned tasks

3. **Verification Steps**:
   - Verify changes meet requirements
   - Test functionality if applicable
   - Update documentation as needed

### 3. Implementation Standards

Follow these standards during continuation:

1. **Code Changes**:
   - Make focused, incremental changes
   - Follow existing patterns in the codebase
   - Add appropriate error handling
   - Include necessary type definitions

2. **Documentation Updates**:
   - Keep implementation-progress.md current
   - Document any deviations from the plan
   - Note any new issues or considerations

3. **Knowledge Integration**:
   - Use fetch_rules for specialized knowledge
   - Follow established patterns
   - Document new patterns discovered

## Usage Example

```typescript
// Initial planning folder analysis
read_file("planning/feature/README.md")
read_file("planning/feature/implementation-progress.md")

// Access implementation knowledge
fetch_rules(["knowledge/rules/patterns/impl/implementation-patterns"])

// Find similar patterns
codebase_search("feature implementation patterns")

// Make implementation changes
read_file("target_file.ts")
edit_file("target_file.ts", "Implement feature changes")

// Update progress
edit_file("planning/feature/implementation-progress.md", "Update progress")
```

## Success Criteria

Implementation continuation is successful when:

1. **Progress Tracking**:
   - Current status is clear
   - Next steps are identified
   - Blockers are documented

2. **Code Quality**:
   - Changes follow existing patterns
   - Error handling is complete
   - Types are properly defined

3. **Documentation**:
   - Progress is tracked
   - Changes are documented
   - Issues are noted

## Common Issues and Solutions

| Issue | Solution |
|-------|----------|
| Unclear next steps | Review implementation-progress.md and README.md |
| Missing context | Check additional context files in planning folder |
| Pattern uncertainty | Use codebase_search to find similar patterns |
| Knowledge gaps | Use fetch_rules to access relevant knowledge |

## Related Knowledge Components

For additional guidance, access these knowledge components:

```typescript
fetch_rules([
  "knowledge/rules/patterns/impl/implementation-patterns",
  "knowledge/rules/patterns/tool/tool-combinations",
  "knowledge/rules/reference/architecture"
], "Accessing implementation guidance")
``` 