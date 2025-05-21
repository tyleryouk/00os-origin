# Current State of Steam API Integration - Services 

This document provides an overview of the `back-end/app/steam/services` directory, which contains client classes for interacting with various Steam Web API endpoints.

## Service Module Overview

The services directory contains the following files:

- `__init__.py` - Exports all client classes
- `account.py` - AccountClient for account-related operations
- `explore.py` - ExploreClient for profile discovery
- `info.py` - InfoClient for utility endpoints
- `items.py` - ItemsClient for item and market listing operations
- `profile.py` - ProfileClient for user profile and inventory operations
- `trade.py` - TradeClient for trade-related operations

## __init__.py

Exports all client classes for easy imports:

```python
from .items import ItemsClient
from .profile import ProfileClient
from .trade import TradeClient
from .info import InfoClient
from .explore import ExploreClient
from .account import AccountClient

__all__ = [
    'ItemsClient',
    'ProfileClient',
    'TradeClient',
    'InfoClient',
    'ExploreClient',
    'AccountClient'
]
```

## AccountClient

Handles Steam account-related operations.

### Methods:

- `get_account_info(force_refresh=False)` - Gets authenticated account information
- `set_login_secure(login_secure, steam_id, session_id=None)` - Sets the steamLoginSecure cookie
- `invalidate_session()` - Logs out/invalidates the current session
- `check_api_quota(force_refresh=False)` - Checks API usage and limits

### Cache:

- Uses `RedisCache` with prefix "steam:account:" and default 30-minute TTL

## ExploreClient

Handles profile discovery and search operations.

### Methods:

- `get_random_profiles(count=10, force_refresh=False)` - Gets random Steam profiles
- `get_top_profiles(limit=10, offset=0, force_refresh=False)` - Gets top profiles by inventory value
- `get_latest_profiles(limit=10, force_refresh=False)` - Gets most recently active profiles
- `search_profiles(query, limit=10, offset=0)` - Searches for profiles based on query

### Cache:

- Uses `RedisCache` with prefix "steam:explore:" and default 15-minute TTL

## InfoClient

Provides utility endpoints for item information, conversions, and reference data.

### Methods:

- `convert_steam_id(steam_id, force_refresh=False)` - Converts between different Steam ID formats
- `get_game_items(app_id=730, language="english", force_refresh=False)` - Gets item information for a specific game
- `get_supported_markets(force_refresh=False)` - Gets information about supported markets
- `get_cs_containers(force_refresh=False)` - Gets CS2/CS:GO containers and collections
- `get_cs_collection(collection_slug, force_refresh=False)` - Gets details for a specific CS2/CS:GO collection
- `get_item_autocomplete(query, app_id=730, limit=10)` - Gets autocomplete suggestions for item search
- `get_currencies(force_refresh=False)` - Gets list of available currencies
- `get_exchange_rates(force_refresh=False)` - Gets currency exchange rates

### Cache:

- Uses `RedisCache` with prefix "steam:info:" and default 1-hour TTL
- Uses varying TTLs based on data volatility

## ItemsClient

Handles item and market listing operations.

### Methods:

- `get_item_info(item_id)` - Gets detailed information about a specific item
- `get_market_listings(filters=None, page=1, limit=50)` - Gets market listings with optional filtering
- `get_price_history(market_hash_name)` - Gets price history for a specific item
- `get_item_categories(app_id)` - Gets available item categories for a specific game
- `get_order_activity(item_nameid, currency="USD", limit=100)` - Gets recent market activity for an item
- `get_float_info(inspect_link, use_cache=True)` - Gets float information for a CS2 item using its inspect link

### Cache:

- Uses `RedisCache` with prefix "steam:items:" and default 1-hour TTL
- Uses adaptive TTL based on data volatility

### Helper Methods:

- `_adapt_listing_fields(data)` - Adapts API response fields to match model fields

## ProfileClient

Handles user profile and inventory operations.

### Methods:

- `get_user_profile(steam_id, force_refresh=False)` - Gets a user's Steam profile information
- `get_friend_list(steam_id, force_refresh=False)` - Gets a user's Steam friend list
- `get_user_inventory(steam_id, app_id=730, context_id="2", force_refresh=False)` - Gets a user's Steam inventory
- `get_trade_eligibility(steam_id)` - Gets the trade eligibility status for a user
- `get_inventory_privacy(steam_id)` - Gets the inventory privacy settings for a user
- `get_inventory_batch(steam_ids, app_id=730)` - Gets inventories for multiple users in a single call

### Cache:

- Uses two separate Redis caches:
  - `profile_cache` with prefix "steam:profile:" and default 1-hour TTL for profile data
  - `inventory_cache` with prefix "steam:inventory:" and default 30-minute TTL for inventory data

### Helper Methods:

- `_adapt_inventory_item_fields(data)` - Adapts inventory item fields to match model expectations
- `_process_raw_inventory_data(data, steam_id, app_id)` - Processes raw inventory API responses

## TradeClient

Handles trade-related operations.

### Methods:

- `create_trade_offer(request)` - Creates a new trade offer
- `accept_trade_offer(request)` - Accepts a trade offer
- `get_trade_history(request)` - Retrieves the trade history for a user
- `get_trade_offers(steamloginsecure, sent_only=False, received_only=False)` - Retrieves active trade offers
- `cancel_trade_offer(request)` - Cancels a trade offer
- `decline_trade_offer(request)` - Declines a trade offer
- `get_trade_offer_status(tradeofferid)` - Gets the current status of a trade offer

### Cache:

- Uses `RedisCache` with prefix "steam:trade:" and default 5-minute TTL
- Caches trade offer status data for quick lookups

## Common Patterns

All service modules follow these common patterns:

1. **Client Initialization**: Each client is initialized with a `SteamWebAPIClient` instance.
2. **Redis Caching**: All clients use Redis-based caching with appropriate TTLs.
3. **Error Handling**: Comprehensive try/except blocks with logging.
4. **Logging**: Detailed logging using the app's logger.
5. **Validation**: Pydantic model validation for both requests and responses.
6. **Adaptive TTL**: Many clients use adaptive TTL based on data volatility.
7. **Field Adaptation**: Helper methods to handle API field inconsistencies.

