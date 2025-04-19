# Steam Web API Integration: Consolidated Backend Context

## Architecture Overview

The Steam Web API integration follows a layered architecture pattern within the GigaSwap backend:

```
back-end/
  └── app/
      └── steam/                 # Root directory for Steam integration backend code
          ├── client.py              # Base SteamWebAPIClient
          ├── exceptions.py          # Custom exception classes
          ├── cache.py               # Redis caching implementation
          ├── models/                # Data models 
          │   ├── __init__.py
          │   ├── item.py            # Item models
          │   ├── inventory.py       # Inventory models
          │   └── trade.py           # Trade models
          ├── services/              # Service modules
          │   ├── __init__.py
          │   ├── items.py           # ItemsClient
          │   ├── inventory.py       # InventoryClient
          │   └── trades.py          # TradesClient
          ├── routes/                # API routes
          │   ├── __init__.py
          │   ├── item_routes.py     # Item-related endpoints
          │   ├── inventory_routes.py # Inventory-related endpoints
          │   └── trade_routes.py    # Trade-related endpoints
          └── __init__.py
```

### Layered Architecture

1. **Base Client Layer**: Handles HTTP communication with the Steam Web API
2. **Models Layer**: Defines Pydantic models for request/response validation
3. **Service Layer**: Contains business logic for different Steam API areas
4. **Caching Layer**: Implements Redis-based caching for performance and rate limiting
5. **API Routes Layer**: Exposes REST endpoints for frontend consumption

## Key Components

### SteamWebAPIClient

The core client that handles all communication with the Steam Web API:

```python
class SteamWebAPIClient:
    def __init__(self, api_key, base_url="https://steamwebapi.com"):
        self.api_key = api_key
        self.base_url = base_url
        self.session = self._create_session()
        self.logger = self._setup_logger()
        
    def _create_session(self):
        session = requests.Session()
        session.headers.update({
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json",
            "Accept": "application/json"
        })
        return session
        
    async def _request(self, method, endpoint, params=None, data=None, **kwargs):
        """Make a request to the Steam Web API with error handling and retries"""
        # Implementation with proper error handling, logging, and retries
        # Includes:
        # - Rate limit detection
        # - Retry mechanism with exponential backoff
        # - Comprehensive logging
        # - Error transformation to custom exceptions
```

### Exception Hierarchy

Custom exceptions for error handling:

```python
class SteamAPIException(Exception):
    """Base exception for all Steam API errors"""
    pass

class SteamAPIAuthError(SteamAPIException):
    """Authentication errors (401, 403)"""
    pass

class SteamAPIRateLimitError(SteamAPIException):
    """Rate limit exceeded errors (429)"""
    pass

class SteamAPITimeoutError(SteamAPIException):
    """Timeout errors"""
    pass

class SteamAPIServerError(SteamAPIException):
    """Server errors (5xx)"""
    pass

class SteamAPIClientError(SteamAPIException):
    """Client errors (4xx not covered by other exceptions)"""
    pass

class SteamAPIDataError(SteamAPIException):
    """Data validation or parsing errors"""
    pass
```

### Service Clients

#### ItemsClient

Handles CS2 item data retrieval and processing:

```python
class ItemsClient:
    def __init__(self, client):
        self.client = client
        self.cache = RedisCache(prefix="steam:items:", ttl=3600)
        
    async def get_market_items(self, game="cs2", search=None, price_min=None, 
                               price_max=None, page=1, limit=20):
        """Get market items with filtering options"""
        # Implementation with caching and error handling
        
    async def get_item_info(self, item_id=None, market_hash_name=None):
        """Get detailed information about a specific item"""
        # Implementation with caching and error handling
        
    async def get_item_price_history(self, market_hash_name, days=30):
        """Get price history for an item"""
        # Implementation with caching and error handling
```

#### InventoryClient

Manages Steam inventory access:

```python
class InventoryClient:
    def __init__(self, client):
        self.client = client
        self.cache = RedisCache(prefix="steam:inventory:", ttl=1800)
        
    async def get_user_inventory(self, steam_id, game="cs2", parse=True):
        """Get a user's Steam inventory"""
        # Implementation with caching and error handling
        
    async def get_inventory_privacy(self, steam_id):
        """Check if a user's inventory is public or private"""
        # Implementation with caching and error handling
        
    async def get_trade_eligibility(self, steam_id):
        """Check if a user is eligible for trading"""
        # Implementation with caching and error handling
```

#### TradeClient

