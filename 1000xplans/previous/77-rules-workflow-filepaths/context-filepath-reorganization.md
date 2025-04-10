# Context: Project-Rule-Parameter Filepath Reorganization and Missing Enhancements

## Overview

This document maps the reorganization of project-rule-parameters from the flat structure (`1000xbrain/parameters/rules/*.md`) to the new subdirectory structure, and identifies missing enhancements that need to be implemented. This mapping will guide our updates to references throughout the codebase and the creation of missing files.

## Directory Structure

The new organization places files into logical categories:

```
1000xbrain/parameters/rules/
├── README.md
├── plan-mode/
│   ├── plan-mode-front-end-enhancement.md
│   ├── plan-mode-subsystem.md
│   ├── plan-mode-error-recovery.md
│   ├── plan-mode-performance.md
│   ├── plan-mode-system-wide.md
│   ├── continue-planning.md
│   ├── continue-planning-front-end-enhancement.md  # MISSING - NEEDS TO BE CREATED
│   ├── template-basic.md
│   ├── template-advanced.md
│   ├── template-standard-hallucination.md
│   └── template-past-chat-hallucination.md
├── dev-mode/
│   ├── dev-mode-front-end-enhancement.md  # MISSING - NEEDS TO BE CREATED
│   ├── dev-mode-subsystem.md
│   ├── dev-mode-error-recovery.md
│   ├── dev-mode-performance.md
│   ├── dev-mode-system-wide.md
│   ├── continue-implementation.md
│   ├── continue-implementation-front-end-enhancement.md  # MISSING - NEEDS TO BE CREATED
│   ├── continue-implementation-subsystem.md
│   ├── continue-implementation-system-wide.md
│   ├── continue-implementation-performance.md
│   └── continue-implementation-error-recovery.md
├── helpers/
│   ├── analysis/
│   │   ├── analyze-related-rules.md
│   │   ├── audit-project-rules.md
│   │   ├── scan-message-commands.md
│   │   └── scan-symbol-usage.md
│   ├── verification/
│   │   ├── verify-backtick-wrapping.md
│   │   ├── verify-context-files.md
│   │   └── verify-implementation.md
│   ├── validation/
│   │   ├── validate-changes.md
│   │   ├── validate-path-format.md
│   │   ├── check-extension-format.md
│   │   └── check-references.md
│   ├── implementation/
│   │   ├── context-first-implementation.md
│   │   └── direct-implementation.md
│   ├── recovery/
│   │   └── direct-implementation-continuation.md
│   └── finalization/
│       └── finalize-implementation.md
└── no-planning-folder/
    ├── README.md
    ├── no-planning-folder-front-end-enhancement.md  # MISSING - NEEDS TO BE CREATED
    ├── no-planning-folder-subsystem.md  # MISSING - NEEDS TO BE CREATED
    └── no-planning-folder-system-wide.md  # MISSING - NEEDS TO BE CREATED
```

## File Migration Mapping

Below is the mapping of files from their original location to their new location:

### Plan-Mode Files

| Original Path | New Path |
|--------------|----------|
| `@parameters/rules/plan-mode-subsystem.mdc` | `@parameters/rules/plan-mode/plan-mode-subsystem.mdc` |
| `@parameters/rules/plan-mode-error-recovery.mdc` | `@parameters/rules/plan-mode/plan-mode-error-recovery.mdc` |
| `@parameters/rules/plan-mode-performance.mdc` | `@parameters/rules/plan-mode/plan-mode-performance.mdc` |
| `@parameters/rules/plan-mode-system-wide.mdc` | `@parameters/rules/plan-mode/plan-mode-system-wide.mdc` |
| `@parameters/rules/plan-mode-front-end-enhancement.mdc` | `@parameters/rules/plan-mode/plan-mode-front-end-enhancement.mdc` |
| `@parameters/rules/continue-planning.mdc` | `@parameters/rules/plan-mode/continue-planning.mdc` |
| `@parameters/rules/template-basic.mdc` | `@parameters/rules/plan-mode/template-basic.mdc` |
| `@parameters/rules/template-advanced.mdc` | `@parameters/rules/plan-mode/template-advanced.mdc` |
| `@parameters/rules/template-standard-hallucination.mdc` | `@parameters/rules/plan-mode/template-standard-hallucination.mdc` |
| `@parameters/rules/template-past-chat-hallucination.mdc` | `@parameters/rules/plan-mode/template-past-chat-hallucination.mdc` |

