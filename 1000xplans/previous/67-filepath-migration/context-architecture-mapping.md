# Context Analysis: Cognitive Architecture Mapping

## Cognitive Architecture Overview

The 1000xbrain cognitive architecture has been reorganized into a clear four-directory structure, with each directory corresponding to a specific rule type and access method:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                                                                         │
│                        1000XBRAIN ARCHITECTURE                          │
│                                                                         │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │
│  │             │  │             │  │             │  │             │    │
│  │    /core    │  │  /workflows │  │ /parameters │  │  /knowledge │    │
│  │             │  │             │  │             │  │             │    │
│  │ Always Rules│  │Auto-Attached│  │Manual Rules │  │Agent Request│    │
│  │             │  │   Rules     │  │             │  │   Rules     │    │
│  └─────┬───────┘  └─────┬───────┘  └─────┬───────┘  └─────┬───────┘    │
│        │                │                │                │            │
│        ▼                ▼                ▼                ▼            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │
│  │ Automatic   │  │ File-Match  │  │ Explicitly  │  │ fetch_rules │    │
│  │ Inclusion   │  │ Activation  │  │ Referenced  │  │  Tool Call  │    │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘    │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

This structure provides a clear mapping between directories, rule types, and access methods that must be consistently reflected in all filepath references throughout the 1000xbrain files.

## Current Directory Structure

The current 1000xbrain architecture consists of these primary directories:

| Directory | Rule Type | Access Method | Purpose |
|-----------|-----------|---------------|---------|
| `/core` | Always | Automatic | Core identity and cognitive capabilities |
| `/workflows` | Auto-Attached | File matching | Domain-specific procedural knowledge |
| `/parameters` | Manual | Explicit reference | Task-specific specialized guidance |
| `/knowledge` | Agent Requested | fetch_rules tool | Specialized domain knowledge |

Each directory has a specific subdirectory structure that must be reflected accurately in all filepath references:

### Core Directory Structure

```
/core
├── README.md
├── communication/
│   ├── message-commands.md
│   └── response-format.md
├── identity/
│   ├── global-rules.md
│   └── purpose.md
└── modes/
    ├── dev-mode.md
    ├── mode-transitions.md
    ├── mode-system.md
    └── plan-mode.md
```

### Workflows Directory Structure

```
/workflows
├── README.md
├── rules-workflow/
│   ├── rules-workflow.md
│   └── [specialized workflow files]
├── front-end-workflow/
│   ├── front-end-workflow.md
│   └── [specialized workflow files]
├── back-end-workflow/
│   ├── back-end-workflow.md
│   └── [specialized workflow files]
├── documentation-workflow/
│   ├── documentation-workflow.md
│   └── [specialized workflow files]
└── scripts-workflow/
    ├── scripts-workflow.md
    └── [specialized workflow files]
```

### Parameters Directory Structure

```
/parameters
├── README.md
├── rules/
│   ├── dev-mode-system-wide.md
│   ├── plan-mode-system-wide.md
│   └── [other specialized parameters]
├── front-end/
│   └── [specialized parameters]
├── back-end/
│   └── [specialized parameters]
├── documentation/
│   └── [specialized parameters]
└── scripts/
    └── [specialized parameters]
```

### Knowledge Directory Structure

```
/knowledge
├── README.md
├── guides/
│   ├── architecture.md
│   ├── cognitive-enhancement.md
│   ├── fetch-rules.md
│   └── [other guides]
├── patterns/
│   ├── doc/
│   ├── impl/
│   ├── tool/
│   └── index.md
└── reference/
    ├── architecture/
    ├── contributions/
    ├── domains/
    ├── examples/
    ├── guides/
    ├── maps/
    ├── shortcut-references.md
    └── index.md
```

## Path Migration Patterns

The filepath migration requires systematic updates following specific patterns based on the file's rule type and location. The following patterns must be applied consistently:

### 1. Core File Path Patterns

**Old Path Patterns:**
- `meta/identity/...` → `core/identity/...`
- `meta/modes/...` → `core/modes/...`
- `meta/communication/...` → `core/communication/...`

**New Path Format:**
```
core/[subsystem]/[file].md
```

**Access Method Reference Format:**
```
Always automatically included
```

### 2. Workflow File Path Patterns

**Old Path Patterns:**
- `domains/rules/...` → `workflows/rules-workflow/...`
- `domains/front-end/...` → `workflows/front-end-workflow/...`
- `domains/back-end/...` → `workflows/back-end-workflow/...`
- `domains/documentation/...` → `workflows/documentation-workflow/...`
- `domains/scripts/...` → `workflows/scripts-workflow/...`

**New Path Format:**
```
workflows/[domain]-workflow/[file].md
```

**Access Method Reference Format:**
```
Auto-attached when matching file types are active
```

### 3. Parameter File Path Patterns

**Old Path Patterns:**
- `knowledge/rules/...` → `parameters/rules/...`
- `knowledge/front-end/...` → `parameters/front-end/...`
- `knowledge/back-end/...` → `parameters/back-end/...`
- `knowledge/documentation/...` → `parameters/documentation/...`
- `knowledge/scripts/...` → `parameters/scripts/...`

**New Path Format:**
```
parameters/[domain]/[file].md
```

