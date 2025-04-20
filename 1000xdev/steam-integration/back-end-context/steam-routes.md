# Current State of Steam API Integration - Routes

This document provides an overview of the `back-end/app/steam/routes` directory, which contains FastAPI route definitions for exposing the Steam Web API integration as RESTful endpoints.

## Route Module Overview

The routes directory contains the following files:

- `__init__.py` - Exports all router objects
- `account_routes.py` - Routes for account-related operations
- `explore_routes.py` - Routes for profile discovery
- `info_routes.py` - Routes for utility endpoints
- `items_routes.py` - Routes for item and market listing operations
- `profile_routes.py` - Routes for user profile and inventory operations
- `trade_routes.py` - Routes for trade-related operations

Additionally, `__init__.py` imports two routers that aren't yet present in the directory:
- `auth_routes.py` - Routes for Steam authentication
- `monitoring_routes.py` - Routes for monitoring Steam API health

## Common Route Patterns

All route modules follow these common patterns:

1. **Router Creation**: Each module creates an APIRouter with a specific prefix (e.g., `/api/steam/items`)
2. **Dependencies**: Each defines `get_steam_client()` and a service-specific dependency (e.g., `get_items_client()`)
3. **Error Handling**: Consistent error responses with appropriate HTTP status codes
4. **Logging**: Comprehensive logging using the app's logger
5. **Documentation**: Detailed docstrings and parameter descriptions for API documentation

## __init__.py

Exports all routers for central registration:

```python
from .trade_routes import router as trade_router
from .profile_routes import router as profile_router
from .items_routes import router as items_router
from .info_routes import router as info_router
from .explore_routes import router as explore_router
from .account_routes import router as account_router
from .auth_routes import router as auth_router
from .monitoring_routes import router as monitoring_router

__all__ = [
    'trade_router',
    'profile_router',
    'items_router',
    'info_router',
    'explore_router',
    'account_router',
    'auth_router',
    'monitoring_router'
]
```

## account_routes.py

Routes for handling Steam account operations.

### Router Configuration

- **Prefix**: `/api/steam/account`
- **Tag**: `steam-account`

### Endpoints

- `GET /me` - Get authenticated account information
- `POST /steamloginsecure` - Set the steamLoginSecure cookie for authentication
- `POST /logout` - Invalidate the current session
- `GET /quota` - Check API quota and limits

## explore_routes.py

Routes for discovering and searching Steam profiles.

### Router Configuration

- **Prefix**: `/api/steam/explore`
- **Tag**: `steam-explore`

### Endpoints

- `GET /random` - Get random Steam profiles
- `GET /toplist` - Get top Steam profiles by inventory value
- `GET /last` - Get latest Steam profiles
- `GET /profile` - Search for Steam profiles

## info_routes.py

Routes for utility endpoints and reference data.

### Router Configuration

- **Prefix**: `/api/steam/info`
- **Tag**: `steam-info`

### Endpoints

- `GET /steamid` - Convert between different SteamID formats
- `GET /items` - Get item information for a specific game
- `GET /markets` - Get information about supported markets
- `GET /cs/containers` - Get CS2/CS:GO containers and collections
- `GET /cs/collection/{slug}` - Get details for a specific CS2/CS:GO collection
- `GET /complete/items` - Get autocomplete suggestions for game items
- `GET /currency/list` - List available currencies for conversion
- `GET /currency/exchange` - Get currency exchange rates

## items_routes.py

Routes for item and market listing operations.

### Router Configuration

- **Prefix**: `/api/steam/items`
- **Tag**: `steam-items`

### Endpoints

- `GET /details/{item_id}` - Get detailed information about a specific item
- `GET /search` - Search for items based on query parameters
- `GET /listings/{item_name}` - Get market listings for a specific item
- `GET /price-history/{item_name}` - Get price history for a specific item
- `GET /categories` - Get available item categories for a specific app
- `GET /order-activity/{item_nameid}` - Get recent order activity for an item
- `POST /order-activity` - Get order activity using a request body
- `GET /float` - Get float information for a CS2 item using its inspect link

### Environment Variables

Uses `STEAM_WEB_API_KEY` from environment variables for API authentication.

## profile_routes.py

Routes for user profile and inventory operations.

### Router Configuration

- **Prefix**: `/api/steam/profile`
- **Tag**: `steam-profile`

### Endpoints

- `GET /{steam_id}` - Get a user's Steam profile
- `GET /inventory/{steam_id}` - Get a user's Steam inventory
- `GET /inventory/{steam_id}/items` - Get all items in a user's Steam inventory
- `GET /eligibility/{steam_id}` - Check if a user is eligible for trading
- `GET /privacy/{steam_id}` - Get the privacy settings for a user's inventory
- `GET /friendlist/{steam_id}` - Get a user's friend list
- `POST /inventory/batch` - Get inventories for multiple users in one request

## trade_routes.py

Routes for trade-related operations.

### Router Configuration

- **Prefix**: `/api/steam/trade`
- **Tag**: `steam-trade`

### Endpoints

- `POST /create` - Create a new trade offer
- `PUT /accept` - Accept a trade offer
- `POST /history` - Get the trade history for a user
- `POST /offers` - Get active trade offers for a user
- `POST /cancel` - Cancel a trade offer
- `POST /decline` - Decline a trade offer
- `GET /status/{tradeofferid}` - Get the current status of a trade offer

## Missing Modules

The `__init__.py` file references two modules not yet present in the directory:

### auth_routes.py (Not Implemented)

Would likely handle:
- Steam OpenID authentication
- Session management
- Login/logout operations
- Token generation/validation

### monitoring_routes.py (Not Implemented)

Would likely handle:
- API health checks
- Rate limit monitoring
- Usage statistics
- System status

## Implementation Notes

1. **Model Validation**: Routes use Pydantic models for request/response validation
2. **Query Parameters**: Consistent use of FastAPI Query for parameter validation and documentation
3. **Error Handling**: Standardized error responses with appropriate HTTP status codes
4. **Dependency Injection**: Consistent pattern for service client injection
5. **Documentation**: Comprehensive docstrings for OpenAPI documentation generation

## Next Steps for Routes

1. Implement `auth_routes.py` for Steam authentication
2. Implement `monitoring_routes.py` for system monitoring
3. Add more robust input validation
4. Implement pagination for listing endpoints
5. Add caching headers for appropriate responses
6. Add rate limiting for public endpoints
