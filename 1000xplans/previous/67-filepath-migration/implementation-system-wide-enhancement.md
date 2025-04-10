# Implementation Plan: System-Wide Filepath Migration

## Enhancement Scope

This implementation plan outlines the approach for systematically updating all filepaths throughout the 1000xbrain architecture to align with the new directory structure. The scope includes:

1. Updating all cross-references between brain-files
2. Standardizing path formats across the entire architecture
3. Ensuring all project-rule-parameter references use the correct format
4. Converting direct knowledge file references to fetch_rules tool calls
5. Updating file structure diagrams and visual representations

## Implementation Strategy

The implementation will follow a methodical, directory-based approach to ensure all relevant files are updated with consistent filepath references. The strategy focuses on:

1. **Top-Down Implementation**: Starting with core system files and README documents, then proceeding to more specialized files
2. **Pattern-Based Updates**: Using consistent transformation patterns for each type of file reference
3. **Incremental Verification**: Verifying each batch of updates before proceeding to the next
4. **Dependency-Aware Sequencing**: Updating files in an order that respects cross-component dependencies

## Implementation Phases

### Phase 1: Core System Documentation Updates

The first phase focuses on updating the foundational files that define the cognitive architecture's structure:

1. **Root Directory Documentation**
   - Update `1000xbrain/README.md` with new directory structure
   - Update all file path references to use new locations
   - Update directory structure diagrams

2. **Core Directory Updates**
   - Update `core/README.md` with new file structure descriptions
   - Update all path references in core identity and mode files
   - Fix cross-references between core files

3. **Primary Directory READMEs**
   - Update `workflows/README.md` with correct file paths
   - Update `parameters/README.md` with correct file paths
   - Update `knowledge/README.md` with correct file paths

### Phase 2: Cross-System References

The second phase focuses on updating cross-references between different subsystems:

1. **Core → Workflow References**
   - Update references from core files to workflow files
   - Fix import and include path references
   - Update documentation links

2. **Workflow → Parameter References**
   - Update message-command examples with correct parameter paths
   - Fix project-rule-parameter references
   - Update documentation about parameter usage

3. **Knowledge Access Updates**
   - Convert direct knowledge references to fetch_rules tool calls
   - Update fetch_rules paths to use new knowledge structure
   - Standardize knowledge reference format

### Phase 3: Detailed Subsystem Updates

The third phase focuses on updating each specific subsystem:

1. **Core Subsystem Updates**
   - Update mode system files with correct paths
   - Update identity files with correct paths
   - Fix communication files with correct path references

2. **Workflow Subsystem Updates**
   - Update each workflow's entry point file
   - Fix specialized workflow files
   - Update workflow cross-references

3. **Parameter Subsystem Updates**
   - Update parameter files for each domain
   - Fix specialized parameter references
   - Update parameter cross-references

4. **Knowledge Subsystem Updates**
   - Update knowledge structure references
   - Fix guide and pattern references
   - Update knowledge organization documentation

### Phase 4: Examples and Tutorials

The fourth phase focuses on updating example code and tutorial content:

1. **Code Example Updates**
   - Update file paths in code examples
   - Fix path references in implementation guidance
   - Update paths in tool call examples

2. **Tool Call Examples**
   - Update fetch_rules tool call examples
   - Fix paths in file creation and modification examples
   - Update documentation tool examples

3. **Message-Command Examples**
   - Update project-rule-parameter paths in all message-command examples
   - Fix mode transition examples
   - Update workflows with correct parameter references

### Phase 5: Comprehensive Verification

The final phase focuses on verification and testing:

1. **Path Existence Verification**
   - Verify all referenced files exist at specified paths
   - Check for broken links or references
   - Fix any remaining path issues

2. **Cross-Reference Integrity**
   - Verify cross-references between components
   - Check bidirectional references
   - Ensure complete path consistency

3. **Final Documentation Updates**
   - Update implementation progress documentation
   - Create path migration reference guide
   - Document any special cases or exceptions

## Standardized Implementation Patterns

To ensure consistency, the following standard patterns will be applied throughout the implementation:

### Core Path Update Pattern

```markdown
# Before
For core capabilities, see [global-rules.md](meta/identity/global-rules.md).

# After
For core capabilities, see [global-rules.md](core/identity/global-rules.md).
```

### Workflow Path Update Pattern

```markdown
# Before
Refer to [rules-workflow.md](domains/rules/rules-workflow.md) for workflow guidance.

# After
Refer to [rules-workflow.md](workflows/rules-workflow/rules-workflow.md) for workflow guidance.
```

### Parameter Path Update Pattern

