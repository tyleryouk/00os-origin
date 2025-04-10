# Helper Rules Inventory and Migration Mapping

## Complete Inventory

Based on our analysis of the 1000xbrain/parameters/rules/helpers/ directory, we've identified the following helper rules:

### Analysis Helpers
- Location: `1000xbrain/parameters/rules/helpers/analysis/`
- Purpose: Tools for analyzing codebase and requirements
- Pathway: analysis
- Files:
  - `requirements-analysis.md`: Analyzes and enhances requirements documentation
  - `codebase-analysis.md`: Analyzes existing code patterns and structures
  - `context-analysis.md`: Analyzes contextual information for planning
  - `architecture-analysis.md`: Analyzes system architecture for implementation planning

### Implementation Helpers
- Location: `1000xbrain/parameters/rules/helpers/implementation/`
- Purpose: Tools for implementing specific patterns
- Pathway: implementation
- Files:
  - `context-first-implementation.md`: Focus on gathering context before implementation
  - `direct-implementation.md`: Focus on immediate implementation
  - `pattern-based-implementation.md`: Implementation following established patterns
  - `tool-optimized-implementation.md`: Implementation optimized for efficient tool usage
  - `system-wide-implementation.md`: Implementation affecting multiple system components

### Recovery Helpers
- Location: `1000xbrain/parameters/rules/helpers/recovery/`
- Purpose: Tools for recovering from errors or issues
- Pathway: recovery
- Files:
  - `direct-implementation-continuation.md`: Focus on continuing interrupted direct implementations
  - `error-recovery.md`: Recovery from implementation errors
  - `state-recovery.md`: Recovery from interrupted implementation state
  - `context-recovery.md`: Recovery of context after interruption

### Validation Helpers
- Location: `1000xbrain/parameters/rules/helpers/validation/`
- Purpose: Tools for validating implementations
- Pathway: validation
- Files:
  - `implementation-validation.md`: Validates implementation quality and completeness
  - `performance-validation.md`: Validates performance characteristics
  - `security-validation.md`: Validates security aspects of implementation
  - `type-validation.md`: Validates type safety and correctness

### Verification Helpers
- Location: `1000xbrain/parameters/rules/helpers/verification/`
- Purpose: Tools for verifying implementations
- Pathway: verification
- Files:
  - `planning-verification.md`: Verifies planning documentation completeness
  - `requirements-verification.md`: Verifies requirements quality and coverage
  - `implementation-approach-verification.md`: Verifies implementation approach
  - `test-scenario-verification.md`: Verifies test scenario completeness

### Finalization Helpers
- Location: `1000xbrain/parameters/rules/helpers/finalization/`
- Purpose: Tools for finalizing implementations
- Pathway: finalization
- Files:
  - `enhance-planning.md`: Enhances planning documentation to finalize it
  - `implementation-finalization.md`: Finalizes implementation details
  - `documentation-finalization.md`: Finalizes documentation updates
  - `system-integration-finalization.md`: Finalizes system integration

### Parameter Management Helpers
- Location: `1000xbrain/parameters/rules/helpers/parameter-management/`
- Purpose: Tools for managing parameters
- Pathway: parameter-management
- Files:
  - `parameter-validation.md`: Validates parameter formats and usage
  - `parameter-organization.md`: Organizes parameters for clarity
  - `parameter-documentation.md`: Documents parameter usage patterns

## Comprehensive Migration Mapping

Based on our context analysis and mode-specific patterns, here is the complete mapping of helper rules to their target directories with pathway assignments:

### Helpers to Plan Mode

