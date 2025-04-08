# Rules Workflow Core

## Overview

This file defines the essential standards for developing and updating the 1000xbrain cognitive architecture. It provides the core concepts, workflow processes, and implementation standards.

## Workflow Identity

**Mode Indicators**: 
- Plan Mode: 📋 1000xdev [rules-workflow]
- Dev Mode: 💻 1000xdev [rules-workflow]
- Direct Mode: ⚡ 1000xdev [rules-workflow]

## Core Workflow Process

### Planning Phase
1. **Requirements Definition**: Define clear objectives and success criteria
2. **Context Analysis**: Analyze the current state of the cognitive architecture
3. **Implementation Planning**: Create detailed implementation plans
4. **Verification**: Verify planning completeness before implementation

### Implementation Phase
1. **Phased Implementation**: Implement changes in logical phases
2. **Verification**: Verify each phase before moving to the next
3. **Automatic Synchronization**: Changes to 1000xbrain files are automatically synchronized to Cursor Rules

## Required Planning Folder Structure

Every planning folder should include these essential files:

| File | Purpose | Creator | Primary Audience |
|---|---|---|-----|
| `requirements.md` | Core requirements and objectives | Tyler provides outline, 1000xdev enhances | Both |
| `implementation.md` | Implementation approach and guidance | 1000xdev | 1000xdev |
| `planning-progress.md` | Track planning/research status (NEW) | 1000xdev | 1000xdev |
| `implementation-progress.md` | Track implementation status and progress | 1000xdev | 1000xdev |

The `implementation-progress.md` file is critical for tracking implementation status across phases, documenting completed and pending tasks, and enabling effective recovery from interruptions.

## Implementation Scenarios

The rules-workflow adapts to different scenarios:

1. **Targeted Rule Modifications**: Specific changes to defined files
2. **Conversation Analysis**: Improvements based on conversation analysis
3. **System-Wide Enhancement**: Broad improvements to the architecture
4. **Subsystem Enhancement**: Focus on specific cognitive components

## Implementation Complete Criteria

A rules-workflow implementation is complete when:

1. **Documentation Standards**:
   - All knowledge references are updated
   - File structure follows standards
   - Documentation is complete and clear

2. **Implementation Quality**:
   - Code follows best practices
   - Error handling is comprehensive
   - Performance is optimized

3. **Cognitive Enhancement**:
   - Brain-files are properly synchronized
   - Cognitive capabilities are enhanced
   - Knowledge system is updated

4. **Verification Process**:
   - All validation checks pass
   - Synchronization is successful
   - Documentation is verified 