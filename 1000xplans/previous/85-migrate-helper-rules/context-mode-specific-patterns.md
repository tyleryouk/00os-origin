# Context Analysis: Mode-Specific Patterns

## Mode-Specific Operational Patterns

To ensure each helper rule is migrated to the appropriate mode directory, we need to understand the distinct patterns and responsibilities of each mode. This analysis will guide our categorization decisions.

### Plan Mode Patterns (📋 1000xdev)

**Core Responsibilities:**
- Documentation creation and planning
- Requirements analysis and enhancement
- Implementation planning
- Technical context documentation
- Verification criteria establishment
- Success criteria definition

**Tool Usage Patterns:**
- Documentation tools (`edit_file` for markdown)
- Analysis tools (`list_dir`, `read_file`, `codebase_search`)
- Knowledge access (`fetch_rules`)
- No direct code implementation

**Content Focus:**
- Planning folder generation
- Requirements documentation
- Context documentation
- Implementation planning
- Test criteria documentation

**Helper Rules That Align with Plan Mode:**
- Analysis tools (requirements, architecture, code review)
- Planning structure generators
- Verification planning tools
- Documentation validators
- Parameter management tools (for planning)

### Dev Mode Patterns (💻 1000xdev)

**Core Responsibilities:**
- Code implementation and modification
- Testing and debugging
- Error handling
- Implementation verification
- Code quality improvement

**Tool Usage Patterns:**
- Implementation tools (`edit_file` for code)
- Code analysis tools (`codebase_search`, `grep_search`)
- Testing tools (`run_terminal_cmd`)
- Knowledge access (`fetch_rules`)
- No documentation updates

**Content Focus:**
- Code implementation
- Implementation testing
- Error handling
- Quality verification
- Performance optimization

**Helper Rules That Align with Dev Mode:**
- Standard implementation patterns
- Error recovery tools
- Validation tools
- Testing frameworks
- Refinement tools
- Finalization tools

### Direct Mode Patterns (⚡ 1000xdev)

**Core Responsibilities:**
- Immediate implementation without planning
- Research-first approach
- Rapid implementation
- Implementation verification

**Tool Usage Patterns:**
- Research tools (minimum 20 tool calls)
- Implementation tools (`edit_file` for code)
- Testing tools (`run_terminal_cmd`)
- Knowledge access (`fetch_rules`)
- No documentation creation

**Content Focus:**
- Comprehensive research
- Pattern discovery
- Immediate implementation
- Self-contained verification

**Helper Rules That Align with Direct Mode:**
- Direct implementation strategies
- Research pattern generators
- Context-gathering tools
- Direct mode recovery tools
- Rapid verification tools

## Mode-Specific Context Boundaries

Understanding the context boundaries for each mode helps determine where each helper rule belongs:

### Plan Mode Context

In Plan Mode, the context is limited to:
- The `1000xbrain/README.md` file
- The current planning folder

This limited context means plan-mode helper rules should be designed to operate with minimal system context, focusing on creating comprehensive planning folders.

### Dev Mode Context

In Dev Mode, the context includes:
- Planning documentation from the planning folder
- Knowledge accessed through `fetch_rules`
- Code relevant to the implementation

Dev-mode helper rules should be designed to operate with the planning documentation as their primary guide, focusing on implementation based on that planning.

### Direct Mode Context

In Direct Mode, the context is built through:
- Extensive research (minimum 20 tool calls)
- Pattern discovery from existing code
- The user's direct implementation request

Direct-mode helper rules should be designed to operate without planning documentation, focusing on research and immediate implementation.

## Pathway Organization Within Modes

Each mode contains helper rules organized into pathways, which are functional categories that group related helper rules. The pathway system helps organize and categorize rules based on their functional role within each mode.

### Common Pathways Across Modes

Some pathways appear in multiple modes but with mode-specific implementations:

| Pathway | Plan Mode | Dev Mode | Direct Mode |
|---------|-----------|----------|-------------|
| **system-wide** | System-wide planning | System-wide implementation | System-wide direct implementation |
| **recovery** | Planning recovery | Implementation recovery | Direct implementation recovery |
| **implementation** | Implementation planning | Implementation patterns | Direct implementation approaches |

### Mode-Specific Pathways

Some pathways are unique to specific modes due to their specialized functions:

| Mode | Specific Pathways | Purpose |
|------|-------------------|---------|
| **Plan Mode** | analysis, verification, parameter-management | Focus on planning and preparation |
| **Dev Mode** | validation, finalization | Focus on implementation verification and completion |
| **Direct Mode** | research | Focus on rapid research and implementation |

### Native Project-Rule-Parameters

Some project-rule-parameters don't fit cleanly into a pathway and are considered "native" to their mode:

| Mode | Native Parameters | Purpose |
|------|-------------------|---------|
| **Plan Mode** | template-basic, template-advanced | Core planning templates |
| **Dev Mode** | continue-implementation | Core implementation continuation |
| **Direct Mode** | direct-mode | Core direct implementation |

