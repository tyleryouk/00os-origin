# mode: plan-mode | workflow: rules-workflow | pathway: none | filepath: @parameters/rules/plan-mode/enhance-planning.mdc  | optional-standard-parameter(s): none

# Enhance Planning: Rules Workflow

## File Purpose

This file provides an iterative planning enhancement pattern for rules workflow implementation. It should be used when:

- Planning documentation requires further refinement
- Additional research and analysis is needed to improve planning accuracy
- Planning files need optimization before implementation
- Complex implementation planning requires iterative enhancement

This parameter is designed to work with the `enhance-planning:` message-command, providing a structured approach to progressively improving planning documentation through multiple iterations.

This message-command can be issued multiple times in sequence to progressively enhance planning files.

## Enhancement Process Overview

The planning enhancement process follows these key steps:

1. **Planning State Analysis**
   - Assess current planning documentation quality
   - Identify areas needing enhancement
   - Analyze planning comprehensiveness
   - Evaluate implementation readiness

2. **Enhancement Strategy Selection**
   - Determine most valuable enhancement targets
   - Select appropriate research approach
   - Design iterative enhancement plan
   - Prioritize high-impact improvements

3. **Enhanced Research Process**
   - Conduct thorough research using tool calls
   - Analyze existing implementation patterns
   - Access relevant knowledge components
   - Find architectural precedents

4. **Planning Document Enhancement**
   - Apply research findings to planning documents
   - Enhance implementation guidance
   - Improve technical accuracy
   - Add missing implementation details

5. **Enhancement Value Assessment**
   - Analyze if further enhancement would provide diminishing returns
   - Determine if planning is sufficiently complete
   - Assess implementation readiness
   - Provide explicit recommendation on enhancement completion

## Planning State Analysis

Begin by analyzing the current state of planning documentation:

```typescript
// 1. Review core planning files
read_file("[planning_folder_path]/requirements.md", should_read_entire_file=true)
read_file("[planning_folder_path]/implementation-[feature].md", should_read_entire_file=true)

// 2. Check context files
read_file("[planning_folder_path]/context-[feature].md", should_read_entire_file=true)
read_file("[planning_folder_path]/README.md", should_read_entire_file=true)

// 3. Assess implementation progress
read_file("[planning_folder_path]/implementation-progress.md", should_read_entire_file=true)

// 4. Check test scenarios
if (file_exists("[planning_folder_path]/test-cheatsheet.md")) {
  read_file("[planning_folder_path]/test-cheatsheet.md", should_read_entire_file=true)
}
```

## Enhancement Strategy Selection

Based on the planning state analysis, select appropriate enhancement strategies:

1. **Requirements Enhancement**
   - Clarify ambiguous requirements
   - Add missing technical requirements
   - Provide implementation constraints
   - Include validation criteria

2. **Implementation Plan Enhancement**
   - Add detailed implementation steps
   - Improve phase organization
   - Enhance tool call sequences
   - Provide example implementations

3. **Context Enhancement**
   - Add architectural background
   - Include technical context
   - Document dependencies
   - Clarify integration points

4. **Test Strategy Enhancement**
   - Add comprehensive test scenarios
   - Include verification methods
   - Document edge cases
   - Provide validation checks

## Enhanced Research Process

Conduct thorough research using explicit tool calls:

```typescript
// 1. Research similar implementations
codebase_search("implementation of [related feature]", ["relevant directories"])

// 2. Analyze existing patterns
grep_search("pattern: [pattern name]", false, "*.md")

// 3. Access relevant knowledge
fetch_rules(["knowledge/rules/relevant/pattern"])

// 4. Examine related file structures
list_dir("path/to/related/implementation")

// 5. Read related implementation files
read_file("path/to/related/implementation/file", should_read_entire_file=true)
```

## Planning Document Enhancement

Apply research findings to enhance planning documents:

```typescript
// 1. Enhance requirements
edit_file("[planning_folder_path]/requirements.md",
          "Enhance requirements with additional details",
          "// ... existing content ...\n\n## Enhanced Requirements\n\n### Technical Constraints\n- [Constraint 1]\n- [Constraint 2]\n\n### Implementation Requirements\n- [Requirement 1]\n- [Requirement 2]\n\n### Validation Criteria\n- [Criterion 1]\n- [Criterion 2]\n\n// ... existing content ...")

// 2. Enhance implementation plan
edit_file("[planning_folder_path]/implementation-[feature].md",
          "Enhance implementation plan with detailed steps",
          "// ... existing content ...\n\n## Enhanced Implementation Approach\n\n### Tool Call Sequence\n```typescript\n// Example tool call sequence\nread_file(\"path/to/file\", should_read_entire_file=true)\ncodebase_search(\"search term\", [\"relevant directories\"])\nedit_file(\"path/to/file\", \"Edit description\", \"// Implementation code\")\n```\n\n### Example Implementation\n```typescript\n// Example implementation code\n```\n\n// ... existing content ...")