Handles Steam trade offer creation and management:

```python
class TradeClient:
    def __init__(self, client):
        self.client = client
        self.cache = RedisCache(prefix="steam:trade:", ttl=300)
        
    async def create_trade_offer(self, request):
        """Create a new trade offer"""
        # Implementation with proper error handling
        
    async def accept_trade_offer(self, request):
        """Accept a trade offer"""
        # Implementation with proper error handling
        
    async def get_trade_offers(self, steam_login_secure, sent_only=False, received_only=False):
        """Get active trade offers"""
        # Implementation with caching and error handling
        
    async def get_trade_history(self, request):
        """Get trade history"""
        # Implementation with caching and error handling
        
    async def cancel_trade_offer(self, request):
        """Cancel a sent trade offer"""
        # Implementation with proper error handling
        
    async def decline_trade_offer(self, request):
        """Decline a received trade offer"""
        # Implementation with proper error handling
```

## Caching Strategy

Redis-based caching is implemented throughout the Steam integration to improve performance and reduce API calls:

| Data Type | TTL | Cache Key Pattern | Rationale |
|-----------|-----|-------------------|-----------|
| Market Items | 3600s (1 hour) | `steam:items:market:{game}:{query_hash}` | Market data changes infrequently |
| Item Details | 7200s (2 hours) | `steam:items:detail:{item_id}` | Item details rarely change |
| Price History | 14400s (4 hours) | `steam:items:history:{market_hash_name}:{days}` | Historical data is static |
| User Inventory | 1800s (30 min) | `steam:inventory:{steam_id}:{game}` | Inventory can change, balance with API calls |
| Inventory Privacy | 3600s (1 hour) | `steam:inventory:privacy:{steam_id}` | Privacy settings change infrequently |
| Trade Offers | 300s (5 min) | `steam:trade:offers:{steam_id}` | Active trade offers can change frequently |
| Trade History | 3600s (1 hour) | `steam:trade:history:{steam_id}` | Completed trades don't change |

## API Endpoints

The integration exposes the following REST endpoints:

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/steam/items` | GET | List market items with filtering |
| `/api/steam/items/{item_id}` | GET | Get detailed item information |
| `/api/steam/items/prices/{market_hash_name}` | GET | Get item price history |
| `/api/steam/inventory/{steam_id}` | GET | Get user inventory |
| `/api/steam/inventory/{steam_id}/privacy` | GET | Get inventory privacy status |
| `/api/steam/inventory/{steam_id}/eligibility` | GET | Check trade eligibility |
| `/api/steam/trades/{steam_id}` | GET | List user's trades |
| `/api/steam/trades/{trade_id}` | GET | Get trade details |
| `/api/steam/trades/create` | POST | Create trade offer |
| `/api/steam/trades/{trade_id}/accept` | POST | Accept trade offer |
| `/api/steam/trades/{trade_id}/decline` | POST | Decline trade offer |
| `/api/steam/trades/{trade_id}/cancel` | POST | Cancel trade offer |

## Environment Variables

| Variable | Purpose | Default | Required |
|----------|---------|---------|----------|
| `STEAM_WEB_API_KEY` | API key for SteamWebAPI.com | None | Yes |
| `STEAM_WEB_API_BASE_URL` | Base URL for API requests | https://steamwebapi.com | No |
| `REDIS_URL` | Redis connection string | redis://localhost:6379/0 | Yes |
| `STEAM_CACHE_TTL_ITEMS` | TTL for item cache in seconds | 3600 | No |
| `STEAM_CACHE_TTL_INVENTORY` | TTL for inventory cache in seconds | 1800 | No |
| `STEAM_CACHE_TTL_TRADES` | TTL for trades cache in seconds | 300 | No |
| `STEAM_API_RETRY_MAX` | Maximum number of retries for failed requests | 3 | No |
| `STEAM_API_RETRY_DELAY` | Initial delay between retries in seconds | 1 | No |
| `STEAM_API_TIMEOUT` | Request timeout in seconds | 30 | No |

## Testing Strategy

Our testing strategy has been revised to focus on real integration testing rather than mock-based testing. This approach ensures that our API endpoints correctly communicate with the SteamWebAPI.com service in actual usage scenarios.

### Test Directory Structure

```
back-end/tests/steam/
├── conftest.py             # Test configuration and shared fixtures
├── integration/            # Integration tests
│   ├── test_items_api.py   # Tests for real items API integration
│   ├── test_inventory_api.py # Tests for real inventory API integration
│   └── test_trade_api.py   # Tests for real trade API integration
├── test_models.py          # Model validation tests
└── test_routes.py          # API route tests
```

### Integration Testing Approach

Our new testing approach involves:

1. **Real API Requests**: Tests make actual HTTP requests to the SteamWebAPI.com service
2. **Local Backend Server**: Tests run against a local instance of our backend server
3. **Environment Configuration**: Tests use a dedicated API key for testing
4. **End-to-End Validation**: Verify the complete request/response cycle

### Test Prerequisites

To run the integration tests:

1. The local backend server must be running (`uvicorn app.main:app --reload --port 8000`)
2. A valid `STEAM_WEB_API_KEY` must be configured in the environment
3. Redis server must be running for caching functionality

### Essential Tests

**API Integration Tests:**
- Test real HTTP requests to SteamWebAPI.com endpoints
- Verify successful data retrieval and parsing
- Test error handling for invalid requests
- Verify rate limiting behavior in real scenarios

**Route Tests:**
- Test our API routes with real backend running
- Verify authentication and authorization
- Test input validation and error responses
- Validate response formatting

**Model Tests:**
- Verify real API responses can be parsed into our Pydantic models
- Test field mapping with actual data
- Validate constraints and data types

### Integration Testing Strategy

Our integration tests follow these principles:

1. **Shared Test Data**: Use common CS2 items that are reliably available for testing
2. **Idempotent Tests**: Tests should not permanently modify state (e.g., avoid creating permanent trades)
3. **Realistic Scenarios**: Tests simulate actual user behavior and workflows
4. **Comprehensive Coverage**: Test all critical endpoints and use cases

### Sample Integration Test

```python
# Example of an integration test for the items API
@pytest.mark.integration
async def test_get_market_items_integration():
    """Integration test for retrieving market items from the real API"""
    # Create a client for our API
    async with AsyncClient(app=app, base_url="http://localhost:8000") as client:
        # Make a real request to our API endpoint
        response = await client.get("/api/steam/items", params={
            "game": "cs2",
            "limit": 5
        })
        
        # Verify the response
        assert response.status_code == 200
        data = response.json()
        assert len(data) <= 5
        
        # Verify the structure of the returned items
        if len(data) > 0:
            item = data[0]
            assert "id" in item
            assert "name" in item
            assert "market_hash_name" in item
            assert "price" in item
