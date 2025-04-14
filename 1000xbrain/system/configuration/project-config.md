# Project Configuration

This file serves as the central configuration for the entire 1000xsystems infrastructure. It defines the active domains, their locations, and critical system parameters.

## Domain Mappings

| Domain Name | Path | Description | Active |
|-------------|------|-------------|--------|
| front-end | /front-end | Primary user interface | true |
| back-end | /back-end | API and server logic | true |
| 1000xbrain | /1000xbrain | System knowledge base and cognitive architecture | true |
| 1000xrules | /1000xrules | System rules and constraints | true |
| 1000xplans | /1000xplans | Project planning documents | true |
| 1000xscripts | /1000xscripts | System automation scripts | true |

## System Parameters

| Parameter Name | Value | Description |
|----------------|-------|-------------|
| project_name | GigaSwap | The name of the current project |
| project_root | ./ | The root directory of the project |
| default_domain | front-end | The default domain for operations |
| system_version | 1.0.0 | Current version of the 1000xsystems infrastructure |

## Environment Configuration

| Parameter Name | Development | Staging | Production |
|----------------|-------------|---------|------------|
| api_endpoint | http://localhost:3000/api | https://staging-api.example.com | https://api.example.com |
| debug_mode | true | false | false |
| log_level | verbose | info | warning |

## Build Configuration

| Domain | Build Command | Output Directory | CI Pipeline |
|--------|--------------|------------------|------------|
| front-end | npm run build | /dist | front-end-pipeline |
| back-end | npm run build | /build | back-end-pipeline |

## Integration Points

| Service Name | Endpoint | Authentication Method | Active |
|--------------|----------|----------------------|--------|
| database | mongodb://localhost:27017 | environment | true |
| storage | s3://project-bucket | iam-role | true |
| auth_service | https://auth.example.com | oauth2 | true |

## Custom Scripts

| Script Name | Path | Description | Trigger |
|-------------|------|-------------|---------|
| domain-sync | /1000xscripts/domain-sync.ps1 | Synchronizes domain configurations | Manual |
| backup | /1000xscripts/backup.ps1 | Creates system backup | Daily |
| health-check | /1000xscripts/health-check.ps1 | Validates system health | Hourly |

## Required Tools

| Tool Name | Version | Installation Command | Required |
|-----------|---------|----------------------|----------|
| node | >=14.0.0 | `winget install OpenJS.NodeJS` | true |
| powershell | >=7.0.0 | `winget install Microsoft.PowerShell` | true |
| git | >=2.30.0 | `winget install Git.Git` | true |

## System Extensions

| Extension Name | Path | Description | Active |
|----------------|------|-------------|--------|
| code-generator | /1000xextensions/code-generator | Automated code generation | true |
| documentation | /1000xextensions/documentation | Documentation tools | true |
| analyzer | /1000xextensions/analyzer | Code analysis tools | false |

## Notes

- All paths should be relative to the project root
- Configuration changes should be tracked in version control
- Environment-specific values should be overridden by `.env` files
- Use `1000xscripts/validate-config.ps1` to validate configuration changes 