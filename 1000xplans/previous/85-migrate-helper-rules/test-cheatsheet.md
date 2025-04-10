# Test Cheatsheet: Helper Rules Migration

This document outlines the testing scenarios and verification methods to ensure the successful migration of helper rules to their appropriate mode-specific directories.

## Phase 1: Initial Verification

### Scenario 1: Inventory Verification

**Test Procedure:**
1. Verify the complete inventory of all helper files has been properly recorded
2. Confirm all subdirectories have been explored
3. Check that all files are accounted for in the inventory

**Command Sequence:**
```typescript
// Get full directory listing for comparison
list_dir("1000xbrain/parameters/rules/helpers", true)

// Count total files in inventory
grep_search("helpers/.*\.md", false, "planning/85-migrate-helper-rules/helpers-inventory-and-mapping.md") | wc -l

// Compare actual file count with inventory count
find "1000xbrain/parameters/rules/helpers" -name "*.md" | wc -l
```

**Success Criteria:**
- Inventory count matches actual file count
- All subdirectories are included in the inventory
- Each helper file has a corresponding entry in the migration mapping

### Scenario 2: Migration Mapping Verification

**Test Procedure:**
1. Verify each helper file has a clear migration target
2. Confirm workflow and pathway assignments for all files
3. Check for any unassigned or ambiguous mappings

**Command Sequence:**
```typescript
// Check completeness of mapping table
grep_search("\| \`helpers/.*\` \| \`(plan|dev|direct)-mode/.*\` \|", false, "planning/85-migrate-helper-rules/helpers-inventory-and-mapping.md")

// Verify all files have workflow assignments
grep_search("\| rules-workflow \|", false, "planning/85-migrate-helper-rules/helpers-inventory-and-mapping.md")

// Verify all files have pathway assignments
grep_search("\| (analysis|verification|parameter-management|implementation|recovery|validation|finalization|native) \|", false, "planning/85-migrate-helper-rules/helpers-inventory-and-mapping.md")
```

**Success Criteria:**
- Every helper file has an assigned target location
- Assigned workflow matches the file's purpose
- Assigned pathway corresponds to the file's functionality
- No files lack clear migration assignments

## Phase 2: File Presence Verification

### Scenario 3: Migration Completion Verification

**Test Procedure:**
1. Check that all migrated files exist in their target locations
2. Verify no helper files remain in the original helper directories (or verify which ones do)
3. Confirm file naming follows the mode-specific conventions

**Command Sequence:**
```typescript
// Check plan-mode directory for migrated files
list_dir("1000xbrain/parameters/rules/plan-mode")
grep_search("^analysis-|^verification-|^parameter-|^finalization-", false, "1000xbrain/parameters/rules/plan-mode/*.md")

// Check dev-mode directory for migrated files
list_dir("1000xbrain/parameters/rules/dev-mode")
grep_search("^context-first-implementation|^recovery-|^validation-|^finalization-", false, "1000xbrain/parameters/rules/dev-mode/*.md")

// Check direct-mode directory for migrated files
list_dir("1000xbrain/parameters/rules/direct-mode")
grep_search("^direct-implementation|^direct-implementation-continuation", false, "1000xbrain/parameters/rules/direct-mode/*.md")

// Check for any remaining files in helpers directory
list_dir("1000xbrain/parameters/rules/helpers")
find "1000xbrain/parameters/rules/helpers" -name "*.md" | sort
```

**Success Criteria:**
- All files exist in their target locations with correct naming
- No helper files remain in the original helper directories (unless explicitly excluded)
- Mode directory contents match the migration mapping

### Scenario 4: Naming Convention Verification

**Test Procedure:**
1. Verify files in each mode directory follow naming conventions
2. Check for consistency in prefix usage
3. Identify any naming anomalies

**Command Sequence:**
```typescript
// Check plan-mode naming conventions
find "1000xbrain/parameters/rules/plan-mode" -name "*.md" | sort
grep_search -v "^analysis-|^verification-|^parameter-|^finalization-|^README", false, "1000xbrain/parameters/rules/plan-mode/*.md")

// Check dev-mode naming conventions
find "1000xbrain/parameters/rules/dev-mode" -name "*.md" | sort
grep_search -v "^context-first-implementation|^recovery-|^validation-|^finalization-|^README", false, "1000xbrain/parameters/rules/dev-mode/*.md")

// Check direct-mode naming conventions
find "1000xbrain/parameters/rules/direct-mode" -name "*.md" | sort
grep_search -v "^direct-implementation|^direct-implementation-continuation|^README", false, "1000xbrain/parameters/rules/direct-mode/*.md")
```

