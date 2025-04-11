# Naming Conventions for Cycle Management System

## Overview

This document establishes consistent naming conventions for all elements within the cycle management system. Adhering to these conventions ensures clarity, maintainability, and system-wide consistency.

## General Principles

1. **Consistency**: Names should be consistent across all cycles and domains
2. **Clarity**: Names should clearly indicate purpose and content
3. **Specificity**: Names should be specific enough to avoid ambiguity
4. **Brevity**: Names should be concise while remaining clear
5. **Kebab-case**: Use kebab-case (lowercase words separated by hyphens) for all file and directory names

## Cycle Names

Cycles must be named following these conventions:

1. **Format**: Use kebab-case (e.g., `cycle-manager`, `component-creator`)
2. **Descriptiveness**: Names must describe the cycle's primary function
3. **Domain Prefixing**: No domain prefixing in the cycle name itself (domain is indicated by directory structure)
4. **Uniqueness**: Names must be unique within their domain

Examples of well-named cycles:
- `cycle-manager` (creates and manages cycles)
- `knowledge-enhancer` (enhances knowledge files)
- `component-creator` (creates UI components)
- `data-processor` (processes data sources)

## Command Files

Command files within cycles follow a strictly numeric convention:

1. **Primary Files**: Use single numbers (1.md through 7.md) for the 7 sequential steps
2. **Documentation**: Use README.md for the cycle documentation
3. **No Other Files**: Additional functionality should be implemented through brain components, not through additional command files

## Process Files

Process files in `1000xbrain/<domain>/<cycle-name>/processes/` follow these conventions:

1. **Naming Pattern**: `<action>-<subject>-process.md`
2. **Action Verbs**: Use clear action verbs (e.g., initiate, analyze, plan, implement, verify, refine, complete)
3. **Standard Process Set**: Every cycle should have these standard processes:
   * `initiate-cycle-process.md` (for command 1)
   * `analyze-requirements-process.md` (for command 2)
   * `plan-implementation-process.md` (for command 3)
   * `implement-changes-process.md` (for command 4)
   * `verify-changes-process.md` (for command 5)
   * `refine-changes-process.md` (for command 6)
   * `complete-cycle-process.md` (for command 7)
4. **Additional Processes**: Specialized processes should follow the same pattern (e.g., `create-knowledge-process.md`)

## Knowledge Files

Knowledge files in `1000xbrain/<domain>/<cycle-name>/knowledge/` follow these conventions:

1. **Naming Pattern**: `<subject>[-<qualifier>].md`
2. **Topic Focus**: Each file should focus on a single well-defined knowledge area
3. **Standard Knowledge Set**: Core cycles should have standardized knowledge files:
   * `cycle-structure.md` (for defining cycle structure)
   * `unified-model.md` (for defining the unified operation model)
   * `naming-conventions.md` (for consistent naming)
   * `best-practices.md` (for optimal implementation patterns)
4. **Domain-Specific Knowledge**: Additional knowledge files specific to the cycle's domain should follow the same pattern

## Operational Feedback Files

Files in `1000xbrain/<domain>/<cycle-name>/operational_feedback/` follow these conventions:

1. **Current Cycle**: Always named `current_cycle.md`
2. **User Requests**: Named `change_request.md` when capturing user requirements
3. **Implementation Plans**: Named `implementation_plan.md`
4. **Implementation Logs**: Named `implementation_log.md`
5. **Verification Reports**: Named `verification_report.md`
6. **Enhancement Tracking**: Named `potential_enhancements.md`
7. **Archived Cycles**: Named `archived_cycles.md` or `archived_cycle_<ID>.md` for individual archives

## Command Invocation

Command invocation follows this standard format:

1. **Full Format**: `run command:<domain>/<cycle-name>/<command-number>`
2. **Examples**:
   * `run command:system/cycle-manager/1`
   * `run command:frontend/component-creator/3`
   * `run command:backend/api-builder/7`

## Directory Structures

Directory structure follows these conventions:

1. **Command Structure**:
   ```
   1000xcommands/
     └── <domain>/
         └── <cycle-name>/
             ├── 1.md
             ├── 2.md
             └── ...
   ```

2. **Brain Structure**:
   ```
   1000xbrain/
     └── <domain>/
         └── <cycle-name>/
             ├── knowledge/
             │   └── <subject>.md
             ├── processes/
             │   └── <action>-<subject>-process.md
             └── operational_feedback/
                 └── current_cycle.md
   ```

## Special Case: Guideline Files

Guideline files in `1000xbrain/system/guidelines/` follow these conventions:

1. **Naming Pattern**: `<area>-<topic>.md`
2. **Area Prefixes**: Common areas include:
   * `implementation-` (for implementation guidelines)
   * `cycle-` (for cycle-related guidelines)
   * `documentation-` (for documentation guidelines)
   * `testing-` (for testing guidelines)
3. **Examples**:
   * `cycle-standardization.md`
   * `implementation-best-practices.md`
   * `documentation-standards.md`

## References

* Cycle Structure: `1000xbrain/system/cycle-manager/knowledge/cycle-structure.md`
* Unified Model Documentation: `1000xbrain/system/cycle-manager/knowledge/unified-model.md`
* System Guidelines Directory: `1000xbrain/system/guidelines/` 