## Content Pattern Identification

Examining content patterns helps identify where each helper rule belongs:

### Plan Mode Content Patterns

- Comprehensive documentation structure
- Planning folder templates
- Verification checklists
- Requirements enhancement
- Context documentation patterns

### Dev Mode Content Patterns

- Implementation strategies
- Testing approaches
- Error recovery mechanisms
- Validation frameworks
- Quality improvement patterns

### Direct Mode Content Patterns

- Research strategies
- Pattern discovery approaches
- Rapid implementation techniques
- Self-verification mechanisms

## Standardized Header System

Each file MUST have a standardized header that clearly identifies its workflow and pathway:

```
# Workflow: [workflow-type] | Pathway: [pathway-name]
```

Where:
- `[workflow-type]` is typically "rules-workflow" (could also be front-end-workflow, back-end-workflow, etc.)
- `[pathway-name]` is the specific pathway like "system-wide", "recovery", "implementation", etc.
- Both workflow-type and pathway-name MUST be in lower-case kebab-case format (words separated by hyphens, all lowercase)

For native project-rule-parameters that don't fit into a specific pathway, use:

```
# Workflow: rules-workflow | Pathway: native
```

IMPORTANT: This standardized header is MANDATORY for EVERY project-rule-parameter in rules-workflow, without exception. It must be the very first line of the file to ensure consistent parsing by automation scripts.

This standardized header system provides several benefits:
1. **Clarity**: Each file clearly indicates its workflow and pathway
2. **Consistency**: All files follow the same header format with consistent casing
3. **Parsability**: Scripts can easily extract workflow and pathway information
4. **Self-documentation**: Files are self-describing even without prior knowledge
5. **Organization**: Files can be automatically grouped by workflow or pathway
6. **Automation**: Enables automatic processing and organization via scripts

## Transition Patterns Between Modes

Understanding transition patterns helps identify helpers that facilitate mode transitions:

### Plan-to-Dev Transition

- Completion of planning documentation
- Verification of planning completeness
- Transition to implementation

### Dev-to-Plan Transition

- Completion of implementation
- Documentation of implementation outcomes
- Transition to planning for next phase

### Direct Mode Initiations

- Bypassing planning phase
- Research-first approach
- Immediate implementation

## Decision Framework for Mode Assignment

Based on the above patterns, here's a decision framework for assigning helper rules to modes:

1. **Primary Function Test**:
   - If primarily focused on documentation/planning → Plan Mode
   - If primarily focused on code implementation → Dev Mode
   - If primarily focused on research and immediate implementation → Direct Mode

2. **Tool Usage Test**:
   - If primarily uses documentation tools → Plan Mode
   - If primarily uses implementation tools → Dev Mode or Direct Mode
   - If primarily uses research tools → Direct Mode

3. **Context Dependency Test**:
   - If operates with minimal system context → Plan Mode
   - If depends on planning documentation → Dev Mode
   - If relies on research and direct input → Direct Mode

4. **Transition Role Test**:
   - If facilitates planning completion → Plan Mode
   - If facilitates implementation → Dev Mode
   - If facilitates direct action → Direct Mode

## Decision Framework for Pathway Assignment

Once a helper rule is assigned to a mode, use this framework to determine its pathway:

1. **Functional Role Test**:
   - What primary function does this helper serve within its mode?
   - Which existing pathway best matches this function?

2. **Operation Similarity Test**:
   - Which other helpers operate in a similar way?
   - What pathway are those similar helpers assigned to?

3. **Tool Usage Pattern Test**:
   - What tools does this helper primarily use?
   - Which pathway is associated with those tool patterns?

4. **Content Pattern Test**:
   - What content patterns does this helper exhibit?
   - Which pathway typically contains those patterns?

If no existing pathway is a good fit, consider whether the helper should be:
- Assigned to the "native" pathway (if it's a core mode functionality)
- Assigned to a new pathway (if it represents a distinct functional category)
- Split into multiple files across different pathways (if it serves multiple functions)

## Mode-Specific Naming Conventions

To maintain consistency after migration, these naming conventions should be considered:

### Plan Mode Naming Patterns

- `template-{purpose}.md`: For planning templates
- `plan-mode-{function}.md`: For specialized planning functions
- `verification-{aspect}.md`: For verification tools
- `analysis-{type}.md`: For analysis tools

### Dev Mode Naming Patterns

- `dev-mode-{function}.md`: For specialized implementation functions
- `continue-implementation-{purpose}.md`: For continuation strategies
- `validation-{aspect}.md`: For validation tools
- `recovery-{type}.md`: For recovery tools
- `finalization-{purpose}.md`: For finalization tools

### Direct Mode Naming Patterns

- `direct-mode-{function}.md`: For specialized direct implementation functions
- `direct-implementation-{purpose}.md`: For direct implementation strategies
- `research-{focus}.md`: For research strategies

These pattern analyses will guide the migration of each helper rule to its most appropriate mode directory and pathway, ensuring logical organization and functional alignment. 