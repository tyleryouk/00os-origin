# Context: 1000xbrain Structure and Steam Web API Integration

## Current State of 1000xbrain

This document provides essential context for implementing the Steam Web API pathways within the 1000xbrain cognitive architecture. It outlines the current structure and development state of different components to guide implementation.

### Implementation Status

- **rules-workflow**: Almost fully implemented
  - Contains comprehensive documentation and workflow patterns
  - Has well-defined parameter files for all modes
  - Strong knowledge component structure with guides, reference, and patterns
  
- **front-end-workflow**: Partially implemented (approximately 50%)
  - Has essential workflow documentation
  - Contains some parameter files for different modes
  - Includes log-based workflow processing
  - Has UX-situation guidance and component patterns
  
- **back-end-workflow**: Not implemented
  - Directory structure exists but no actual files
  - Needs complete implementation of all files and components
  
- **scripts-workflow**: Not implemented
  - Directory structure exists but no actual files
  - Needs complete implementation of all files and components

### Directory Structure Analysis

#### Core Structure

The core cognitive architecture is well-developed with comprehensive files for:
- Identity components (`/core/identity/`)
- Communication standards (`/core/communication/`)
- Mode system (`/core/modes/`)
- Mode transitions (`/core/modes/transitions/`)

#### Knowledge Structure

Knowledge is organized into specialized domains:
- `knowledge/rules/guides/` - Comprehensive guides for system components
- `knowledge/rules/patterns/` - Implementation and behavior patterns
- `knowledge/rules/reference/` - Reference materials and architecture documentation
- Knowledge directories for front-end, back-end, and scripts exist but are empty

#### Parameters Structure

Parameters are organized by workflow type and mode:
- `parameters/rules/` - Comprehensive parameters for rules workflow
  - Includes plan-mode, dev-mode, and direct-mode subdirectories
- `parameters/front-end/` - Partial parameters for front-end workflow
  - Includes some files in plan-mode and dev-mode
- `parameters/back-end/` - Directory exists but no files
- `parameters/scripts/` - Directory exists but no files

#### Workflows Structure

Workflows define the Auto-Attached project rules:
- `workflows/rules/` - Comprehensive workflow documentation
- `workflows/front-end/` - Partial workflow documentation
- `workflows/back-end/` - Directory exists but no files
- `workflows/scripts/` - Directory exists but no files

## Steam Web API Integration Requirements

The task is to create new pathways for the Steam Web API integration, focusing on:

1. **front-end-workflow**
   - Create pathway: `front-end | steam-web-api`
   - Add parameter files:
     - `parameters/front-end/dev-mode/steam-web-api.md`
     - `parameters/front-end/direct-mode/steam-web-api.md`
     - `parameters/front-end/plan-mode/steam-web-api.md`
   - Create knowledge base files in `knowledge/front-end/steam-web-api/`
   - Update Auto Attached brain-files in `workflows/front-end/` as needed

2. **back-end-workflow**
   - Create pathway: `back-end | steam-web-api`
   - Add parameter files:
     - `parameters/back-end/dev-mode/steam-web-api.md`
     - `parameters/back-end/direct-mode/steam-web-api.md`
     - `parameters/back-end/plan-mode/steam-web-api.md`
   - Create knowledge base files in `knowledge/front-end/steam-web-api/`
   - Create minimal Auto Attached brain-files in `workflows/back-end/`

3. **rules-workflow for front-end**
   - Create pathway: `rules-workflow | front-end-steam-web-api`
   - Add parameter files:
     - `parameters/front-end/dev-mode/steam-web-api.md`
     - `parameters/front-end/direct-mode/steam-web-api.md`
     - `parameters/front-end/plan-mode/steam-web-api.md`

4. **rules-workflow for back-end**
   - Create pathway: `rules-workflow | back-end-steam-web-api`
   - Add parameter files:
     - `parameters/back-end/dev-mode/steam-web-api.md`
     - `parameters/back-end/direct-mode/steam-web-api.md`
     - `parameters/back-end/plan-mode/steam-web-api.md`

## Header Requirements

Every project-rule-parameter must have the following header:
```
# workflow: [workflow-type] | pathway: [pathway-name] | message-command: [message-command] | standard-parameter(s): [standard-parameter] | project-rule-parameter-filepath: [project-rule-parameter-filepath]
```

Every knowledge-base file must have the following header:
```
# USE WHEN [description-of-file]
```

## Implementation Considerations

1. **Existing Steam References**:
   - The front-end already contains CS2 gun models with Steam links
   - Current implementation includes mock links rather than real integration
   - Research has identified SteamWebAPI.com as the preferred API for integration

2. **Knowledge Integration Priority**:
   - Focus on creating comprehensive knowledge files for the Steam Web API integration
   - Ensure parameter files follow existing patterns for consistency
   - Create proper workflow documentation that aligns with existing documentation

3. **Implementation Sequence**:
   1. Create directory structures first
   2. Implement knowledge files
   3. Create parameter files
   4. Update workflow documentation
   5. Verify all headers are correctly formatted
   6. Ensure all @ symbols are properly wrapped in backticks

## SteamWebAPI.com Integration Focus

Based on the research, the implementation should focus on:
- User authentication through Steam
- CS2 inventory access and management
- Trade offers and trade history
- Market prices and item details
- Security considerations including Steam Guard verification

This implementation will enhance GigaSwap's marketplace by integrating real CS2 skin data from users' Steam inventories, providing a seamless trading experience while maintaining security and compliance with Steam's terms of service. 