# Test Cheatsheet: System-Wide Filepath Migration

## Verification Approach

This test cheatsheet provides a comprehensive guide for verifying the successful migration of filepaths throughout the 1000xbrain cognitive architecture. The verification process will focus on ensuring all file references correctly align with the new directory structure and follow the appropriate access patterns for each rule type.

## Core Verification Areas

### 1. Path Existence Verification

Verify that all referenced files exist at their specified paths:

| Test Area | Verification Approach | Success Criteria |
|-----------|----------------------|------------------|
| Direct Markdown Links | Check each `[text](path/to/file.md)` link | File exists at the referenced path |
| Project-Rule-Parameters | Check each `@parameters/path/to/file.mdc` reference | File exists with `.md` extension in 1000xbrain directory |
| fetch_rules Tool Calls | Check each `fetch_rules(["knowledge/path/to/file"])` | File exists at knowledge/path/to/file.md |
| Directory Structure Diagrams | Check each file listed in structure diagrams | Files exist at the represented paths |
| Code Examples | Check file paths in example code | Referenced files exist at specified paths |

### 2. Rule Type Alignment Verification

Verify that file references align with the appropriate rule type:

| Rule Type | Directory | Access Method | Verification Approach |
|-----------|-----------|---------------|----------------------|
| Always | /core | Automatic | Check references to core files use direct links |
| Auto-Attached | /workflows | File matching | Check references to workflow files use direct links |
| Manual | /parameters | Explicit reference | Check references use `@parameters/path/file.mdc` format |
| Agent Requested | /knowledge | fetch_rules tool | Check references use `fetch_rules(["knowledge/path/file"])` format |

### 3. Access Method Verification

Verify that the correct access method is used for each rule type:

| Access Method | Pattern | Verification Approach |
|---------------|---------|----------------------|
| Direct Link | `[text](path/to/file.md)` | Check direct links are used for core and workflow references |
| Project-Rule-Parameter | `@parameters/path/file.mdc` | Check Manual rules use @parameters reference format |
| fetch_rules Tool Call | `fetch_rules(["knowledge/path/file"])` | Check Agent Requested rules use fetch_rules format |

### 4. Cross-Reference Integrity Verification

Verify that cross-references between components are maintained correctly:

| Reference Type | Verification Approach | Success Criteria |
|----------------|----------------------|------------------|
| Bidirectional References | Check both sides of cross-references | Both files reference each other correctly |
| Component Dependencies | Check references across component boundaries | References follow correct directory structure |
| README References | Check README file references to components | References use correct paths for referenced components |

## Test Case Matrix

### Core Path Test Cases

| Test ID | Test Case | Input | Expected Result | Verification Method |
|---------|-----------|-------|----------------|---------------------|
| C-01 | Core Identity File Reference | `meta/identity/global-rules.md` | `core/identity/global-rules.md` | Direct file check |
| C-02 | Core Modes File Reference | `meta/modes/plan-mode.md` | `core/modes/plan-mode.md` | Direct file check |
| C-03 | Core Communication File Reference | `meta/communication/message-commands.md` | `core/communication/message-commands.md` | Direct file check |
| C-04 | Core README Structure | Structure diagram in core/README.md | Updated structure with /core directories | Visual inspection |
| C-05 | Core Cross-References | References between core files | All references use /core paths | Regex search |

### Workflow Path Test Cases

| Test ID | Test Case | Input | Expected Result | Verification Method |
|---------|-----------|-------|----------------|---------------------|
| W-01 | Rules Workflow Reference | `domains/rules/rules-workflow.md` | `workflows/rules-workflow/rules-workflow.md` | Direct file check |
| W-02 | Front-End Workflow Reference | `domains/front-end/front-end-workflow.md` | `workflows/front-end-workflow/front-end-workflow.md` | Direct file check |
| W-03 | Back-End Workflow Reference | `domains/back-end/back-end-workflow.md` | `workflows/back-end-workflow/back-end-workflow.md` | Direct file check |
| W-04 | Workflow README Structure | Structure diagram in workflows/README.md | Updated structure with /workflows directories | Visual inspection |
| W-05 | Workflow Cross-References | References between workflow files | All references use /workflows paths | Regex search |