**Project-Rule-Parameter Reference Format:**
```
@parameters/[domain]/[file].mdc
```

### 4. Knowledge File Path Patterns

**Old Path Patterns:**
- `domains/knowledge/...` → `knowledge/...`
- `meta/architecture/...` → `knowledge/reference/architecture/...`
- `meta/contributions/...` → `knowledge/reference/contributions/...`
- `domains/patterns/...` → `knowledge/patterns/...`
- `domains/reference/...` → `knowledge/reference/...`

**New Path Format:**
```
knowledge/[category]/[subcategory]/[file].md
```

**fetch_rules Tool Call Format:**
```typescript
fetch_rules(["knowledge/[category]/[subcategory]/[file]"])
```

## Special Path Reference Cases

### Project-Rule-Parameter References

Project-rule-parameter references must always:
1. Begin with the `@` symbol
2. Use the `.mdc` extension
3. Follow the directory structure for the appropriate rule type

**Example:**
```
@parameters/rules/plan-mode-system-wide.mdc
```

### fetch_rules Tool Call Paths

fetch_rules tool call paths must always:
1. Use the knowledge directory
2. Be enclosed in square brackets and quotes
3. Never include the `.md` extension
4. Optionally include multiple paths in an array

**Example:**
```typescript
fetch_rules(["knowledge/reference/architecture"])
```

### Cross-Reference Links

Cross-reference links must:
1. Use correct relative or absolute paths
2. Maintain the `.md` extension
3. Follow the directory structure for the appropriate rule type

**Example:**
```
See [architecture overview](knowledge/guides/architecture.md) for more details.
```

## Directory-Purpose Alignment

Each directory has a specific purpose that must be consistently referenced:

| Directory | Purpose | Key Alignment |
|-----------|---------|---------------|
| `/core` | Core identity and capabilities | Central, essential AI characteristics |
| `/workflows` | Domain-specific procedural knowledge | How to approach specific domains |
| `/parameters` | Task-specific specialized guidance | Detailed guidance for specific tasks |
| `/knowledge` | Specialized domain knowledge | Reference information and patterns |

All references to these directories must align with their intended purpose and access method.

## File Migration Mapping

For all files that have moved during the reorganization, the following mapping shows their old and new locations:

| Old Path | New Path | Rule Type | Access Method |
|----------|----------|-----------|---------------|
| meta/identity/global-rules.md | core/identity/global-rules.md | Always | Automatic |
| meta/modes/mode-system.md | core/modes/mode-system.md | Always | Automatic |
| domains/rules/rules-workflow.md | workflows/rules-workflow/rules-workflow.md | Auto-Attached | File Match |
| knowledge/rules/plan-mode-system-wide.md | parameters/rules/plan-mode-system-wide.md | Manual | @reference |
| domains/knowledge/patterns/basic-patterns.md | knowledge/patterns/basic-patterns.md | Agent Requested | fetch_rules |

## Path Validation Requirements

To ensure correctness, all updated paths must be validated against these requirements:

1. **Existence**: The target file must actually exist at the referenced path
2. **Correct Type**: The path must point to a file of the appropriate rule type
3. **Correct Extension**: The file must have the `.md` extension (or `.mdc` for project-rule-parameters)
4. **Appropriate Access Method**: The access method referenced must match the rule type
5. **Consistent Formatting**: The path format must follow the standards for the reference type

## Integration Points Between Subsystems

The following integration points between subsystems must maintain correct path references:

### Core to Workflow Integration

Core mode systems reference workflow processes:
- `core/modes/dev-mode.md` → references to `workflows/*/workflow.md`
- `core/modes/plan-mode.md` → references to `workflows/*/workflow.md`

### Workflow to Parameter Integration

Workflows reference parameter files for specialized guidance:
- `workflows/rules-workflow/rules-workflow.md` → references to `parameters/rules/*.md`
- `workflows/front-end-workflow/front-end-workflow.md` → references to `parameters/front-end/*.md`

### Knowledge Access Integration

All subsystems reference knowledge components through fetch_rules:
- `core/*.md` → references to `knowledge/*/*.md` via fetch_rules
- `workflows/*.md` → references to `knowledge/*/*.md` via fetch_rules
- `parameters/*.md` → references to `knowledge/*/*.md` via fetch_rules

## Path Migration Priorities

The priority for path migration should follow this order:

1. **Core Documentation** - Update the foundational identity files first
2. **README Files** - Update directory README files that explain structure
3. **Cross-System References** - Update references between different subsystems
4. **Workflow Files** - Update domain-specific workflow files
5. **Parameter Files** - Update specialized parameter files
6. **Knowledge References** - Update knowledge directory references and fetch_rules paths
7. **Examples and Tutorials** - Update paths in examples and tutorial content

This priority ensures that the most foundational components are updated first, followed by components that depend on them.

## Implementation Strategy

The implementation strategy for this filepath migration should:

1. **Map All Paths**: Comprehensively identify all paths requiring updates
2. **Group by Pattern**: Organize updates according to common patterns
3. **Update by Priority**: Follow the priority order for updates
4. **Verify Incrementally**: Validate each group of updates before proceeding
5. **Document Changes**: Maintain a record of all path migrations

By following this structured approach, we can ensure consistent and accurate filepath migration across the entire 1000xbrain cognitive architecture. 