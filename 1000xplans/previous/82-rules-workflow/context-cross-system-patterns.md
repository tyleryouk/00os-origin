# Cross-System Patterns: Project-Rule-Parameter System

## Parameter Management Command Patterns

The current parameter management system includes these command patterns that span across subsystems:

### Pattern 1: Direct Parameter Management

```
manage-parameters: add name="parameter-name" path="parameters/rules/category/parameter-name.md" description="Parameter description" category="category"
manage-parameters: remove name="parameter-name"
manage-parameters: update name="parameter-name" description="Updated description"
manage-parameters: verify
```

**Used in**: Single parameter management
**Implementation**: Parameter-manager.md
**Integration**: Uses 1000xscripts/parameters/ PowerShell scripts

### Pattern 2: Workflow-Specific Parameter Management

```
manage-parameters: add workflow="workflow-type" name="parameter-name" path="parameters/workflow/category/parameter-name.md" description="Parameter description" category="category" message-command="message-command" standard-parameters="param1,param2"
manage-parameters: remove workflow="workflow-type" name="parameter-name"
manage-parameters: update workflow="workflow-type" name="parameter-name" description="Updated description"
manage-parameters: verify workflow="workflow-type"
manage-parameters: convert-refs
```

**Used in**: Cross-workflow parameter management
**Implementation**: Cross-workflow-parameter-manager.md
**Integration**: Uses 1000xscripts/parameters/Manage-AllParameters.ps1

## Parameter Reference Patterns

The parameter reference system includes these patterns:

### Pattern 3: Direct Path References

```
@parameters/rules/plan-mode/template-basic.mdc
```

**Used in**: Original message-commands
**Implementation**: Direct path resolution
**Integration**: Cursor Rules system

### Pattern 4: Alias References

```
@alias:rules:template-basic
```

**Used in**: Newer message-commands
**Implementation**: Alias resolution through registry
**Integration**: Requires alias-registry.json

## Parameter Implementation Patterns

The parameter implementation system includes these patterns:

### Pattern 5: Single Registry Implementation

```json
{
  "parameters": {
    "parameter-name": {
      "path": "parameters/rules/category/parameter-name.md",
      "description": "Parameter description",
      "category": "category"
    }
  }
}
```

**Used in**: parameter-registry.json
**Implementation**: Direct PowerShell script manipulation
**Integration**: Single workflow only

### Pattern 6: Alias Registry Implementation

```json
{
  "aliases": {
    "workflow": {
      "parameter-name": {
        "path": "parameters/workflow/category/parameter-name.md",
        "description": "Parameter description",
        "category": "category",
        "messageCommand": "message-command",
        "standardParameters": ["param1", "param2"]
      }
    }
  }
}
```

**Used in**: alias-registry.json
**Implementation**: Cross-workflow PowerShell script manipulation
**Integration**: Multiple workflows

## Parameter Management Workflows

The system currently lacks defined workflows for parameter management, with only these implicit patterns:

### Pattern 7: Direct Parameter Creation

1. Manually create parameter file
2. Register parameter using manage-parameters command
3. No planning or verification phase

**Used in**: Ad-hoc parameter creation
**Implementation**: Direct file creation + command
**Integration**: Minimal process integration

### Pattern 8: Alias-Based Parameter Creation

1. Manually create parameter file
2. Register parameter using cross-workflow manage-parameters command
3. Use convert-refs to update references
4. No planning or verification phase

**Used in**: Ad-hoc cross-workflow parameter creation
**Implementation**: Direct file creation + commands
**Integration**: Partial process integration

## Missing Pattern: Complete Parameter Management Workflow

A complete parameter management workflow would include:

1. **Planning Phase**: Document requirements and integration points
2. **Implementation Phase**: Create parameter file with consistent structure
3. **Registration Phase**: Register the parameter in the appropriate registry
4. **Verification Phase**: Verify parameter references and functionality
5. **Documentation Phase**: Update documentation to reflect new parameter

This complete pattern is missing from the current system.

## Cross-Subsystem Integration Patterns

The system currently relies on these cross-subsystem integration patterns:

### Pattern 9: Script-Based Registry Updates

PowerShell scripts manipulate JSON registries directly, with no abstraction layer between cognitive operations and file system operations.

### Pattern 10: Manual Reference Management

Parameter references must be manually managed when parameters change locations, with only partial automation through the convert-refs operation.

### Pattern 11: Disconnected Knowledge Access

No integration between the parameter system and the knowledge access system (fetch_rules) to provide parameter-specific knowledge.

## Pattern Standardization Opportunities

These patterns present opportunities for standardization:

1. **Unified Registry System**: Consolidate both registry approaches into a single, comprehensive system
2. **Standardized Parameter Workflow**: Create a consistent workflow for parameter planning and implementation
3. **Workflow-Specific Commands**: Create dedicated commands for each workflow type
4. **Knowledge Integration**: Integrate parameter system with fetch_rules knowledge access
5. **Automated Reference Management**: Fully automate parameter reference management
6. **Consistent Command Structure**: Standardize command syntax across all parameter operations

## Cross-System Optimization Opportunities

These optimization opportunities span multiple subsystems:

1. **Registry Unification**: Single source of truth for all parameters
2. **Command Streamlining**: Simplified, consistent command structure
3. **Workflow Integration**: Dedicated pathways for each workflow
4. **Knowledge Connection**: Direct knowledge access for parameter implementation
5. **Reference Automation**: Fully automated reference management
6. **Process Definition**: Clear planning → implementation → verification workflow 