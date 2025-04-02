# Scan Symbol Usage

## File Purpose and Relationship

This file defines the process for scanning and validating @ symbol usage within the 1000xbrain cognitive architecture. It should be consulted when:

- Performing comprehensive @ symbol usage analysis
- Verifying compliance with @ symbol usage guidelines
- Identifying patterns of @ symbol usage
- Ensuring consistent symbol handling across the codebase

This file complements:
- **check-references.md**: Reference consistency checking
- **verify-backtick-wrapping.md**: Backtick wrapping verification
- **validate-path-format.md**: Path format validation
- **scanning-process.md**: @ symbol scanning process

## Usage as Project-Rule-Parameter

This file contains the comprehensive @ symbol scanning process and should be referenced as a project-rule-parameter when conducting a thorough symbol usage audit:

```
scan-symbol-usage: @knowledge/rules/scan-symbol-usage.mdc
```

## Command Format

```
scan-symbol-usage: @knowledge/rules/scan-symbol-usage.mdc
```

## Required Context

To perform @ symbol usage scanning, the following context is required:

1. Access to all 1000xbrain files
2. Understanding of the @ symbol usage guidelines
3. Knowledge of acceptable and unacceptable @ symbol patterns
4. Awareness of exceptions for the first 20 lines

## Process Steps

### 1. Comprehensive @ Symbol Extraction

First, perform a comprehensive extraction of all @ symbols:

```typescript
// Find all @ symbols
grep_search("@", false, "1000xbrain/**/*.md")

// Count total @ symbols
run_terminal_cmd("Get-ChildItem -Path '1000xbrain' -Recurse -Include '*.md' | Select-String -Pattern '@' -AllMatches | ForEach-Object { $_.Matches } | Measure-Object | Select-Object -ExpandProperty Count", false, false)
```

### 2. @ Symbol Location Analysis

Analyze where @ symbols appear in the codebase:

