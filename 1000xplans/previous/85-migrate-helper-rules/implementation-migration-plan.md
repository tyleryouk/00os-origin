# Implementation Plan: Helper Rules Migration

## Objective

Migrate all helper rules from the current `1000xbrain/parameters/rules/helpers/` directory structure to the appropriate mode-specific directories (`plan-mode/`, `dev-mode/`, or `direct-mode/`), ensuring logical organization, consistent naming, and appropriate content updates including standardized pathway headers.

## Target Files

The migration will involve:

1. **Source Directory**: 
   - All files in `1000xbrain/parameters/rules/helpers/` and its subdirectories

2. **Target Directories**:
   - `1000xbrain/parameters/rules/plan-mode/`
   - `1000xbrain/parameters/rules/dev-mode/`
   - `1000xbrain/parameters/rules/direct-mode/`

## Implementation Approach

### Phase 1: Analysis and Inventory

1. **Complete Inventory Creation**
   - Use tool calls to create a comprehensive inventory of all helper files
   - Tool call sequence:
   ```typescript
   // List all directories within helpers
   list_dir("1000xbrain/parameters/rules/helpers")

   // For each subdirectory, list all files
   list_dir("1000xbrain/parameters/rules/helpers/analysis")
   list_dir("1000xbrain/parameters/rules/helpers/implementation")
   list_dir("1000xbrain/parameters/rules/helpers/recovery")
   list_dir("1000xbrain/parameters/rules/helpers/validation")
   list_dir("1000xbrain/parameters/rules/helpers/verification")
   list_dir("1000xbrain/parameters/rules/helpers/finalization")
   list_dir("1000xbrain/parameters/rules/helpers/parameter-management")
   ```
   - Document the complete inventory in `helpers-inventory-and-mapping.md`
   - Expected outcome: Complete list of all helper files organized by subdirectory

2. **Content Analysis for Mode Assignment**
   - Analyze each file's content to determine appropriate mode assignment
   - Tool call sequence for each file:
   ```typescript
   // Read file content
   read_file("1000xbrain/parameters/rules/helpers/[subdirectory]/[filename].md", should_read_entire_file=true)
   
   // Analyze mode indicators and content focus
   grep_search("📋 1000xdev|💻 1000xdev|⚡ 1000xdev", false, "1000xbrain/parameters/rules/helpers/[subdirectory]/[filename].md")
   grep_search("planning|documentation|analysis", false, "1000xbrain/parameters/rules/helpers/[subdirectory]/[filename].md")
   grep_search("implementation|code|development", false, "1000xbrain/parameters/rules/helpers/[subdirectory]/[filename].md")
   grep_search("direct|immediate|research", false, "1000xbrain/parameters/rules/helpers/[subdirectory]/[filename].md")
   ```
   - Apply decision framework documented in `context-mode-specific-patterns.md`
   - Expected outcome: Mode assignment for each helper file

3. **Pathway Identification**
   - Analyze each file to determine the appropriate pathway
   - Review existing pathways in the target mode directories
   - Document pathway assignment in the migration mapping
   - Expected outcome: Pathway assignment for each helper file

4. **Dependency Analysis**
   - Identify cross-references between helper files
   - Document dependencies to ensure updates are made in correct order
   - Tool call sequence:
   ```typescript
   // Search for references to other helper files
   grep_search("helpers/", false, "1000xbrain/parameters/rules/helpers/**/*.md")
   ```
   - Expected outcome: Map of dependencies between helper files

### Phase 2: Preparation and Planning

1. **Detailed Migration Mapping Creation**
   - Create a comprehensive mapping document with:
     - Source path
     - Target path
     - Mode assignment
     - Pathway assignment
     - Required content updates
     - Dependencies
   - Format as a structured table in `helpers-inventory-and-mapping.md`
   - Expected outcome: Complete migration mapping for all helper files

2. **Standardized Header Template Creation**
   - Create standardized header templates for each workflow-pathway combination
   - Document templates in the implementation plan
   - Include validation checks to ensure header format consistency
   - Expected outcome: Header templates for all workflow-pathway combinations