**Success Criteria:**
- Plan mode files follow prefixing conventions (analysis-, verification-, parameter-, finalization-)
- Dev mode files follow consistent naming patterns
- Direct mode files maintain their specific naming conventions
- No irregularly named files exist in any mode directory

## Phase 3: Content Verification

### Scenario 5: Standardized Header Verification

**Test Procedure:**
1. Check each migrated file for the standardized header format
2. Verify the header appears as the very first line of the file
3. Confirm workflow type and pathway are correctly specified
4. Check for exact format including pipe symbol and spacing

**Command Sequence:**
```typescript
// Check that every file starts with the header (first line)
grep_search -l "^# Workflow: .*\| Pathway: " "1000xbrain/parameters/rules/plan-mode/*.md" | wc -l
grep_search -l "^# Workflow: .*\| Pathway: " "1000xbrain/parameters/rules/dev-mode/*.md" | wc -l
grep_search -l "^# Workflow: .*\| Pathway: " "1000xbrain/parameters/rules/direct-mode/*.md" | wc -l

// Check for exact header format with no extra spaces
grep_search -l "^# Workflow: rules-workflow \| Pathway: [a-z-]+" "1000xbrain/parameters/rules/plan-mode/*.md" | wc -l
grep_search -l "^# Workflow: rules-workflow \| Pathway: [a-z-]+" "1000xbrain/parameters/rules/dev-mode/*.md" | wc -l
grep_search -l "^# Workflow: rules-workflow \| Pathway: [a-z-]+" "1000xbrain/parameters/rules/direct-mode/*.md" | wc -l

// Check for pathway-specific headers
for pathway in "analysis" "verification" "parameter-management" "implementation" "recovery" "validation" "finalization" "native"; do
  echo "Pathway: $pathway"
  grep_search -l "^# Workflow: rules-workflow \| Pathway: $pathway$" "1000xbrain/parameters/rules/**/*.md" | wc -l
done

// Find any files missing the standardized header
find "1000xbrain/parameters/rules/plan-mode" "1000xbrain/parameters/rules/dev-mode" "1000xbrain/parameters/rules/direct-mode" -name "*.md" | xargs grep -L "^# Workflow: .*\| Pathway: " 
```

**Success Criteria:**
- All migrated files have standardized headers at the very first line
- Headers follow exact format: `# Workflow: rules-workflow | Pathway: [pathway-name]`
- No extra spaces before or after the pipe symbol
- Workflow type and pathway name are in lowercase kebab-case
- Every project-rule-parameter has the header (except README.md)

### Scenario 6: Mode Indicator Verification

**Test Procedure:**
1. Check each migrated file for the correct mode indicator
2. Verify mode indicators align with the file's location
3. Confirm workflow-type placeholder is present

**Command Sequence:**
```typescript
// Check plan-mode files for correct mode indicator
grep_search -l "📋 1000xdev \[workflow-type\]" "1000xbrain/parameters/rules/plan-mode/*.md" | wc -l
find "1000xbrain/parameters/rules/plan-mode" -name "*.md" -not -name "README.md" | wc -l

// Check dev-mode files for correct mode indicator
grep_search -l "💻 1000xdev \[workflow-type\]" "1000xbrain/parameters/rules/dev-mode/*.md" | wc -l
find "1000xbrain/parameters/rules/dev-mode" -name "*.md" -not -name "README.md" | wc -l

// Check direct-mode files for correct mode indicator
grep_search -l "⚡ 1000xdev \[workflow-type\]" "1000xbrain/parameters/rules/direct-mode/*.md" | wc -l
find "1000xbrain/parameters/rules/direct-mode" -name "*.md" -not -name "README.md" | wc -l

// Check for incorrect mode indicators (wrong mode)
grep_search "💻 1000xdev \[workflow-type\]|⚡ 1000xdev \[workflow-type\]" false, "1000xbrain/parameters/rules/plan-mode/*.md"
grep_search "📋 1000xdev \[workflow-type\]|⚡ 1000xdev \[workflow-type\]" false, "1000xbrain/parameters/rules/dev-mode/*.md"
grep_search "📋 1000xdev \[workflow-type\]|💻 1000xdev \[workflow-type\]" false, "1000xbrain/parameters/rules/direct-mode/*.md"
```