| Source | Target | Workflow | Pathway | Required Updates | Migration Priority |
|--------|--------|----------|---------|-----------------|-------------------|
| `helpers/analysis/requirements-analysis.md` | `plan-mode/analysis-requirements.md` | rules-workflow | analysis | Add header, update mode indicator, update paths | High |
| `helpers/analysis/codebase-analysis.md` | `plan-mode/analysis-codebase.md` | rules-workflow | analysis | Add header, update mode indicator, update paths | High |
| `helpers/analysis/context-analysis.md` | `plan-mode/analysis-context.md` | rules-workflow | analysis | Add header, update mode indicator, update paths | High |
| `helpers/analysis/architecture-analysis.md` | `plan-mode/analysis-architecture.md` | rules-workflow | analysis | Add header, update mode indicator, update paths | Medium |
| `helpers/verification/planning-verification.md` | `plan-mode/verification-planning.md` | rules-workflow | verification | Add header, update mode indicator, update paths | High |
| `helpers/verification/requirements-verification.md` | `plan-mode/verification-requirements.md` | rules-workflow | verification | Add header, update mode indicator, update paths | Medium |
| `helpers/verification/implementation-approach-verification.md` | `plan-mode/verification-implementation-approach.md` | rules-workflow | verification | Add header, update mode indicator, update paths | Medium |
| `helpers/verification/test-scenario-verification.md` | `plan-mode/verification-test-scenario.md` | rules-workflow | verification | Add header, update mode indicator, update paths | Medium |
| `helpers/parameter-management/parameter-validation.md` | `plan-mode/parameter-validation.md` | rules-workflow | parameter-management | Add header, update mode indicator, update paths | Medium |
| `helpers/parameter-management/parameter-organization.md` | `plan-mode/parameter-organization.md` | rules-workflow | parameter-management | Add header, update mode indicator, update paths | Medium |
| `helpers/parameter-management/parameter-documentation.md` | `plan-mode/parameter-documentation.md` | rules-workflow | parameter-management | Add header, update mode indicator, update paths | Low |
| `helpers/finalization/enhance-planning.md` | `plan-mode/finalization-enhance-planning.md` | rules-workflow | finalization | Add header, update mode indicator, update paths | High |
| `helpers/finalization/documentation-finalization.md` | `plan-mode/finalization-documentation.md` | rules-workflow | finalization | Add header, update mode indicator, update paths | Medium |

### Helpers to Dev Mode

| Source | Target | Workflow | Pathway | Required Updates | Migration Priority |
|--------|--------|----------|---------|-----------------|-------------------|
| `helpers/implementation/context-first-implementation.md` | `dev-mode/context-first-implementation.md` | rules-workflow | implementation | Add header, update mode indicator, update paths | High |
| `helpers/implementation/pattern-based-implementation.md` | `dev-mode/pattern-based-implementation.md` | rules-workflow | implementation | Add header, update mode indicator, update paths | Medium |
| `helpers/implementation/tool-optimized-implementation.md` | `dev-mode/tool-optimized-implementation.md` | rules-workflow | implementation | Add header, update mode indicator, update paths | Medium |
| `helpers/implementation/system-wide-implementation.md` | `dev-mode/system-wide-implementation.md` | rules-workflow | implementation | Add header, update mode indicator, update paths | Medium |
| `helpers/recovery/error-recovery.md` | `dev-mode/recovery-error.md` | rules-workflow | recovery | Add header, update mode indicator, update paths | High |
| `helpers/recovery/state-recovery.md` | `dev-mode/recovery-state.md` | rules-workflow | recovery | Add header, update mode indicator, update paths | Medium |
| `helpers/recovery/context-recovery.md` | `dev-mode/recovery-context.md` | rules-workflow | recovery | Add header, update mode indicator, update paths | Medium |
| `helpers/validation/implementation-validation.md` | `dev-mode/validation-implementation.md` | rules-workflow | validation | Add header, update mode indicator, update paths | High |
| `helpers/validation/performance-validation.md` | `dev-mode/validation-performance.md` | rules-workflow | validation | Add header, update mode indicator, update paths | Medium |
| `helpers/validation/security-validation.md` | `dev-mode/validation-security.md` | rules-workflow | validation | Add header, update mode indicator, update paths | Medium |
| `helpers/validation/type-validation.md` | `dev-mode/validation-type.md` | rules-workflow | validation | Add header, update mode indicator, update paths | Medium |
| `helpers/finalization/implementation-finalization.md` | `dev-mode/finalization-implementation.md` | rules-workflow | finalization | Add header, update mode indicator, update paths | High |
| `helpers/finalization/system-integration-finalization.md` | `dev-mode/finalization-system-integration.md` | rules-workflow | finalization | Add header, update mode indicator, update paths | Medium |

