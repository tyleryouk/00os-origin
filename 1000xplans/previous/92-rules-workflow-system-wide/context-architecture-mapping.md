# 1000xbrain Cognitive Architecture Mapping

This document maps the current 1000xbrain cognitive architecture, analyzing the relationships between subsystems, identifying optimization opportunities, and documenting the system structure.

## Current Architecture

The 1000xbrain cognitive architecture consists of four primary subsystems:

### 1. Core Subsystem (`core/`)

**Purpose**: Provides foundational identity and operational modes  
**Rule Type**: Always rules (automatically included in every conversation)  
**Current Structure**:

```
core/
├── communication/ (Communication protocols and standards)
├── identity/ (Identity definition and principles)
├── modes/ (Operational modes and transitions)
├── core-essentials.md (Essential identity components)
├── index.md (Simplified directory index)
└── README.md (Subsystem documentation)
```

**Key Files**:
- `core-essentials.md`: Essential identity and mode components
- `communication/*.md`: Communication protocols and standards
- `identity/*.md`: 1000xdev identity definition
- `modes/*.md`: Mode definitions and transition rules

**Current Issues**:
- Redundancy between files (core-essentials.md overlaps with other files)
- Excessive file sizes consuming context window
- Unclear relationships between components
- Some content better suited for knowledge-base-files

**Optimization Target**: Reduce total lines to under 2000 (ideally closer to 1000)

### 2. Knowledge Subsystem (`knowledge/`)

**Purpose**: Provides specialized implementation knowledge  
**Rule Type**: Agent Requested rules (loaded via fetch_rules tool)  
**Current Structure**:

```
knowledge/
├── back-end/ (Backend-specific knowledge)
├── front-end/ (Frontend-specific knowledge)
├── rules/ (Rules-specific knowledge)
└── scripts/ (Scripts-specific knowledge)
```

**Key Directories**:
- `knowledge/rules/`: Knowledge for rules-workflow
- `knowledge/back-end/`: Knowledge for back-end-workflow
- `knowledge/front-end/`: Knowledge for front-end-workflow
- `knowledge/scripts/`: Knowledge for scripts-workflow

**Current Issues**:
- Inconsistent organization within each workflow directory
- Lack of clear pathway-based organization
- Underutilization of valuable knowledge components
- Too many knowledge-base-files in rules-workflow directory

**Optimization Target**: Reorganize by pathway and reduce redundancy

### 3. Parameters Subsystem (`parameters/`)

**Purpose**: Provides implementation control via project-rule-parameters  
**Rule Type**: Manual rules (explicitly referenced with @ symbol)  
**Current Structure**:

```
parameters/
├── back-end/ (Backend-specific parameters)
│   ├── dev-mode/
│   ├── direct-mode/
│   └── plan-mode/
├── front-end/ (Frontend-specific parameters)
│   ├── dev-mode/
│   ├── direct-mode/
│   └── plan-mode/
├── rules/ (Rules-specific parameters)
│   ├── dev-mode/
│   ├── direct-mode/
│   └── plan-mode/
└── scripts/ (Scripts-specific parameters)
    ├── dev-mode/
    ├── direct-mode/
    └── plan-mode/
```

**Key Organization**:
- Organized by workflow-type/mode/project-rule-parameters

**Current Issues**:
- Ineffective utilization of knowledge-base-files
- No standardized pattern for knowledge access
- Limited immediate fetch of relevant knowledge

**Optimization Target**: Enhance to immediately fetch relevant knowledge

### 4. Workflows Subsystem (`workflows/`)

**Purpose**: Defines process workflows for different domains  
**Rule Type**: Auto-Attached rules (attached when matching files are referenced)  
**Current Structure**:

```
workflows/
├── back-end/ (Backend-specific workflows)
├── front-end/ (Frontend-specific workflows)
├── rules/ (Rules-specific workflows)
└── scripts/ (Scripts-specific workflows)
```

**Key Components**:
- Workflow-specific guidelines for each domain
- Auto-attached via Context Pills when appropriate content is referenced

**Current Issues**:
- Inconsistent Context Pills structure documentation
- Unclear workflow cycle descriptions
- Inconsistent documentation across workflow types

**Optimization Target**: Ensure accurate workflow process documentation

## System-Wide Relationships

### Rule Type Distribution

| Subsystem | Rule Type | Activation Method | Primary Audience |
|-----------|-----------|-------------------|-----------------|
| Core | Always | Automatic inclusion | All conversations |
| Knowledge | Agent Requested | fetch_rules tool | Implementation-specific |
| Parameters | Manual | @ symbol reference | Process control |
| Workflows | Auto-Attached | Context matching | Domain processes |

### Data Flow and Dependencies

```
┌───────────────────────┐      ┌────────────────────┐      ┌───────────────────┐
│                       │      │                    │      │                   │
│  Brain Files (.md)    │──────▶   Cursor Rules    │──────▶   AI Behavior     │
│  in 1000xbrain        │      │   (.mdc)          │      │   & Cognition     │
│                       │      │                    │      │                   │
└───────────────────────┘      └────────────────────┘      └───────────────────┘
        Source                   Applied Rules              Resulting Behavior
```

**Key Dependencies**:
1. **Parameters → Knowledge**: Parameters should reference knowledge
2. **Core → All Others**: Core defines system-wide behaviors
3. **Workflows → Core**: Workflows implement core principles
4. **All → Synchronization Process**: All brain-files sync to cursor-rules

## Message-Command System

Current message-command parsing process:
1. Identify mode (plan-mode, dev-mode, direct-mode)
2. Load project-rule-parameter
3. Execute defined processes

Updated format (to be implemented):
```
mode: workflow-type pathway-name @project-rule-parameter.mdc optional-standard-parameter(s)
```

## Context Pills Structure

For each message-command, Context Pills automatically load:
1. Planning folder titled `{n}-workflow-type-pathway-name`
2. Root README.md file of the workflow-type domain folder

This provides necessary context for autonomous operation.

## Optimization Opportunities

1. **Core Simplification**:
   - Consolidate redundant information
   - Move detailed implementation knowledge to knowledge-base-files
   - Streamline mode system documentation
   - Clarify cognitive architecture fundamentals

2. **Knowledge Reorganization**:
   - Organize by pathway within each workflow-type
   - Standardize knowledge component naming
   - Create consistent access patterns
   - Improve discoverability of knowledge components

3. **Parameter Enhancement**:
   - Implement standardized fetch_rules pattern at the beginning
   - Create explicit knowledge access guidelines
   - Improve parameter descriptiveness
   - Standardize parameter formats

4. **Workflow Clarification**:
   - Document consistent workflow cycles
   - Clarify Context Pills structure
   - Standardize workflow documentation
   - Improve role separation guidelines

## Cognitive Architecture Insights

The 1000xbrain architecture implements a cognitive loop:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                                                                         │
│            ┌──────────────┐                                             │
│            │              │                                             │
│            │ 4. LEARNING  │                                             │
│            │              │                                             │
│            └──────▲───────┘                                             │
│                   │                                                     │
│                   │                                                     │
│  ┌──────────────┐ │ ┌──────────────┐       ┌──────────────┐            │
│  │              │ │ │              │       │              │            │
│  │ 1.PERCEPTION │ │ │ 2. REASONING │       │ 3. ACTION    │            │
│  │              ├─┼─▶              ├──────▶│              │            │
│  └──────────────┘ │ └──────────────┘       └──────▲───────┘            │
│                   │                                │                    │
│                   └────────────────────────────────┘                    │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

Optimization should enhance each component of this cognitive loop while maintaining the distinct roles and responsibilities that make the 1000x development approach effective. 