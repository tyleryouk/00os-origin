# Check Extension Format

## File Purpose and Relationship

This file defines the process for verifying proper extension usage within the 1000xbrain cognitive architecture. It should be consulted when:

- Verifying that all project-rule-parameter references use .mdc extension
- Ensuring that all actual files use .md extension
- Checking for extension inconsistencies
- Understanding the distinction between .md and .mdc files

This file complements:
- `@parameters/rules/check-references.mdc`: Reference consistency checking
- `@parameters/rules/verify-backtick-wrapping.mdc`: Backtick wrapping verification
- `@parameters/rules/validate-path-format.mdc`: Path format validation
- `@parameters/rules/scan-symbol-usage.mdc`: @ symbol scanning

## Usage as Project-Rule-Parameter

This file contains the extension format checking process and should be referenced as a project-rule-parameter when verifying extension format consistency:

```
check-extension-format: @parameters/rules/check-extension-format.mdc
```

## Command Format

```
check-extension-format: @parameters/rules/check-extension-format.mdc
```

## Required Context

To perform extension format checking, the following context is required:

1. Access to all 1000xbrain files
2. Understanding of the .md/.mdc extension distinction
3. Knowledge of proper reference formats
4. Understanding of the synchronization process between .md and .mdc files

## Process Steps

### 1. Project-Rule-Parameter Reference Extraction

First, extract all project-rule-parameter references:

```typescript
// Find all project-rule-parameter references
grep_search("@parameters/rules/[a-z0-9-]+\\.[a-z]+", false, "1000xbrain/**/*.md")

// Focus specifically on .md references (potentially incorrect)
grep_search("@parameters/rules/[a-z0-9-]+\\.md[^c]", false, "1000xbrain/**/*.md")
```

### 2. Extension Usage Verification

Verify the proper extension usage in references:

```typescript
// Check for .md extension in references (incorrect)
grep_search("@parameters/rules/[a-z0-9-]+\\.md[^c]", false, "1000xbrain/**/*.md")

// Check for correct .mdc extension in references
grep_search("@parameters/rules/[a-z0-9-]+\\.mdc", false, "1000xbrain/**/*.md")
```

### 3. File Extension Verification

Verify that actual files use the correct .md extension:

```typescript
// List files in knowledge/rules directory
list_dir("1000xbrain/parameters/rules")

// Check for any files with .mdc extension (incorrect)
run_terminal_cmd("Get-ChildItem -Path '1000xbrain/parameters/rules' -Filter '*.mdc' | Select-Object Name", false, false)
```

### 4. Extension Distinction Documentation

Verify that extension distinction is properly documented:

```typescript
// Check for extension distinction explanation
grep_search("extension|.md|.mdc", false, "1000xbrain/workflows/rules-workflow/*.md")
```

### 5. Synchronization Process Verification

Verify that the synchronization process between .md and .mdc files is properly documented:

```typescript
// Check for synchronization process documentation
grep_search("synchronization|sync", false, "1000xbrain/workflows/rules-workflow/*.md")
```

## Expected Outputs

The extension format checking process should produce:

1. A list of all project-rule-parameter references with their extension usage
2. Verification results for extension format compliance
3. Identification of incorrect extension usage
4. Verification that actual files use correct extensions

## Error Handling

Common issues and their resolutions:

| Issue | Resolution |
|-------|------------|
| .md extension in references | Change to .mdc in all project-rule-parameter references |
| .mdc extension in actual files | Change to .md for actual files in 1000xbrain |
| Inconsistent extension documentation | Update documentation to clarify extension usage |
| Missing extension distinction | Add documentation explaining .md vs .mdc usage |

## Extension Check Examples

### Basic Extension Check Report

```
💻 1000xdev [rules-workflow]

Extension format check complete.

References analyzed:
- 189 total project-rule-parameter references found
- 182 references use correct .mdc extension
- 7 references use incorrect .md extension

File extensions:
- All 47 files in knowledge/rules directory use correct .md extension
- No files with incorrect .mdc extension found

Documentation:
- Extension distinction properly documented in rules-workflow.md
- Synchronization process documented in sync-cursor-rules.md

Extension format checking revealed 7 issues that need to be addressed.
```

### Detailed Extension Issues Report

```
💻 1000xdev [rules-workflow]

Detailed extension format issues:

Incorrect .md extension in references:
- knowledge/rules/analyze-related-rules.md: `@parameters/rules/scan-message-commands.md` (line 42)
- workflows/rules-workflow/message-commands-reference.md: `@parameters/rules/verify-implementation.md` (line 78)
- workflows/rules-workflow/rules-workflow-cheatsheet.md: `@parameters/rules/verify-backtick-wrapping.md` (line 36)
- workflows/rules-workflow/rules-workflow-cheatsheet.md: `@parameters/rules/validate-path-format.md` (line 37)
- workflows/rules-workflow/rules-workflow-cheatsheet.md: `@parameters/rules/scan-symbol-usage.md` (line 38)
- core/modes/mode-transitions.md: `@parameters/rules/continue-implementation.md` (line 156)
- core/communication/message-commands.md: `@parameters/rules/continue-planning.md` (line 126)

Implementation recommendations:
- Change all .md to .mdc in project-rule-parameter references
- Add additional documentation about extension distinction if needed
- Ensure all new content follows proper extension usage
```

## Automated Extension Checking

For more efficient extension checking, the following tool sequence can be used:

```typescript
// 1. Extract all project-rule-parameter references
grep_search("@parameters/rules/[a-z0-9-]+\\.[a-z]+", false, "1000xbrain/**/*.md")

// 2. Check for incorrect .md extension
grep_search("@parameters/rules/[a-z0-9-]+\\.md[^c]", false, "1000xbrain/**/*.md")

// 3. Check file extensions
list_dir("1000xbrain/parameters/rules")
run_terminal_cmd("Get-ChildItem -Path '1000xbrain/parameters/rules' -Filter '*.mdc' | Select-Object Name", false, false)

// 4. Document extension checking results
edit_file("1000xbrain/workflows/rules-workflow/extension-check-results.md", 
          "Document extension checking results",
          "# Extension Format Checking Results\n\n...")
```

This extension checking process ensures consistent extension usage throughout the 1000xbrain cognitive architecture, maintaining the critical distinction between source files (.md) and reference files (.mdc). 