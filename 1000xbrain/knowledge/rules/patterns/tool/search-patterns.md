# USE WHEN implementing search functionality, finding code in the codebase, or optimizing search tool usage

# Search Patterns

## Overview

This document provides optimized patterns for effective search tool usage in the 1000xbrain cognitive architecture. These patterns represent proven strategies for finding relevant code, navigating the codebase, and identifying implementation patterns.

As a Manual reference file, this document is designed to be explicitly referenced when you need comprehensive search patterns:

```
message-command: @patterns/tool/search.mdc
```

## Search Tool Reference

### Available Search Tools

| Tool | Purpose | Best For | Limitations |
|------|---------|----------|-------------|
| `codebase_search` | Semantic search for concepts | Finding implementations based on concepts | Less precise for exact text |
| `grep_search` | Pattern-based text search | Finding specific symbols or patterns | Limited semantic understanding |
| `file_search` | Fuzzy filename matching | Finding files by name | Only searches filenames |
| `list_dir` | Directory exploration | Understanding project structure | Only shows one directory level |

### Tool Selection Guide

Choose the right search tool based on your current need:

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│                   Search Tool Selection                     │
│                                                             │
│  ┌─────────────┐      ┌─────────────┐     ┌─────────────┐   │
│  │             │      │             │     │             │   │
│  │ Need to find│ Yes  │ Understand  │ No  │ Use         │   │
│  │ concepts?   │─────▶│ file names? │────▶│ codebase_   │   │
│  │             │      │             │     │ search      │   │
│  └─────────────┘      └──────┬──────┘     └─────────────┘   │
│         │                    │ Yes                          │
│         │ No                 ▼                              │
│         │             ┌─────────────┐                       │
│         │             │             │                       │
│         │             │ Use         │                       │
│         │             │ file_search │                       │
│         │             │             │                       │
│         │             └─────────────┘                       │
│         ▼                                                   │
│  ┌─────────────┐       ┌────────────┐                       │
│  │             │  Yes  │            │                       │
│  │ Need exact  │──────▶│ Use        │                       │
│  │ text match? │       │ grep_search│                       │
│  │             │       │            │                       │
│  └─────────────┘       └────────────┘                       │
│         │                                                   │
│         │ No                                                │
│         ▼                                                   │
│  ┌─────────────┐                                            │
│  │             │                                            │
│  │ Use         │                                            │
│  │ list_dir    │                                            │
│  │             │                                            │
│  └─────────────┘                                            │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Core Search Patterns

### 1. Progressive Refinement Pattern

**Purpose**: Systematically narrow search scope from broad concepts to specific implementations.

**Implementation**:

```typescript
// 1. Start with broad conceptual search
codebase_search("authentication system implementation")

// 2. Refine to specific architectural component
codebase_search("authentication middleware implementation")

// 3. Find specific function or class implementation
grep_search("AuthMiddleware", "include_pattern": "*.ts")

// 4. Examine implementation details
read_file("[identified_file]", should_read_entire_file=true)
```

**When to Use**: When exploring unfamiliar code territory or seeking specific implementations.

### 2. Feature Localization Pattern

**Purpose**: Quickly identify all components related to a specific feature.

**Implementation**:

```typescript
// 1. Identify feature entry point
grep_search("featureName", "include_pattern": "*/index.*")

// 2. Find feature dependencies
grep_search("import.*from.*featureName", "include_pattern": "*.{ts,tsx,js,jsx}")

// 3. Locate feature tests
grep_search("describe.*featureName", "include_pattern": "*test*")

// 4. Find feature documentation
grep_search("## featureName", "include_pattern": "*.md")
```

**When to Use**: When analyzing feature implementation across a codebase.

### 3. Implementation Pattern Discovery

**Purpose**: Find established patterns for implementing common functionality.

**Implementation**:

```typescript
// 1. Find similar implementations
codebase_search("how form validation is implemented")

// 2. Identify pattern variations
grep_search("validate.*form", "include_pattern": "*.{ts,tsx,js,jsx}")

// 3. Analyze pattern structure
read_file("[identified_pattern_file]", should_read_entire_file=true)

// 4. Find pattern tests
grep_search("test.*validate.*form", "include_pattern": "*test*")
```

**When to Use**: When implementing new functionality that should match existing patterns.

### 4. Architecture Navigation Pattern

**Purpose**: Understand project architecture through directed exploration.

**Implementation**:

```typescript
// 1. Start at project root
list_dir("")

// 2. Identify main directories
list_dir("src")

// 3. Explore key architecture files
file_search("index")
read_file("[main_index_file]", should_read_entire_file=true)

// 4. Map module relationships
grep_search("import.*from", "include_pattern": "src/*/index.*")
```

**When to Use**: When getting familiar with a new codebase or architecture.

### 5. Error Origin Tracing Pattern

**Purpose**: Trace errors back to their source for debugging.

**Implementation**:

```typescript
// 1. Find error message
grep_search("Error:.*specific error text")

// 2. Locate error handler
grep_search("try.*catch.*Error", "include_pattern": "*.{ts,tsx,js,jsx}")

// 3. Find error generation point
grep_search("throw new Error", "include_pattern": "*.{ts,tsx,js,jsx}")

// 4. Examine error context
read_file("[error_file]", offset=error_line-10, limit=20)
```