3. **Migration Batch Planning**
   - Organize files into migration batches based on:
     - Dependencies (independent files first)
     - Complexity (simpler files first)
     - Mode/pathway groupings (migrate related files together)
   - Document batch plan in the implementation plan
   - Expected outcome: Organized migration sequence with batch assignments

4. **Verification Checklist Development**
   - Create a detailed verification checklist for each migration batch
   - Include file-specific verification criteria
   - Document verification process in `test-cheatsheet.md`
   - Expected outcome: Comprehensive verification checklist for all migrations

### Phase 3: Migration Execution

For each batch of helper rules:

1. **Pre-Migration Verification**
   - Verify source files exist and content is understood
   - Review dependencies and ensure proper migration order
   - Tool call sequence:
   ```typescript
   // Verify source file exists
   read_file("1000xbrain/parameters/rules/helpers/[subdirectory]/[filename].md", should_read_entire_file=true)
   ```
   - Expected outcome: Confirmation that files are ready for migration

2. **Target File Creation with Standardized Header**
   - Create each target file with the standardized header and updated content
   - Tool call sequence:
   ```typescript
   // Create target file with standardized header
   edit_file("1000xbrain/parameters/rules/[mode-directory]/[target-filename].md",
           "Create [target-filename].md with standardized header and updated content",
           "# Workflow: rules-workflow | Pathway: [pathway-name]\n\n[Original file content with necessary updates]")
   ```
   - Apply these specific updates to each file:
     - Add standardized header as first line
     - Update mode indicator to match target mode (📋, 💻, or ⚡)
     - Update path references from old to new structure
     - Update content to align with mode-specific context
   - Expected outcome: New file created in target directory with proper header and updated content

3. **Content Path Reference Updates**
   - Update all path references in the content to reflect the new structure
   - Tool call sequence:
   ```typescript
   // Update path references in content
   edit_file("1000xbrain/parameters/rules/[mode-directory]/[target-filename].md",
           "Update path references in [target-filename].md",
           "// ... existing content with helpers/ references replaced with mode-specific paths ...")
   ```
   - Expected outcome: All path references updated to reflect new structure

4. **Post-Migration Verification**
   - Verify the target file was created successfully
   - Check content updates were applied correctly
   - Tool call sequence:
   ```typescript
   // Verify target file creation
   read_file("1000xbrain/parameters/rules/[mode-directory]/[target-filename].md", should_read_entire_file=true)
   
   // Verify header format
   grep_search("^# Workflow: rules-workflow \| Pathway: [pathway-name]", false, "1000xbrain/parameters/rules/[mode-directory]/[target-filename].md")
   
   // Verify no references to old paths remain
   grep_search("helpers/", false, "1000xbrain/parameters/rules/[mode-directory]/[target-filename].md")
   ```
   - Expected outcome: Successful verification of each migrated file

### Phase 4: Documentation and System Updates

1. **README File Updates**
   - Update README files in each mode directory to reflect new content
   - Tool call sequence:
   ```typescript
   // Read existing README
   read_file("1000xbrain/parameters/rules/[mode-directory]/README.md", should_read_entire_file=true)
   
   // Update README with new content
   edit_file("1000xbrain/parameters/rules/[mode-directory]/README.md",
           "Update README to include migrated helper rules",
           "// ... existing content ...\n\n## Migrated Helper Rules\n\n### [Pathway Name] Pathway\n- [file1].md: [brief description]\n- [file2].md: [brief description]\n\n// ... existing content ...")
   ```
   - Expected outcome: Updated README files that document the migrated helpers

2. **Command Reference Updates**
   - Identify and update any documentation that references the migrated helper rules
   - Search for references in other documentation files
   - Tool call sequence:
   ```typescript
   // Search for references to update
   grep_search("helpers/[subdirectory]", false, "1000xbrain/**/*.md")
   ```
   - For each reference found, update to new path
   - Expected outcome: All documentation references updated to new paths

3. **Migration Report Creation**
   - Create a comprehensive migration report documenting:
     - All files migrated
     - Mode and pathway assignments
     - Content updates applied
     - Verification results
   - Store in the planning folder for future reference
   - Expected outcome: Detailed migration report for project records

