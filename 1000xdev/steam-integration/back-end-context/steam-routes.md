# Current State of Steam API Integration - Routes

This document provides a comprehensive overview of all route modules in the Steam API integration. Routes define the API endpoints for the GigaSwap platform to interact with Steam's services.

## Directory Structure

Routes are organized in the `back-end/app/steam/routes` directory:

```
back-end/app/steam/routes/
├── __init__.py           - Route registration and exports
├── account_routes.py     - Account management endpoints
├── explore_routes.py     - Profile exploration endpoints
├── info_routes.py        - Steam information endpoints
├── items_routes.py       - Item management endpoints
├── profile_routes.py     - User profile endpoints
└── trade_routes.py       - Trading system endpoints
```

## __init__.py

This file exports all route modules and registers them with the main application router.

**Key components:**
- Imports and exports all router modules
- Allows main application to easily include all Steam routes

## account_routes.py

**Router path:** `/api/steam/account`
**Tag:** `steam-account`

Handles Steam account management and authentication features.

**Key endpoints:**
- `GET /me` - Get current account information
- `POST /steamloginsecure` - Set Steam login cookie for authentication
- `POST /logout` - Invalidate the current session
- `GET /quota` - Check API quota and usage limits

**Important features:**
- Authentication management
- Session handling
- API quota monitoring
- Cookie-based authentication

## explore_routes.py

**Router path:** `/api/steam/explore`
**Tag:** `steam-explore`

Provides endpoints for discovering and exploring Steam user profiles.

**Key endpoints:**
- `GET /random` - Get random Steam profiles
- `GET /toplist` - Get top Steam profiles by inventory value
- `GET /last` - Get latest added Steam profiles
- `GET /profile` - Search for Steam profiles

**Important features:**
- Profile discovery mechanisms
- Inventory value-based sorting
- Profile search functionality
- Batch profile retrieval

## info_routes.py

**Router path:** `/api/steam/info`
**Tag:** `steam-info`

Provides general information and utility endpoints related to Steam.

**Key endpoints:**
- `GET /steamid` - Convert between different SteamID formats
- `GET /items` - Get item information for a specific game
- `GET /markets` - Get information about supported markets
- `GET /cs/containers` - Get CS2/CS:GO containers and collections
- `GET /cs/collection/{slug}` - Get details for a specific CS collection
- `GET /complete/items` - Provide autocomplete suggestions for items
- `GET /currency/list` - List available currencies
- `GET /currency/exchange` - Get currency exchange rates

**Important features:**
- SteamID conversion utilities
- Game item database access
- Currency conversion
- Autocomplete functionality
- CS2-specific information

## items_routes.py

**Router path:** `/api/steam/items`
**Tag:** `steam-items`

Provides endpoints for accessing and managing Steam market items.

**Key endpoints:**
- `GET /details/{item_id}` - Get item details
- `GET /search` - Search for items
- `GET /listings/{item_name}` - Get market listings for an item
- `GET /price-history/{item_name}` - Get price history for an item
- `GET /categories` - Get item categories
- `GET /order-activity/{item_nameid}` - Get market order activity
- `POST /order-activity` - Alternative endpoint for order activity
- `GET /float` - Get float information for CS2 items

**Important features:**
- Item detail retrieval
- Market listing information
- Price history tracking
- CS2 item float info retrieval
- Search functionality

## profile_routes.py

**Router path:** `/api/steam/profile`
**Tag:** `steam-profile`

Handles user profile data and inventory management.

**Key endpoints:**
- `GET /{steam_id}` - Get user profile
- `GET /inventory/{steam_id}` - Get user inventory
- `GET /inventory/{steam_id}/items` - Get user inventory items
- `GET /eligibility/{steam_id}` - Check trade eligibility
- `GET /privacy/{steam_id}` - Get privacy settings
- `GET /friendlist/{steam_id}` - Get user friend list
- `POST /inventory/batch` - Get multiple inventories in one request

**Important features:**
- Profile information retrieval
- Inventory management
- Trading eligibility verification
- Privacy settings information
- Friend list access
- Batch inventory retrieval

## trade_routes.py

**Router path:** `/api/steam/trade`
**Tag:** `steam-trade`

Provides endpoints for Steam trading system integration.

**Key endpoints:**
- `POST /create` - Create a new trade offer
- `PUT /accept` - Accept a trade offer
- `POST /history` - Get trade history
- `POST /offers` - Get active trade offers
- `POST /cancel` - Cancel a trade offer
- `POST /decline` - Decline a trade offer
- `GET /status/{tradeofferid}` - Get trade offer status

**Important features:**
- Trade offer creation
- Trade acceptance/decline/cancellation
- Trade history retrieval
- Trade status monitoring
- Security validation

## Common Patterns

All route modules share several common patterns:

1. **Dependency Injection:**
   - Uses FastAPI's dependency injection for client creation
   - Creates appropriate service clients for each domain

2. **Error Handling:**
   - Consistent HTTP exception handling
   - Detailed error messages
   - Appropriate status codes

3. **Logging:**
   - Comprehensive request/response logging
   - Error logging with contextual information
   - Performance monitoring

4. **Authentication:**
   - API key validation where needed
   - Session management through cookies
   - Appropriate security checks

5. **Response Models:**
   - Pydantic models for request/response validation
   - Strictly typed returns
   - Consistent response formats

## Implementation Notes

- All endpoints use async/await for non-blocking operation
- Error handling follows a consistent pattern (try/except with detailed logging)
- Authentication is handled through API keys and Steam cookies
- Rate limiting is controlled by the Steam Web API
- API responses are cached where appropriate
