# Steam Web API Workflow for Back-End

## Overview

This workflow provides specialized behavior for back-end components that interact with the Steam Web API, extending the base back-end workflow with Steam-specific patterns. It encompasses authentication, inventory management, market data handling, and trading system integration.

## Workflow Activation

This workflow is automatically attached whenever working with any file in the `back-end/` directory. It extends the base back-end workflow with Steam Web API-specific patterns and guidance for Steam-related components.

## Behavior Specialization

This workflow specializes behavior for Steam Web API integration by:

1. **Authentication Patterns**:
   - Steam OpenID authentication flows
   - Security token handling for Steam users
   - Secure session management patterns
   - User profile data storage and retrieval
   - API key security management

2. **Inventory Patterns**:
   - Steam inventory data fetching and caching
   - CS2 skin data transformation patterns
   - Inventory privacy handling
   - Inventory data validation and normalization
   - Inventory change detection

3. **Market Data Patterns**:
   - Price data aggregation patterns
   - Historical price tracking
   - Market trend analysis
   - Exchange rate conversion
   - Real-time market updates

4. **Trading Patterns**:
   - Trade offer creation and validation
   - Trade status tracking and management
   - Trade history storage and retrieval
   - Secure trade verification patterns
   - Escrow system integration

## Integration Architecture

The Steam Web API integration follows this layered architecture:

1. **API Client Layer**:
   - Handles direct communication with Steam Web API
   - Implements proper rate limiting
   - Manages authentication headers
   - Handles retry logic
   - Monitors API health

2. **Service Layer**:
   - Transforms API responses to domain models
   - Implements business logic
   - Handles caching strategies
   - Manages error scenarios
   - Coordinates multi-step operations

3. **Controller Layer**:
   - Exposes Steam functionalities via FastAPI endpoints
   - Handles request validation
   - Manages authentication/authorization
   - Implements proper error responses
   - Provides OpenAPI documentation

4. **Background Processing Layer**:
   - Handles long-running Steam operations
   - Implements polling for trade status
   - Manages market data synchronization
   - Processes inventory updates
   - Executes scheduled tasks

## Related Parameters

This workflow integrates with the following parameter files:

- **Plan Mode**: `parameters/back-end/plan-mode/steam-web-api.md`
- **Dev Mode**: `parameters/back-end/dev-mode/steam-web-api.md`
- **Direct Mode**: `parameters/back-end/direct-mode/steam-web-api.md`

## Knowledge Integration

This workflow references the following knowledge components:

- **Authentication**: `knowledge/back-end/steam-web-api/authentication.md`
- **Inventory**: `knowledge/back-end/steam-web-api/inventory.md`
- **Market Data**: `knowledge/back-end/steam-web-api/market-data.md`
- **Trading**: `knowledge/back-end/steam-web-api/trading.md`
- **Security**: `knowledge/back-end/steam-web-api/security.md`
- **Data Caching**: `knowledge/back-end/steam-web-api/data-caching.md`

## Integration with Other Workflows

1. **Authentication Workflow Integration**:
   - Extends `workflows/back-end/authentication.md` with Steam-specific authentication
   - Implements Steam OpenID Connect patterns
   - Manages Steam user identity in the system
   - Handles Steam session security

2. **Caching Workflow Integration**:
   - Extends `workflows/back-end/caching.md` with Steam-specific caching strategies
   - Implements adaptive TTL for different Steam data types
   - Uses Redis for Steam inventory and market data
   - Handles cache invalidation for Steam events

3. **Database Workflow Integration**:
   - Extends `workflows/back-end/database.md` with Steam data modeling
   - Implements Steam-specific database schemas
   - Manages Steam item historical data
   - Optimizes queries for Steam-related operations

## Quality Requirements

Steam Web API features must meet these quality gates:

1. **Test Coverage**: 90% minimum coverage
2. **Code Quality**: 8.5/10 minimum Pylint score
3. **Security**: Pass all Bandit security checks and Steam-specific security tests
4. **Performance**: Pass Steam-specific performance benchmarks
5. **Reliability**: Handle Steam API outages gracefully

## Implementation Guidelines

1. **API Integration**:
   - Use aiohttp for async HTTP requests to Steam API
   - Implement proper rate limiting with exponential backoff
   - Handle Steam-specific error codes and responses
   - Cache responses with appropriate TTL
   - Log all Steam API interactions for debugging

2. **Error Handling**:
   - Handle Steam API rate limits with retry logic
   - Manage authentication failures with proper user feedback
   - Process API-specific errors with fallback mechanisms
   - Implement comprehensive logging for Steam operations
   - Provide degraded functionality during Steam outages

3. **Data Management**:
   - Cache Steam inventory data with appropriate invalidation
   - Transform API responses to consistent internal formats
   - Validate Steam data formats before processing
   - Handle data privacy requirements for Steam user data
   - Implement data consistency checks

4. **Security Practices**:
   - Never expose Steam API keys in client-side code
   - Implement proper API key rotation
   - Validate all Steam authentication tokens
   - Secure Steam trade URLs and offers
   - Monitor for suspicious Steam trading patterns

## Steam API Rate Limiting Strategy

1. **Client-Side Rate Limiting**:
   - Implement token bucket algorithm
   - Configure appropriate rate windows
   - Track rate limits per endpoint
   - Implement backoff strategies

2. **Response Handling**:
   - Parse Steam rate limit headers
   - Adjust request timing dynamically
   - Queue non-urgent requests
   - Prioritize critical operations

3. **Error Recovery**:
   - Detect rate limit errors (429 responses)
   - Implement exponential backoff
   - Retry with jitter
   - Fall back to cached data when appropriate

4. **Monitoring**:
   - Track API quota consumption
   - Alert on approaching limits
   - Log rate limit events
   - Monitor Steam API status 