### Helpers to Direct Mode

| Source | Target | Workflow | Pathway | Required Updates | Migration Priority |
|--------|--------|----------|---------|-----------------|-------------------|
| `helpers/implementation/direct-implementation.md` | `direct-mode/direct-implementation.md` | rules-workflow | implementation | Add header, update mode indicator, update paths | High |
| `helpers/recovery/direct-implementation-continuation.md` | `direct-mode/direct-implementation-continuation.md` | rules-workflow | recovery | Add header, update mode indicator, update paths | High |

## Mode-Specific Content Patterns

When updating content for each migrated file, follow these precise patterns based on the target mode and pathway:

### Plan Mode Content Patterns

#### 1. Standardized Header Pattern

```markdown
# Workflow: rules-workflow | Pathway: [pathway-name]

# [Original Title]

> **IMPORTANT**: This file defines [purpose] for Planning Mode.
```

#### 2. Mode Indicator Pattern

```markdown
📋 1000xdev [workflow-type]
```

#### 3. Tool Call Pattern

```typescript
// Plan mode tool call sequence
read_file("[planning_folder_path]/requirements.md", should_read_entire_file=true)
edit_file("[planning_folder_path]/implementation-[feature].md",
          "Enhance implementation plan",
          "// Updated content...")
```

### Dev Mode Content Patterns

#### 1. Standardized Header Pattern

```markdown
# Workflow: rules-workflow | Pathway: [pathway-name]

# [Original Title]

> **IMPORTANT**: This file defines [purpose] for Developer Mode.
```

#### 2. Mode Indicator Pattern

```markdown
💻 1000xdev [workflow-type]
```

#### 3. Tool Call Pattern

```typescript
// Dev mode tool call sequence
read_file("[target_file.ext]", should_read_entire_file=true)
codebase_search("related implementation")
edit_file("[target_file.ext]", 
          "Implement feature",
          "// Implementation code...")
```

### Direct Mode Content Patterns

#### 1. Standardized Header Pattern

```markdown
# Workflow: rules-workflow | Pathway: [pathway-name]

# [Original Title]

> **IMPORTANT**: This file defines [purpose] for Direct Mode.
```

#### 2. Mode Indicator Pattern

```markdown
⚡ 1000xdev [workflow-type]
```

#### 3. Tool Call Pattern

```typescript
// Direct mode tool call sequence (emphasizing research)
// Minimum 20 tool calls for research
codebase_search("existing implementation patterns")
grep_search("similar functionality", false, "*.ts")
read_file("[relevant_file]", should_read_entire_file=true)
// Implementation after thorough research
edit_file("[target_file]", 
          "Implement feature",
          "// Implementation code...")
```

## Pathway-Specific Content Patterns

Each pathway has specific content patterns that should be maintained and enhanced during migration:

### Analysis Pathway (Plan Mode)

```markdown
# Workflow: rules-workflow | Pathway: analysis

# [Analysis Type] Analysis

> **IMPORTANT**: This file defines analysis approaches for Planning Mode.

## Analysis Purpose

This file provides structured approaches for analyzing [specific domain] to enhance planning quality.

## Analysis Process

1. **Gathering Information**: [Analysis-specific approach]
2. **Pattern Recognition**: [Analysis-specific patterns]
3. **Documentation Enhancement**: [How to document findings]

## Tool Usage Pattern

```typescript
// Analysis tool sequence
codebase_search("[search terms]")
grep_search("[pattern]", false, "[file pattern]")
read_file("[target file]", should_read_entire_file=true)
```

## Analysis Documentation

```

### Verification Pathway (Plan Mode)

```markdown
# Workflow: rules-workflow | Pathway: verification

# [Verification Type] Verification

> **IMPORTANT**: This file defines verification approaches for Planning Mode.

## Verification Purpose

This file provides structured approaches for verifying [specific aspect] to ensure planning quality.

## Verification Process

1. **Checklist Development**: [Verification-specific approach]
2. **Completeness Verification**: [Verification-specific techniques]
3. **Quality Assessment**: [How to assess quality]

## Verification Criteria

[Criteria specific to verification type]
```

