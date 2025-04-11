# Cycle-Manager Command References

## Overview

This document provides standardized references for all cycle-manager commands, ensuring consistent documentation and implementation. These references serve as the source of truth for command structure and operation.

## Command File Structure

All cycle-manager commands follow a standardized structure:

1. **Header**: Clear title indicating the command purpose
2. **Dynamic Execution**: Reference to the relevant process file
3. **Description**: Brief explanation of command function
4. **Next Step**: Guidance on the next command in sequence

## Command References

### 1. Cycle Initiation

**Command File**: `1000xcommands/system/cycle-manager/1.md`
**Process Reference**: `1000xbrain/system/cycle-manager/processes/initiation-process.md`
**Function**: Initializes a new cycle and prepares the environment
**Next Step**: `run command:system/cycle-manager/2`

### 2. Requirement Analysis

**Command File**: `1000xcommands/system/cycle-manager/2.md`
**Process Reference**: `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md`
**Function**: Analyzes requirements and determines execution mode
**Next Step**: `run command:system/cycle-manager/3`

### 3. Planning

**Command File**: `1000xcommands/system/cycle-manager/3.md`
**Process Reference**: `1000xbrain/system/cycle-manager/processes/planning-process.md`
**Function**: Creates an implementation plan for the cycle
**Next Step**: `run command:system/cycle-manager/4`

### 4. Implementation

**Command File**: `1000xcommands/system/cycle-manager/4.md`
**Process Reference**: `1000xbrain/system/cycle-manager/processes/implementation-process.md`
**Function**: Executes the planned changes
**Next Step**: `run command:system/cycle-manager/5`

### 5. Verification

**Command File**: `1000xcommands/system/cycle-manager/5.md`
**Process Reference**: `1000xbrain/system/cycle-manager/processes/cycle-verification-process.md`
**Function**: Verifies that implementation meets requirements
**Output File**: `1000xbrain/system/cycle-manager/operational_feedback/verification_report.md`
**Next Step**: `run command:system/cycle-manager/6` or `run command:system/cycle-manager/7`

### 6. Refinement

**Command File**: `1000xcommands/system/cycle-manager/6.md`
**Process Reference**: `1000xbrain/system/cycle-manager/processes/refinement-process.md`
**Function**: Addresses issues identified during verification
**Next Step**: `run command:system/cycle-manager/7`

### 7. Completion

**Command File**: `1000xcommands/system/cycle-manager/7.md`
**Process Reference**: `1000xbrain/system/cycle-manager/processes/completion-process.md` and `1000xbrain/system/cycle-manager/processes/cycle-review-process.md`
**Function**: Finalizes the cycle and documents results
**Output File**: `1000xbrain/system/cycle-manager/operational_feedback/completion_summary.md`
**Next Step**: `run command:system/cycle-manager/1` (for next cycle)

## File Path Standards

### Command Files

All command files are stored in `1000xcommands/system/cycle-manager/` with numeric filenames (1.md through 7.md).

### Process Files

Process files are stored in `1000xbrain/system/cycle-manager/processes/` with descriptive filenames following the pattern `[function]-process.md`.

### Operational Feedback Files

Operational feedback files are stored in `1000xbrain/system/cycle-manager/operational_feedback/` with standardized filenames:

* `current_cycle.md` - Information about the current cycle
* `change_request.md` - Details of the requested change
* `implementation_plan.md` - Plan for implementing the change
* `implementation_log.md` - Log of implementation actions
* `verification_report.md` - Results of the verification process
* `completion_summary.md` - Summary of cycle completion
* `enhancement_registry.md` - Registry of enhancement opportunities

## Standardization Notes

1. **File Naming**: All filenames should use consistent conventions:
   * Use hyphens, not underscores, in process file names
   * Use underscores, not hyphens, in operational feedback file names

2. **Command References**: When referencing commands in documentation:
   * Use the format `run command:system/cycle-manager/N` (where N is the command number)
   * Always wrap in backticks for clarity

3. **File References**: When referencing files in documentation:
   * Use the full path relative to the repository root
   * Always wrap in backticks
   * Use consistent terminology (report, not results) 