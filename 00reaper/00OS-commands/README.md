# 00OS Command Development Hub

This directory serves as the central hub for 00OS command development, management, and optimization. It contains the tools, documentation, and workflow guides needed to develop and maintain the 00OS command system.

## Directory Structure

```
00reaper/00OS-commands/
│
├── README.md                    # This file - main entry point
├── current-task.md              # Current development focus
├── current-implementation.md    # Current system state documentation
├── major-changes.md             # Record of significant changes
│
├── context/                     # Context files for current state of 00OS operating system
├── templates/                   # Command templates and patterns
├── documentation/               # System documentation
├── testing/                     # Testing resources and guides
└── user-directed/               # User-focused resources
```

## Core Development Workflow

To work with the 00OS command system, follow this two-command workflow:

1. **Define Task:** Update `current-task.md` with your specific development goal.

2. **Load Context & Implement:**
   * Run `> reaper-read-files 00reaper/00OS-commands` to load context
   * Run `> reaper-implement` to analyze and implement your task

## Command Organization

As per REQ-000, all 00OS commands are now organized into three main categories:

1. **Global System Commands** (`00os/processes/system/` directory)
   * Commands available to any AI Agent (e.g., help, echo, system-status)
   * Core system functionality that works regardless of identity

2. **Global Tool Commands** (`00os/processes/tools/` directory)
   * Utility commands available to any AI Agent (e.g., file-list, file-read)
   * Generic tools that work regardless of identity

3. **AI Agent-Specific Commands**
   * **00reaper Commands** (`00os/processes/00reaper/` directory)
     * Commands specific to the 00reaper AI Agent (e.g., reaper-init, reaper-sync)
     * Work with workflow files located in the 00reaper directory
   * **1000xdev Commands** (`00os/processes/1000xdev/` directory)
     * Commands specific to the 1000xdev AI Agent (planned)
     * Will work with workflow files located in the 1000xdev directory

When implementing new commands, place them in the appropriate category based on their purpose and the AI Agent they're designed for.

## Key Resources

### Core Workflow Files (Root Directory)
* **current-task.md** - Define your immediate development goals here
* **current-implementation.md** - Overview of the current system state
* **major-changes.md** - Records significant architectural changes
* **hallucination-log.md** - Tracks known hallucination issues

### Templates (`templates/`)
* **command-template.md** - Primary template for new commands
* **implemented-patterns.md** - Standard tool call patterns
* **command-standards.md** - Command implementation standards

### Documentation (`documentation/`)
* **00OS-command-development.md** - Comprehensive development guide
* **00OS-command-user-guide.md** - End-user documentation
* **command-registry.md** - Command registry documentation

### Testing (`testing/`)
* **testing-guide.md** - Guidelines for testing commands
* **testing-framework.md** - Framework for systematic testing

### User Resources (`user-directed/`)
* **user_requests.md** - Tracking of user enhancement requests

## Command Implementation Process

1. Review `current-task.md` to understand the goal
2. Check `documentation/00OS-command-development.md` for standards
3. Use appropriate template from `templates/`
4. Implement and test following the testing guide
5. Update tracking documentation

## Critical Principles

1. **Tool Call Architecture** - 00OS commands execute via a sequence of tool calls
2. **Mandatory Rule Fetching** - All commands MUST use `fetch_rules` to get their process
3. **Standard Response Format** - Use consistent prefixes (✅, ❌, ⚠️)
4. **No Self-Execution** - Commands should NEVER execute themselves via terminal commands
5. **Proper Categorization** - Place commands in the correct category directories based on their target AI Agent

## Getting Started

1. Run `> help` to see available commands
2. Check `documentation/00OS-command-user-guide.md` for usage information
3. Review `current-implementation.md` to understand the system architecture

For detailed development information, see `documentation/00OS-command-development.md`.
