# Mode Transitions

## Overview

This document provides essential guidance on transitions between Planning Mode, Developer Mode, and Direct Mode. For detailed patterns and comprehensive examples, refer to the knowledge files referenced below.

## Knowledge Access

For comprehensive mode transition documentation, access these knowledge components:

```typescript
// For detailed mode transition patterns
fetch_rules(["knowledge/rules/patterns/modes/mode-transition-patterns"], 
           "Understanding mode transition patterns and processes")

// For specific mode patterns
fetch_rules(["knowledge/rules/patterns/modes/plan-mode-patterns"], 
           "Understanding Planning Mode patterns")
fetch_rules(["knowledge/rules/patterns/modes/dev-mode-patterns"], 
           "Understanding Developer Mode patterns")
fetch_rules(["knowledge/rules/patterns/modes/direct-mode-patterns"], 
           "Understanding Direct Mode patterns")
```

## Core Transition Principles

1. **Initiation Rule**: Every conversation starts in Planning Mode unless direct-mode is used
2. **Single Transition Point**: Only ONE mode transition per implementation cycle
3. **One-Way Transition**: In each cycle, transition ONLY from dev-mode to plan-mode after implementation is complete
4. **Clear Role Separation**: No documentation updates in dev-mode, no code changes in plan-mode
5. **Mode Indicator Requirement**: Every message must include the appropriate mode indicator
   - Planning Mode: 📋 indicator
   - Developer Mode: 💻 indicator
   - Direct Mode: ⚡ indicator

## Mode Transition Commands

### Planning to Implementation Transition

When 1000xdev has sent `planning-document-complete` message-command, Tyler can initiate a direct transition to Developer Mode:

```
dev-mode: workflow-type @optional-implementation-strategy.mdc
```

### Bypassing Planning with Direct Mode

To bypass the planning phase entirely, Tyler can use direct-mode:

```
direct-mode: workflow-type @optional-implementation-strategy.mdc

prompt: Specific implementation details
```

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

## Continuation Commands

After the initial transition, implementation can be guided or recovered using continuation commands:

1. **Continue Implementation**: `continue-implementation: @specific-path.mdc`
   - Provides specific implementation guidance
   - Useful for complex implementation phases
   - Can specify different strategies for different phases

For detailed information on context management during transitions and advanced transition patterns, see the knowledge files.