# rules-workflow | system-wide

Working on creating a pathway for the steam web api to enhance the integration of the steam web api into the GigaSwap marketplace. Retain 1000x development principles.

## Core Requirements

1. Create new pathway for front-end-workflow

Domains:
parameters\front-end\
knowledge\front-end\
workflows\front-end\

front-end | `steam-web-api` pathway for front-end includes the following project-rule-parameters:
parameters\front-end\dev-mode\steam-web-api.md
parameters\front-end\direct-mode\steam-web-api.md
parameters\front-end\plan-mode\steam-web-api.md

Create knowledge-base files in:
knowledge\front-end\steam-web-api\

Update Auto Attached brain-files in workflows\front-end\ as needed

2. Create new pathway for back-end-workflow
Domains
parameters\back-end\
knowledge\back-end\
workflows\back-end\

back-end | `steam-web-api` pathway for back-end includes the following project-rule-parameters:
parameters\back-end\dev-mode\steam-web-api.md
parameters\back-end\direct-mode\steam-web-api.md
parameters\back-end\plan-mode\steam-web-api.md

Create knowledge-base files in:
knowledge\back-end\steam-web-api\

There are no Auto Attached brain-files in workflows\back-end\ yet. Create minimal Auto Attached brain-files in Update Auto Attached brain-files in workflows\back-end\ as needed. 

3. Create new pathway within rules-workflow for enhancing the front-end | steam-web-api pathway.
rules-workflow | `front-end-steam-web-api` pathway for rules-workflow includes the following project-rule-parameters:
parameters\rules\dev-mode\front-end-steam-web-api.md
parameters\rules\direct-mode\front-end-steam-web-api.md
parameters\rules\plan-mode\front-end-steam-web-api.md

Create knowledge-base files in:
knowledge\rules\front-end-steam-web-api\

4. Create new pathway within rules-workflow for enhancing the back-end | steam-web-api pathway.
rules-workflow | `back-end-steam-web-api` pathway for rules-workflow includes the following project-rule-parameters:
parameters\rules\dev-mode\back-end-steam-web-api.md
parameters\rules\direct-mode\back-end-steam-web-api.md
parameters\rules\plan-mode\back-end-steam-web-api.md

Create knowledge-base files in:
knowledge\rules\back-end-steam-web-api\

## Technical Context

### API Selection and Integration

- **Primary API Service**: Use SteamWebAPI.com as the primary API service as it's specifically designed for CS2 skin trading
- **Authentication Mechanism**: Implement Steam OpenID authentication for user login and inventory access
- **API Key Management**: Securely store and manage the existing API key (LITUJ4KSYS7D1QC0)
- **Rate Limit Handling**: Implement rate limiting mechanisms to stay within the free/starter plan limits initially
- **Error Handling**: Design comprehensive error handling across all Steam API interactions

### Architecture Requirements

- **Front-End Integration**: Extend existing CS2 marketplace components to use real Steam data instead of mock data
- **Back-End Proxy**: Create proxy endpoints for all Steam API calls to enhance security and add caching
- **Caching Strategy**: Implement multi-level caching with appropriate timeframes for different data types
- **Security Measures**: Implement proper authentication token handling and secure trading protocols
- **Cross-System Patterns**: Apply the defined cross-system patterns consistently across all components

## Implementation Guidelines

### Code Standards

- **TypeScript Standards**: Follow existing TypeScript patterns in the front-end codebase
- **Python/FastAPI Standards**: Implement back-end components following FastAPI best practices
- **Error Handling**: Use consistent error handling patterns across all components
- **Logging**: Leverage the existing logging system with CS2-specific logging methods
- **Testing**: Create comprehensive tests for all Steam API integration points

### Integration Points

- **CS2Gun Model**: Extend the existing CS2Gun model to fully support real Steam inventory data
- **API Endpoint Structure**: Follow RESTful API design principles for all new endpoints
- **Authentication Flow**: Integrate with the existing authentication system
- **UI Components**: Enhance existing CS2 marketplace UI components to display real Steam data
- **Caching Mechanisms**: Utilize appropriate caching strategies for different data types

## Acceptance Criteria

1. **Authentication**
   - Users can successfully authenticate with their Steam accounts
   - Authentication tokens are securely stored and managed
   - Session persistence works correctly across page reloads

2. **Inventory Integration**
   - Users' CS2 inventories are displayed correctly
   - Inventory data is properly cached for performance
   - Inventory updates are reflected in the UI

3. **Market Data**
   - Market prices are displayed for all items
   - Historical price data is available and visualized
   - Price updates occur at appropriate intervals

4. **Trading Functionality**
   - Users can create trade offers
   - Security verification is properly implemented
   - Trade history is tracked and displayed

5. **Cognitive Architecture**
   - All knowledge components are properly accessible
   - Parameter files function correctly with message-commands
   - Workflows are properly attached based on file patterns

## Risk Assessment

### API Limitations

- **Rate Limits**: Free tier initially limits to 10 requests/minute, may require upgrades
- **Service Reliability**: Third-party service may have outages requiring fallback strategies
- **API Changes**: Future API changes could require maintenance updates

### Implementation Challenges

- **Back-End Creation**: Back-end workflow is not currently implemented and requires full setup
- **Authentication Complexity**: Steam OpenID implementation may have security edge cases
- **Data Synchronization**: Keeping inventory data in sync requires careful implementation
- **Performance Concerns**: Real API calls may be slower than mock data, requiring optimization

### Mitigation Strategies

- **Caching Layer**: Implement comprehensive caching to reduce API calls
- **Fallback Data**: Create fallback mechanism using cached data if API is unavailable
- **Progressive Enhancement**: Implement features incrementally starting with most critical
- **Comprehensive Testing**: Create thorough test suite for all integration points

**Important context**
Every project-rule-parameter must have the following header:
# workflow: [workflow-type] | pathway: [pathway-name] | message-command: [message-command] | standard-parameter(s): [standard-parameter] | project-rule-parameter-filepath: [project-rule-parameter-filepath]

Every knowledge-base file must have the following header:
# USE WHEN [description-of-file]