```

### Rate Limit Handling

To avoid rate limit issues during testing:

1. **Throttling**: Tests include delays between requests
2. **Selective Testing**: CI pipelines run a subset of integration tests
3. **Caching Support**: Tests leverage our caching mechanism
4. **Test Environment**: Use a dedicated API key for testing with appropriate limits

### CI/CD Integration

Our continuous integration pipeline:

1. Starts a local backend server for testing
2. Configures test environment variables
3. Runs integration tests against the local server
4. Reports test results and coverage

### Testing Additional Scenarios

Beyond basic integration tests, we also test:

1. **Cache Behavior**: Verify caching works correctly with real data
2. **Error Recovery**: Test recovery from network errors and timeouts
3. **Rate Limit Handling**: Verify our backoff strategy works with real rate limits
4. **Long-Running Operations**: Test behavior of time-intensive operations

This comprehensive integration testing approach ensures our Steam Web API integration works correctly in real-world scenarios, providing confidence in the reliability and robustness of our implementation.

## Current Implementation Status

### ✅ Completed

- Base client implementation with error handling and retry logic
- Custom exception hierarchy
- Core service clients (Items, Inventory, Trade)
- Data models for all API responses
- Redis caching implementation
- API routes for all services

### 🔄 In Progress

- Minimal test implementation
- Frontend API service integration
- Documentation updates

### 🔜 Next Steps

1. Complete minimal test suite for base client
2. Implement basic service tests
3. Connect frontend components to backend endpoints
4. Deploy and monitor initial integration

## Integration with GigaSwap Backend

The Steam Web API integration connects with several other components of the GigaSwap backend:

- **Authentication System**: Uses JWT tokens from the auth system for API routes
- **Redis Integration**: Leverages the existing Redis setup for caching
- **Logging System**: Integrates with the application's logging framework
- **Error Handling**: Follows the established error handling patterns

## Error Handling Strategy

- Custom exceptions for different error types
- Consistent error response format across all endpoints
- Proper logging for all errors with contextual information
- Fallback mechanisms for API failures (cached data where appropriate)
- Rate limit detection and handling with exponential backoff 