### Implementation Pathway (Dev Mode)

```markdown
# Workflow: rules-workflow | Pathway: implementation

# [Implementation Type]

> **IMPORTANT**: This file defines implementation approaches for Developer Mode.

## Implementation Purpose

This file provides structured approaches for implementing [specific features] efficiently and correctly.

## Implementation Process

1. **Context Building**: [Implementation-specific approach]
2. **Pattern Application**: [Implementation-specific techniques]
3. **Quality Validation**: [How to validate implementation]

## Tool Usage Pattern

```typescript
// Implementation tool sequence
read_file("[target_file]", should_read_entire_file=true)
codebase_search("[related patterns]")
edit_file("[target_file]", 
          "Implement feature",
          "// Implementation code...")
```
```

### Recovery Pathway (Dev/Direct Mode)

```markdown
# Workflow: rules-workflow | Pathway: recovery

# [Recovery Type]

> **IMPORTANT**: This file defines recovery approaches for [Developer/Direct] Mode.

## Recovery Purpose

This file provides structured approaches for recovering from [specific issues] during implementation.

## Recovery Process

1. **Issue Identification**: [Recovery-specific approach]
2. **Context Restoration**: [Recovery-specific techniques]
3. **Implementation Continuation**: [How to resume implementation]

## Recovery Patterns

[Patterns specific to recovery type]
```

## Migration Sequence Planning

To ensure an orderly migration, we'll follow this sequence:

### Phase 1: Independent Files (Batch 1)
- Files without cross-dependencies
- Focus on enhance-planning.md as a test case

### Phase 2: Core Implementation Files (Batch 2)
- Direct implementation pattern files first
- Context-first implementation files second
- Other implementation pattern files

### Phase 3: Recovery and Continuation Files (Batch 3)
- Direct implementation continuation files
- Error recovery files
- Other recovery pattern files

### Phase 4: Remaining Files (Batch 4)
- Analysis helpers
- Verification helpers
- Validation helpers
- Parameter management helpers
- Finalization helpers

## Dependency-Aware Migration Order

Based on our dependency analysis, here's the recommended migration order to minimize broken references:

1. `helpers/implementation/direct-implementation.md` → `direct-mode/direct-implementation.md`
2. `helpers/implementation/context-first-implementation.md` → `dev-mode/context-first-implementation.md` 
3. `helpers/recovery/direct-implementation-continuation.md` → `direct-mode/direct-implementation-continuation.md`
4. `helpers/recovery/error-recovery.md` → `dev-mode/recovery-error.md`
5. `helpers/finalization/enhance-planning.md` → `plan-mode/finalization-enhance-planning.md`
6. Remaining implementation helpers to dev-mode
7. Remaining recovery helpers to dev-mode
8. Analysis helpers to plan-mode
9. Verification helpers to plan-mode
10. Validation helpers to dev-mode
11. Parameter management helpers to plan-mode
12. Remaining finalization helpers to respective modes

## Content Update Guidelines

When updating content, follow these guidelines for each type of update:

### 1. Adding Standardized Header

- Add the header as the very first line of the file
- Use exact format: `# Workflow: rules-workflow | Pathway: [pathway-name]`
- Ensure workflow-type and pathway-name are in lowercase kebab-case
- No spaces before or after the pipe symbol

### 2. Updating Mode Indicators

- Change any mode indicators to match the target mode
- Plan mode: 📋 1000xdev [workflow-type]
- Dev mode: 💻 1000xdev [workflow-type]
- Direct mode: ⚡ 1000xdev [workflow-type]
- Preserve [workflow-type] placeholder for all instances

### 3. Updating Path References

- Change any references to helpers directory to the new mode-specific paths
- Update all message-command examples with new file paths
- For references to files in the same pathway, use appropriate mode prefix

### 4. Adapting Content for Mode Context