// 3. Enhance context
edit_file("[planning_folder_path]/context-[feature].md",
          "Enhance context with architectural information",
          "// ... existing content ...\n\n## Enhanced Architectural Context\n\n### Component Relationships\n- [Relationship 1]\n- [Relationship 2]\n\n### Technical Dependencies\n- [Dependency 1]\n- [Dependency 2]\n\n### Integration Points\n- [Integration Point 1]\n- [Integration Point 2]\n\n// ... existing content ...")

// 4. Enhance test strategy
if (file_exists("[planning_folder_path]/test-cheatsheet.md")) {
  edit_file("[planning_folder_path]/test-cheatsheet.md",
            "Enhance test strategy with comprehensive scenarios",
            "// ... existing content ...\n\n## Enhanced Test Scenarios\n\n### Edge Case Testing\n- [Edge Case 1]\n- [Edge Case 2]\n\n### Error Handling Tests\n- [Error Test 1]\n- [Error Test 2]\n\n### Performance Tests\n- [Performance Test 1]\n- [Performance Test 2]\n\n// ... existing content ...")
}
```

## Enhancement Value Assessment

After each enhancement iteration, assess if further enhancement would provide significant value:

```typescript
// Update implementation progress with enhancement assessment
edit_file("[planning_folder_path]/implementation-progress.md",
          "Document enhancement and assess further value",
          "// ... existing content ...\n\n## Planning Enhancement Assessment\n\n### Enhancements Applied\n- [Enhancement 1]\n- [Enhancement 2]\n\n### Enhancement Value Analysis\n- Current planning quality: [High/Medium/Low]\n- Implementation readiness: [Ready/Needs more work]\n- Further enhancement value: [High/Medium/Low]\n\n### Recommendation\n[Recommendation on whether to continue enhancement or proceed to implementation]\n\n// ... existing content ...")
```

## Common Enhancement Patterns

### Requirements Enhancement Pattern

```markdown
# Enhanced Requirements

## Core Requirements
[Original requirements remain unchanged]

## Technical Context
- System architecture constraints
- Performance expectations
- Security requirements
- Compatibility requirements

## Implementation Guidelines
- Preferred implementation patterns
- Technology constraints
- Code style requirements
- Documentation standards

## Acceptance Criteria
- Functional criteria
- Performance criteria
- Quality criteria
- Documentation criteria

## Risk Assessment
- Potential implementation challenges
- Mitigation strategies
- Performance considerations
- Security considerations
```

### Implementation Plan Enhancement Pattern

```markdown
# Enhanced Implementation Plan

## Implementation Approach
[Original approach remains unchanged]

## Detailed Phase Breakdown
### Phase 1: [Phase Name]
1. Task 1
   - Subtask 1.1
   - Subtask 1.2
   - Tool call sequence
   - Expected outcome
2. Task 2
   - Subtask 2.1
   - Subtask 2.2
   - Tool call sequence
   - Expected outcome

### Phase 2: [Phase Name]
[Similar detailed breakdown]

## Implementation Patterns
- Pattern 1: [Description and usage]
- Pattern 2: [Description and usage]

## Integration Points
- Integration Point 1: [Description and approach]
- Integration Point 2: [Description and approach]

## Verification Approach
- Verification Step 1: [Description and method]
- Verification Step 2: [Description and method]
```

## Enhancement Value Assessment Guidelines

When assessing whether further planning enhancement would provide diminishing returns, consider:

1. **Implementation Readiness**
   - Are the requirements clear and specific?
   - Is the implementation plan detailed and actionable?
   - Are all necessary context details provided?
   - Are test scenarios comprehensive?

2. **Planning Completeness**
   - Does the planning cover all aspects of the implementation?
   - Are edge cases and potential issues addressed?
   - Is the implementation approach well-defined?
   - Are verification methods established?

3. **Enhancement Impact**
   - Would further enhancement significantly improve implementation quality?
   - Would additional detail clarify ambiguous areas?
   - Would more research reveal important patterns?
   - Would enhancement reduce implementation time?

4. **Diminishing Returns Analysis**
   - Are enhancements becoming more minor with each iteration?
   - Has the planning reached a point of refinement where further changes are minimal?
   - Would time be better spent beginning implementation?
   - Is the implementation approach already well-validated?

## Enhancement Completion Signaling

When enhancement is complete and further iterations would provide diminishing returns:

```
📋 1000xdev [rules-workflow]

Planning enhancement complete:

Enhancements Applied:
- Enhanced requirements with technical constraints and validation criteria
- Improved implementation plan with detailed tool call sequences
- Added architectural context with component relationships
- Enhanced test strategy with edge cases and performance tests

Enhancement Value Analysis:
- Current planning quality: High
- Implementation readiness: Ready
- Further enhancement value: Low (diminishing returns)

Recommendation:
Further planning enhancement would provide diminishing returns. The planning documentation is comprehensive and implementation-ready. Recommend proceeding to implementation phase.

planning-enhancement-complete
```