```markdown
# Before
plan-mode: rules-workflow @knowledge/rules/plan-mode-system-wide.mdc

# After
plan-mode: rules-workflow @parameters/rules/plan-mode-system-wide.mdc
```

### Knowledge Path Update Pattern

```markdown
# Before
For implementation patterns, see [implementation-patterns.md](domains/knowledge/patterns/implementation-patterns.md).

# After
For implementation patterns, see:
```typescript
fetch_rules(["knowledge/patterns/impl/implementation-patterns"], 
           "Accessing implementation patterns")
```
```

### Directory Structure Update Pattern

```markdown
# Before
```
/1000xbrain
├── meta/
├── domains/
└── knowledge/
```

# After
```
/1000xbrain
├── core/
├── workflows/
├── parameters/
└── knowledge/
```
```

## File Update Approach

Each file will be updated using the following approach:

1. **Scan for Path References**: Identify all file path references in the file
2. **Classify Reference Types**: Identify whether each reference is a direct link, project-rule-parameter, fetch_rules call, etc.
3. **Apply Transformation Rules**: Apply the appropriate transformation pattern to each reference
4. **Update Directory Diagrams**: Update any visual representations of directory structure
5. **Fix Cross-References**: Ensure any cross-references point to the correct locations
6. **Verify Updates**: Check that all updates maintain correct path relationships

## Update Sequencing Logic

The updates will be sequenced based on the following logic:

1. **Foundational First**: Update core architectural documentation before specialized files
2. **Top-Down Approach**: Start with root directories and work down to specific files
3. **Dependency Order**: Update files before their dependents
4. **Batch Processing**: Group similar files for batch updates with consistent patterns
5. **Incremental Verification**: Verify each batch before proceeding to the next

## README.md Structure Updates

All directory README.md files will be updated to include:

1. **Updated Structure Description**: Clear description of the new directory structure
2. **Correct Rule Type Mapping**: Accurate mapping between directories and rule types
3. **Proper Access Method Documentation**: Updated documentation on how to access different rule types
4. **Corrected Directory Diagrams**: Updated visual representations of directory structure

### Root README.md Update Pattern

```markdown
## Directory Structure

The 1000xbrain cognitive architecture is organized into four main directories, each corresponding to a specific rule type:

| Directory | Rule Type | Access Method | Purpose |
|-----------|-----------|---------------|---------|
| `/core` | Always | Automatic | Core identity and capabilities |
| `/workflows` | Auto-Attached | File matching | Domain-specific procedural knowledge |
| `/parameters` | Manual | Explicit reference | Task-specific specialized guidance |
| `/knowledge` | Agent Requested | fetch_rules tool | Specialized domain knowledge |
```

## Implementation Sequence Details

### Phase 1: Core Documentation Updates

#### Step 1.1: Root README.md Update
1. Update directory structure diagrams
2. Fix rule type mapping table
3. Update all file path references
4. Correct access method documentation

#### Step 1.2: Core Directory README.md Update
1. Update core directory purpose description
2. Fix subsystem structure documentation
3. Update all cross-references to other subsystems
4. Correct access method documentation

#### Step 1.3: Primary Directory README.md Updates
1. Update workflows README.md
2. Create or update parameters README.md
3. Update knowledge README.md
4. Ensure consistent directory descriptions

### Phase 2: Cross-System References

#### Step 2.1: Core → Workflow References
1. Update references in core/modes files
2. Fix references in core/identity files
3. Update references in core/communication files

#### Step 2.2: Workflow → Parameter References
1. Update message-command examples in workflow files
2. Fix project-rule-parameter references 
3. Update documentation about parameter usage

#### Step 2.3: Knowledge Access Updates
1. Identify direct knowledge references
2. Convert to fetch_rules tool calls
3. Update fetch_rules paths to use new structure

### Phase 3: Detailed Subsystem Updates

#### Step 3.1: Core Subsystem Files
1. Update core/modes/mode-system.md
2. Update core/modes/plan-mode.md
3. Update core/modes/dev-mode.md
4. Update core/identity/global-rules.md
5. Update core/communication/message-commands.md

#### Step 3.2: Workflow Subsystem Files
1. Update workflows/rules-workflow/rules-workflow.md
2. Update workflows/front-end-workflow/front-end-workflow.md
3. Update workflows/back-end-workflow/back-end-workflow.md
4. Update workflows/documentation-workflow/documentation-workflow.md
5. Update workflows/scripts-workflow/scripts-workflow.md

#### Step 3.3: Parameter Subsystem Files
1. Update parameters/rules files
2. Update parameters/front-end files
3. Update parameters/back-end files
4. Update parameters/documentation files
5. Update parameters/scripts files

#### Step 3.4: Knowledge Subsystem Files
1. Update knowledge/guides files
2. Update knowledge/patterns files
3. Update knowledge/reference files
4. Update knowledge/index files