4. **Final System-Wide Verification**
   - Run comprehensive verification testing as documented in `test-cheatsheet.md`
   - Tool call sequence:
   ```typescript
   // Check for any remaining references to helpers directory
   grep_search("helpers/", false, "1000xbrain/parameters/rules/**/*.md")
   
   // Verify all files have standardized headers
   grep_search("^# Workflow: .*\| Pathway:", false, "1000xbrain/parameters/rules/**/*.md")
   ```
   - Expected outcome: Successful system-wide verification of the migration

## Migration Mapping Structure

The migration mapping will follow this structure:

### Analysis Helpers to Plan Mode

| Source | Target | Workflow | Pathway | Required Updates |
|--------|--------|----------|---------|-----------------|
| `helpers/analysis/requirements-analysis.md` | `plan-mode/analysis-requirements.md` | rules-workflow | analysis | Add header, update mode indicator, update paths |
| `helpers/analysis/codebase-analysis.md` | `plan-mode/analysis-codebase.md` | rules-workflow | analysis | Add header, update mode indicator, update paths |

### Implementation Helpers to Dev Mode and Direct Mode

| Source | Target | Workflow | Pathway | Required Updates |
|--------|--------|----------|---------|-----------------|
| `helpers/implementation/context-first-implementation.md` | `dev-mode/context-first-implementation.md` | rules-workflow | implementation | Add header, update mode indicator, update paths |
| `helpers/implementation/direct-implementation.md` | `direct-mode/direct-implementation.md` | rules-workflow | implementation | Add header, update mode indicator, update paths |

### Recovery Helpers to Dev Mode and Direct Mode

| Source | Target | Workflow | Pathway | Required Updates |
|--------|--------|----------|---------|-----------------|
| `helpers/recovery/direct-implementation-continuation.md` | `direct-mode/direct-implementation-continuation.md` | rules-workflow | recovery | Add header, update mode indicator, update paths |
| `helpers/recovery/error-recovery.md` | `dev-mode/recovery-error.md` | rules-workflow | recovery | Add header, update mode indicator, update paths |

### Validation and Verification Helpers

| Source | Target | Workflow | Pathway | Required Updates |
|--------|--------|----------|---------|-----------------|
| `helpers/validation/implementation-validation.md` | `dev-mode/validation-implementation.md` | rules-workflow | validation | Add header, update mode indicator, update paths |
| `helpers/verification/planning-verification.md` | `plan-mode/verification-planning.md` | rules-workflow | verification | Add header, update mode indicator, update paths |

### Finalization Helpers

| Source | Target | Workflow | Pathway | Required Updates |
|--------|--------|----------|---------|-----------------|
| `helpers/finalization/enhance-planning.md` | `plan-mode/finalization-enhance-planning.md` | rules-workflow | finalization | Add header, update mode indicator, update paths |
| `helpers/finalization/implementation-finalization.md` | `dev-mode/finalization-implementation.md` | rules-workflow | finalization | Add header, update mode indicator, update paths |

### Parameter Management Helpers

| Source | Target | Workflow | Pathway | Required Updates |
|--------|--------|----------|---------|-----------------|
| `helpers/parameter-management/parameter-validation.md` | `plan-mode/parameter-validation.md` | rules-workflow | parameter-management | Add header, update mode indicator, update paths |

## Standardized Header Templates

Use these exact header templates for each pathway:

### For Plan Mode Files

```markdown
# Workflow: rules-workflow | Pathway: analysis
```

```markdown
# Workflow: rules-workflow | Pathway: verification
```

```markdown
# Workflow: rules-workflow | Pathway: parameter-management
```

```markdown
# Workflow: rules-workflow | Pathway: finalization
```

### For Dev Mode Files

```markdown
# Workflow: rules-workflow | Pathway: implementation
```

```markdown
# Workflow: rules-workflow | Pathway: recovery
```

```markdown
# Workflow: rules-workflow | Pathway: validation
```

```markdown
# Workflow: rules-workflow | Pathway: finalization
```

### For Direct Mode Files

```markdown
# Workflow: rules-workflow | Pathway: implementation
```

```markdown
# Workflow: rules-workflow | Pathway: recovery
```

## Example File Migration

### Source File Example: helpers/finalization/enhance-planning.md