**When to Use**: When debugging errors or exceptions.

## Advanced Search Patterns

### 1. Multi-Tool Triangulation Pattern

**Purpose**: Use multiple search tools in combination to precisely locate specific code.

**Implementation**:

```typescript
// 1. Start with conceptual understanding
codebase_search("user authentication flow")

// 2. Find specific files involved
file_search("auth")

// 3. Locate specific implementation details
grep_search("authenticate\(", "include_pattern": "*auth*.{ts,js}")

// 4. Examine file context
read_file("[identified_file]", should_read_entire_file=true)
```

**When to Use**: When searching for complex implementations across multiple files.

### 2. Code Flow Analysis Pattern

**Purpose**: Trace execution flow through a codebase.

**Implementation**:

```typescript
// 1. Start at entry point function
grep_search("function handleUserLogin", "include_pattern": "*.{ts,js}")

// 2. Find function calls from entry point
read_file("[entry_point_file]", should_read_entire_file=true)
// Identify called functions like "validateCredentials"

// 3. Locate called functions
grep_search("function validateCredentials", "include_pattern": "*.{ts,js}")

// 4. Repeat for next level of function calls
read_file("[next_function_file]", should_read_entire_file=true)
```

**When to Use**: When analyzing execution flows or debugging complex interactions.

### 3. Component Relationship Mapping

**Purpose**: Discover relationships between components or modules.

**Implementation**:

```typescript
// 1. Identify component imports
grep_search("import.*from.*Component", "include_pattern": "*.{tsx,jsx}")

// 2. Find component props interface
grep_search("interface.*ComponentProps", "include_pattern": "*.{ts,tsx}")

// 3. Locate component tests
grep_search("test.*Component", "include_pattern": "*test*")

// 4. Find component style definitions
grep_search("Component.*style", "include_pattern": "*.{css,scss,styled*}")
```

**When to Use**: When understanding component architecture and relationships.

## Tool-Specific Patterns

### Semantic Search (codebase_search)

```typescript
// 1. Concept-based search
codebase_search("how user authentication is implemented")

// 2. Domain-targeted search
codebase_search("form validation patterns", 
                "target_directories": ["src/forms", "src/validation"])

// 3. Implementation approach search
codebase_search("approach to handle API errors")
```

### Pattern Search (grep_search)

```typescript
// 1. Symbol search
grep_search("AuthContext")

// 2. Pattern with context
grep_search("import.*from.*'@/utils'")

// 3. Language-specific search
grep_search("useState\(", "include_pattern": "*.tsx")

// 4. Case-sensitive search
grep_search("User", "case_sensitive": true)
```

### File Search (file_search)

```typescript
// 1. Component search
file_search("Button")

// 2. Test file search
file_search("test")

// 3. Configuration search
file_search("config")
```

### Directory Exploration (list_dir)

```typescript
// 1. Root exploration
list_dir("")

// 2. Feature exploration
list_dir("src/features")

// 3. Configuration exploration
list_dir("config")
```

## Search Pattern Combinations

Combine these patterns for more effective searching:

1. **New Feature Implementation**:
   - Start with Implementation Pattern Discovery
   - Follow with Feature Localization on similar features
   - Use Component Relationship Mapping to understand integration points

2. **Bug Investigation**:
   - Start with Error Origin Tracing
   - Follow with Code Flow Analysis to understand execution path
   - Use Multi-Tool Triangulation to examine all related components

3. **Architecture Familiarization**:
   - Start with Architecture Navigation
   - Follow with Component Relationship Mapping
   - Use Progressive Refinement to understand key subsystems

## Usage Examples

### Finding Authentication Implementation

```typescript
// 1. Locate authentication concepts
codebase_search("authentication implementation")

// 2. Find authentication files
file_search("auth")

// 3. Identify authentication functions
grep_search("function.*authenticate", "include_pattern": "*.{ts,js}")

// 4. Examine implementation
read_file("[auth_implementation_file]", should_read_entire_file=true)
```

### Understanding Component Structure

```typescript
// 1. Find component definition
file_search("Button")

// 2. Examine component implementation
read_file("[component_file]", should_read_entire_file=true)

// 3. Find component usage examples
grep_search("<Button", "include_pattern": "*.{tsx,jsx}")

// 4. Find component tests
grep_search("test.*Button", "include_pattern": "*test*")
```

### Debugging an Error

```typescript
// 1. Find error message
grep_search("TypeError: Cannot read property")

// 2. Locate error-throwing files
grep_search("object\\.property", "include_pattern": "*.{ts,js}")

// 3. Examine error context
read_file("[error_file]", offset=error_line-10, limit=20)

// 4. Find similar error handling
codebase_search("how TypeError is handled for missing properties")
```

## Related Knowledge

For additional search knowledge, reference these files:
- `@patterns/tool/read.mdc`: Reading patterns to use after finding files
- `@patterns/tool/edit.mdc`: Editing patterns for implementing changes
- `@guides/search-tools.mdc`: Detailed guide to search tool parameters 