- Ensure content aligns with the target mode's primary responsibilities
- Update examples to reflect mode-specific workflows
- Modify any tool call sequences to match mode-specific patterns
- Adjust terminology to align with mode context

## Migration Readiness Assessment

Based on our analysis, we can prioritize the migration of the following files:

1. **Highest Priority**: Files with clear mode alignment and identified pathways
   - `helpers/implementation/direct-implementation.md` → `direct-mode/direct-implementation.md` (Pathway: implementation)
   - `helpers/recovery/direct-implementation-continuation.md` → `direct-mode/direct-implementation-continuation.md` (Pathway: recovery)
   - `helpers/implementation/context-first-implementation.md` → `dev-mode/context-first-implementation.md` (Pathway: implementation)
   - `helpers/finalization/enhance-planning.md` → `plan-mode/finalization-enhance-planning.md` (Pathway: finalization)

2. **Medium Priority**: Files with clear pathway alignment but potential dependencies
   - Analysis helpers → Plan Mode (Pathway: analysis)
   - Verification helpers → Plan Mode (Pathway: verification)
   - Validation helpers → Dev Mode (Pathway: validation)
   - Other finalization helpers → respective modes

3. **Lower Priority**: Helper files with complex dependencies or less frequent usage
   - Parameter management helpers → Plan Mode (Pathway: parameter-management)
   - System-wide implementation helpers → Dev Mode (Pathway: implementation)

## Content Transformation Examples

### Example 1: direct-implementation.md

**Before:**
```markdown
# Direct Implementation

This file defines the operation of the `direct-mode: rules-workflow @parameters/rules/helpers/implementation/direct-implementation.mdc` message-command...

Direct implementation mode requires a minimum of 20 tool calls for research before implementation...
```

**After:**
```markdown
# Workflow: rules-workflow | Pathway: implementation

# Direct Implementation

> **IMPORTANT**: This file defines direct implementation approaches for Direct Mode.

This file defines the operation of the `direct-mode: rules-workflow @parameters/rules/direct-mode/direct-implementation.mdc` message-command...

Direct implementation mode requires a minimum of 20 tool calls for research before implementation...
```

### Example 2: enhance-planning.md

**Before:**
```markdown
# Enhance Planning: Rules Workflow

## File Purpose

This file provides an iterative planning enhancement pattern for rules workflow implementation...

```typescript
// Update implementation progress with enhancement assessment
edit_file("[planning_folder_path]/implementation-progress.md", ...)
```
```

**After:**
```markdown
# Workflow: rules-workflow | Pathway: finalization

# Enhance Planning: Rules Workflow

> **IMPORTANT**: This file defines planning enhancement approaches for Planning Mode.

## File Purpose

This file provides an iterative planning enhancement pattern for rules workflow implementation...

```typescript
// Update implementation progress with enhancement assessment
edit_file("[planning_folder_path]/implementation-progress.md", ...)
```
```

## Mode-Pathway Matrix

After migration, the expected distribution of files across modes and pathways will be:

| Mode | Pathway | File Count | Examples |
|------|---------|------------|----------|
| plan-mode | analysis | 4 | analysis-requirements.md, analysis-codebase.md, etc. |
| plan-mode | verification | 4 | verification-planning.md, verification-requirements.md, etc. |
| plan-mode | parameter-management | 3 | parameter-validation.md, parameter-organization.md, etc. |
| plan-mode | finalization | 2 | finalization-enhance-planning.md, finalization-documentation.md |
| dev-mode | implementation | 4 | context-first-implementation.md, pattern-based-implementation.md, etc. |
| dev-mode | recovery | 3 | recovery-error.md, recovery-state.md, recovery-context.md |
| dev-mode | validation | 4 | validation-implementation.md, validation-performance.md, etc. |
| dev-mode | finalization | 2 | finalization-implementation.md, finalization-system-integration.md |
| direct-mode | implementation | 1 | direct-implementation.md |
| direct-mode | recovery | 1 | direct-implementation-continuation.md |

This matrix confirms a logical distribution aligned with the responsibilities of each mode while maintaining pathway consistency across the modes. 