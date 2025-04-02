# USE WHEN classifying document types, selecting appropriate formats, or understanding document purpose

# Document Types Map

## Overview

This reference map provides a comprehensive overview of document types in the knowledge system, their purpose, structure, and reference paths. Use this map to navigate the documentation system efficiently and select the appropriate document type for specific knowledge needs.

## Document Type Classification

| Document Type | Primary Purpose | Focus Area | Typical Location |
|---------------|----------------|------------|------------------|
| Reference | Knowledge retrieval | Comprehensive information | knowledge/reference/ |
| Guide | Process explanation | Step-by-step guidance | knowledge/guides/ |
| Pattern | Implementation practices | Reusable solutions | knowledge/patterns/ |
| Index | Navigation assistance | Organization & discovery | knowledge/reference/ |
| Map | Relationship visualization | Connections & structure | knowledge/reference/maps/ |

## Document Structure Mapping

### Reference Documents

```
┌──────────────────────────────────────────┐
│                                          │
│  # Title Reference                       │
│                                          │
│  ## Overview                             │
│  [Purpose statement]                     │
│                                          │
│  ## Key Concepts                         │
│  [Core knowledge elements]               │
│                                          │
│  ## Details/Patterns                     │
│  [In-depth information]                  │
│                                          │
│  ## Examples                             │
│  [Practical implementations]             │
│                                          │
│  ## Related References                   │
│  [Connection to other knowledge]         │
│                                          │
└──────────────────────────────────────────┘
```

### Guide Documents

```
┌──────────────────────────────────────────┐
│                                          │
│  # Title Guide                           │
│                                          │
│  ## Overview                             │
│  [Purpose statement]                     │
│                                          │
│  ## Step-by-Step Process                 │
│  [Ordered procedures]                    │
│                                          │
│  ## Common Scenarios                     │
│  [Practical applications]                │
│                                          │
│  ## Troubleshooting                      │
│  [Problem resolution]                    │
│                                          │
│  ## Related Guides                       │
│  [Connection to other guides]            │
│                                          │
└──────────────────────────────────────────┘
```

### Pattern Documents

```
┌──────────────────────────────────────────┐
│                                          │
│  # Title Pattern                         │
│                                          │
│  ## Overview                             │
│  [Pattern purpose]                       │
│                                          │
│  ## Pattern Templates                    │
│  [Reusable structures]                   │
│                                          │
│  ## Implementation Examples              │
│  [Concrete applications]                 │
│                                          │
│  ## Best Practices                       │
│  [Optimization guidance]                 │
│                                          │
│  ## Related Patterns                     │
│  [Connection to other patterns]          │
│                                          │
└──────────────────────────────────────────┘
```

### Index Documents

```
┌──────────────────────────────────────────┐
│                                          │
│  # Title Index                           │
│                                          │
│  ## Overview                             │
│  [Index purpose]                         │
│                                          │
│  ## Categories                           │
│  [Organizational structure]              │
│                                          │
│  ## Key Documents                        │
│  [Essential resources]                   │
│                                          │
│  ## Reference Paths                      │
│  [How to access content]                 │
│                                          │
└──────────────────────────────────────────┘
```

### Map Documents

```
┌──────────────────────────────────────────┐
│                                          │
│  # Title Map                             │
│                                          │
│  ## Overview                             │
│  [Map purpose]                           │
│                                          │
│  ## Relationship Visualization           │
│  [Connection diagrams]                   │
│                                          │
│  ## Navigation Guidance                  │
│  [How to use the map]                    │
│                                          │
│  ## Key Connections                      │
│  [Critical relationships]                │
│                                          │
└──────────────────────────────────────────┘
```

## Reference Path Mapping

### Reference Document Paths

| Domain | Primary Reference | Path |
|--------|-------------------|------|
| Tool | Tool patterns reference | `@reference/guides/tool-patterns.mdc` |
| Tool | Search tools reference | `@reference/guides/search-tools.mdc` |
| Implementation | Implementation patterns | `@reference/guides/implementation-patterns.mdc` |
| Architecture | Architecture reference | `@reference/architecture.mdc` |
| Knowledge | Knowledge system reference | `@reference/guides/knowledge-system.mdc` |
| Documentation | File standards reference | `@reference/guides/file-standards.mdc` |