**Success Criteria:**
- Plan mode files contain exactly 📋 1000xdev [workflow-type]
- Dev mode files contain exactly 💻 1000xdev [workflow-type]
- Direct mode files contain exactly ⚡ 1000xdev [workflow-type]
- No mode indicator mismatches between file location and indicator
- Mode indicator count matches file count (excluding README.md)

### Scenario 7: Path Reference Verification

**Test Procedure:**
1. Check for any remaining references to the old helpers directory
2. Verify path references use the new mode-specific locations
3. Confirm message-command examples have been updated

**Command Sequence:**
```typescript
// Check for old path references that need updating
grep_search -l "helpers/" "1000xbrain/parameters/rules/plan-mode/*.md"
grep_search -l "helpers/" "1000xbrain/parameters/rules/dev-mode/*.md"
grep_search -l "helpers/" "1000xbrain/parameters/rules/direct-mode/*.md"

// Check message-command examples for updated paths
grep_search "@parameters/rules/helpers/" "1000xbrain/parameters/rules/plan-mode/*.md"
grep_search "@parameters/rules/helpers/" "1000xbrain/parameters/rules/dev-mode/*.md"
grep_search "@parameters/rules/helpers/" "1000xbrain/parameters/rules/direct-mode/*.md"

// Check for correct new path references
grep_search -l "@parameters/rules/plan-mode/" "1000xbrain/parameters/rules/plan-mode/*.md"
grep_search -l "@parameters/rules/dev-mode/" "1000xbrain/parameters/rules/dev-mode/*.md"
grep_search -l "@parameters/rules/direct-mode/" "1000xbrain/parameters/rules/direct-mode/*.md"
```

**Success Criteria:**
- No references to the old helpers directory structure
- Path references correctly use mode-specific directories
- Message-command examples use updated paths
- All @-references use the correct new path format

### Scenario 8: Content Alignment Verification

**Test Procedure:**
1. Examine content to ensure it aligns with mode responsibilities
2. Verify tool call patterns match the mode's expected patterns
3. Check for content that might be misaligned with the mode

**Command Sequence:**
```typescript
// Check for plan-mode appropriate content
grep_search "documentation|planning|analysis|verification" "1000xbrain/parameters/rules/plan-mode/*.md" | wc -l

// Check for dev-mode appropriate content
grep_search "implementation|development|code|testing" "1000xbrain/parameters/rules/dev-mode/*.md" | wc -l

// Check for direct-mode appropriate content
grep_search "research|direct implementation|immediate" "1000xbrain/parameters/rules/direct-mode/*.md" | wc -l

// Check for tool patterns appropriate to plan-mode
grep_search "edit_file\\(.+\\.md" "1000xbrain/parameters/rules/plan-mode/*.md" | wc -l

// Check for tool patterns appropriate to dev-mode
grep_search "edit_file\\(.+\\.ts|js|tsx|jsx|py" "1000xbrain/parameters/rules/dev-mode/*.md" | wc -l

// Check for direct-mode research emphasis
grep_search "research|minimum.*20 tool calls|pattern discovery" "1000xbrain/parameters/rules/direct-mode/*.md" | wc -l

// Check for misaligned content
grep_search "run_terminal_cmd|edit_file\\(.+\\.ts|js|tsx|jsx|py" "1000xbrain/parameters/rules/plan-mode/*.md"
grep_search "planning document|documentation creation" "1000xbrain/parameters/rules/dev-mode/*.md"
grep_search "planning document|implementation plan" "1000xbrain/parameters/rules/direct-mode/*.md"
```

**Success Criteria:**
- Plan mode files focus on documentation and planning activities
- Dev mode files focus on implementation and verification
- Direct mode files emphasize research and immediate implementation
- No significant content-mode misalignments detected

## Phase 4: Integration Testing

### Scenario 9: README File Verification

**Test Procedure:**
1. Check README files in each mode directory for updates
2. Verify they include references to the newly migrated helpers
3. Confirm README files explain the pathway system

