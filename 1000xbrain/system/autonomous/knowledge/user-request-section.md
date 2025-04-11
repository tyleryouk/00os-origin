# USER REQUEST SECTION Knowledge

## Overview

The USER REQUEST SECTION is a standardized template used in the system/autonomous cycle to capture user requirements and guide the enhancement process. This knowledge file documents the structure, purpose, and usage of the USER REQUEST SECTION.

## Structure

The USER REQUEST SECTION template follows this standard structure:

```markdown
# USER REQUEST SECTION

## Request Summary

[Brief description of the requested enhancement or task]

## Constraints

* [Constraint 1]
* [Constraint 2]

## Success Criteria

* [Criterion 1]
* [Criterion 2]

## Priority

[High/Medium/Low]

## Mode

[USER_DIRECTED/AUTONOMOUS]
```

### Section Descriptions

1. **Request Summary**:
   * A clear, concise description of the enhancement or task requested
   * Should identify the primary goal and scope
   * Provides the foundation for research and planning phases

2. **Constraints**:
   * Limitations or boundaries that must be respected during implementation
   * May include technical constraints, time limitations, resource restrictions
   * Helps scope the work appropriately

3. **Success Criteria**:
   * Specific, measurable outcomes that define successful completion
   * Used to verify that the implementation meets requirements
   * Referenced during verification and refinement phases

4. **Priority**:
   * Indicates the importance and urgency of the request
   * Options: High, Medium, Low
   * Influences resource allocation and scheduling

5. **Mode**:
   * Specifies how the cycle should operate
   * Options:
     * USER_DIRECTED: User provides specific requirements and guides the process
     * AUTONOMOUS: System identifies and implements enhancements with minimal user input
   * Affects the level of autonomy in decision-making throughout the cycle

## Usage in the Autonomous Cycle

### Initialization Phase

* In USER_DIRECTED mode, the USER REQUEST SECTION is provided by the user
* In AUTONOMOUS mode, the template is created but may be minimally populated
* The initialization process preserves any existing USER REQUEST SECTION content

### Research Phase

* Parses the USER REQUEST SECTION to guide analysis
* Uses Request Summary to focus research on relevant areas
* Applies Constraints to filter and prioritize findings
* References Success Criteria to align research with desired outcomes
* Adapts process based on specified Mode

### Planning Phase

* Structures implementation plan to address Request Summary
* Ensures plan respects all specified Constraints
* Designs tasks to meet Success Criteria
* Adjusts planning detail based on Priority
* Tailors autonomy level according to Mode

### Implementation Phase

* Executes plan with awareness of all USER REQUEST SECTION parameters
* Frequently references Success Criteria during implementation
* Adheres to Constraints throughout the process
* Documents implementation details with traceability to Request Summary

### Verification Phase

* Directly measures implementation against Success Criteria
* Ensures Constraints were respected
* Verifies that the Request Summary goals were achieved
* Adapts verification depth based on Priority
* Adjusts verification autonomy based on Mode

### Refinement Phase

* Addresses any gaps between implementation and Success Criteria
* Makes adjustments while continuing to respect Constraints
* Ensures final solution fully addresses the Request Summary

## Best Practices

1. **Clarity and Specificity**:
   * Request Summary should be specific enough to guide implementation
   * Success Criteria should be measurable and unambiguous
   * Constraints should be clearly defined

2. **Completeness**:
   * All sections should be populated for optimal cycle execution
   * Missing sections may lead to assumptions or default behaviors

3. **Consistency**:
   * Ensure alignment between sections (e.g., Success Criteria should address Request Summary)
   * Avoid contradictions between Constraints and other sections

4. **Appropriate Mode Selection**:
   * USER_DIRECTED: For specific, well-defined enhancements requiring user guidance
   * AUTONOMOUS: For exploratory enhancements where the system can make decisions

5. **Priority Accuracy**:
   * Assign Priority based on genuine importance and urgency
   * Consider system impact when determining Priority

## Integration with Processes

The USER REQUEST SECTION is referenced and processed by multiple system/autonomous processes:

1. **initiate-cycle-process.md**: Creates or preserves the USER REQUEST SECTION
2. **research-process.md**: Parses the section to guide analysis
3. **planning-process.md**: Uses the section to structure the implementation plan
4. **implementation-process.md**: References the section during execution
5. **verification-process.md**: Validates implementation against Success Criteria
6. **refinement-process.md**: Makes adjustments to meet Success Criteria

Each process integrates with the USER REQUEST SECTION in specific ways to ensure alignment throughout the cycle. 