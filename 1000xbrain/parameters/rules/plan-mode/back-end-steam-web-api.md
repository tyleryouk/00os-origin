# workflow: rules-workflow | pathway: back-end-steam-web-api | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/plan-mode/back-end-steam-web-api.md

## Parameter Purpose

This parameter provides specialized guidance for planning enhancements to the Steam Web API integration in back-end components of GigaSwap. It focuses on creating comprehensive documentation for back-end Steam integration pathways.

## Usage Context

Use this parameter when planning enhancements to:
- Steam OpenID authentication endpoints
- CS2 inventory management APIs
- Steam trading functionality in the back-end
- Market data aggregation from Steam sources
- Proxy API implementation for SteamWebAPI.com

## Planning Guidelines

### Documentation Structure

Create the following documentation files for back-end Steam integration:

1. **Requirements Document**:
   ```markdown
   # Back-End Steam Integration Requirements

   ## Authentication Requirements
   - Implement Steam OpenID authentication
   - Support session management for Steam users
   - Store and validate authentication tokens

   ## API Integration Requirements
   - Create proxy endpoints for all SteamWebAPI.com calls
   - Implement rate limiting to stay within plan limits
   - Build caching layer for high-traffic endpoints

   ## Security Requirements
   - Implement proper Steam Guard verification
   - Securely handle API keys and tokens
   - Create proper validation for all Steam-related inputs

   ## Data Requirements
   - Design models for Steam inventory items
   - Create structures for market data storage
   - Implement historical price tracking
   ```

2. **Implementation Plan**:
   ```markdown
   # Back-End Steam Integration Implementation Plan

   ## Authentication Implementation
   1. Create Steam OpenID authentication endpoints
   2. Implement session management for Steam users
   3. Store and validate authentication tokens

   ## API Implementation
   1. Create proxy endpoints for SteamWebAPI.com
   2. Implement rate limiting middleware
   3. Build multi-level caching system

   ## Security Implementation
   1. Implement Steam Guard verification
   2. Create secure API key management
   3. Build input validation for all Steam endpoints

   ## Data Implementation
   1. Build Steam inventory item models
   2. Create market data structures
   3. Implement price history tracking
   ```

### Planning Considerations

When planning back-end Steam integration, consider:

1. **Rate Limiting**:
   - Free tier initially limits to 10 requests/minute
   - Need to implement client-side throttling
   - Consider caching strategy to minimize API calls

2. **Authentication Complexity**:
   - OpenID implementation requires multiple endpoints
   - Proper session management is critical
   - Token storage requires security considerations

3. **Proxy Design**:
   - All Steam API calls should go through back-end proxy
   - Proxy adds caching, rate limiting, and error handling
   - Consistent error handling pattern across all endpoints

## Knowledge Access

For detailed implementation guidance, access these knowledge components:

```typescript
fetch_rules(["knowledge/back-end/steam-web-api/authentication"], 
           "Understanding Steam authentication implementation for back-end")

fetch_rules(["knowledge/back-end/steam-web-api/market-data"], 
           "Understanding Steam market data handling for back-end")

fetch_rules(["knowledge/rules/back-end-steam-web-api/best-practices"], 
           "Understanding best practices for Steam integration in back-end")
```

## Documentation Enhancement

The following documentation should be created or enhanced:

1. **Back-End API Documentation**:
   - Document all Steam-related endpoints
   - Include authentication flow documentation
   - Document rate limiting considerations
   - Include error handling patterns

2. **Integration Documentation**:
   - Document interaction between front-end and back-end
   - Specify API contracts and data models
   - Document error scenarios and handling
   - Include performance considerations

## Success Criteria

Planning documentation will be considered complete when:

1. **Comprehensive Coverage**:
   - All Steam API integration points are documented
   - Authentication flow is completely specified
   - Security considerations are thoroughly addressed
   - Data models are completely defined

2. **Implementation Guidance**:
   - Step-by-step implementation approach is provided
   - Technical requirements are clearly specified
   - Integration points with front-end are well-defined
   - Error handling approaches are documented 