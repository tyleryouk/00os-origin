# Process: Updating References to Deprecated 1000xplans Files

## Overview

This process defines the systematic approach for identifying and updating references to deprecated 1000xplans files across all cycle processes, commands, and knowledge files. The goal is to ensure all references are migrated to operational_feedback or other appropriate locations.

## Steps

### 1. Reference Identification (Initial Scan)

1. **Scan process files for references**:
   ```
   grep_search("1000xplans/system/implementation-progress", include_pattern="*.md", exclude_pattern="*operational_feedback*")
   grep_search("1000xplans/system/requirements", include_pattern="*.md", exclude_pattern="*operational_feedback*")
   grep_search("1000xplans/plan", include_pattern="*.md", exclude_pattern="*operational_feedback*")
   ```

2. **Document findings in central registry**:
   - Create/update `1000xbrain/system/cycle-manager/operational_feedback/file_reference_registry.md`
   - For each reference found:
     ```markdown
     - **File**: [path/to/file.md]
       - **Line**: [line number]
       - **Context**: [context of reference]
       - **Recommended Update**: [suggested replacement]
       - **Status**: Pending
     ```

### 2. Prioritization

1. **Categorize references by importance**:
   - **Critical**: Core process files (initiation, planning, etc.)
   - **High**: Command files
   - **Medium**: Knowledge files
   - **Low**: Documentation files

2. **Prioritize by cycle frequency**:
   - Higher priority for files used in more active cycles
   - Document priorities in the registry

### 3. Update Process (Per File)

1. **Read the full file**:
   ```
   read_file("path/to/file.md", should_read_entire_file=true)
   ```

2. **Analyze current usage pattern**:
   - Determine how the deprecated file is being used
   - Identify the appropriate replacement (typically in operational_feedback)
   - Consider context and overall file purpose

3. **Make targeted edits**:
   ```
   edit_file("path/to/file.md", "Update deprecated 1000xplans reference", 
     "// ... existing code ...
      // Update reference from deprecated 1000xplans file to operational_feedback
      // OLD: path/to/1000xplans/deprecated-file.md
      // NEW: path/to/operational_feedback/replacement-file.md
      // ... existing code ...")
   ```

4. **Verify the update**:
   ```
   read_file("path/to/file.md", offset=[relevant section], limit=[appropriate size])
   ```

5. **Update registry status**:
   - Mark reference as "Updated" in the registry
   - Add notes about the specific changes made

### 4. Incremental Implementation

1. **Implement updates in batches**:
   - Start with critical files
   - Limit to 3-5 files per cycle to manage risk
   - Document progress in file_migration_progress.md

2. **Validate after each batch**:
   - Run relevant commands to verify functionality
   - Document any issues encountered

### 5. Progress Tracking

1. **Update progress in each cycle**:
   ```
   edit_file("1000xbrain/system/cycle-manager/operational_feedback/file_migration_progress.md", 
     "Update migration progress", "// ... existing content ...
     ## Progress Update [DATE]
     
     ### Files Updated
     - [file1.md]: Replaced references to implementation-progress.md with operational_feedback/implementation_log.md
     - [file2.md]: Replaced references to requirements.md with operational_feedback/change_request.md
     
     ### Current Completion
     - Critical files: [X]% complete
     - High priority: [Y]% complete
     - Overall: [Z]% complete
     
     ### Next Batch
     - [file3.md]
     - [file4.md]
     - [file5.md]")
   ```

### 6. Verification

1. **After completing all updates in a priority level**:
   - Run a verification scan to ensure no references were missed
   ```
   grep_search("1000xplans/system/implementation-progress", include_pattern="*.md", exclude_pattern="*operational_feedback*")
   ```

2. **Document verification results**:
   - Update file_migration_progress.md with verification results
   - Address any missed references

## Common Reference Replacements

| Deprecated File | Recommended Replacement |
|-----------------|-------------------------|
| 1000xplans/system/implementation-progress.md | 1000xbrain/[domain]/[cycle]/operational_feedback/implementation_log.md |
| 1000xplans/system/requirements.md | 1000xbrain/[domain]/[cycle]/operational_feedback/change_request.md |
| 1000xplans/plan.md | 1000xbrain/[domain]/[cycle]/operational_feedback/implementation_plan.md |

## Risk Management

1. **Backup before editing**:
   - Consider creating temporary copies of critical files before making changes
   - Document the backup location in the registry

2. **Incremental testing**:
   - Test each batch of updates before proceeding to the next
   - Have rollback procedures ready if issues occur

3. **Maintain compatibility during transition**:
   - In some cases, maintain both old and new references with clear deprecation notices
   - Example: 
     ```
     // DEPRECATED: Reading from 1000xplans/system/requirements.md (will be removed in future)
     // PREFERRED: Using operational_feedback/change_request.md for requirements
     ```

## Timeline and Success Criteria

1. **Timeline**:
   - Critical files: Complete within next cycle
   - High priority: Complete within next 2 cycles
   - Medium priority: Complete within next 3 cycles
   - Low priority: Complete within next 4 cycles

2. **Success Criteria**:
   - Zero references to deprecated files remaining in active process files
   - All references properly redirected to appropriate operational_feedback locations
   - No functional regressions in any cycle
   - Complete documentation of all changes made 