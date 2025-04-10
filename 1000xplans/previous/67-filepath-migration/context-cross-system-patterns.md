# Context Analysis: Cross-System Patterns

## Overview of Cross-System Patterns

This analysis identifies the common patterns that span multiple subsystems within the 1000xbrain cognitive architecture. These patterns must be consistently updated during the filepath migration to maintain system integrity and ensure proper cross-references between components.

## Reference Pattern Types

Within the 1000xbrain system, file paths appear in several distinct patterns that must be systematically identified and updated:

### 1. Direct File References

Direct references explicitly point to other files within documentation using relative or absolute paths. These typically appear in the form:

```markdown
See [file name](path/to/file.md) for more information.
```

**Common Locations:**
- README.md files
- Documentation sections referring to other components
- Tutorial and example sections

**Migration Requirements:**
- Update all file paths to reflect new directory structure
- Maintain relative path relationships where appropriate
- Ensure links correctly point to existing files

### 2. Project-Rule-Parameter References

References to Manual rules in message-commands that use the `@` symbol to explicitly include specific rules. These appear in the form:

```
message-command: parameter @path/to/rule.mdc
```

**Common Locations:**
- Message-command examples
- Workflow documentation
- Tutorial content showing message-command usage

**Migration Requirements:**
- Update all references to use the new `/parameters` directory
- Ensure all extensions use `.mdc` not `.md`
- Maintain the `@` symbol prefix

### 3. fetch_rules Tool Calls

Tool calls to access Agent Requested rules using the fetch_rules tool. These appear in the form:

```typescript
fetch_rules(["knowledge/path/to/rule"])
```

**Common Locations:**
- Documentation of knowledge access
- Examples of tool usage
- Implementation guidance

**Migration Requirements:**
- Update all paths to use the new `/knowledge` directory
- Ensure proper array format with square brackets and quotes
- Remove file extensions from paths inside fetch_rules

### 4. File Structure Diagrams

Visual representations of the directory structure in ASCII or markdown format. These appear in the form:

```
/directory
├── file1.md
└── subdirectory/
    └── file2.md
```

**Common Locations:**
- README.md files
- Architecture documentation
- Structure overview sections

**Migration Requirements:**
- Update directory and file names to match new structure
- Maintain consistent indentation and formatting
- Ensure diagrams accurately reflect the actual structure

### 5. Code Block Examples

Example code that includes file paths. These appear in the form:

```typescript
// Example code that uses file paths
const path = "path/to/file.md";
```

**Common Locations:**
- Implementation guidance
- Tool usage examples
- Tutorial code

**Migration Requirements:**
- Update paths in example code to reflect new structure
- Maintain consistency with actual recommended patterns
- Ensure example code remains valid

## Cross-Component Reference Patterns

The following patterns represent common cross-component references that must be updated consistently:

### Core → Knowledge References

**Old Pattern:**
```typescript
// Reference to meta/architecture
See meta/architecture/structure-overview.md for details.

// Reference to domains/knowledge
For patterns, see domains/knowledge/patterns/implementation-patterns.md.
```

**New Pattern:**
```typescript
// Reference to knowledge/reference/architecture
See knowledge/reference/architecture/structure-overview.md for details.

// Reference to knowledge/patterns
For patterns, see knowledge/patterns/impl/implementation-patterns.md.

// Using fetch_rules
fetch_rules(["knowledge/reference/architecture/structure-overview"], 
           "Understanding architecture structure")
```

### Workflow → Parameter References

**Old Pattern:**
```
plan-mode: rules-workflow @knowledge/rules/plan-mode-system-wide.mdc
dev-mode: front-end-workflow @knowledge/front-end/react-components.mdc
```

**New Pattern:**
```
plan-mode: rules-workflow @parameters/rules/plan-mode-system-wide.mdc
dev-mode: front-end-workflow @parameters/front-end/react-components.mdc
```

### Parameter → Knowledge References

**Old Pattern:**
```
See domains/knowledge/patterns/implementation-patterns.md for standard patterns.
```

**New Pattern:**
```typescript
// Direct reference
See knowledge/patterns/impl/implementation-patterns.md for standard patterns.

// Using fetch_rules
fetch_rules(["knowledge/patterns/impl/implementation-patterns"],
           "Accessing implementation patterns")
```

### README → Directory Component References

**Old Pattern:**
```markdown
| File | Purpose |
|------|---------|
| [meta/identity/global-rules.md](meta/identity/global-rules.md) | Core identity |
| [domains/rules/rules-workflow.md](domains/rules/rules-workflow.md) | Rules workflow |
```

