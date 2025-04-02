# Alias-Based Parameter Management System

This directory contains scripts for managing project-rule-parameters used in the 1000xbrain cognitive architecture using an alias-based approach. This system eliminates the need to manually update file paths in references when parameters are moved or renamed.

## Key Features

1. **Alias-Based References**:
   - `@alias:workflow:parameter-name` instead of direct file paths
   - Workflow namespacing for parameter isolation
   - Complete path independence

2. **Centralized Management**:
   - Single registry for all parameters
   - Automatic reference updating
   - Cross-workflow support

3. **Usability Improvements**:
   - Shorter, more readable references
   - Clear parameter ownership
   - Consistent documentation

## Registry File

The registry file (`alias-registry.json`) serves as the central repository for all parameter metadata. It is structured as follows:

```json
{
  "schemaVersion": "1.0",
  "lastUpdated": "2023-04-01T12:00:00Z",
  "aliases": {
    "rules": {
      "parameter-name": {
        "path": "parameters/rules/category/parameter-name.md",
        "mdcPath": "parameters/rules/category/parameter-name.mdc",
        "description": "Parameter description",
        "category": "category",
        "messageCommand": "message-command",
        "standardParameters": ["param1", "param2"],
        "usageExamples": [
          "message-command: workflow-type @alias:rules:parameter-name"
        ],
        "relatedParameters": ["related-parameter-name"]
      }
    }
  }
}
```

**⚠️ Do not edit the registry file directly. Use the parameter management scripts instead.**

## Management Scripts

### Register-ParameterAlias.ps1

Adds a new parameter alias to the registry.

```powershell
./Register-ParameterAlias.ps1 -Workflow "rules" -Name "parameter-name" -Path "parameters/rules/category/parameter-name.md" -Description "Parameter description" -Category "category" -MessageCommand "message-command" -StandardParameters "param1","param2"
```

### Remove-ParameterAlias.ps1

Removes a parameter alias from the registry.

```powershell
./Remove-ParameterAlias.ps1 -Workflow "rules" -Name "parameter-name"
```

### Update-ParameterAlias.ps1

Updates an existing parameter alias in the registry.

```powershell
./Update-ParameterAlias.ps1 -Workflow "rules" -Name "parameter-name" -Description "Updated description"
```

### Verify-AliasRegistry.ps1

Verifies the integrity of the alias registry and references.

```powershell
./Verify-AliasRegistry.ps1
```

### Convert-ToAliasReferences.ps1

Converts old file path references to the new alias format.

```powershell
./Convert-ToAliasReferences.ps1
```

### Update-AliasReferences.ps1

Updates references to aliases in the codebase.

```powershell
./Update-AliasReferences.ps1 -Workflow "rules" -Name "parameter-name" -Action "update"
```

### Update-AliasDocumentation.ps1

Generates documentation from the alias registry.

```powershell
./Update-AliasDocumentation.ps1 -Workflow "rules"
```

### Resolve-AliasReference.ps1

Resolves an alias reference to its actual file path.

```powershell
./Resolve-AliasReference.ps1 -AliasReference "@alias:rules:parameter-name"
```

## Simplified Management with Manage-AllParameters.ps1

For ease of use, you can use the `Manage-AllParameters.ps1` script to perform all operations:

```powershell
# Add a parameter
./Manage-AllParameters.ps1 -Operation add -Workflow "rules" -Name "parameter-name" -Path "parameters/rules/category/parameter-name.md" -Description "Parameter description" -Category "category" -MessageCommand "message-command"

# Remove a parameter
./Manage-AllParameters.ps1 -Operation remove -Workflow "rules" -Name "parameter-name"

# Update a parameter
./Manage-AllParameters.ps1 -Operation update -Workflow "rules" -Name "parameter-name" -Description "Updated description"

# List all parameters
./Manage-AllParameters.ps1 -Operation list

# List parameters in a specific workflow
./Manage-AllParameters.ps1 -Operation list -Workflow "rules"

# Show details for a specific parameter
./Manage-AllParameters.ps1 -Operation list -Workflow "rules" -Name "parameter-name"

# Verify registry integrity
./Manage-AllParameters.ps1 -Operation verify

# Convert old references to alias format
./Manage-AllParameters.ps1 -Operation convert-refs
```

## Using the Message-Command System

To manage parameters through message-commands, use the `manage-parameters` command:

```
manage-parameters: add workflow="rules" name="parameter-name" path="parameters/rules/category/parameter-name.md" description="Parameter description" category="category" message-command="message-command"
```

```
manage-parameters: remove workflow="rules" name="parameter-name"
```

```
manage-parameters: update workflow="rules" name="parameter-name" description="Updated description"
```

```
manage-parameters: verify
```

```
manage-parameters: convert-refs
```

## Advantages of Alias Format

1. **Path Independence**:
   - References use aliases instead of file paths
   - Even if files move, aliases remain valid
   - No need to manually update references

2. **Workflow Isolation**:
   - Clear workflow namespacing prevents confusion
   - Parameters with the same name in different workflows don't conflict
   - Makes it obvious which workflow a parameter belongs to

3. **Automatic Reference Management**:
   - Aliases are automatically resolved to current paths
   - References are automatically updated across all files
   - No manual grep/search needed to update references

4. **Migration Path**:
   - Automatic conversion of old references to new alias format
   - Backward compatibility with existing file paths
   - Gradual adoption without breaking existing code

## Important Notes

1. All parameters must have corresponding files in the 1000xbrain directory
2. All parameter references should use the alias format: `@alias:workflow:parameter-name`
3. Always use the management system instead of manually editing parameter files
4. Run verification regularly to ensure all references are valid and consistent 