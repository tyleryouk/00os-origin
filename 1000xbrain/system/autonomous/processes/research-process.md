# Process: Autonomous Research

## Goal: Identify optimization opportunities across system components using advanced analysis techniques.

## Required Knowledge:
- research-principles.md
- pattern-recognition-principles.md
- complexity-metrics.md

## Steps:

1. **Process USER REQUEST SECTION**:
   * Check for USER REQUEST SECTION content in the repository
   * Parse the section to extract:
     * Request Summary
     * Constraints
     * Success Criteria
     * Priority
     * Mode (USER_DIRECTED/AUTONOMOUS)
   * Use this information to guide the research focus and approach
   * If operating in USER_DIRECTED mode, prioritize areas mentioned in the Request Summary
   * **(Error Handling)**: If USER REQUEST SECTION is not found, assume AUTONOMOUS mode and proceed with general system analysis

2. **Define Target Directories**:
   * List the primary system component directories:
     * `1000xrules/`
     * `1000xscripts/`
     * `1000xbrain/` (excluding `/system/autonomous/operational_feedback/`)
     * `1000xcommands/` (excluding `/system/autonomous/`)
     * `1000xplans/`
   * If USER_DIRECTED mode is active, filter or prioritize directories based on Request Summary

3. **Initial Directory Scan**:
   * For each target directory, use `list_dir` recursively to build a complete file inventory
   * Record file path, name, extension, size, and location metadata for each file
   * Group files by component type (rule, script, brain, command, plan)
   * Apply any constraints from USER REQUEST SECTION to filter relevant files

4. **Content Analysis**:
   * For each file (starting with smaller files and prioritizing .md files):
     * Use `read_file` to extract content
     * **Lexical Analysis**:
       * Search for placeholder patterns: "TODO", "TBD", "(Placeholder)", "to be added", "placeholder", "# (More principles to be added)"
       * Identify incomplete sections: sections with minimal content (< 50 chars)
       * Detect template markers: unchanged boilerplate text, example code
     * **Structural Analysis**:
       * Analyze document structure (headers, sections)
       * Check for incomplete structures (missing sections in standard templates)
       * Verify proper formatting and organization
     * **Context-Aware Analysis**:
       * Compare content to expected patterns for the file type
       * Check for consistency with related files
       * Verify appropriate level of detail for the component type
     * **USER REQUEST Alignment**:
       * If in USER_DIRECTED mode, assess how each file relates to the Request Summary
       * Tag files that directly impact Success Criteria

5. **Pattern Recognition**:
   * Apply pattern detection across files following pattern-recognition-principles.md:
     * **Similarity Detection**:
       * Compare files with similar names/purposes for duplicated content
       * Identify files with similar structures but different content
       * Look for near-duplicate sections across multiple files
     * **Standard Pattern Compliance**:
       * Check if files follow established naming conventions
       * Verify directory structure consistency
       * Identify files that deviate from component type standards
     * **File Relationship Analysis**:
       * Identify incomplete file groups (e.g., missing knowledge file for process)
       * Check for orphaned files (no references from other components)
     * **USER REQUEST Pattern Analysis**:
       * If in USER_DIRECTED mode, identify patterns relevant to the requested enhancement

6. **Complexity Assessment**:
   * For each file, calculate complexity metrics following complexity-metrics.md:
     * **Structural Complexity**:
       * Measure nesting depth, branching complexity
       * Count components, dependencies
       * Analyze length metrics relative to file type
     * **Conceptual Complexity**:
       * Assess concept density and abstraction level
       * Estimate cognitive load
       * Evaluate domain specificity requirements
     * **Implementation Complexity**:
       * Calculate verbosity and documentation ratios
       * Analyze parameter complexity and coupling degree
     * **Calculate Overall Complexity Score**:
       * Apply the scoring formula from complexity-metrics.md
       * Normalize scores within each component type
       * Flag files exceeding complexity thresholds for their type

7. **Prioritization**:
   * Combine findings from all analysis types
   * Apply priority calculation formula:
     * Priority = (Content Issues × 0.3) + (Pattern Issues × 0.3) + (Complexity Score × 0.4)
   * If in USER_DIRECTED mode, apply additional weighting based on alignment with Request Summary
   * Sort findings by priority score

8. **Structure Findings**:
   * Organize findings into categories:
     * **Content Quality Issues**: Placeholder content, minimal implementations
     * **Pattern Inconsistencies**: Deviations from standards, redundancies
     * **Complexity Hotspots**: Components exceeding complexity thresholds
     * **Structural Problems**: Missing files, incomplete relationships
     * **USER REQUEST Alignment**: How findings relate to the requested enhancement (if applicable)
   * For each finding, include:
     * File Path
     * Issue Category
     * Description (detailed explanation of the issue)
     * Severity (High/Medium/Low)
     * Priority Score
     * Recommended Action
     * Relation to USER REQUEST (if in USER_DIRECTED mode)

9. **Generate Research Report**:
   * Use `edit_file` to create a structured research findings report at:
     `1000xbrain/system/autonomous/operational_feedback/research_findings.md`
   * Format should include:
     * Operation Mode (USER_DIRECTED/AUTONOMOUS)
     * USER REQUEST SECTION Summary (if in USER_DIRECTED mode)
     * Executive Summary
     * Methodology
     * Prioritized Findings (categorized)
     * Statistical Analysis
     * Recommended Focus Areas
     * Alignment with Success Criteria (if in USER_DIRECTED mode)

10. **Signal Completion**:
    * Update completion log with summary of research phase
    * Indicate that research findings are ready for the planning phase
    * Include operation mode in the completion signal 