### Parameter Path Test Cases

| Test ID | Test Case | Input | Expected Result | Verification Method |
|---------|-----------|-------|----------------|---------------------|
| P-01 | Rules Parameter Reference | `@knowledge/rules/plan-mode-system-wide.mdc` | `@parameters/rules/plan-mode-system-wide.mdc` | Regex search |
| P-02 | Front-End Parameter Reference | `@knowledge/front-end/react-components.mdc` | `@parameters/front-end/react-components.mdc` | Regex search |
| P-03 | Back-End Parameter Reference | `@knowledge/back-end/fastapi-patterns.mdc` | `@parameters/back-end/fastapi-patterns.mdc` | Regex search |
| P-04 | Parameter README Structure | Structure diagram in parameters/README.md | Updated structure with /parameters directories | Visual inspection |
| P-05 | Parameter File Link | Link to `knowledge/rules/plan-mode-system-wide.md` | Link to `parameters/rules/plan-mode-system-wide.md` | Regex search |

### Knowledge Path Test Cases

| Test ID | Test Case | Input | Expected Result | Verification Method |
|---------|-----------|-------|----------------|---------------------|
| K-01 | Patterns Reference | `domains/knowledge/patterns/implementation-patterns.md` | `knowledge/patterns/impl/implementation-patterns.md` | Direct file check |
| K-02 | Architecture Reference | `meta/architecture/structure-overview.md` | `knowledge/reference/architecture/structure-overview.md` | Direct file check |
| K-03 | Guides Reference | `domains/knowledge/guides/architecture.md` | `knowledge/guides/architecture.md` | Direct file check |
| K-04 | fetch_rules Tool Call | `fetch_rules(["domains/knowledge/patterns/implementation-patterns"])` | `fetch_rules(["knowledge/patterns/impl/implementation-patterns"])` | Regex search |
| K-05 | Knowledge README Structure | Structure diagram in knowledge/README.md | Updated structure with /knowledge directories | Visual inspection |

### Cross-System Test Cases

| Test ID | Test Case | Input | Expected Result | Verification Method |
|---------|-----------|-------|----------------|---------------------|
| X-01 | Core → Workflow Reference | Reference from core file to workflow file | Updated path to /workflows directory | Regex search |
| X-02 | Workflow → Parameter Reference | Message-command with @knowledge parameter | Message-command with @parameters parameter | Regex search |
| X-03 | Direct → fetch_rules Conversion | Direct link to knowledge file | fetch_rules tool call to knowledge file | Regex search |
| X-04 | Root README Rule Type Table | Directory and rule type mapping | Updated mapping with new directory structure | Visual inspection |
| X-05 | Directory Structure Diagram | ASCII diagram of directory structure | Updated diagram with new directories | Visual inspection |

### Special Case Test Cases

| Test ID | Test Case | Input | Expected Result | Verification Method |
|---------|-----------|-------|----------------|---------------------|
| S-01 | Nested Path Reference | Path in code block or example | Updated path following migration pattern | Regex search within code blocks |
| S-02 | Mixed Access Method Reference | Documentation showing multiple access methods | All methods updated to correct formats | Manual inspection |
| S-03 | File Structure Diagram | ASCII diagram showing file structure | Updated diagram with correct paths | Visual inspection |
| S-04 | Message-Command Example | Example showing command with parameter | Updated parameter path in example | Regex search |
| S-05 | fetch_rules Example | Example showing fetch_rules call | Updated path in fetch_rules example | Regex search |

## Verification Techniques

### 1. Regex Search Patterns

Use these regex patterns to find paths that need updating:

| Target | Regex Pattern | Replacement Pattern |
|--------|--------------|---------------------|
| Core File Paths | `\bmeta/(identity\|modes\|communication)/([a-zA-Z0-9-]+\.md)\b` | `core/$1/$2` |
| Workflow File Paths | `\bdomains/(rules\|front-end\|back-end\|documentation\|scripts)/([a-zA-Z0-9-]+\.md)\b` | `workflows/$1-workflow/$2` |
| Parameter References | `@knowledge/(rules\|front-end\|back-end\|documentation\|scripts)/([a-zA-Z0-9-]+\.mdc)\b` | `@parameters/$1/$2` |
| Knowledge File Paths | `\bdomains/knowledge/([a-zA-Z0-9/-]+\.md)\b` | `knowledge/$1` |
| Architecture Paths | `\bmeta/architecture/([a-zA-Z0-9-]+\.md)\b` | `knowledge/reference/architecture/$1` |
| fetch_rules Calls | `fetch_rules\(\["domains/knowledge/([a-zA-Z0-9/-]+)"\]\)` | `fetch_rules(["knowledge/$1"])` |

### 2. Direct File Existence Checks

Use these commands to verify file existence after updates:

```bash
# Check all markdown links point to existing files
find 1000xbrain -name "*.md" -exec grep -o "\[[^]]*\]([^)]*\.md)" {} \; | sed 's/.*(\(.*\))/\1/' | xargs -I{} test -f "1000xbrain/{}" && echo "File exists: {}" || echo "Missing file: {}"

# Check all parameter references have corresponding files
find 1000xbrain -name "*.md" -exec grep -o "@parameters/[^[:space:]]*\.mdc" {} \; | sed 's/@parameters\(.*\)\.mdc/\1.md/' | xargs -I{} test -f "1000xbrain/parameters{}" && echo "File exists: {}" || echo "Missing file: {}"

# Check all fetch_rules calls point to existing files
find 1000xbrain -name "*.md" -exec grep -o 'fetch_rules(\["knowledge/[^"]*"\])' {} \; | sed 's/fetch_rules(\["knowledge\/\([^"]*\)"\])/\1.md/' | xargs -I{} test -f "1000xbrain/knowledge/{}" && echo "File exists: {}" || echo "Missing file: {}"
```

### 3. Visual Inspection Checklist

For visual elements that require manual inspection:

| Element | Inspection Points | Success Criteria |
|---------|------------------|------------------|
| Directory Structure Diagrams | Directory names, structure hierarchy | Matches new directory structure |
| Rule Type Tables | Directory names, rule types, access methods | Correctly maps directories to rule types |
| Code Examples | File paths in example code | Uses new path structure |
| Message-Command Examples | Parameter paths in examples | Uses @parameters format |
| fetch_rules Examples | Knowledge paths in examples | Uses knowledge directory |

### 4. Comprehensive Path Validation Script

Create a script to validate all path references throughout the codebase:

```bash
#!/bin/bash
# Validate all path references in the 1000xbrain directory

# Check direct markdown links
echo "Checking markdown links..."
find 1000xbrain -name "*.md" -exec grep -o "\[[^]]*\]([^)]*\.md)" {} \; | sed 's/.*(\(.*\))/\1/' > markdown_links.txt
cat markdown_links.txt | while read link; do
    if [[ ! -f "1000xbrain/$link" ]]; then
        echo "Invalid link: $link"
    fi
done

# Check parameter references
echo "Checking parameter references..."
find 1000xbrain -name "*.md" -exec grep -o "@parameters/[^[:space:]]*\.mdc" {} \; | sed 's/@parameters\(.*\)\.mdc/\1.md/' > parameter_refs.txt
cat parameter_refs.txt | while read ref; do
    if [[ ! -f "1000xbrain/parameters$ref" ]]; then
        echo "Invalid parameter reference: parameters$ref"
    fi
done

# Check fetch_rules calls
echo "Checking fetch_rules calls..."
find 1000xbrain -name "*.md" -exec grep -o 'fetch_rules(\["knowledge/[^"]*"\])' {} \; | sed 's/fetch_rules(\["knowledge\/\([^"]*\)"\])/\1.md/' > knowledge_refs.txt
cat knowledge_refs.txt | while read ref; do
    if [[ ! -f "1000xbrain/knowledge/$ref" ]]; then
        echo "Invalid knowledge reference: knowledge/$ref"
    fi
done

# Check for old path patterns
echo "Checking for old path patterns..."
find 1000xbrain -name "*.md" -exec grep -l "\bmeta/\|\bdomains/\|@knowledge/" {} \; > files_with_old_paths.txt
if [[ -s files_with_old_paths.txt ]]; then
    echo "Files still containing old path patterns:"
    cat files_with_old_paths.txt
fi

echo "Validation complete."
```