Current content (abbreviated):
```markdown
# Enhance Planning: Rules Workflow

## File Purpose

This file provides an iterative planning enhancement pattern for rules workflow implementation...
```

### Target File Example: plan-mode/finalization-enhance-planning.md

Updated content with standardized header:
```markdown
# Workflow: rules-workflow | Pathway: finalization

# Enhance Planning: Rules Workflow

## File Purpose

This file provides an iterative planning enhancement pattern for rules workflow implementation...

[Content with updated path references]
```

## Migration Sequencing

The migration will be executed in batches:

### Batch 1: Standalone Files (No Dependencies)
- Files with minimal or no cross-references to other helper files
- Simpler files to validate migration approach
- Example: `helpers/finalization/enhance-planning.md` → `plan-mode/finalization-enhance-planning.md`

### Batch 2: Core Implementation Files
- Implementation helpers that other files may depend on
- Focus on files central to the mode system
- Example: `helpers/implementation/context-first-implementation.md` → `dev-mode/context-first-implementation.md`

### Batch 3: Recovery and Continuation Files
- Recovery mechanisms and continuation patterns
- Files that often reference implementation files
- Example: `helpers/recovery/direct-implementation-continuation.md` → `direct-mode/direct-implementation-continuation.md`

### Batch 4: Remaining Helper Files
- Analysis, validation, verification helpers
- Parameter management helpers
- Any remaining files not covered in previous batches

## Detailed Verification Process

For each migrated file, perform these verification steps:

1. **Header Format Verification**:
   - First line MUST be `# Workflow: rules-workflow | Pathway: [pathway-name]`
   - Workflow type and pathway name MUST be in lowercase kebab-case format
   - No spaces before or after the pipe symbol (|)

2. **Mode Indicator Verification**:
   - Plan mode files MUST contain 📋 1000xdev [workflow-type]
   - Dev mode files MUST contain 💻 1000xdev [workflow-type]
   - Direct mode files MUST contain ⚡ 1000xdev [workflow-type]

3. **Path Reference Verification**:
   - NO references to the original helpers directory structure
   - All references updated to new mode-specific paths
   - All message-command examples updated with new paths

4. **Content Alignment Verification**:
   - Content MUST align with the assigned mode's responsibilities
   - Tool call patterns MUST match the mode's expected patterns
   - Examples MUST demonstrate mode-specific usage

5. **File Naming Convention Verification**:
   - Plan mode files: `analysis-*.md`, `verification-*.md`, `parameter-*.md`, `finalization-*.md`
   - Dev mode files: `context-first-implementation.md`, `recovery-*.md`, `validation-*.md`, `finalization-*.md`
   - Direct mode files: `direct-implementation.md`, `direct-implementation-continuation.md`

## Success Criteria

The migration will be considered successful when:

1. All helper rules are moved to their appropriate mode directories
2. All files have standardized headers meeting EXACT format requirements:
   - Header is the very first line of the file
   - Format is precisely: `# Workflow: rules-workflow | Pathway: [pathway-name]`
   - Both workflow-type and pathway-name are in lowercase kebab-case format
   - Every project-rule-parameter has this header without exception
3. All content is updated to reflect mode-specific contexts:
   - Mode indicators match the target mode
   - Content aligns with mode responsibilities
   - Tool call patterns follow mode-specific usage
4. All path references are updated to reflect the new structure:
   - No references to helpers directory remain
   - All message-command examples use the new paths
   - All cross-references use the new paths
5. All README files are updated to reflect the new organization
6. Verification testing passes for all checks in the test cheatsheet

## Implementation Timeline

1. **Phase 1: Analysis and Inventory** - 1 day
   - Complete inventory creation
   - Content analysis for mode assignment
   - Pathway identification
   - Dependency analysis

2. **Phase 2: Preparation and Planning** - 1 day
   - Detailed migration mapping creation
   - Standardized header template creation
   - Migration batch planning
   - Verification checklist development

3. **Phase 3: Migration Execution** - 2-3 days
   - Batch 1 migration and verification
   - Batch 2 migration and verification
   - Batch 3 migration and verification
   - Batch 4 migration and verification

4. **Phase 4: Documentation and System Updates** - 1 day
   - README file updates
   - Command reference updates
   - Migration report creation
   - Final system-wide verification 