### Dev-Mode Files

| Original Path | New Path |
|--------------|----------|
| `@parameters/rules/dev-mode-subsystem.mdc` | `@parameters/rules/dev-mode/dev-mode-subsystem.mdc` |
| `@parameters/rules/dev-mode-error-recovery.mdc` | `@parameters/rules/dev-mode/dev-mode-error-recovery.mdc` |
| `@parameters/rules/dev-mode-performance.mdc` | `@parameters/rules/dev-mode/dev-mode-performance.mdc` |
| `@parameters/rules/dev-mode-system-wide.mdc` | `@parameters/rules/dev-mode/dev-mode-system-wide.mdc` |
| `@parameters/rules/continue-implementation.mdc` | `@parameters/rules/dev-mode/continue-implementation.mdc` |
| `@parameters/rules/continue-implementation-subsystem.mdc` | `@parameters/rules/dev-mode/continue-implementation-subsystem.mdc` |
| `@parameters/rules/continue-implementation-system-wide.mdc` | `@parameters/rules/dev-mode/continue-implementation-system-wide.mdc` |
| `@parameters/rules/continue-implementation-performance.mdc` | `@parameters/rules/dev-mode/continue-implementation-performance.mdc` |
| `@parameters/rules/continue-implementation-error-recovery.mdc` | `@parameters/rules/dev-mode/continue-implementation-error-recovery.mdc` |

### Helper Files

| Original Path | New Path |
|--------------|----------|
| `@parameters/rules/analyze-related-rules.mdc` | `@parameters/rules/helpers/analysis/analyze-related-rules.mdc` |
| `@parameters/rules/audit-project-rules.mdc` | `@parameters/rules/helpers/analysis/audit-project-rules.mdc` |
| `@parameters/rules/scan-message-commands.mdc` | `@parameters/rules/helpers/analysis/scan-message-commands.mdc` |
| `@parameters/rules/scan-symbol-usage.mdc` | `@parameters/rules/helpers/analysis/scan-symbol-usage.mdc` |
| `@parameters/rules/verify-backtick-wrapping.mdc` | `@parameters/rules/helpers/verification/verify-backtick-wrapping.mdc` |
| `@parameters/rules/verify-context-files.mdc` | `@parameters/rules/helpers/verification/verify-context-files.mdc` |
| `@parameters/rules/verify-implementation.mdc` | `@parameters/rules/helpers/verification/verify-implementation.mdc` |
| `@parameters/rules/validate-changes.mdc` | `@parameters/rules/helpers/validation/validate-changes.mdc` |
| `@parameters/rules/validate-path-format.mdc` | `@parameters/rules/helpers/validation/validate-path-format.mdc` |
| `@parameters/rules/check-extension-format.mdc` | `@parameters/rules/helpers/validation/check-extension-format.mdc` |
| `@parameters/rules/check-references.mdc` | `@parameters/rules/helpers/validation/check-references.mdc` |
| `@parameters/rules/context-first-implementation.mdc` | `@parameters/rules/helpers/implementation/context-first-implementation.mdc` |
| `@parameters/rules/direct-implementation.mdc` | `@parameters/rules/helpers/implementation/direct-implementation.mdc` |
| `@parameters/rules/direct-implementation-continuation.mdc` | `@parameters/rules/helpers/recovery/direct-implementation-continuation.mdc` |
| `@parameters/rules/finalize-implementation.mdc` | `@parameters/rules/helpers/finalization/finalize-implementation.mdc` |

