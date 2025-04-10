# Knowledge: Autonomous Research Principles

## Core Goal: Optimization First

*   Prioritize identifying redundancy, inefficiency, or complexity for removal/simplification.
*   Seek opportunities to improve clarity and maintainability.
*   Enhancements (new features/capabilities) are secondary to optimization.

## Target Areas (Initial List)

*   `1000xrules`: Consistency, clarity, necessity of rules.
*   `1000xscripts`: Efficiency, error handling, relevance.
*   `1000xbrain`: Knowledge accuracy, process logic, guideline relevance.
*   `1000xcommands`: Command structure, tool call efficiency, redundancy.
*   `1000xplans`: Template effectiveness, clarity.

## Research Methodologies

### 1. Content Analysis

* **Placeholder Detection**: 
  * Identify files containing minimal content or explicit placeholder indicators.
  * Look for comments like "to be added," "placeholder," or "TODO."
  * Analyze content-to-structure ratio (files with lots of headings but little content).

* **Completeness Assessment**:
  * Verify critical sections exist in knowledge/process files.
  * Check for expected patterns in different file types.
  * Identify sections that lack sufficient detail or explanation.

* **Quality Metrics**:
  * Clarity of instruction in process files.
  * Comprehensiveness of knowledge files.
  * Consistency with established patterns.

### 2. Pattern Recognition

* **Code Pattern Analysis**:
  * Identify common code patterns across similar files.
  * Detect inconsistencies in command structure or process flow.
  * Find opportunities for abstraction or standardization.

* **Structural Alignment**:
  * Compare file structure across related components.
  * Identify misalignments between knowledge and process files.
  * Verify naming conventions and organizational patterns.

* **Reference Integrity**:
  * Analyze file references for correctness and consistency.
  * Identify circular references or orphaned references.
  * Detect missing connections between related components.

### 3. Complexity Assessment

* **Quantitative Metrics**:
  * Length of files (excessively long files may need refactoring).
  * Depth of nesting (especially in scripts).
  * Number of conditional branches.
  * Number of dependencies.

* **Qualitative Indicators**:
  * Clarity of purpose and responsibility.
  * Ease of understanding without contextual knowledge.
  * Degree of coupling between components.

* **Risk Analysis**:
  * Identify critical paths that require robust error handling.
  * Assess failure modes and recovery mechanisms.
  * Evaluate potential cascading effects of changes.

## Prioritization Framework

* **High Priority**:
  * Issues that block core functionality.
  * Structural problems that affect multiple components.
  * Clear violations of established patterns.
  * Missing critical components or references.

* **Medium Priority**:
  * Inconsistencies with minor impact.
  * Optimization opportunities with good ROI.
  * Incomplete but functional components.
  * Documentation gaps in important areas.

* **Low Priority**:
  * Minor stylistic issues.
  * Edge case handling improvements.
  * Enhancement suggestions beyond core optimization.
  * Documentation refinements for clarity.

## Output Standards

* **Findings Format**:
  * Categorize by subsystem/component.
  * Include specific file paths and line references.
  * Prioritize issues clearly.
  * Provide actionable recommendations.

* **Evidence Inclusion**:
  * Include snippets of relevant code or content.
  * Reference specific patterns or principles being violated.
  * Document before/after comparisons where applicable.

* **Planning Integration**:
  * Structure findings to facilitate direct conversion to plan tasks.
  * Group related issues for efficient resolution.
  * Include dependency information between issues. 