### Phase 4: Examples and Tutorials

#### Step 4.1: Code Example Updates
1. Update file paths in implementation examples
2. Fix paths in tool usage examples
3. Update paths in system architecture examples

#### Step 4.2: Tool Call Examples
1. Update fetch_rules tool call examples
2. Fix edit_file tool call examples
3. Update other tool call examples

#### Step 4.3: Message-Command Examples
1. Update project-rule-parameter paths in message-command examples
2. Fix mode transition examples
3. Update workflow-specific command examples

### Phase 5: Comprehensive Verification

#### Step 5.1: Path Existence Verification
1. Create script to verify all referenced files exist
2. Run verification against all updated files
3. Fix any identified issues

#### Step 5.2: Cross-Reference Integrity
1. Verify all cross-references are bidirectionally correct
2. Check for orphaned references
3. Ensure consistent path formatting

#### Step 5.3: Final Documentation
1. Update implementation progress document
2. Create path migration reference guide
3. Document special cases and exceptions

## Priority Matrix

| Component | Update Priority | Verification Priority | Dependencies |
|-----------|----------------|----------------------|--------------|
| Root README.md | ★★★★★ | ★★★★★ | None |
| Core READMEs | ★★★★★ | ★★★★★ | Root README |
| Directory READMEs | ★★★★☆ | ★★★★☆ | Root README |
| Core Mode Files | ★★★★☆ | ★★★★☆ | Core READMEs |
| Core Identity Files | ★★★★☆ | ★★★★☆ | Core READMEs |
| Workflow Files | ★★★☆☆ | ★★★★☆ | Directory READMEs |
| Parameter Files | ★★★☆☆ | ★★★★☆ | Directory READMEs |
| Knowledge Files | ★★★☆☆ | ★★★★☆ | Directory READMEs |
| Tool Call Examples | ★★☆☆☆ | ★★★☆☆ | All subsystem files |
| Message-Command Examples | ★★☆☆☆ | ★★★☆☆ | All subsystem files |
| Code Examples | ★★☆☆☆ | ★★★☆☆ | All subsystem files |

## Coordination Requirements

To ensure consistency across all updates, the implementation must adhere to the following coordination requirements:

1. **Terminology Consistency**: Use consistent terminology for directory purposes
2. **Path Format Consistency**: Maintain consistent path formats for each reference type
3. **Rule Type Alignment**: Ensure rule types correctly align with directories
4. **Access Method Clarity**: Clearly document the access method for each rule type
5. **Visual Consistency**: Maintain consistent structure diagrams

## Verification Strategy

The verification strategy includes:

1. **Progressive Verification**: Verify each batch of updates before proceeding
2. **Path Existence Checking**: Verify all referenced files exist
3. **Cross-Reference Validation**: Ensure bidirectional references are maintained
4. **Access Method Verification**: Verify access methods match rule types
5. **Formatting Consistency**: Check for consistent path formatting

## Implementation Metrics and Tracking

Progress will be tracked using the following metrics:

1. **Files Updated**: Count of files that have been successfully updated
2. **References Fixed**: Count of file path references that have been updated
3. **Verification Passed**: Count of files that have passed verification
4. **Phases Completed**: Number of implementation phases completed
5. **Special Cases Resolved**: Count of special cases or exceptions resolved

## Implementation Progress Tracking

Implementation progress will be documented in `planning/67-filepath-migration/implementation-progress.md` with the following structure:

```markdown
# Implementation Progress: Filepath Migration

## Current Status
- Phase: [current phase]
- Step: [current step]
- Last Update: [timestamp]

## Progress Summary
- Files Updated: [count] / [total]
- References Fixed: [count]
- Verification Passed: [count] / [total]

## Phase Status
- Phase 1: [status] - Core Documentation Updates
- Phase 2: [status] - Cross-System References
- Phase 3: [status] - Detailed Subsystem Updates
- Phase 4: [status] - Examples and Tutorials
- Phase 5: [status] - Comprehensive Verification

## Detailed Progress
[Detailed progress by step]

## Issues and Resolutions
[Any special cases or issues encountered]
```

## Rollback Strategy

In case of issues, the following rollback strategy will be used:

1. **Incremental Updates**: Update files in small batches to limit potential issues
2. **Progress Documentation**: Document each update step for potential rollback
3. **Verification Gates**: Do not proceed to next phase until current phase is verified
4. **Issue Tracking**: Document any special cases or issues for targeted resolution

By following this structured implementation plan, we will systematically update all filepaths throughout the 1000xbrain architecture to align with the new directory structure, ensuring consistency and maintaining proper cross-references between all components. 