## Missing Files to Create

The following files need to be created to complete the implementation of all requirements:

### Missing Front-End Enhancement Files

| File to Create | Purpose |
|--------------|----------|
| `parameters/rules/plan-mode/continue-planning-front-end-enhancement.md` | Continuation of front-end enhancement planning |
| `parameters/rules/dev-mode/dev-mode-front-end-enhancement.md` | Implementation of front-end enhancements |
| `parameters/rules/dev-mode/continue-implementation-front-end-enhancement.md` | Continuation of front-end enhancement implementation |

### Missing No-Planning-Folder Mode Files

| File to Create | Purpose |
|--------------|----------|
| `parameters/rules/no-planning-folder/no-planning-folder-front-end-enhancement.md` | Direct front-end enhancement without planning |
| `parameters/rules/no-planning-folder/no-planning-folder-subsystem.md` | Direct subsystem modifications without planning |
| `parameters/rules/no-planning-folder/no-planning-folder-system-wide.md` | Direct system-wide changes without planning |

## Content Pattern Requirements

### Front-End Enhancement Pattern

All front-end enhancement files should follow a consistent pattern:

1. **Plan-Mode Front-End Enhancement**: Focus on analyzing front-end files and planning enhancements to front-end-workflow documentation
2. **Dev-Mode Front-End Enhancement**: Focus on implementing changes to front-end-workflow documentation
3. **Continue-Planning Front-End Enhancement**: Focus on continuing the planning process for front-end enhancements
4. **Continue-Implementation Front-End Enhancement**: Focus on continuing the implementation of front-end enhancements
5. **No-Planning-Folder Front-End Enhancement**: Focus on direct implementation of front-end enhancements without planning

### No-Planning-Folder Mode Pattern

All no-planning-folder files should follow a consistent pattern:

1. **README.md**: Central documentation explaining the mode and its usage
2. **No-Planning-Folder Subsystem**: Direct subsystem enhancement without planning
3. **No-Planning-Folder System-Wide**: Direct system-wide enhancement without planning
4. **No-Planning-Folder Front-End Enhancement**: Direct front-end enhancement without planning

## Target Files for Updates

Based on our analysis, these are the files that need filepath reference updates:

### Core Communication Files
- `1000xbrain/core/communication/syntax-standards.md`
- `1000xbrain/core/communication/message-command-list.md`
- `1000xbrain/core/communication/symbol-guidelines.md`
- `1000xbrain/core/communication/message-commands.md`

### Mode Transitions Files
- `1000xbrain/core/modes/transitions/mode-transitions-handlers.md`

### Workflow Files
- `1000xbrain/workflows/rules-workflow.md`
- `1000xbrain/workflows/README.md`
- `1000xbrain/workflows/rules-workflow/message-commands-reference.md`
- `1000xbrain/workflows/rules-workflow/README.md`
- `1000xbrain/workflows/rules-workflow/rules-workflow-cheatsheet.md`

## Update Pattern

When updating references, we'll follow these guidelines:

1. Maintain proper backtick wrapping: Always wrap project-rule-parameter references in backticks.
2. Use correct file extensions: Use `.mdc` for project-rule-parameters in message-command examples.
3. Maintain existing formatting: Preserve list formats, table structures, and code blocks.
4. Update all examples: Ensure all example message-commands reflect the new structure.
5. Verify consistency: Ensure consistency across all files and cross-references.

## Usage Context

Different references appear in different contexts:

1. **Direct References**: Simple references like `@parameters/rules/plan-mode/plan-mode-subsystem.mdc`
2. **Message-Command Examples**: In command syntax examples like `plan-mode: rules-workflow @parameters/rules/plan-mode/plan-mode-subsystem.mdc`
3. **Table Entries**: In tables documenting available project-rule-parameters
4. **Code Blocks**: Within markdown code blocks
5. **Explanatory Text**: Within regular text that explains usage

Each context requires careful handling to maintain correct syntax and wrapping. 