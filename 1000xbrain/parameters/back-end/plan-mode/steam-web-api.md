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

### Requirements Template

```markdown
# Steam Web API Back-End Integration Requirements

## Authentication Requirements

- [ ] Steam OpenID authentication flow implementation
- [ ] User creation/retrieval based on Steam ID
- [ ] Session management with secure tokens
- [ ] User profile data handling
- [ ] Secure logout functionality

## Inventory Requirements

- [ ] Steam inventory retrieval via SteamWebAPI.com
- [ ] Inventory data transformation and normalization
- [ ] Caching mechanism for inventory data
- [ ] Inventory refresh functionality
- [ ] Privacy settings handling

## Market Data Requirements

- [ ] Price data retrieval from SteamWebAPI.com
- [ ] Historical price data tracking
- [ ] Market trend analysis calculations
- [ ] Price alert functionality
- [ ] Rate limit handling and optimization

## Trading Requirements

- [ ] Trade offer creation and validation
- [ ] Security verification for trades
- [ ] Trade status tracking
- [ ] Trade history storage and retrieval
- [ ] Trade analytics

## Security Requirements

- [ ] Secure API key management
- [ ] Session token security
- [ ] CSRF protection implementation
- [ ] Rate limiting and abuse prevention
- [ ] Data validation and sanitization
```

### Implementation Template

```markdown
# Steam Web API Back-End Integration Implementation Plan

## File Structure

### Authentication Components
- `back-end/app/routes/auth/steam.py`
- `back-end/app/services/steam_auth.py`
- `back-end/app/services/session_service.py`
- `back-end/app/models/user.py`
- `back-end/app/models/session.py`
- `back-end/app/db/repositories/user_repository.py`
- `back-end/app/db/repositories/session_repository.py`

### Inventory Components
- `back-end/app/routes/inventory/steam.py`
- `back-end/app/services/steam_inventory_service.py`
- `back-end/app/models/inventory.py`
- `back-end/app/db/repositories/inventory_repository.py`

### Market Data Components
- `back-end/app/routes/market/steam.py`
- `back-end/app/services/steam_market_service.py`
- `back-end/app/models/market.py`
- `back-end/app/db/repositories/market_repository.py`

### Trading Components
- `back-end/app/routes/trading/steam.py`
- `back-end/app/services/steam_trading_service.py`
- `back-end/app/models/trade.py`
- `back-end/app/db/repositories/trade_repository.py`

### Core Components
- `back-end/app/core/config.py`
- `back-end/app/core/cache.py`
- `back-end/app/core/security.py`
- `back-end/app/core/logger.py`

## Database Schema Updates

```sql
-- Users Table Extension
ALTER TABLE users ADD COLUMN steam_id VARCHAR(32) UNIQUE;
ALTER TABLE users ADD COLUMN steam_profile_url VARCHAR(255);
ALTER TABLE users ADD COLUMN steam_avatar_url VARCHAR(255);
ALTER TABLE users ADD COLUMN steam_trade_url VARCHAR(255);

-- Sessions Table
CREATE TABLE sessions (
    id SERIAL PRIMARY KEY,
    token VARCHAR(64) UNIQUE NOT NULL,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    auth_type VARCHAR(16) NOT NULL,
    expires_at BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inventory Items Table
CREATE TABLE inventory_items (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    asset_id VARCHAR(32) UNIQUE NOT NULL,
    market_hash_name VARCHAR(255) NOT NULL,
    icon_url TEXT,
    wear_value FLOAT,
    pattern_index INTEGER,
    is_stattrak BOOLEAN DEFAULT FALSE,
    tradable BOOLEAN DEFAULT TRUE,
    marketable BOOLEAN DEFAULT TRUE,
    price FLOAT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trades Table
CREATE TABLE trades (
    id SERIAL PRIMARY KEY,
    trade_id VARCHAR(32) UNIQUE NOT NULL,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    partner_steam_id VARCHAR(32) NOT NULL,
    status VARCHAR(16) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Implementation Sequence

1. **Core and Authentication Module**
   - Set up environment configuration with Steam API settings
   - Implement Steam OpenID authentication flow
   - Create user and session models and repositories
   - Implement session management system
   - Create authentication routes

2. **Inventory Module**
   - Implement SteamWebAPI.com inventory integration
   - Create inventory models and repositories
   - Implement caching system for inventory data
   - Develop inventory transformation logic
   - Create inventory routes

3. **Market Data Module**
   - Implement SteamWebAPI.com market data integration
   - Create market models and repositories
   - Implement price history tracking
   - Develop market trend analysis
   - Create market routes

4. **Trading Module**
   - Implement trade creation and validation
   - Create trade models and repositories
   - Implement trade status tracking
   - Develop trade history functionality
   - Create trading routes

## Technology Stack

- **FastAPI**: Core back-end framework
- **PostgreSQL**: Database for persistent storage
- **SQLAlchemy**: ORM for database operations
- **Pydantic**: Data validation and serialization
- **aiohttp**: Async HTTP client for API calls
- **Redis**: Optional cache for performance optimization
```

## Test Cheatsheet Template

```markdown
# Steam Web API Back-End Testing Scenarios

## Authentication Testing

1. **OpenID Authentication Flow**
   - Initiate Steam login process
   - Test OpenID validation logic
   - Verify user creation/retrieval
   - Confirm session creation
   - Test authentication status endpoint

2. **Session Management**
   - Create test session
   - Verify session validation
   - Test session expiration
   - Validate session cookie handling
   - Test logout functionality

3. **Error Handling**
   - Test invalid authentication response
   - Verify handling of missing parameters
   - Test OpenID validation failures
   - Validate error response format
   - Verify logging of authentication errors

## Inventory Testing

1. **Inventory Retrieval**
   - Test inventory endpoint with valid user
   - Verify unauthorized access handling
   - Test refresh parameter functionality
   - Validate transformed inventory data
   - Verify error handling

2. **Caching Behavior**
   - Test initial inventory load time
   - Verify subsequent requests use cache
   - Test cache invalidation with refresh
   - Measure performance improvement with caching
   - Validate cache key generation

## Market Data Testing

1. **Price Data Retrieval**
   - Test price data endpoints
   - Verify price history functionality
   - Validate market trend calculations
   - Test rate limit handling
   - Verify error responses

2. **Data Consistency**
   - Compare data across multiple requests
   - Verify normalization consistency
   - Test edge cases with unusual price patterns
   - Validate historical data storage
   - Check data synchronization

## Trading Testing

1. **Trade Creation**
   - Test trade offer creation
   - Verify validation logic
   - Test security verification
   - Validate required fields
   - Verify error handling

2. **Trade Status Tracking**
   - Create sample trade
   - Test status update functionality
   - Verify history recording
   - Validate notification system
   - Test edge cases for failed trades
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