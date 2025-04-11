# User Request Handling

## Overview

This document defines the standard approach for handling USER REQUEST content within the cognitive architecture system. The system now uses a dedicated `user_request.md` file in the `1000xplans` directory to collect and process user requests, separate from personal notes.

## Core Principles

1. **Dedicated File Approach**: User requests are now stored in a dedicated `user_request.md` file, separate from `notes.md`, which is reserved for Tyler's personal notes.

2. **Clear File Separation**: This approach creates a clear separation between:
   - `user_request.md`: For 1000xdev to read and process (contains implementation instructions)
   - `notes.md`: Exclusively for Tyler's personal notes (not for implementation)
   - `commands-index.md`: Reference file for available commands (for Tyler's use only)

3. **Consistent Processing**: All cycles follow the same standardized approach for handling user requests:
   - Initialization creates/updates the user_request.md file with the USER REQUEST SECTION template
   - Requirement analysis reads from user_request.md to extract directives and requirements
   - All implementation tracking occurs in operational_feedback

## User Request Workflow

The standard workflow for processing user requests is:

1. **Initiation Phase**:
   - Creates/updates the user_request.md file with the USER REQUEST SECTION template
   - Preserves any existing user content if present
   - Ensures the template is consistently formatted

2. **Requirement Analysis Phase**:
   - Reads the user-filled request from user_request.md
   - Extracts directives, requirements, and focus areas
   - Creates structured change_request.md in operational_feedback
   - Preserves the user_request.md structure while resetting the template

## USER REQUEST SECTION Structure

The USER REQUEST SECTION in `1000xplans/system/user_request.md` follows this structure:

```markdown
## USER REQUEST SECTION

# --- TEMPLATE START ---
# Instructions:
# 1. Replace bracketed placeholders with your request details.
# 2. All directive fields are required - they help automate processing.
# 3. Run `1000xscripts/system/list-cycles.ps1` in terminal to see all available cycles.

# Directive: [Enhancement/Fix/Refactor/Analysis]
# Target Cycle: [system/cycle-manager | system/autonomous | system/major-changes | frontend/main | backend/main | All Cycles | System]
# Enhancement Name: [Brief descriptive name]
# Priority: [High/Medium/Low]
# Operation Mode: [USER_DIRECTED/AUTONOMOUS]

# Enhancement Details

[Detailed description of the requested enhancement, fix, refactor, or analysis]

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

## Implementation Guidelines

### Initialization Process

When initializing a cycle:

1. Read the existing user_request.md file if it exists
2. Create or update the USER REQUEST SECTION with the standard template
3. Preserve any user content outside the template

```markdown
# Implementation Example (Initialization)

1. Use `read_file` to check if `1000xplans/system/user_request.md` exists.
2. If it exists, preserve any user content in the USER REQUEST SECTION.
3. Use `edit_file` to create or update the file with the standardized template.
4. Signal to the user that the template is ready for input.
```

### Requirement Analysis Process

When analyzing requirements:

1. Use `read_file` to read the entire `1000xplans/system/user_request.md` file.
2. Extract the USER REQUEST SECTION content.
3. Parse directive fields (Directive, Target Cycle, Enhancement Name, Priority).
4. Extract detailed requirements from the Enhancement Details section.

```markdown
# Implementation Example (Requirement Analysis)

1. Use `read_file` to read the current `1000xplans/system/user_request.md`.
2. Extract directive information and request details.
3. Create structured change_request.md in operational_feedback.
4. Use `edit_file` to update user_request.md:
   - Keep the template fresh
   - Preserve any user content
```

## Special Considerations

1. **"All Cycles | System" Target Option**:
   - This is now a valid target option in the TARGET CYCLE directive
   - When specified, changes apply to all system cycles
   - System cycles include: cycle-manager, autonomous, major-changes

2. **Backward Compatibility**:
   - During transition, process files should check both user_request.md and notes.md
   - If user_request.md exists, it takes precedence over notes.md
   - Processes will be systematically updated to reference only user_request.md

3. **Template Management**:
   - The template should be kept minimal but informative
   - Only 1000xdev should update the template section
   - User content should always be preserved when updating the template

## Related Resources

- File Usage Guidelines: `1000xbrain/system/cycle-manager/knowledge/1000xplans-usage.md`
- Process Files:
  - `1000xbrain/system/cycle-manager/processes/initiation-process.md`
  - `1000xbrain/system/cycle-manager/processes/requirement-analysis-process.md` 