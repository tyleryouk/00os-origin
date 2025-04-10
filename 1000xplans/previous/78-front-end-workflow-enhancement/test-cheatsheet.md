# Test Cheatsheet: Front-End Workflow Enhancement

## Overview

This document provides testing scenarios and verification steps for the front-end-workflow enhancement implementation. It serves as a quick reference for ensuring that the enhancement has been properly implemented and functions as expected.

## Directory Structure Verification

### Phase 1: Directory Structure Tests

| Test ID | Test Description | Expected Result | Verification Method |
|---------|-----------------|-----------------|-------------------|
| DS-1 | Verify plan-mode directory exists | Directory exists | `list_dir("1000xbrain/parameters/front-end/plan-mode")` |
| DS-2 | Verify dev-mode directory exists | Directory exists | `list_dir("1000xbrain/parameters/front-end/dev-mode")` |
| DS-3 | Verify direct-mode directory exists | Directory exists | `list_dir("1000xbrain/parameters/front-end/direct-mode")` |
| DS-4 | Verify helpers directory exists | Directory exists | `list_dir("1000xbrain/parameters/front-end/helpers")` |
| DS-5 | Verify helpers subdirectories exist | All subdirectories exist | Check each helpers subdirectory using `list_dir` |
| DS-6 | Verify README files exist | README.md exists in each directory | Check README.md in each directory |

### Directory Structure Test Commands

```typescript
// Check main directories
list_dir("1000xbrain/parameters/front-end/plan-mode")
list_dir("1000xbrain/parameters/front-end/dev-mode")
list_dir("1000xbrain/parameters/front-end/direct-mode")
list_dir("1000xbrain/parameters/front-end/helpers")

// Check helpers subdirectories
list_dir("1000xbrain/parameters/front-end/helpers/recovery")
list_dir("1000xbrain/parameters/front-end/helpers/finalization")
list_dir("1000xbrain/parameters/front-end/helpers/validation")
list_dir("1000xbrain/parameters/front-end/helpers/implementation")
list_dir("1000xbrain/parameters/front-end/helpers/analysis")
list_dir("1000xbrain/parameters/front-end/helpers/verification")

// Check README files
read_file("1000xbrain/parameters/front-end/plan-mode/README.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/dev-mode/README.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/direct-mode/README.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/helpers/README.md", should_read_entire_file=true)
```

## Parameter File Verification

### Phase 2: Plan-Mode Parameter Tests

| Test ID | Test Description | Expected Result | Verification Method |
|---------|-----------------|-----------------|-------------------|
| PM-1 | Verify plan-mode files migrated | All files present in plan-mode directory | Compare file list with migration plan |
| PM-2 | Verify plan-mode-subsystem.md exists | File exists and has expected content | Read file and verify content |
| PM-3 | Verify plan-mode-system-wide.md exists | File exists and has expected content | Read file and verify content |
| PM-4 | Verify plan-mode-performance.md exists | File exists and has expected content | Read file and verify content |
| PM-5 | Verify template files exist | Template files exist and have expected content | Read files and verify content |
| PM-6 | Verify cross-workflow files exist | Cross-workflow files exist and have expected content | Read files and verify content |
| PM-7 | Verify continue-planning.md exists | File exists and has expected content | Read file and verify content |

### Phase 3: Dev-Mode Parameter Tests

| Test ID | Test Description | Expected Result | Verification Method |
|---------|-----------------|-----------------|-------------------|
| DM-1 | Verify dev-mode files migrated | All files present in dev-mode directory | Compare file list with migration plan |
| DM-2 | Verify dev-mode-subsystem.md exists | File exists and has expected content | Read file and verify content |
| DM-3 | Verify dev-mode-system-wide.md exists | File exists and has expected content | Read file and verify content |
| DM-4 | Verify dev-mode-performance.md exists | File exists and has expected content | Read file and verify content |
| DM-5 | Verify cross-workflow files exist | Cross-workflow files exist and have expected content | Read files and verify content |
| DM-6 | Verify continue-implementation.md exists | File exists and has expected content | Read file and verify content |
| DM-7 | Verify continuation-specific files exist | Continuation files exist and have expected content | Read files and verify content |

### Phase 4: Direct-Mode Parameter Tests

| Test ID | Test Description | Expected Result | Verification Method |
|---------|-----------------|-----------------|-------------------|
| DI-1 | Verify direct-mode README.md exists | File exists and has expected content | Read file and verify content |
| DI-2 | Verify direct-mode-subsystem.md exists | File exists and has expected content | Read file and verify content |
| DI-3 | Verify direct-mode-system-wide.md exists | File exists and has expected content | Read file and verify content |
| DI-4 | Verify cross-workflow files exist | Cross-workflow files exist and have expected content | Read files and verify content |

### Phase 5: Helper Parameter Tests

| Test ID | Test Description | Expected Result | Verification Method |
|---------|-----------------|-----------------|-------------------|
| HP-1 | Verify helper files reorganized | All files present in appropriate subdirectories | Compare file list with migration plan |
| HP-2 | Verify recovery helpers exist | Files exist and have expected content | Read files and verify content |
| HP-3 | Verify validation helpers exist | Files exist and have expected content | Read files and verify content |
| HP-4 | Verify verification helpers exist | Files exist and have expected content | Read files and verify content |
| HP-5 | Verify analysis helpers exist | Files exist and have expected content | Read files and verify content |

### Parameter File Test Commands

