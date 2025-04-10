# Test Cheatsheet: fetch_rules Implementation Verification

## Overview

This test cheatsheet provides verification methods for ensuring that fetch_rules tool usage is properly implemented across all brain-files in the 1000xbrain directory. The verification process includes syntax testing, context validation, and comprehensive search techniques.

## Syntax Validation Tests

### Basic Syntax Test

Verify that all fetch_rules tool calls use the correct basic syntax:

```typescript
fetch_rules(["knowledge/path/to/rule"])
```

Test items:
- Array brackets `[]` are present
- Double quotes `"` around the path
- No trailing commas inside the array
- No file extensions in the path

### Explanation Parameter Test

Verify that explanation parameters are properly formatted:

```typescript
fetch_rules(["knowledge/path/to/rule"], "Explanation for why this rule is being fetched")
```

Test items:
- Comma after the array
- Double quotes `"` around the explanation
- Explanation is concise and descriptive

### Multiple Rules Test

Verify that multiple rules are properly formatted:

```typescript
fetch_rules([
  "knowledge/path/to/first-rule",
  "knowledge/path/to/second-rule"
], "Explanation for fetching multiple rules")
```

Test items:
- Each rule on a separate line with proper indentation
- Commas between rules but not after the last rule
- Consistent formatting throughout the array

## Path Validation Tests

### Path Existence Test

Verify that all paths referenced in fetch_rules calls point to actual files in the knowledge directory:

1. Extract path from fetch_rules call: `knowledge/path/to/rule`
2. Append `.md` extension: `knowledge/path/to/rule.md`
3. Check if file exists in the 1000xbrain directory structure

### Path Format Test

Verify that all paths follow the standardized format:

1. Should start with `knowledge/`
2. Should include the appropriate subdirectory
3. Should not include file extensions
4. Should use kebab-case for file names

### Directory Structure Alignment Test

Verify that paths align with the established directory structure:

```
knowledge/
├── guides/
├── patterns/
│   ├── doc/
│   ├── impl/
│   └── tool/
└── reference/
```

## Documentation Verification

### README.md Verification

Verify that all directory README.md files include appropriate fetch_rules documentation:

1. Contains a section on rule types and access methods
2. Explains fetch_rules usage in the context of that directory
3. Includes appropriate examples
4. Maintains consistent terminology

### Knowledge Access Documentation Test

Verify that all documentation about accessing knowledge:

1. Uses fetch_rules tool for all knowledge references
2. Explains the relationship between fetch_rules and available_instructions
3. Uses consistent terminology
4. Provides clear, executable examples

### Example Consistency Test

Verify that all examples:

1. Use the standardized format (```typescript code blocks)
2. Follow the established patterns
3. Include explanations where appropriate
4. Are consistently formatted

## Comprehensive Search Tests

### Direct Reference Search

Use grep to find any remaining direct references to knowledge files:

```bash
grep -r "knowledge/.*\.md" --include="*.md" 1000xbrain/
```

### Knowledge Directory Reference Search

Find all references to the knowledge directory:

```bash
grep -r "knowledge/" --include="*.md" 1000xbrain/
```

### fetch_rules Implementation Search

Find all fetch_rules tool calls to verify proper implementation:

```bash
grep -r "fetch_rules" --include="*.md" 1000xbrain/
```

## Anti-Pattern Detection

### Missing Array Brackets

Detect instances of missing array brackets:

```bash
grep -r "fetch_rules(" --include="*.md" 1000xbrain/ | grep -v "\["
```

### File Extensions in Paths

Detect instances of file extensions in fetch_rules paths:

```bash
grep -r "fetch_rules(\[\".*\.md" --include="*.md" 1000xbrain/
```

### Inconsistent Naming

Detect instances of inconsistent fetch_rules naming:

```bash
grep -r "fetch_rule" --include="*.md" 1000xbrain/
```

## File-by-File Verification Checklist

Use this checklist to verify each file systematically:

### Core Files

- [ ] `1000xbrain/README.md`
- [ ] `core/identity/global-rules.md`
- [ ] `core/communication/message-commands.md`
- [ ] `core/modes/plan-mode.md`
- [ ] `core/modes/dev-mode.md`
- [ ] `core/communication/syntax-standards.md`

### Workflow Files

- [ ] `workflows/README.md`
- [ ] `workflows/rules-workflow/rules-workflow.md`
- [ ] `workflows/front-end-workflow/front-end-workflow.md`
- [ ] `workflows/back-end-workflow/back-end-workflow.md`
- [ ] `workflows/documentation-workflow/documentation-workflow.md`

### Parameters Files

- [ ] `parameters/README.md`
- [ ] Key parameter files that reference knowledge

### Knowledge Files

- [ ] `knowledge/README.md`
- [ ] `knowledge/patterns/README.md`
- [ ] `knowledge/reference/README.md`
- [ ] `knowledge/guides/README.md`
- [ ] `knowledge/patterns/index.md`
- [ ] `knowledge/reference/index.md`
- [ ] `knowledge/patterns/tool/tool-patterns.md`
- [ ] `knowledge/patterns/tool/tool-combinations.md`
- [ ] `knowledge/patterns/impl/implementation-patterns.md`
- [ ] `knowledge/patterns/doc/file-standards.md`

## Test Scenarios

### Scenario 1: Basic Knowledge Access

Test basic knowledge access documentation:

**Before:**
```markdown
For search patterns, see knowledge/patterns/tool/search-patterns.md.
```

**After:**
```markdown
For search patterns, use:
```typescript
fetch_rules(["knowledge/patterns/tool/search-patterns"])
```
```

### Scenario 2: Explanation Context

Test knowledge access with explanatory context:

**Before:**
```markdown
When implementing search functionality, reference the search-patterns.md file for best practices.
```

**After:**
```markdown
When implementing search functionality, use the fetch_rules tool to access search pattern guidelines:
```typescript
fetch_rules(["knowledge/patterns/tool/search-patterns"], 
           "Implementing efficient search functionality")
```
```

### Scenario 3: Multiple Knowledge Components

Test accessing multiple related knowledge components:

**Before:**
```markdown
For comprehensive tool guidance, see knowledge/patterns/tool/search-patterns.md and knowledge/patterns/tool/command-patterns.md.
```

**After:**
```markdown
For comprehensive tool guidance, use:
```typescript
fetch_rules([
  "knowledge/patterns/tool/search-patterns",
  "knowledge/patterns/tool/command-patterns"
], "Combining search and command patterns for efficient implementation")
```
```

## Knowledge Access Section Template

Use this template for knowledge access sections:

```markdown
## Accessing Specialized Knowledge

Files in the knowledge directory are **Agent Requested Rules** accessed through the fetch_rules tool:

```typescript
// Basic usage - single rule
fetch_rules(["knowledge/patterns/tool/search-patterns"])

// With explanation parameter
fetch_rules(["knowledge/patterns/tool/search-patterns"],
           "Finding efficient search patterns")
```

The fetch_rules tool works in conjunction with the available_instructions section, which lists all available knowledge components that can be accessed.
```

## Implementation Verification Checklist

Use this checklist to verify the overall implementation:

1. **Syntax Consistency**:
   - [ ] All fetch_rules calls use array notation
   - [ ] All string parameters use double quotes
   - [ ] All multiline arrays are consistently formatted

2. **Path Validity**:
   - [ ] All paths exist in the 1000xbrain directory structure
   - [ ] All paths follow the standardized format
   - [ ] No file extensions in paths

3. **Documentation Quality**:
   - [ ] All README.md files include fetch_rules documentation
   - [ ] All knowledge access examples use fetch_rules
   - [ ] Terminology is consistent throughout

4. **No Direct References**:
   - [ ] No direct references to knowledge files remain
   - [ ] All knowledge access uses fetch_rules tool
   - [ ] All examples use proper fetch_rules syntax

This test cheatsheet provides a comprehensive verification framework for ensuring that fetch_rules tool usage is properly implemented across all brain-files in the 1000xbrain directory. 