# Domain Configuration

This document explains how domains are configured and managed within the 1000xsystems infrastructure. Domains are a fundamental organizational concept that allows the system to maintain a clear separation of concerns while remaining adaptable to different project structures.

## Domain Configuration File

The primary domain configuration is stored in:

```
1000xbrain/system/configuration/project-config.md
```

This file contains the "Domain Mappings" section, which defines all domains recognized by the system, their paths, and their roles within the project.

## Domain Mapping Structure

The domain mappings follow this structure:

```markdown
## Domain Mappings

| Domain Name | Path | Description | Active |
|-------------|------|-------------|--------|
| front-end   | /front-end | Primary user interface | true |
| back-end    | /back-end | API and server logic | true |
| mobile-app  | /mobile-app | Mobile application | false |
```

### Domain Mapping Fields

1. **Domain Name**: A unique identifier for the domain, used in system references
2. **Path**: The file system path to the domain's root directory (relative to project root)
3. **Description**: A brief description of the domain's purpose
4. **Active**: Boolean flag indicating whether the domain is currently active

## Domain Registration Process

When adding a new domain to the system, follow these steps:

1. Create the domain's directory structure following templates from `domain-templates.md`
2. Add the domain entry to the Domain Mappings table in `project-config.md`
3. Run the domain registration script to update all system references:

```powershell
./1000xscripts/register-domain.ps1 -DomainName "new-domain-name"
```

## Domain Path Resolution

The system resolves domain paths at runtime using the domain configuration. This allows for flexible domain structures and locations without requiring code changes throughout the system.

### Domain Path Resolution Methods

#### PowerShell Example

```powershell
function Get-DomainPath {
    param (
        [Parameter(Mandatory=$true)]
        [string]$DomainName
    )
    
    $projectConfig = Get-Content -Path "1000xbrain/system/configuration/project-config.md" -Raw
    
    # Extract domain mappings section
    if ($projectConfig -match "## Domain Mappings\s+\|\s*Domain Name\s*\|\s*Path\s*\|\s*Description\s*\|\s*Active\s*\|([\s\S]*?)(\n##|\z)") {
        $domainMappingsTable = $matches[1]
        
        # Extract the specific domain row
        $domainPattern = "\|\s*$DomainName\s*\|\s*([^|]+)\s*\|"
        if ($domainMappingsTable -match $domainPattern) {
            return $matches[1].Trim()
        }
    }
    
    throw "Domain '$DomainName' not found in project configuration"
}

# Usage example
$frontEndPath = Get-DomainPath -DomainName "front-end"
```

#### JavaScript Example

```javascript
const fs = require('fs');
const path = require('path');

function getDomainPath(domainName) {
  const projectConfig = fs.readFileSync(
    path.join(process.cwd(), '1000xbrain/system/configuration/project-config.md'),
    'utf8'
  );
  
  // Extract domain mappings section
  const domainMappingsMatch = projectConfig.match(
    /## Domain Mappings\s+\|\s*Domain Name\s*\|\s*Path\s*\|\s*Description\s*\|\s*Active\s*\|([\s\S]*?)(\n##|\z)/
  );
  
  if (!domainMappingsMatch) {
    throw new Error('Domain mappings section not found in project configuration');
  }
  
  const domainMappingsTable = domainMappingsMatch[1];
  
  // Extract the specific domain row
  const domainPattern = new RegExp(`\\|\\s*${domainName}\\s*\\|\\s*([^|]+)\\s*\\|`);
  const domainMatch = domainMappingsTable.match(domainPattern);
  
  if (!domainMatch) {
    throw new Error(`Domain '${domainName}' not found in project configuration`);
  }
  
  return domainMatch[1].trim();
}

// Usage example
const frontEndPath = getDomainPath('front-end');
```

## Domain Configuration Validation

The system includes validation to ensure domain configurations remain consistent:

