# Cycle Verification Process

## Goal

Verify that cycle implementations meet all requirements, adhere to documentation standards, and function as expected within the unified cycle model. This process provides a standard approach for verifying cycle-manager implementations across all cycle types.

## Process Steps

### 1. Initialize Verification

* Read the current cycle information from `1000xbrain/system/cycle-manager/operational_feedback/current_cycle.md`
* Identify the implementation phase and requirements from associated documentation:
  * Change request (`1000xbrain/system/cycle-manager/operational_feedback/change_request.md`)
  * Implementation plan (`1000xbrain/system/cycle-manager/operational_feedback/implementation_plan.md`)
  * Implementation log (`1000xbrain/system/cycle-manager/operational_feedback/implementation_log.md`)
  
* Determine verification criteria based on operation mode (autonomous or user-directed)

### 2. Prepare Verification Environment

* Create `1000xbrain/system/cycle-manager/operational_feedback/verification_report.md` if it doesn't exist
* Document basic verification information:
  * Cycle ID
  * Change request references
  * Implementation plan references
  * Implementation log references

### 3. Verify Requirements Implementation

* For each requirement defined in the change request or implementation plan:
  * Verify that the implementation addresses the requirement
  * Document evidence of implementation
  * Rate the implementation status (verified, partially verified, failed verification)
  * Note any issues or discrepancies

### 4. Verify Structure and Organization

* Verify that all required files and directories exist
* Check that files follow standardized naming conventions
* Verify cross-references between files are accurate
* Verify adherence to minimalist documentation standards
* Check for consistency across all implementation components

### 5. Verify Functional Operation

* Verify that implemented processes can be executed as designed
* Check all command files and ensure they correctly reference process files
* Verify that the implementation works in both autonomous and user-directed modes
* Test integration with other system components

### 6. Verify Success Criteria

* For each success criterion defined in the change request:
  * Assess whether the criterion has been met
  * Document evidence supporting the assessment
  * Rate the status (met, partially met, not met)
  * Note any issues requiring refinement

### 7. Document Issues and Refinement Needs

* Identify and document any issues discovered during verification
* Categorize issues by type (structural, functional, integration, documentation, etc.)
* Prioritize issues based on impact
* Document potential solutions or refinement approaches

### 8. Determine Overall Verification Status

* Assess the overall implementation status based on:
  * Requirements verification status
  * Structure verification status
  * Functional verification status
  * Success criteria verification status
* Determine if refinement is needed before completion
* Assign an overall status (SUCCESSFUL, PARTIALLY SUCCESSFUL, FAILED)

### 9. Document Next Steps

* Based on verification status, recommend next steps:
  * If SUCCESSFUL: Proceed to completion (`run command:system/cycle-manager/7`)
  * If PARTIALLY SUCCESSFUL: Proceed to refinement (`run command:system/cycle-manager/6`)
  * If FAILED: Return to implementation (`run command:system/cycle-manager/4`)
* Document specific refinement priorities if applicable

### 10. Finalize Verification Report

* Complete and review the verification report
* Ensure all sections are properly documented
* Add verification timestamp and status
* Save verification results to `1000xbrain/system/cycle-manager/operational_feedback/verification_report.md`

## Error Handling

### Missing Requirements Documentation

* If change request or implementation plan is not found:
  * Check alternative locations
  * Create minimum viable documentation based on implementation evidence
  * Note the documentation gap in the verification report

### Implementation Gaps

* If required components are missing:
  * Document the specific gaps
  * Assess the impact on overall functionality
  * Recommend specific implementations to address the gaps

### Inconsistent Standards

* If implementation doesn't follow standards:
  * Document the specific inconsistencies
  * Reference relevant standards documentation
  * Suggest specific updates to align with standards

## Integration Points

* **Initiation**: Triggered by `run command:system/cycle-manager/5`
* **Preceding Process**: Implementation process
* **Following Process**: Refinement process or Completion process
* **Related Knowledge**: Enhancement tracking schema, documentation standards

## Success Criteria

* All requirements are verified against implementation
* All success criteria are assessed
* Issues are clearly documented with refinement approaches
* Overall verification status accurately reflects implementation state
* Clear next steps are defined based on verification results

## Expected Outputs

* Complete verification report at `1000xbrain/system/cycle-manager/operational_feedback/verification_report.md`
* Updated current cycle status
* Clear refinement guidance if needed 