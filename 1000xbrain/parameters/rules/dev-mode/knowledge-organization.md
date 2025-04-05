# mode: dev-mode | workflow: rules-workflow | pathway: knowledge-organization | filepath: @parameters/rules/dev-mode/knowledge-organization.mdc | optional-standard-parameter(s): none

## 1. Purpose

This parameter guides the implementation of knowledge organization within the 1000xbrain cognitive architecture, focusing on pathway-based organization, file structure standardization, and improved knowledge accessibility.

## Knowledge Access

```typescript
// Access essential knowledge components immediately
fetch_rules(["knowledge/rules/pathways/documentation/parameter-template"], 
           "Understanding standardized parameter template for consistent structure")
fetch_rules(["knowledge/rules/pathways/documentation/pathway-organization"], 
           "Understanding pathway organization principles")
fetch_rules(["knowledge/rules/pathways/architecture/knowledge-organization"], 
           "Understanding knowledge system architecture")
```

## 2. Core Command Operation

When the `dev-mode rules-workflow knowledge-organization @parameters/rules/dev-mode/knowledge-organization.mdc none` message-command is received, 1000xdev will:

1. **Initialize Developer Mode**: Enter or remain in Developer Mode with the 💻 1000xdev [rules-workflow] indicator
2. **Access Essential Knowledge**: Fetch parameter template, pathway organization, and knowledge architecture knowledge
3. **Execute Knowledge Organization**: Implement pathway-based knowledge organization
4. **Verify Organization**: Ensure consistent structure and improved accessibility

## 3. Implementation Structure

### Phase 1: Pathway Structure Creation
- Create main pathway directories in knowledge/rules/pathways
- Create pathway-specific index.md files with comprehensive documentation
- Ensure standardized pathway structure
- Define clear pathway boundaries

### Phase 2: Knowledge Component Migration
- Identify knowledge components to migrate
- Determine appropriate pathway for each component
- Move knowledge components to the correct pathway
- Update component content to match pathway standards
- Create or update pathway index files to reflect new components

### Phase 3: Parameter Enhancement
- Update parameters to use standardized format
- Add immediate knowledge fetching to parameters
- Ensure all parameters follow consistent structure
- Verify parameters use the correct filepath references

### Phase 4: README to index.md Conversion
- Identify README.md files to convert (except root)
- Create corresponding index.md files
- Migrate content with appropriate updates
- Verify navigation and references

## 4. Tool Call Sequences

```typescript
// Phase 1: Pathway Structure Creation
// 1. Check existing structure
list_dir("1000xbrain/knowledge/rules")

// 2. Create pathway directory if it doesn't exist
run_terminal_cmd("New-Item -Path \"1000xbrain/knowledge/rules/pathways/[pathway-name]\" -ItemType Directory -Force", false)

// 3. Create pathway index.md
edit_file("1000xbrain/knowledge/rules/pathways/[pathway-name]/index.md",
          "Create pathway index file",
          "# [Pathway Name] Pathway\n\n## Overview\n\n[Overview content]\n\n## Purpose\n\n[Purpose content]\n\n## Knowledge Components\n\n[Component listings]\n\n## Accessing This Pathway\n\n```typescript\nfetch_rules([\"knowledge/rules/pathways/[pathway-name]/component-name\"], \n           \"Purpose\")\n```\n\n## Related Pathways\n\n[Related pathway listings]")

// Phase 2: Knowledge Component Migration
// 1. Identify component to migrate
list_dir("1000xbrain/knowledge/rules/[original-directory]")

// 2. Read component content
read_file("1000xbrain/knowledge/rules/[original-directory]/[component].md", should_read_entire_file=true)

// 3. Create component in new pathway
edit_file("1000xbrain/knowledge/rules/pathways/[pathway-name]/[component].md",
          "Migrate knowledge component to pathway",
          "[Component content with updates]")

// 4. Update pathway index
read_file("1000xbrain/knowledge/rules/pathways/[pathway-name]/index.md", should_read_entire_file=true)
edit_file("1000xbrain/knowledge/rules/pathways/[pathway-name]/index.md",
          "Update pathway index with new component",
          "[Updated index content]")

// Phase 3: Parameter Enhancement
// 1. Read existing parameter
read_file("1000xbrain/parameters/rules/[mode]/[parameter].md", should_read_entire_file=true)

// 2. Update parameter with standardized format
edit_file("1000xbrain/parameters/rules/[mode]/[parameter].md",
          "Update parameter to standardized format",
          "# mode: [mode] | workflow: [workflow-type] | pathway: [pathway-name] | filepath: @parameters/rules/[mode]/[parameter].mdc | optional-standard-parameter(s): [params]\n\n## 1. Purpose\n\n[Purpose content]\n\n## Knowledge Access\n\n```typescript\nfetch_rules([\"knowledge/rules/pathways/[pathway-name]/[component]\"], \n           \"[Purpose]\")\n```\n\n[Remaining parameter content]")

// Phase 4: README to index.md Conversion
// 1. Identify README.md file
list_dir("1000xbrain/knowledge/rules/[directory]")

// 2. Read README.md content
read_file("1000xbrain/knowledge/rules/[directory]/README.md", should_read_entire_file=true)

// 3. Create index.md with updated content
edit_file("1000xbrain/knowledge/rules/[directory]/index.md",
          "Convert README.md to index.md",
          "[Updated content]")
```

## 5. Completion Criteria

The implementation is complete when:
1. All knowledge/rules directories have a pathway-based organization
2. All knowledge components are appropriately categorized in pathways
3. All pathway directories have comprehensive index.md files
4. All parameters follow the standardized format with immediate knowledge fetching
5. All README.md files (except root) have been converted to index.md
6. All references and navigation are updated to maintain consistency

## 6. Error Handling

If errors are encountered during implementation:
1. **Path Not Found**: Check parent directories, create missing directories, verify creation
2. **File Not Found**: Verify file paths, check for alternate locations, create file if needed
3. **Content Issues**: Validate content structure, ensure consistent formatting, fix formatting issues
4. **Reference Errors**: Update references to reflect new pathways, verify reference resolution
5. **Documentation Verification**: Test knowledge access, ensure fetch_rules can access all components 