```powershell
# validate-domains.ps1
function Test-DomainConfiguration {
    $projectConfig = Get-Content -Path "1000xbrain/system/configuration/project-config.md" -Raw
    
    # Extract domain mappings section
    if ($projectConfig -match "## Domain Mappings\s+\|\s*Domain Name\s*\|\s*Path\s*\|\s*Description\s*\|\s*Active\s*\|([\s\S]*?)(\n##|\z)") {
        $domainMappingsTable = $matches[1]
        
        # Parse domains
        $domainRows = $domainMappingsTable -split "\n" | Where-Object { $_ -match "\|\s*([^|]+)\s*\|\s*([^|]+)\s*\|" }
        
        foreach ($row in $domainRows) {
            if ($row -match "\|\s*([^|]+)\s*\|\s*([^|]+)\s*\|") {
                $domainName = $matches[1].Trim()
                $domainPath = $matches[2].Trim()
                
                # Skip header row
                if ($domainName -eq "Domain Name") {
                    continue
                }
                
                # Check if domain directory exists
                $fullPath = Join-Path -Path (Get-Location) -ChildPath $domainPath.TrimStart('/')
                if (-not (Test-Path -Path $fullPath -PathType Container)) {
                    Write-Warning "Domain '$domainName' path '$domainPath' does not exist at '$fullPath'"
                }
            }
        }
    } else {
        Write-Error "Domain mappings section not found in project configuration"
    }
}

Test-DomainConfiguration
```

## Domain Cross-References

To maintain domain independence, all cross-domain references should use the domain resolution system rather than hardcoded paths.

### Best Practices for Domain References

1. **Never use hardcoded paths** to reference other domains
2. **Always use domain resolution functions** to get domain paths
3. **Use relative paths within a domain**
4. **Track cross-domain dependencies** explicitly in documentation

### Example of Proper Domain Referencing

```javascript
// BAD: Hardcoded path
import { someUtility } from '../../../front-end/src/utils/helpers';

// GOOD: Using domain resolution
import { getDomainPath } from '1000xbrain/system/utils/domain-resolver';
import { someUtility } from `${getDomainPath('front-end')}/src/utils/helpers`;
```

## Domain Configuration Automation

The `1000xscripts` directory contains automation scripts for managing domains:

1. **register-domain.ps1**: Registers a new domain with the system
2. **remove-domain.ps1**: Safely removes a domain from the system
3. **update-domain.ps1**: Updates a domain's configuration
4. **validate-domains.ps1**: Validates all domain configurations

## Multi-Environment Domain Configuration

For projects with multiple environments (development, staging, production), domain configurations can be extended with environment-specific settings:

```markdown
## Environment-Specific Domain Mappings

### Development

| Domain Name | Path | Description | Active |
|-------------|------|-------------|--------|
| front-end   | /front-end-dev | Development UI | true |
| back-end    | /back-end-dev | Development API | true |

### Production

| Domain Name | Path | Description | Active |
|-------------|------|-------------|--------|
| front-end   | /front-end-prod | Production UI | true |
| back-end    | /back-end-prod | Production API | true |
```

## Domain Configuration Import/Export

To transfer domain configurations between projects or environments:

```powershell
# Export domain configuration
./1000xscripts/export-domain-config.ps1 -OutputPath "./domain-config-export.json"

# Import domain configuration
./1000xscripts/import-domain-config.ps1 -InputPath "./domain-config-export.json"
```

## Troubleshooting Domain Configuration

Common domain configuration issues and their solutions:

1. **Missing Domain Directory**
   - Issue: Domain path in configuration doesn't exist on filesystem
   - Solution: Create directory or update path in configuration

2. **Duplicate Domain Names**
   - Issue: Multiple domains with the same name
   - Solution: Ensure each domain has a unique name

3. **Circular Dependencies**
   - Issue: Domains reference each other creating circular dependencies
   - Solution: Refactor code to eliminate circular references

4. **Invalid Domain Paths**
   - Issue: Domain paths contain invalid characters or formats
   - Solution: Ensure paths follow platform-appropriate conventions

## Conclusion

Proper domain configuration is essential for maintaining a flexible, maintainable 1000xsystems infrastructure. By following the patterns and practices outlined in this document, you can ensure that your domains remain properly isolated yet accessible across the system. 