**Command Sequence:**
```typescript
// Read updated README files
read_file("1000xbrain/parameters/rules/plan-mode/README.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/rules/dev-mode/README.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/rules/direct-mode/README.md", should_read_entire_file=true)

// Check for migrated helper references
grep_search -l "Migrated Helper Rules" "1000xbrain/parameters/rules/plan-mode/README.md"
grep_search -l "Migrated Helper Rules" "1000xbrain/parameters/rules/dev-mode/README.md"
grep_search -l "Migrated Helper Rules" "1000xbrain/parameters/rules/direct-mode/README.md"

// Check for pathway explanations
grep_search "Pathway" "1000xbrain/parameters/rules/plan-mode/README.md"
grep_search "Pathway" "1000xbrain/parameters/rules/dev-mode/README.md"
grep_search "Pathway" "1000xbrain/parameters/rules/direct-mode/README.md"
```

**Success Criteria:**
- README files mention the newly migrated helpers
- Organization by pathway is clearly explained
- Command examples use the new paths
- Pathway system is documented and defined

### Scenario 10: Command Reference Testing

**Test Procedure:**
1. Test sample message-commands using the new paths
2. Verify the commands function as expected
3. Test each pathway with at least one command

**Command Examples:**
```typescript
// Sample plan-mode command for analysis pathway
plan-mode: rules-workflow @parameters/rules/plan-mode/analysis-requirements.mdc

// Sample plan-mode command for verification pathway
plan-mode: rules-workflow @parameters/rules/plan-mode/verification-planning.mdc

// Sample dev-mode command for implementation pathway
dev-mode: rules-workflow @parameters/rules/dev-mode/context-first-implementation.mdc

// Sample dev-mode command for recovery pathway
continue-implementation: @parameters/rules/dev-mode/recovery-error.mdc

// Sample direct-mode command for implementation pathway
direct-mode: rules-workflow @parameters/rules/direct-mode/direct-implementation.mdc

// Sample direct-mode command for recovery pathway
continue-implementation: @parameters/rules/direct-mode/direct-implementation-continuation.mdc
```

**Success Criteria:**
- Message-commands successfully load the migrated rule files
- Commands function as they did before migration
- No errors or unexpected behavior
- Each pathway has at least one verified command

### Scenario 11: System-Wide Reference Verification

**Test Procedure:**
1. Check for any remaining references to the helpers directory in the entire codebase
2. Verify all documentation has been updated to use the new paths
3. Confirm no lingering references remain

**Command Sequence:**
```typescript
// Search for references in workflow documentation
grep_search "helpers/" "1000xbrain/workflows/**/*.md"

// Search for references in core documentation
grep_search "helpers/" "1000xbrain/core/**/*.md"

// Search for references in knowledge documentation
grep_search "helpers/" "1000xbrain/knowledge/**/*.md"

// Search for references in parameters documentation
grep_search "helpers/" "1000xbrain/parameters/**/*.md"

// Search for message-command examples with old paths
grep_search "@parameters/rules/helpers/" "1000xbrain/**/*.md"
```

**Success Criteria:**
- No references to helpers directory remain in the codebase
- All message-command examples use updated paths
- All documentation is consistent with the new structure

## Phase 5: Edge Case Testing

### Scenario 12: Pathway Consistency Testing

**Test Procedure:**
1. Verify that files in the same pathway have consistent content patterns
2. Check for pathway-specific patterns across different mode directories
3. Verify pathway assignments match file content

**Command Sequence:**
```typescript
// Compare pathway-specific terminology across files
for pathway in "analysis" "verification" "parameter-management" "implementation" "recovery" "validation" "finalization" "native"; do
  echo "==== Pathway: $pathway ===="
  grep_search -l "^# Workflow: rules-workflow \| Pathway: $pathway$" "1000xbrain/parameters/rules/**/*.md"
  grep_search "$pathway" "1000xbrain/parameters/rules/**/*.md" | grep -v "Pathway: $pathway"
done

// Check for common functionality within pathways
grep_search "analysis.*pattern" "1000xbrain/parameters/rules/**/*analysis*.md"
grep_search "verification.*criteria" "1000xbrain/parameters/rules/**/*verification*.md"
grep_search "recovery.*mechanism" "1000xbrain/parameters/rules/**/*recovery*.md"
```

**Success Criteria:**
- Files in the same pathway share consistent terminology
- Pathway-specific patterns are maintained across mode directories
- Pathway assignments match file content and purpose

### Scenario 13: Cross-Mode Dependency Verification

