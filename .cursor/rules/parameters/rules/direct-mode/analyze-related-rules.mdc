# Analyze Related Rules

## File Purpose and Relationship

This file defines the process for analyzing relationships between project rules within the 1000xbrain cognitive architecture. It should be consulted when:

- Assessing interdependencies between different project rules
- Identifying impact of rule changes on other rules
- Ensuring consistent cross-references between rules
- Mapping the overall rule architecture

This file complements:
- **scan-message-commands.md**: Message-command scanning process
- **audit-project-rules.md**: Project rule audit process
- **rules-workflow.md**: Rules workflow process and standards

## Required Context

To perform relationship analysis, the following context is required:

1. Access to all 1000xbrain files, particularly in the knowledge/rules directory
2. Understanding of the message-command system
3. Knowledge of the project-rule-parameter reference patterns

## Process Steps

### 1. Rule Inventory Creation

First, create a comprehensive inventory of all project rules:

```typescript
// List all files in the knowledge/rules directory
list_dir("1000xbrain/knowledge/rules")

// Get file count to understand scope
run_terminal_cmd("Get-ChildItem -Path '1000xbrain/knowledge/rules' -File | Measure-Object | Select-Object -ExpandProperty Count", false, false)
```

### 2. Reference Extraction

Extract all cross-references between project rules:

```typescript
// Find all references to other project rules
grep_search("@knowledge/rules/[a-z0-9-]+\.mdc", false, "1000xbrain/knowledge/rules/*.md")

// Find all references in message-commands documentation
grep_search("message-command.*@knowledge/rules", false, "1000xbrain/**/*.md")
```

### 3. Dependency Mapping

Create a dependency map showing which rules rely on others:

```typescript
// For each rule, find what other rules reference it
grep_search("@knowledge/rules/specific-rule.mdc", false, "1000xbrain/knowledge/rules/*.md")
```

### 4. Consistency Verification

Verify that references are consistent across all rules:

```typescript
// Check for consistent path format
grep_search("@(?!knowledge/rules/)[^\\s]+\\.mdc", false, "1000xbrain/knowledge/rules/*.md")

// Check for consistent extension usage
grep_search("@knowledge/rules/[a-z0-9-]+\\.md[^c]", false, "1000xbrain/knowledge/rules/*.md")
```

### 5. Impact Analysis

Analyze the potential impact of changes to specific rules:

```typescript
// For a specific rule, identify all dependent rules
grep_search("@knowledge/rules/target-rule.mdc", false, "1000xbrain/**/*.md")

// Check for implementation dependencies
codebase_search("specific rule implementation pattern", ["1000xbrain/knowledge/rules"])
```

## Expected Outputs

The analysis process should produce:

1. A complete inventory of all project rules
2. A dependency map showing relationships between rules
3. A list of inconsistencies or issues in references
4. Recommendations for improving rule relationships

## Error Handling

Common issues and their resolutions:

| Issue | Resolution |
|-------|------------|
| Inconsistent reference formats | Standardize to `@knowledge/rules/filename.mdc` format |
| Circular dependencies | Break circular relationships by refactoring rules |
| Orphaned rules | Document or remove rules with no incoming references |
| Missing references | Add proper backtick-wrapped references |

## Analysis Examples

### Basic Analysis Report

```
📋 1000xdev [rules-workflow]

Related rules analysis complete.

Rule inventory:
- 47 rules in knowledge/rules directory

Dependency highlights:
- Core rules (mode-transitions.md, core-essentials.md) referenced by 15+ other rules
- Template rules referenced by 5+ other rules
- Verification rules mostly self-contained
- Usage patterns (verify-planning.md, check-references.md) referenced by 10-15 other rules
- Special workflows (log-based-workflow.md, error-recovery.md) referenced by 8-12 other rules

Reference consistency:
- 95% of references follow standard format
- 3 rules use inconsistent path formats
- 2 rules use incorrect extensions

Recommendations:
- Standardize all references to @knowledge/rules/*.mdc format
- Add cross-references to 4 under-referenced rules
- Consider consolidating 2 rules with significant overlap
```

### Detailed Impact Analysis

```
📋 1000xdev [rules-workflow]

Impact analysis for proposed changes to verify-planning.md complete.

Rules directly referencing verify-planning.md:
- continue-planning.md
- template-basic.md
- template-advanced.md

Indirect dependencies:
- 5 additional rules depend on continue-planning.md
- 3 additional rules depend on plan-mode-subsystem.md

Impact assessment:
- Medium impact (affects 10 total rules)
- Verification process changes will require updates to dependent rules
- Documentation references will need updating in workflow files

Implementation recommendation:
- Staged approach with initial core changes
- Followed by updates to directly dependent rules
- Final updates to indirectly dependent rules
```

## Automated Analysis

For more efficient analysis, the following tool sequence can be used:

```typescript
// 1. Create rule inventory
list_dir("1000xbrain/knowledge/rules")

// 2. Extract all cross-references
grep_search("@knowledge/rules/[a-z0-9-]+\.mdc", false, "1000xbrain/knowledge/rules/*.md")

// 3. For specific rule analysis
grep_search("@knowledge/rules/target-rule.mdc", false, "1000xbrain/**/*.md")

// 4. Check for inconsistencies
grep_search("@(?!knowledge/rules/)[^\\s]+\\.mdc", false, "1000xbrain/knowledge/rules/*.md")

// 5. Document findings
edit_file("planning/rules-analysis/analysis-results.md", 
          "Document rule relationship findings",
          "# Rule Relationship Analysis\n\n...")
```

This analysis process ensures understanding of the complex interconnections between project rules and helps maintain a consistent, well-structured rule system. 