## Cross-Reference Verification Matrix

Use this matrix to verify cross-references between components:

| From → To | Core | Workflows | Parameters | Knowledge |
|-----------|------|-----------|------------|-----------|
| **Core** | core/file.md | workflows/domain-workflow/file.md | @parameters/domain/file.mdc | fetch_rules(["knowledge/category/file"]) |
| **Workflows** | core/file.md | workflows/domain-workflow/file.md | @parameters/domain/file.mdc | fetch_rules(["knowledge/category/file"]) |
| **Parameters** | core/file.md | workflows/domain-workflow/file.md | @parameters/domain/file.mdc | fetch_rules(["knowledge/category/file"]) |
| **Knowledge** | core/file.md | workflows/domain-workflow/file.md | @parameters/domain/file.mdc | fetch_rules(["knowledge/category/file"]) |

## Directory Structure Verification

Verify the directories have the correct structure:

```bash
# Core directory structure
find 1000xbrain/core -type d -maxdepth 1 | sort
# Expected: communication, identity, modes

# Workflows directory structure
find 1000xbrain/workflows -type d -maxdepth 1 | sort
# Expected: rules-workflow, front-end-workflow, back-end-workflow, documentation-workflow, scripts-workflow

# Parameters directory structure
find 1000xbrain/parameters -type d -maxdepth 1 | sort
# Expected: rules, front-end, back-end, documentation, scripts

# Knowledge directory structure
find 1000xbrain/knowledge -type d -maxdepth 1 | sort
# Expected: guides, patterns, reference
```

## Documentation Verification

### README.md Directory Structure Verification

Check that all README.md files accurately describe the new directory structure:

| File | Verification Points | Success Criteria |
|------|---------------------|------------------|
| 1000xbrain/README.md | Directory structure description, rule type mapping | Correctly describes four-directory structure |
| core/README.md | Core directory structure, purpose | Correctly describes core as Always rules |
| workflows/README.md | Workflow directory structure, purpose | Correctly describes workflows as Auto-Attached rules |
| parameters/README.md | Parameter directory structure, purpose | Correctly describes parameters as Manual rules |
| knowledge/README.md | Knowledge directory structure, purpose | Correctly describes knowledge as Agent Requested rules |

### Rule Type and Access Method Documentation

Verify that all documentation correctly describes rule types and access methods:

| Rule Type | Directory | Access Method | Verification Points |
|-----------|-----------|---------------|---------------------|
| Always | /core | Automatic | Documentation describes automatic inclusion |
| Auto-Attached | /workflows | File matching | Documentation describes file pattern matching activation |
| Manual | /parameters | Explicit reference | Documentation describes @parameters/path/file.mdc format |
| Agent Requested | /knowledge | fetch_rules tool | Documentation describes fetch_rules(["knowledge/path/file"]) format |

By using this comprehensive test cheatsheet, we can systematically verify that all filepath references throughout the 1000xbrain cognitive architecture have been correctly updated to align with the new directory structure and access patterns. 