**Test Procedure:**
1. Check for dependencies between files in different modes
2. Verify that cross-mode references use the correct new paths
3. Confirm there are no circular dependencies

**Command Sequence:**
```typescript
// Check for references between modes
grep_search "plan-mode/" "1000xbrain/parameters/rules/dev-mode/*.md"
grep_search "plan-mode/" "1000xbrain/parameters/rules/direct-mode/*.md"

grep_search "dev-mode/" "1000xbrain/parameters/rules/plan-mode/*.md"
grep_search "dev-mode/" "1000xbrain/parameters/rules/direct-mode/*.md"
```

**Success Criteria:**
- Cross-mode references use correct paths
- Dependencies between modes are properly maintained
- No circular dependencies exist

### Scenario 14: File Content Integrity Verification

**Test Procedure:**
1. Verify that no essential content was lost during migration
2. Compare original and migrated files for content equivalence
3. Check for any unintended changes

**Command Sequence:**
```typescript
// For a sample of files, compare original and migrated content
// Excluding the header and path updates

// Example with enhance-planning.md
read_file("1000xbrain/parameters/rules/helpers/finalization/enhance-planning.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/rules/plan-mode/finalization-enhance-planning.md", should_read_entire_file=true)

// Example with direct-implementation.md
read_file("1000xbrain/parameters/rules/helpers/implementation/direct-implementation.md", should_read_entire_file=true)
read_file("1000xbrain/parameters/rules/direct-mode/direct-implementation.md", should_read_entire_file=true)

// Check file sizes to identify potential content loss
find "1000xbrain/parameters/rules/helpers" -name "*.md" -exec ls -l {} \; | sort -k 5 -n
find "1000xbrain/parameters/rules/plan-mode" "1000xbrain/parameters/rules/dev-mode" "1000xbrain/parameters/rules/direct-mode" -name "*.md" -not -name "README.md" -exec ls -l {} \; | sort -k 5 -n
```

**Success Criteria:**
- Essential content preserved in all migrated files
- Only intended changes applied (header addition, path updates, mode-specific adjustments)
- No unintended content changes or omissions

### Scenario 15: Comprehensive Mode-Pathway Verification Matrix

**Test Procedure:**
1. Generate a comprehensive matrix of all mode-pathway combinations
2. Verify files are properly categorized in each combination
3. Identify any gaps or inconsistencies in the migration

**Command Sequence:**
```typescript
# Create a matrix of all mode-pathway combinations
echo "=== Mode-Pathway Matrix ==="
echo -e "Mode\tPathway\tCount"

for mode in "plan-mode" "dev-mode" "direct-mode"; do
  for pathway in "analysis" "verification" "parameter-management" "implementation" "recovery" "validation" "finalization" "native"; do
    count=$(grep_search -l "^# Workflow: rules-workflow \| Pathway: $pathway$" "1000xbrain/parameters/rules/$mode/*.md" | wc -l)
    echo -e "$mode\t$pathway\t$count"
  done
done
```

**Success Criteria:**
- All appropriate mode-pathway combinations are populated
- No unexpected mode-pathway combinations exist
- Distribution of files aligns with migration mapping

## Final Verification Checklist

### Phase 1: Initial Setup
- [ ] Complete inventory verified and documented
- [ ] Migration mapping fully defined and documented
- [ ] All helper files assigned to appropriate mode and pathway

### Phase 2: File Migration
- [ ] All files migrated to target locations
- [ ] Naming conventions followed correctly
- [ ] No remaining files in helpers directory (unless explicitly excluded)
- [ ] File counts match between inventory and migrated files

### Phase 3: Content Updates
- [ ] All files have standardized headers as first line
- [ ] Mode indicators match target directories
- [ ] All path references updated to new structure
- [ ] Content aligns with mode responsibilities
- [ ] No helpers directory references remain

### Phase 4: Documentation
- [ ] README files updated in all mode directories
- [ ] Pathway system clearly documented
- [ ] Message-command examples use correct paths
- [ ] System-wide documentation updated with new paths

### Phase 5: Integration
- [ ] All message-commands function as expected
- [ ] Cross-mode references correct and functional
- [ ] No circular dependencies exist
- [ ] Content integrity maintained through migration

### Phase 6: Final Approval
- [ ] All verification steps completed and passed
- [ ] Mode-pathway matrix confirms proper organization
- [ ] No unexpected errors or inconsistencies
- [ ] Migration successfully completed and documented 