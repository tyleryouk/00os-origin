# Available Directives Knowledge

## Overview

This document defines the global directives available within the `USER REQUEST SECTION` format. Directives provide a streamlined way to trigger specific system actions without requiring a full change request narrative. They enable efficient interaction with cycle-manager and other cycles.

## Directive Structure

Directives follow a standardized format within the `USER REQUEST SECTION`:

```markdown
## USER REQUEST SECTION

# Directive: [Directive Name]
# Target Cycle: [Cycle Name]
# [Optional Parameter 1]: [Value]
# [Optional Parameter 2]: [Value]
# Directive Notes: [Optional additional context]

## END USER REQUEST SECTION
```

## Available Directives

### 1. Analyze Cycle

**Purpose**: Triggers analysis of a specific cycle to identify potential enhancements, issues, or optimization opportunities.

**Required Parameters**:
- `Directive: Analyze Cycle`
- `Target Cycle: [cycle-name]`

**Optional Parameters**:
- `Analysis Focus: [focus-area]` - Specifies a particular aspect to focus analysis on (e.g., Bottlenecks, Documentation, Implementation, Integration)
- `Directive Notes: [context]` - Provides additional context for the analysis

**Example**:
```markdown
## USER REQUEST SECTION

# Directive: Analyze Cycle
# Target Cycle: autonomous
# Analysis Focus: Documentation
# Directive Notes: Looking specifically for opportunities to improve process documentation clarity.

## END USER REQUEST SECTION
```

### 2. Enhancement

**Purpose**: Requests a specific enhancement to a cycle.

**Required Parameters**:
- `Directive: Enhancement`
- `Target Cycle: [cycle-name]`
- `Enhancement Name: [brief-name]`
- `Priority: [High/Medium/Low]`

**Optional Parameters**:
- `Enhancement Details: [details]` - Detailed description of the enhancement
- `Focus Areas: [bullet-points]` - Specific areas to focus on

**Example**:
```markdown
## USER REQUEST SECTION

# Directive: Enhancement
# Target Cycle: cycle-manager
# Enhancement Name: Reporting System
# Priority: Medium
# Enhancement Details: Add capability to generate summary reports of cycle activities

## END USER REQUEST SECTION
```

### 3. List Cycles

**Purpose**: Requests a list of all available cycles in the system.

**Required Parameters**:
- `Directive: List Cycles`

**Optional Parameters**:
- `Domain: [system/frontend/backend/all]` - Limits listing to a specific domain
- `Directive Notes: [context]` - Additional context for the request

**Example**:
```markdown
## USER REQUEST SECTION

# Directive: List Cycles
# Domain: system

## END USER REQUEST SECTION
```

## Using Directives

To use a directive:

1. Edit `1000xplans/[domain]/notes.md`
2. Update the `USER REQUEST SECTION` with the appropriate directive format
3. Run the appropriate cycle-manager command (typically `run command:system/cycle-manager/1`)

The cycle-manager will detect the directive format and process it accordingly, often bypassing the standard change request analysis for more streamlined execution.

## Adding New Directives

New directives can be added to this knowledge file after implementing the corresponding processing logic in:
- `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md`
- Any additional process files needed for the directive's execution

## Related Process Files

- `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md` - Handles initial directive parsing
- `1000xbrain/system/cycle-manager/processes/cycle-analysis-process.md` - Handles the Analyze Cycle directive execution 