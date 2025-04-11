# Cycle Review Process

## Goal

Review completed cycle implementations to identify accomplishments, challenges, lessons learned, and enhancement opportunities for future cycles. This process provides a standardized approach to conducting effective cycle reviews and planning next steps in the cycle-manager system.

## Process Steps

### 1. Initialize Review

* Read the current cycle information from `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`
* Retrieve key cycle documentation:
  * Change request (`1000xbrain/system/cycle-manager/operational_feedback/change_request.md`)
  * Implementation plan (`1000xbrain/system/cycle-manager/operational_feedback/implementation_plan.md`)
  * Implementation log (`1000xbrain/system/cycle-manager/operational_feedback/implementation_log.md`)
  * Verification report (`1000xbrain/system/cycle-manager/operational_feedback/verification_report.md`)

### 2. Analyze Cycle Outcomes

* Compare initial requirements against final implementation
* Identify key accomplishments and successful components
* Document what worked well in the implementation approach
* Note any implementation patterns that should be replicated in future cycles

### 3. Assess Challenges and Solutions

* Identify significant challenges encountered during the cycle
* Document how these challenges were addressed
* Analyze the effectiveness of the solutions
* Note any unresolved challenges that should be addressed in future cycles

### 4. Evaluate Efficiency and Performance

* Assess the overall efficiency of the cycle implementation
* Compare planned vs. actual implementation time
* Identify process bottlenecks or inefficiencies
* Document opportunities for improving cycle performance

### 5. Document Lessons Learned

* Synthesize key lessons from the cycle implementation
* Document insights about process, implementation, or verification
* Note specific learnings related to the cycle-manager system
* Identify transferable lessons for other cycle types

### 6. Identify Enhancement Opportunities

* Review the entire implementation to identify enhancement opportunities
* Check for enhancement patterns described in `1000xbrain/system/cycle-manager/knowledge/enhancement-patterns.md`
* Categorize potential enhancements using the enhancement tracking schema
* Prioritize enhancements based on impact and feasibility

### 7. Update Enhancement Registry

* Access the enhancement registry at `1000xbrain/system/cycle-manager/operational_feedback/enhancement_registry.md`
* Add new enhancement opportunities identified during review
* Update existing enhancement entries if applicable
* Follow the standardized enhancement tracking schema

### 8. Plan Next Cycle

* Based on identified enhancements and remaining work:
  * Determine the focus for the next cycle
  * Establish preliminary priorities
  * Identify key requirements
  * Note specific process adjustments needed
* Create an initial plan for the next cycle

### 9. Prepare Completion Summary

* Create a completion summary for the current cycle at `1000xbrain/system/cycle-manager/operational_feedback/completion_summary.md`
* Include:
  * Implementation summary
  * Results achieved
  * Challenges encountered
  * Future enhancement opportunities
  * Next steps recommendation

### 10. Document Next Steps

* Clearly document the recommendation to initiate the next cycle:
  * `run command:system/cycle-manager/1`
* Include specific focus areas for the next cycle

## Error Handling

### Missing Documentation

* If key cycle documentation is missing:
  * Attempt to reconstruct from other available sources
  * Document the information gap in the review
  * Note the missing documentation as an issue for future cycles

### Unclear Outcomes

* If cycle outcomes are unclear or incomplete:
  * Document the specific ambiguities
  * Make reasonable assumptions where possible
  * Note the lack of clarity as an issue for future cycles

### Enhancement Identification Challenges

* If enhancement opportunities are difficult to identify:
  * Review similar past cycles for patterns
  * Consult enhancement-patterns.md for guidance
  * Focus on structural and process improvements if specific enhancements are unclear

## Integration Points

* **Initiation**: Triggered by `run command:system/cycle-manager/4` as part of cycle completion
* **Preceding Process**: Verification process or Refinement process
* **Following Process**: Cycle Initiation process (next cycle)
* **Related Knowledge**: Enhancement patterns, enhancement tracking schema

## Success Criteria

* Comprehensive review of cycle implementation and outcomes
* Clear documentation of accomplishments, challenges, and lessons learned
* Well-defined enhancement opportunities added to the registry
* Specific, actionable plan for the next cycle
* Complete completion summary documenting cycle results

## Expected Outputs

* Updated enhancement registry with new opportunities
* Completion summary documenting cycle results
* Initial plan guidance for the next cycle
* Clear next steps recommendation 