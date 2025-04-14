# 00reaper Folder Structure and Organization

## Overview
This document provides a comprehensive map of the 00reaper folder structure, which serves as the primary operational environment for 00OS development, maintenance, and system administration.

## Directory Structure

```
00reaper/                             # Main 00reaper directory
├── config/                           # Configuration files
│   ├── reaper-init.config.json       # Config for reaper-init command
│   └── [other configs]               # Additional configurations
├── enhancements/                     # Enhancement proposals and documentation
│   ├── 2023-06-08-command-composition.md
│   ├── 2023-06-10-context-management-system.md
│   ├── 2023-06-15-process-state-management.md
│   ├── 2023-06-15-sync-command.md
│   ├── 2025-04-14-rule-type-sync-fix.md
│   └── 2025-04-15-reaper-init-enhancement.md
├── research/                         # Research findings and technical investigations
│   └── 2023-06-10-context-management-research.md
├── state/                            # Context state files and history
│   └── context-state-[timestamp].json
├── ai-terminal-research.md           # Background research on AI terminals
├── command-parser.md                 # Command parsing architecture
├── context-management.md             # Context preservation strategies
├── enhancement-tracker.md            # Central tracking for all enhancements
├── final-goal.md                     # Defined target state and objectives
├── folder-structure.md               # This document - organization overview
├── implementation-summary.md         # Summary of implementation approach
├── mdc-file-guide.md                 # Guide for .mdc file format
├── notes.md                          # Development session notes
├── process-format.md                 # Standard process file format
├── process-implementation-strategy.md # Strategy for process development
├── sync-migration-strategy.md        # Strategy for syncing between 00os and .cursor/rules
├── system-architecture.md            # System architecture documentation
├── terminal-implementation-plan.md   # Implementation plan for terminal
├── terminal-interface-design.md      # Terminal interface technical design
├── terminal-interface-goals.md       # Goals for the terminal interface
├── understanding-00os.md             # Core overview of the 00OS system
└── user-rules.md                     # Rules for user interaction
```

## File Categories

The files in the 00reaper directory are organized into logical categories to facilitate efficient context loading:

### Core Understanding
Essential files that define the core architecture and purpose:
- understanding-00os.md
- final-goal.md
- system-architecture.md

### Implementation Strategy
Files related to the development approach and implementation:
- process-implementation-strategy.md
- sync-migration-strategy.md
- implementation-summary.md
- mdc-file-guide.md

### Interface Design
Files related to command flow and user experience:
- terminal-interface-design.md
- terminal-interface-goals.md
- command-parser.md
- terminal-implementation-plan.md

### Process Format
Files defining the execution framework:
- process-format.md

### Knowledge Management
Files handling context and session continuity:
- context-management.md
- user-rules.md
- folder-structure.md (this file)

### Enhancement Tracking
Files tracking system evolution:
- enhancement-tracker.md
- enhancements/*.md (individual enhancement proposals)

### Research and Notes
Background information and session records:
- ai-terminal-research.md
- notes.md
- research/*.md (detailed research documents)

## Directory Purposes

### config/
Contains configuration files for various system components. These files define behavior, preferences, and operational parameters for 00OS commands and features.

### enhancements/
Stores detailed proposals and documentation for system enhancements. Each file follows a standardized format with metadata, current limitations, proposed changes, and implementation details.

### research/
Contains in-depth technical investigations, findings, and research on specific topics relevant to 00OS development.

### state/
Stores context state files generated during system operations. These files provide continuity between sessions and track the historical state of the system.

## Usage Guidelines

1. **File Naming**:
   - Core documents: descriptive-name.md
   - Enhancements: YYYY-MM-DD-enhancement-name.md
   - Research: YYYY-MM-DD-research-topic.md
   - State files: context-state-[timestamp].json

2. **Content Structure**:
   - All documents should have a clear title as the first heading
   - Implementation files should include metadata, purpose, and detailed sections
   - Enhancement proposals must follow the standard enhancement template

3. **Organization**:
   - New files should be placed in the appropriate directory based on their purpose
   - The enhancement-tracker.md file must be updated when new enhancements are added
   - Notes.md should be updated with session information

## Context Loading

The reaper-init command uses this structure to efficiently load context, with files organized by category for optimized loading and prioritization. The config/reaper-init.config.json file defines loading parameters and profiles for different initialization scenarios. 