**New Pattern:**
```markdown
| File | Purpose |
|------|---------|
| [core/identity/global-rules.md](core/identity/global-rules.md) | Core identity |
| [workflows/rules-workflow/rules-workflow.md](workflows/rules-workflow/rules-workflow.md) | Rules workflow |
```

## System-Wide Directory Structure References

Directory structure references appear throughout the system and must be consistently updated:

### Root Directory Structure

**Old Pattern:**
```
/1000xbrain
├── meta/
├── domains/
└── knowledge/
```

**New Pattern:**
```
/1000xbrain
├── core/
├── workflows/
├── parameters/
└── knowledge/
```

### Rule Type Mappings

**Old Pattern:**
```markdown
| Category | Rule Type | Purpose |
|----------|-----------|---------|
| meta | Always | Core capabilities |
| domains | Auto | Domain-specific processes |
| knowledge | Manual | Specialized guidance |
```

**New Pattern:**
```markdown
| Directory | Rule Type | Access Method | Purpose |
|-----------|-----------|---------------|---------|
| core | Always | Automatic | Core capabilities |
| workflows | Auto-Attached | File matching | Domain-specific processes |
| parameters | Manual | Explicit reference | Specialized guidance |
| knowledge | Agent Requested | fetch_rules tool | Domain expertise |
```

## Common Update Challenges

The following challenges must be addressed consistently across the system:

### 1. Nested Path References

Some files contain nested references to paths within code blocks or examples. These require special attention:

```markdown
```typescript
// Example showing a path reference
function getPath() {
    return "meta/architecture/structure.md";
}
```

These must be updated to use the new paths:

```markdown
```typescript
// Example showing a path reference
function getPath() {
    return "knowledge/reference/architecture/structure.md";
}
```
```

### 2. Mixed Access Method References

Some documentation describes multiple access methods, requiring consistent updates to all referenced paths:

**Old Pattern:**
```markdown
You can reference this rule directly using:
- Direct link: knowledge/rules/template.md
- Message-command: @knowledge/rules/template.mdc
```

**New Pattern:**
```markdown
You can reference this rule directly using:
- Direct link: parameters/rules/template.md
- Message-command: @parameters/rules/template.mdc
```

### 3. Directory Purpose Descriptions

Descriptions of directory purposes must be updated to reflect the new structure:

**Old Pattern:**
```markdown
The `meta` directory contains core cognitive components that define identity.
The `domains` directory contains domain-specific workflow guidance.
The `knowledge` directory contains specialized manual rules.
```

**New Pattern:**
```markdown
The `core` directory contains Always rules defining core cognitive components.
The `workflows` directory contains Auto-Attached rules for domain-specific processes.
The `parameters` directory contains Manual rules for specialized task guidance.
The `knowledge` directory contains Agent Requested rules accessed via fetch_rules.
```

### 4. Message-Command Syntax Examples

Examples showing message-command syntax must be updated:

**Old Pattern:**
```
plan-mode: rules-workflow @knowledge/rules/plan-mode-system-wide.mdc
dev-mode: front-end-workflow @knowledge/front-end/react-components.mdc
```

**New Pattern:**
```
plan-mode: rules-workflow @parameters/rules/plan-mode-system-wide.mdc
dev-mode: front-end-workflow @parameters/front-end/react-components.mdc
```

### 5. fetch_rules Tool Call Examples

Examples showing fetch_rules tool calls must be updated:

**Old Pattern:**
```typescript
fetch_rules(["domains/knowledge/patterns/implementation-patterns"])
```

**New Pattern:**
```typescript
fetch_rules(["knowledge/patterns/impl/implementation-patterns"])
```

## Path Pattern Prioritization

The priority for updating different path patterns should be:

1. **Directory Structure References**: Fundamental representations of the overall structure
2. **Rule Type Mappings**: Core descriptions of how rule types relate to directories
3. **Project-Rule-Parameter References**: Message-command parameters for explicit rule inclusion
4. **fetch_rules Tool Calls**: Tool calls for accessing knowledge
5. **Direct File References**: Standard markdown links to other files
6. **File Structure Diagrams**: Visual representations of the directory structure
7. **Code Block Examples**: Example code that includes file paths

## Implementation Approach for Cross-System Patterns

To ensure consistent updates across all cross-system patterns:

1. **Pattern Identification**: Identify all instances of each pattern type
2. **Pattern Grouping**: Group related patterns for batch updates
3. **Pattern Templates**: Create templates for consistent replacement
4. **Priority-Based Updates**: Update patterns according to priority order
5. **Cross-Reference Validation**: Verify cross-references between components

By systematically addressing these cross-system patterns, we can ensure a consistent and accurate filepath migration that maintains the integrity of the 1000xbrain cognitive architecture. 