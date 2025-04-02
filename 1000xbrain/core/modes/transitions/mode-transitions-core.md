# Mode Transitions Core

## File Purpose and Relationship

This file defines the core transition processes between Planning Mode and Developer Mode. It is part of the split mode-transitions documentation:

- **mode-transitions-core.md** (this file): Essential transition definition and process
- **mode-transitions-handlers.md**: Specialized transition handlers and recovery protocols
- **mode-transitions-context.md**: Context management during transitions

## Mode Transition System

### Mode Transition Visual Overview

```
┌───────────────────────────────────────────────────────────────────────────────────┐
│                                                                                   │
│  ┌─────────────────────┐            ┌─────────────────────┐                       │
│  │                     │            │                     │                       │
│  │   PLANNING MODE     │            │   DEVELOPER MODE    │                       │
│  │   (📋 1000xdev)     │            │   (💻 1000xdev)     │                       │
│  │                     │            │                     │                       │
│  │  ┌───────────────┐  │   Direct   │  ┌───────────────┐  │                       │
│  │  │ Documentation │  │ Transition │  │     Code      │  │                       │
│  │  │   Creation    │  │    ───▶    │  │ Implementation│  │                       │
│  │  └───────────────┘  │            │  └───────────────┘  │                       │
│  │                     │            │                     │                       │
│  └─────────────────────┘            └─────────────────────┘                       │
│                 ▲                            │                                    │
│                 │                            │                                    │
│                 └────────────────────────────┘                                    │
│                 Implementation Completion                                         │
│                                                                                   │
│                                  ┌─────────────────────┐                          │
│                                  │                     │                          │
│                                  │    DIRECT MODE      │                          │
│                                  │    (⚡ 1000xdev)     │                          │
│                                  │                     │                          │
│                                  │  ┌───────────────┐  │                          │
│                                  │  │  Research &   │  │                          │
│                                  │  │ Implementation│  │                          │
│                                  │  └───────────────┘  │                          │
│                                  │                     │                          │
│                                  └─────────────────────┘                          │
│                                                                                   │
└───────────────────────────────────────────────────────────────────────────────────┘
```

### Transition Principles

1. **Initiation Rule**: Every conversation starts in Planning Mode unless direct-mode is used
2. **Single Transition Point**: Only ONE mode transition per implementation cycle
3. **One-Way Transition**: In each cycle, transition ONLY from dev-mode to plan-mode after implementation is complete
4. **Clear Role Separation**: No documentation updates in dev-mode, no code changes in plan-mode
5. **Mode Indicator Requirement**: Every message must include the appropriate mode indicator
   - Planning Mode: 📋 indicator
   - Developer Mode: 💻 indicator
   - Direct Mode: ⚡ indicator

## Direct Transition Protocol

### Planning to Implementation Transition

When 1000xdev has sent `planning-document-complete` message-command, Tyler can initiate a direct transition to Developer Mode:

```
dev-mode: workflow-type @parameters/rules/dev-mode/optional-implementation-strategy.mdc
```

This simplified transition has these benefits:

1. **Reduced Complexity**: Single message-command instead of three
2. **Context Retention**: Better context management during transition
3. **Reduced Hallucinations**: Fewer opportunities for context confusion
4. **Strategy Flexibility**: Optional implementation strategy parameter

### Bypassing Planning with Direct Mode

To bypass the planning phase entirely, Tyler can use direct-mode:

```
direct-mode: workflow-type @parameters/rules/direct-mode/optional-implementation-strategy.mdc

prompt: Specific implementation details
```

This approach offers:
1. **Immediate Implementation**: Skips planning documentation phase
2. **Research-First Approach**: Makes minimum 20 tool calls for research before implementation
3. **Rapid Iteration**: For smaller changes where detailed planning is unnecessary
4. **Clear Designation**: Uses ⚡ indicator for all responses

### Implementation to Planning Transition

After implementation is complete, 1000xdev signals completion and transitions back to Planning Mode:

```
💻 1000xdev [workflow-type]

Implementation complete:
- All requirements implemented
- Functionality verified
- Used appropriate implementation patterns

implementation-complete
```

Similarly, after direct-mode implementation:

```
⚡ 1000xdev [workflow-type]

Implementation complete:
- All requirements implemented
- Functionality verified
- Used appropriate implementation patterns

implementation-complete
```

## Knowledge Access During Transitions

During mode transitions, the `fetch_rules` tool provides access to specialized knowledge:

```typescript
// Access transition patterns
fetch_rules(["knowledge/rules/patterns/impl/mode-transition-patterns"], 
           "Understanding effective mode transition patterns")

// Access implementation preparation patterns
fetch_rules(["knowledge/rules/patterns/impl/implementation-preparation"], 
           "Preparing for implementation phase transition")

// Access direct-mode research patterns
fetch_rules(["knowledge/rules/patterns/impl/direct-mode-research-patterns"], 
           "Optimizing research phase in direct implementation mode")
```

## Basic Workflow Examples

### Simple Planning to Implementation Workflow

```
# Tyler initiates planning
plan-mode: rules-workflow

# 1000xdev creates planning documentation
📋 1000xdev [rules-workflow]
# ... planning activities ...

# 1000xdev signals planning completion
📋 1000xdev [rules-workflow]
planning-document-complete

# Tyler initiates direct transition to implementation
dev-mode: rules-workflow

# 1000xdev implements changes
💻 1000xdev [rules-workflow]
# ... implementation activities ...

# 1000xdev signals implementation completion
💻 1000xdev [rules-workflow]
implementation-complete
```

### Simple Direct Implementation Workflow

```
# Tyler initiates direct implementation
direct-mode: rules-workflow

# Tyler provides implementation details
prompt: Implement specific feature

# 1000xdev performs research and implements changes
⚡ 1000xdev [rules-workflow]
# ... research and implementation activities ...

# 1000xdev signals implementation completion
⚡ 1000xdev [rules-workflow]
implementation-complete
```

## Cross-References

For additional information, see:
- **plan-mode/core.md**: Planning Mode essentials
- **dev-mode/core.md**: Developer Mode essentials
- **direct-mode/core.md**: Direct Mode essentials
- **mode-transitions-handlers.md**: Specialized transition handling
- **mode-transitions-context.md**: Context management during transitions 