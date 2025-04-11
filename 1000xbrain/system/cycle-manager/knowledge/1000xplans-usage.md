# 1000xplans Usage Guidelines

## Overview

This document defines the purpose, structure, and usage guidelines for the `1000xplans` directory within the system architecture. The directory has been optimized to serve primarily as Tyler's domain for input, with clear separation between user input and system operation.

## Core Principles

1. **User-Focused Input**: The `1000xplans` directory serves primarily as Tyler's domain for providing input to the system.
2. **Minimal Structure**: Only essential files are maintained to reduce cognitive load and eliminate redundancy.
3. **Clear Role Separation**: There is a clear delineation between Tyler's role (input provider) and 1000xdev's role (primarily reading from 1000xplans).
4. **Operational Integration**: Seamless integration with the `operational_feedback` structure in `1000xbrain`.

## Directory Structure

### Optimized Structure

The optimized `1000xplans` directory structure includes:

* **`1000xplans/system/`**
  * `notes.md` - Primary file for Tyler's input via the USER REQUEST SECTION
  * `commands-index.md` - Reference file for available commands

* **`1000xplans/front-end/`** (as needed)
  * `notes.md` - Domain-specific input for front-end

* **`1000xplans/back-end/`** (as needed)
  * `notes.md` - Domain-specific input for back-end

### Deprecated Files

The following files are deprecated in the optimized structure:
* `implementation-progress.md` - Replaced by operational_feedback tracking
* `plan.md` - Replaced by implementation plans in operational_feedback
* `requirements.md` - Requirements now captured in change_request.md

## Role Separation

### Tyler's Role (Input Provider)

Tyler interacts with `1000xplans` by:
* Providing input through the USER REQUEST SECTION in `notes.md`
* Adding notes in the Tyler Youk section of `notes.md`
* Referencing the `commands-index.md` for available commands

### 1000xdev's Role (Reader)

1000xdev interacts with `1000xplans` by:
* Reading input from the USER REQUEST SECTION and Tyler Youk section
* Updating the USER REQUEST SECTION template (only exception to read-only approach)
* Maintaining the `commands-index.md` file
* NOT writing to any other parts of `notes.md` or creating additional files

## Integration with operational_feedback

The optimization establishes a clear workflow:

1. Tyler provides input in `1000xplans/system/notes.md`
2. 1000xdev reads this input during requirement analysis
3. 1000xdev creates a structured `change_request.md` in the appropriate `operational_feedback` directory
4. Implementation tracking, plans, logs, and verification occur in `operational_feedback`
5. No implementation artifacts are stored in `1000xplans`

## USER REQUEST SECTION Format

The standardized USER REQUEST SECTION format in `notes.md` is:

```markdown
## USER REQUEST SECTION

# --- TEMPLATE START ---
# Instructions:
# 1. Replace bracketed placeholders with your request details.
# 2. All directive fields are required - they help automate processing.
# 3. Run `1000xscripts/system/list-cycles.ps1` in terminal to see all available cycles.

# Directive: [Enhancement|Fix|Refactor|Analysis]
# Target Cycle: [domain/cycle-name]
# Enhancement Name: [Brief descriptive name]
# Priority: [High|Medium|Low]

# Enhancement Details
[Provide a clear description of what needs to be done. Be specific about requirements.]

# Focus Areas (Optional)
[Specific files or components that should receive attention]

# --- DIRECTIVE REFERENCE ---
# Enhancement: Add new functionality or improve existing features
# Fix: Correct problems or issues in existing functionality
# Refactor: Restructure code without changing functionality
# Analysis: Evaluate component(s) without making changes
# --- TEMPLATE END ---

## END USER REQUEST SECTION
```

## Usage Guidelines

### For Tyler

1. **Providing Input**:
   * Use the USER REQUEST SECTION in `notes.md` for all formal requests
   * Use the Tyler Youk notes section for less formal comments, observations, or future ideas
   * Keep requests clear and specific

2. **File Usage**:
   * Focus on `notes.md` and `commands-index.md`
   * Do not create additional files in this structure

### For 1000xdev

1. **Interacting with 1000xplans**:
   * Read from `notes.md` but do not write to it (except for the USER REQUEST SECTION template)
   * Maintain the `commands-index.md` file
   * Do not create additional files in this structure
   * Transform user input into structured documents in `operational_feedback`

2. **USER REQUEST SECTION Template**:
   * Only update the template portion of the USER REQUEST SECTION
   * Preserve any user input when updating
   * Keep the template clear and minimal

## Implementation Considerations

1. **Backward Compatibility**:
   * The optimized structure maintains compatibility with existing cycles
   * References to deprecated files in process documents should be updated

2. **Process Updates**:
   * Processes that previously referenced implementation-progress.md, plan.md, or requirements.md need updating
   * New process files should reference only the active files

3. **File Transition**:
   * Important information from deprecated files should be incorporated into the operational_feedback structure
   * No sudden deletion of files - gradually phase out as cycles are updated 