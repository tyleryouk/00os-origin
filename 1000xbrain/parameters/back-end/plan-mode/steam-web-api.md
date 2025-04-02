# workflow: back-end-workflow | pathway: steam-web-api | message-command: plan-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/back-end/plan-mode/steam-web-api.md

## Parameter Purpose

This parameter provides specialized planning guidance for Steam Web API integration in back-end components while in Planning Mode.

## Knowledge Access

For detailed planning guidance, access the following knowledge components:

```typescript
fetch_rules(["knowledge/back-end/steam-web-api/authentication"], 
           "Understanding Steam authentication implementation in back-end")

fetch_rules(["knowledge/back-end/steam-web-api/inventory"], 
           "Understanding Steam inventory API implementation")

fetch_rules(["knowledge/back-end/steam-web-api/market-data"], 
           "Understanding Steam market data API implementation")

fetch_rules(["knowledge/back-end/steam-web-api/trading"], 
           "Understanding Steam trading API implementation")
```

## Planning Documentation Structure

### Required Files

| File | Purpose | Special Focus |
|---|---|---|
| `README.md` | Provide planning overview | Steam Web API integration approach |
| `requirements.md` | Define integration requirements | Steam API-specific requirements |
| `implementation-progress.md` | Track implementation progress | Phase-by-phase tracking |
| `context-steam-api.md` | Document Steam API context | API capabilities and limitations |
| `context-integration-patterns.md` | Document integration patterns | Steam API integration patterns |
| `implementation-steam-api.md` | Plan implementation approach | Phased implementation plan |
| `test-cheatsheet.md` | Define testing approach | Steam API-specific testing |

**mandatory**
README.md must have this header at the top of the file:
# back-end-workflow | steam-web-api

### Implementation Progress Structure

The `implementation-progress.md` file should follow this structure:

```markdown
# Implementation Progress: Steam Web API Integration

## Phase Overview

### Phase 1: Authentication Implementation
- [ ] Steam OpenID authentication flow
  - [ ] Authentication endpoint creation
  - [ ] Session management implementation
  - [ ] User profile handling
- [ ] Security measures
  - [ ] Token validation
  - [ ] Session security
  - [ ] Error handling

### Phase 2: Inventory Integration
- [ ] Inventory retrieval system
  - [ ] SteamWebAPI.com integration
  - [ ] Data transformation
  - [ ] Caching implementation
- [ ] Inventory management
  - [ ] Refresh mechanism
  - [ ] Error handling
  - [ ] Rate limiting

### Phase 3: Market Data Integration
- [ ] Price data system
  - [ ] Market data retrieval
  - [ ] Historical tracking
  - [ ] Price analytics
- [ ] Market operations
  - [ ] Rate limit handling
  - [ ] Error management
  - [ ] Data validation

### Phase 4: Trading System
- [ ] Trade functionality
  - [ ] Offer creation
  - [ ] Security verification
  - [ ] Status tracking
- [ ] Trade management
  - [ ] History storage
  - [ ] Analytics
  - [ ] Error handling

## Current Status

### Completed Items
- [List of completed items with completion dates]

### In Progress
- [List of items currently being implemented]

### Blocked Items
- [List of blocked items with blocker description]

### Next Steps
- [List of next items to implement]

## Implementation Notes

### Authentication Progress Notes
- [Notes about authentication implementation]
- [Challenges encountered]
- [Solutions implemented]

### Inventory Progress Notes
- [Notes about inventory implementation]
- [Challenges encountered]
- [Solutions implemented]

### Market Data Progress Notes
- [Notes about market data implementation]
- [Challenges encountered]
- [Solutions implemented]

### Trading Progress Notes
- [Notes about trading implementation]
- [Challenges encountered]
- [Solutions implemented]

## Metrics

### Implementation Metrics
- Total completed items: [number]
- Items in progress: [number]
- Blocked items: [number]
- Completion percentage: [number]%

### Performance Metrics
- Authentication response time: [number]ms
- Inventory load time: [number]ms
- Market data refresh rate: [number]/minute
- Trading operation time: [number]ms

## Quality Gates

### Authentication Quality
- [ ] All security measures implemented
- [ ] Error handling comprehensive
- [ ] Session management robust
- [ ] Performance targets met

### Inventory Quality
- [ ] Data transformation accurate
- [ ] Caching effective
- [ ] Error handling comprehensive
- [ ] Rate limiting working

### Market Data Quality
- [ ] Price tracking accurate
- [ ] Historical data complete
- [ ] Analytics functioning
- [ ] Performance targets met

### Trading Quality
- [ ] Security measures complete
- [ ] Status tracking accurate
- [ ] History system working
- [ ] Error handling comprehensive
```

## Documentation Focus Areas

When planning the Steam Web API back-end integration, focus on:

1. **Architecture Design Documents**:
   - Service-based architecture diagram
   - Database schema design
   - Caching strategy documentation
   - API endpoint specification

2. **Security Documentation**:
   - Authentication flow security analysis
   - API key management strategy
   - CSRF protection implementation
   - Rate limiting and abuse prevention approach

3. **Performance Optimization**:
   - Caching strategy documentation
   - Database query optimization
   - Connection pooling configuration
   - Rate limit management approach

4. **Integration Patterns**:
   - SteamWebAPI.com integration patterns
   - Error handling and fallback strategies
   - Data transformation processes
   - Consistent response formatting

## Best Practices

1. **Requirements Documentation**:
   - Use clear, checkable requirements
   - Group by functional area
   - Include security requirements explicitly
   - Reference existing patterns when applicable

2. **Implementation Planning**:
   - Follow FastAPI best practices
   - Organize by component groups
   - Establish clear dependencies
   - Prioritize in logical sequence

3. **Testing Documentation**:
   - Create comprehensive test scenarios
   - Document error case handling
   - Include performance testing
   - Outline security testing approaches 