```typescript
// Check plan-mode files
list_dir("1000xbrain/parameters/front-end/plan-mode")
read_file("1000xbrain/parameters/front-end/plan-mode/plan-mode-subsystem.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/plan-mode/plan-mode-system-wide.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/plan-mode/plan-mode-performance.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/plan-mode/template-basic.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/plan-mode/template-advanced.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/plan-mode/continue-planning.md", should_read_entire_file=true)

// Check dev-mode files
list_dir("1000xbrain/parameters/front-end/dev-mode")
read_file("1000xbrain/parameters/front-end/dev-mode/dev-mode-subsystem.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/dev-mode/dev-mode-system-wide.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/dev-mode/dev-mode-performance.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/dev-mode/continue-implementation.md", should_read_entire_file=true)

// Check direct-mode files
list_dir("1000xbrain/parameters/front-end/direct-mode")
read_file("1000xbrain/parameters/front-end/direct-mode/README.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/direct-mode/direct-mode-subsystem.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/front-end/direct-mode/direct-mode-system-wide.md", should_read_entire_file=true)

// Check helper files
list_dir("1000xbrain/parameters/front-end/helpers/recovery")
list_dir("1000xbrain/parameters/front-end/helpers/validation")
list_dir("1000xbrain/parameters/front-end/helpers/verification")
list_dir("1000xbrain/parameters/front-end/helpers/analysis")
```

## Documentation Verification

### Phase 6: Documentation Tests

| Test ID | Test Description | Expected Result | Verification Method |
|---------|-----------------|-----------------|-------------------|
| DO-1 | Verify front-end-workflow.md enhanced | File updated with comprehensive content | Read file and verify content |
| DO-2 | Verify README.md enhanced | File updated with comprehensive content | Read file and verify content |
| DO-3 | Verify reference documentation enhanced | File updated with comprehensive content | Read file and verify content |
| DO-4 | Verify cheatsheet documentation enhanced | File updated with comprehensive content | Read file and verify content |
| DO-5 | Verify specialized documentation created | Files exist and have expected content | Read files and verify content |
| DO-6 | Verify process-specific guidance created | Files exist and have expected content | Read files and verify content |
| DO-7 | Verify pattern documentation created | Files exist and have expected content | Read files and verify content |

### Documentation Test Commands

```typescript
// Check workflow documentation
read_file("1000xbrain/workflows/front-end-workflow.md", should_read_entire_file=true)
read_file("1000xbrain/workflows/front-end-workflow/README.md", should_read_entire_file=true)
read_file("1000xbrain/workflows/front-end-workflow/front-end-workflow-reference.md", should_read_entire_file=true)
read_file("1000xbrain/workflows/front-end-workflow/front-end-workflow-cheatsheet.md", should_read_entire_file=true)

// Check specialized documentation
list_dir("1000xbrain/workflows/front-end-workflow")
```

## Cross-Workflow Integration Verification

### Phase 7: Integration Tests

| Test ID | Test Description | Expected Result | Verification Method |
|---------|-----------------|-----------------|-------------------|
| IN-1 | Verify integration points enhanced | Integration points documented | Review integration documentation |
| IN-2 | Verify integration documentation created | Documentation exists and has expected content | Read files and verify content |
| IN-3 | Verify integration examples created | Examples exist and are clear | Review examples |
| IN-4 | Verify troubleshooting guidance provided | Guidance exists and is helpful | Review guidance |
| IN-5 | Verify cross-workflow parameters created | Parameters exist and function as expected | Check parameters |

### Integration Test Commands

```typescript
// Check integration documentation
grep_search("front-end-workflow", false, "1000xbrain/workflows/back-end-workflow/**/*.md")
grep_search("front-end-workflow", false, "1000xbrain/workflows/documentation-workflow/**/*.md")
grep_search("front-end-workflow", false, "1000xbrain/workflows/rules-workflow/**/*.md")

// Check cross-workflow parameters
list_dir("1000xbrain/parameters/front-end/plan-mode")
grep_search("back-end|documentation|rules", false, "1000xbrain/parameters/front-end/**/*.md")
```

## Functional Testing

### Plan-Mode Command Test

The following test verifies that the plan-mode command works with front-end workflow parameters:

```
plan-mode: front-end-workflow @parameters/front-end/plan-mode/template-basic.mdc
```

Expected result: Plan mode is activated with the front-end-workflow and the template is applied.

### Dev-Mode Command Test

The following test verifies that the dev-mode command works with front-end workflow parameters:

```
dev-mode: front-end-workflow @parameters/front-end/dev-mode/dev-mode-subsystem.mdc
```

Expected result: Dev mode is activated with the front-end-workflow and the subsystem enhancement approach is applied.

### Direct-Mode Command Test

The following test verifies that the direct-mode command works with front-end workflow parameters:

```
direct-mode: front-end-workflow @parameters/front-end/direct-mode/direct-mode-subsystem.mdc

prompt: Create a simple Button component
```

Expected result: Direct mode is activated with the front-end-workflow, research is conducted, and implementation begins.

## Completion Verification Checklist

- [ ] All directories created and properly structured
- [ ] All plan-mode parameters created and properly formatted
- [ ] All dev-mode parameters created and properly formatted
- [ ] All direct-mode parameters created and properly formatted
- [ ] All helper parameters organized and properly formatted
- [ ] Documentation enhanced and properly formatted
- [ ] Cross-workflow integration documented and implemented
- [ ] Functional tests pass for plan-mode, dev-mode, and direct-mode commands
- [ ] Backward compatibility maintained
- [ ] README files comprehensive and accurate
- [ ] Tool call patterns standardized and documented 