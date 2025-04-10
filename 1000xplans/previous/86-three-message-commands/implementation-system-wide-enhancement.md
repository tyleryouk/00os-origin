# Implementation Plan: System-Wide Enhancement

## Enhancement Scope

This system-wide enhancement will:

1. Condense the core/ directory to under 1000 total lines
2. Preserve the hierarchical importance of global-rules.md
3. Move detailed implementation knowledge to knowledge/rules/
4. Support the simplified three message-commands system
5. Ensure all references align with the four allowed workflows
6. Maintain consistent brain-files terminology throughout

## Implementation Strategy

The implementation will follow a phased approach with careful content migration to preserve all critical knowledge while significantly reducing the core directory size.

### Phase 1: Migrate Detailed Knowledge

1. Create new knowledge modules in knowledge/rules/ for content to be moved
2. Move detailed symbol guidelines from symbol-guidelines.md
3. Move detailed syntax standards from syntax-standards.md
4. Move mode implementation details from modes/ subdirectories
5. Move tool usage standards and examples
6. Move advanced mode transition handlers

**Key Destinations**:
- knowledge/rules/patterns/communication/
- knowledge/rules/patterns/modes/
- knowledge/rules/reference/syntax/
- knowledge/rules/guides/mode-system/

### Phase 2: Condense Core Files

1. Condense core-essentials.md to absolute essentials only
2. Streamline global-rules.md to focus on identity and core principles
3. Simplify communication directory files
4. Condense mode system documentation
5. Reduce identity documents to essentials

**Core Files to Preserve**:
- core/core-essentials.md
- core/identity/global-rules.md
- core/communication/message-commands.md
- core/communication/file-editing-safety.md
- core/modes/mode-transitions.md

### Phase 3: Update Cross-References

1. Update all references to workflows to use only the four valid workflows
2. Update fetch_rules patterns to access the new knowledge locations
3. Ensure consistent brain-files terminology
4. Verify that README.md files follow the "workflow | pathway" format

### Phase 4: Integration & Verification

1. Verify total core/ line count is under 1000 lines
2. Confirm all critical knowledge is preserved and accessible
3. Check all cross-references for validity
4. Ensure global-rules.md remains hierarchically most important
5. Verify consistent terminology throughout the system

## Target Files for Modification

### Core Files to Condense

| File | Current Lines | Target Lines | Reduction |
|------|---------------|--------------|-----------|
| global-rules.md | 550 | 300 | 250 |
| symbol-guidelines.md | 581 | 80 | 501 |
| syntax-standards.md | 354 | 80 | 274 |
| file-editing-safety.md | 145 | 80 | 65 |
| modes/* | 247+ | 150 | 97+ |
| README.md | 145 | 100 | 45 |
| core-essentials.md | 51 | 51 | 0 |
| index.md | 69 | 59 | 10 |
| message-commands.md | 58 | 50 | 8 |
| **TOTAL** | ~2,200+ | ~950 | ~1,250+ |

### Knowledge Files to Create

1. **Symbol Guidelines & Patterns**:
   - knowledge/rules/patterns/communication/symbol-usage.md
   - knowledge/rules/patterns/communication/symbol-combinations.md

2. **Syntax Standards & Patterns**:
   - knowledge/rules/patterns/communication/syntax-patterns.md
   - knowledge/rules/reference/syntax/message-command-syntax.md
   - knowledge/rules/reference/syntax/mode-indicator-syntax.md

3. **Mode Implementation Details**:
   - knowledge/rules/patterns/modes/plan-mode-patterns.md
   - knowledge/rules/patterns/modes/dev-mode-patterns.md
   - knowledge/rules/patterns/modes/direct-mode-patterns.md
   - knowledge/rules/guides/mode-system/transitions.md

4. **Tool Usage & Parameters**:
   - knowledge/rules/patterns/tool/tool-selection.md
   - knowledge/rules/patterns/tool/tool-sequences.md
   - knowledge/rules/reference/parameters/parameter-system.md

## Implementation Patterns

### Content Migration Pattern
```
1. Create destination file in knowledge/rules/
2. Move detailed sections from core/ files
3. Ensure cross-references are updated
4. Condense source file to essential information only
5. Add fetch_rules reference in source file to access detailed knowledge
```

### File Reduction Strategy
```
1. Identify essential knowledge that must remain in core/
2. Move all detailed examples to knowledge/rules/
3. Move implementation-specific details to knowledge/rules/
4. Keep only critical safety information and identity components
5. Move workflow-specific details to appropriate workflow directories
```

## Verification Approach

To verify successful implementation:

1. **Line Count Verification**:
   - Count total lines in core/ directory
   - Ensure count is under 1000 lines

2. **Knowledge Access Verification**:
   - Test fetch_rules access to all migrated knowledge
   - Verify all critical information is accessible

3. **Reference Integrity**:
   - Check all cross-references for validity
   - Ensure no broken links to moved content

4. **Terminology Consistency**:
   - Verify consistent use of "brain-files" terminology
   - Check workflow references match the four valid workflows

5. **Header Format**:
   - Confirm README.md files follow the "workflow | pathway" format

## Success Criteria

This implementation will be considered successful when:

1. Total core/ directory line count is under 1000 lines
2. global-rules.md remains hierarchically most important
3. All critical knowledge remains accessible via fetch_rules
4. All references to workflows use only the four valid workflows
5. Consistent "brain-files" terminology is used throughout
6. README.md headers follow the "workflow | pathway" format 