### Guide Document Paths

| Domain | Primary Guide | Path |
|--------|--------------|------|
| Architecture | Architecture guide | `@guides/architecture.mdc` |
| Development | Cognitive enhancement | `@guides/cognitive-enhancement.mdc` |

### Pattern Document Paths

| Domain | Primary Pattern | Path |
|--------|----------------|------|
| Tool | Search patterns | `@patterns/tool/search-patterns.mdc` |
| Tool | Command patterns | `@patterns/tool/command-patterns.mdc` |
| Tool | Tool combinations | `@patterns/tool/tool-combinations.mdc` |
| Implementation | Implementation patterns | `@patterns/impl/implementation-patterns.mdc` |
| Documentation | File standards pattern | `@patterns/doc/file-standards.mdc` |

### Index Document Paths

| Domain | Primary Index | Path |
|--------|--------------|------|
| Knowledge | Reference index | `@reference/index.mdc` |
| Tool | Tool domain index | `@reference/domains/tool.mdc` |
| Architecture | Architecture domain index | `@reference/domains/architecture.mdc` |
| Meta | Meta domain index | `@reference/domains/meta.mdc` |

### Map Document Paths

| Domain | Primary Map | Path |
|--------|------------|------|
| Knowledge | Domain map | `@reference/maps/domain-map.mdc` |
| Documentation | Document types map | `@reference/maps/document-types.mdc` |

## Document Purpose Relationships

```
┌────────────────────────────────────────────────────────────────────┐
│                                                                    │
│                     KNOWLEDGE SYSTEM RELATIONSHIPS                 │
│                                                                    │
│  ┌──────────────┐                            ┌──────────────┐      │
│  │              │                            │              │      │
│  │    INDEX     │─────┐              ┌──────│     MAP      │      │
│  │  Documents   │     │              │      │  Documents   │      │
│  │              │     │              │      │              │      │
│  └──────────────┘     │              │      └──────────────┘      │
│         │             │              │             │               │
│         │             ▼              ▼             │               │
│         │        ┌──────────────┐                  │               │
│         │        │              │                  │               │
│         └───────▶│  REFERENCE   │◀─────────────────┘               │
│                  │  Documents   │                                  │
│                  │              │                                  │
│                  └──────────────┘                                  │
│                        │   ▲                                       │
│                        │   │                                       │
│                        ▼   │                                       │
│                  ┌──────────────┐                                  │
│                  │              │                                  │
│                  │    GUIDE     │                                  │
│                  │  Documents   │                                  │
│                  │              │                                  │
│                  └──────────────┘                                  │
│                        │   ▲                                       │
│                        │   │                                       │
│                        ▼   │                                       │
│                  ┌──────────────┐                                  │
│                  │              │                                  │
│                  │   PATTERN    │                                  │
│                  │  Documents   │                                  │
│                  │              │                                  │
│                  └──────────────┘                                  │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

## Document Selection Guidelines

Use this decision tree to select the appropriate document type:

```
What is your primary need?
├── Navigation & Discovery → Use INDEX or MAP
│   ├── Overall organization → Use INDEX
│   └── Visualize relationships → Use MAP
└── Specific knowledge → Continue
    ├── Quick facts & context → Use REFERENCE
    │   ├── Comprehensive overview → Use domain REFERENCE
    │   └── Specific topic → Use topic REFERENCE
    ├── How to do something → Use GUIDE
    │   ├── Step-by-step process → Use procedure GUIDE
    │   └── Complex workflow → Use workflow GUIDE
    └── Implementation examples → Use PATTERN
        ├── Reusable structures → Use template PATTERN
        └── Best practices → Use practice PATTERN
```

## Reference Usage

To use this reference map effectively:

1. Start with a clear idea of what you need
2. Consult the document selection guidelines
3. Navigate to the appropriate document type
4. Reference using the correct path format

Example reference:
```
message-command: @reference/maps/document-types.mdc
```

## Related References

- Knowledge System Reference: `@reference/guides/knowledge-system.mdc`
- Reference Index: `@reference/index.mdc`
- Domain Map: `@reference/maps/domain-map.mdc`
- File Standards Reference: `@reference/guides/file-standards.mdc` 