```typescript
// Find @ symbols in file headers
grep_search("^# .*@|^## .*@", false, "1000xbrain/**/*.md")

// Find @ symbols in first 20 lines
run_terminal_cmd("foreach ($file in Get-ChildItem -Path '1000xbrain' -Recurse -Include '*.md') { $content = Get-Content $file.FullName -TotalCount 20; $matches = [regex]::Matches($content, '@'); foreach ($match in $matches) { Write-Output $file.Name + ': @ symbol in first 20 lines' } }", false, false)

// Find @ symbols in regular text (not in code blocks)
grep_search("[^`]@[^`]", false, "1000xbrain/**/*.md")
```

### 3. @ Symbol Pattern Analysis

Analyze patterns of @ symbol usage:

```typescript
// Find common project-rule-parameter patterns
grep_search("@knowledge/rules/[a-z0-9-]+\\.mdc", false, "1000xbrain/**/*.md")

// Find @ symbols in code blocks
grep_search("```.*@", false, "1000xbrain/**/*.md")

// Find unusual @ symbol patterns
grep_search("@[^a-z0-9-/]", false, "1000xbrain/**/*.md")
```

### 4. @ Symbol Usage Compliance

Verify compliance with @ symbol usage guidelines:

```typescript
// Check for unwrapped @ symbols (potentially problematic)
grep_search("@[^`]", false, "1000xbrain/**/*.md")

// Check for @ symbols in file names or headers
run_terminal_cmd("Get-ChildItem -Path '1000xbrain' -Recurse | Where-Object { $_.Name -match '@' } | Select-Object -ExpandProperty FullName", false, false)
grep_search("^#.*@", false, "1000xbrain/**/*.md")

// Check for multiple unwrapped @ symbols in close proximity
grep_search("[^`]@.*@[^`]", false, "1000xbrain/**/*.md")
```

### 5. @ Symbol Density Analysis

Analyze the density of @ symbols in files:

```typescript
// Find files with high @ symbol counts
run_terminal_cmd("Get-ChildItem -Path '1000xbrain' -Recurse -Include '*.md' | ForEach-Object { $file = $_; $count = (Select-String -Path $file.FullName -Pattern '@' -AllMatches).Matches.Count; [PSCustomObject]@{ File = $file.FullName; Count = $count } } | Sort-Object -Property Count -Descending | Select-Object -First 10", false, false)

// Check for files with excessive @ symbol density
run_terminal_cmd("Get-ChildItem -Path '1000xbrain' -Recurse -Include '*.md' | ForEach-Object { $file = $_; $count = (Select-String -Path $file.FullName -Pattern '@' -AllMatches).Matches.Count; $lines = (Get-Content $file.FullName).Count; if ($lines -gt 0) { $density = [math]::Round(($count / $lines) * 100, 2); [PSCustomObject]@{ File = $file.FullName; Count = $count; Lines = $lines; Density = \"$density%\" } } } | Sort-Object -Property Density -Descending | Select-Object -First 5", false, false)
```

## Expected Outputs

The @ symbol scanning process should produce:

1. A comprehensive inventory of @ symbol usage
2. Analysis of @ symbol patterns and locations
3. Compliance verification against @ symbol guidelines
4. Identification of potential @ symbol issues

## Error Handling

Common issues and their resolutions:

| Issue | Resolution |
|-------|------------|
| Unwrapped @ symbols | Add backtick wrapping around @ symbols |
| @ symbols in headers | Remove @ symbols from headers or reword |
| Multiple unwrapped @ symbols | Use code blocks or separate with text |
| @ symbols in file names | Rename files to avoid @ symbols |
| Excessive @ symbol density | Restructure content to reduce @ symbol usage |

## Symbol Scanning Examples

### Basic Symbol Scanning Report

```
💻 1000xdev [rules-workflow]

Symbol usage scanning complete.

Symbol inventory:
- 247 total @ symbols found across 42 files
- 189 @ symbols in project-rule-parameter references
- 58 @ symbols in other contexts

Location analysis:
- 32 @ symbols in first 20 lines of files (acceptable)
- 12 @ symbols in file headers (review needed)
- 203 @ symbols in regular text

Compliance verification:
- 218 properly backtick-wrapped @ symbols
- 29 unwrapped @ symbols
- 5 files with excessive @ symbol density (>5% of lines)

Symbol scanning identified 41 potential issues that should be reviewed.
```

### Detailed Symbol Usage Analysis

```
💻 1000xdev [rules-workflow]

Detailed @ symbol usage analysis:

High @ symbol density files:
- core/communication/symbol-guidelines.md: 52 symbols, 156 lines (33.3% density)
- workflows/rules-workflow/scanning-process.md: 31 symbols, 156 lines (19.9% density)
- core/communication/message-commands.md: 21 symbols, 122 lines (17.2% density)

@ symbol patterns:
- Project-rule-parameter references: 189 instances (76.5%)
- Cross-references at file beginnings: 28 instances (11.3%)
- Code block examples: 22 instances (8.9%)
- Unwrapped in text: 8 instances (3.2%)

Implementation recommendations:
- Wrap 8 unwrapped @ symbols in backticks
- Reword 12 headers containing @ symbols
- Use code blocks for dense @ symbol sections
- Consider restructuring symbol-guidelines.md to reduce density
```

## Automated Symbol Scanning

For more efficient symbol scanning, the following tool sequence can be used:

```typescript
// 1. Extract all @ symbols
grep_search("@", false, "1000xbrain/**/*.md")

// 2. Find unwrapped @ symbols
grep_search("@[^`]|[^`]@", false, "1000xbrain/**/*.md")

// 3. Analyze @ symbol patterns
grep_search("@knowledge/rules/[a-z0-9-]+\\.mdc", false, "1000xbrain/**/*.md")
grep_search("^#.*@", false, "1000xbrain/**/*.md")

// 4. Check for @ symbols in file names
run_terminal_cmd("Get-ChildItem -Path '1000xbrain' -Recurse | Where-Object { $_.Name -match '@' } | Select-Object -ExpandProperty FullName", false, false)

// 5. Document scanning results
edit_file("1000xbrain/workflows/rules-workflow/symbol-scanning-results.md", 
          "Document @ symbol scanning results",
          "# @ Symbol Scanning Results\n\n...")
```

This comprehensive @ symbol scanning process provides a detailed analysis of symbol usage patterns, identifies potential issues, and ensures consistent, reliable @ symbol handling throughout the 1000xbrain cognitive architecture. 