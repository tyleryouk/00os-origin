# Steam API Models - Backend Documentation

This document provides a comprehensive overview of the Pydantic models implemented in the `back-end/app/steam/models` directory. These models facilitate integration with the Steam Web API by providing strongly-typed structures for requests and responses.

## Directory Structure

The `models` directory contains the following Python files:

- `__init__.py` (145 lines) - Exports all models through a unified interface
- `account.py` (95 lines) - Account-related models including login, status, and quotas
- `explore.py` (79 lines) - Models for exploring Steam profiles and marketplace trends
- `info.py` (130 lines) - General Steam information models like ID conversion and game data
- `items.py` (155 lines) - Item models for CS2 skins and marketplace listings
- `profile.py` (139 lines) - User profile models including inventory integration
- `trade.py` (156 lines) - Trading system models for creating and managing trade offers

## Model Categories

### Account Models (`account.py`)

Models for account management, authentication, and API usage tracking:

- `AccountUsageStatistics` - Tracks API usage metrics (requests today, monthly, total)
- `AccountSubscription` - Details about user's subscription plan (dates, limits, features)
- `AccountResponse` - User account information response
- `LoginSecureRequest` - Request model for steam login secure cookie
- `LoginSecureResponse` - Authentication status response
- `LogoutResponse` - Response when logging out
- `QuotaStatus` - Enum for API quota status (normal, warning, exceeded, blocked)
- `ApiQuotaResponse` - Details about API usage limits and remaining quota

### Explore Models (`explore.py`)

Models for discovery and exploration within Steam:

- `ProfileSummary` - Condensed profile information for browsing
- `RandomProfilesResponse` - Response with random Steam profiles
- `TopProfilesResponse` - Profiles with highest inventory value
- `LatestProfilesResponse` - Most recently active profiles
- `ProfileSearchRequest` - Request for searching profiles
- `ProfileSearchResponse` - Profile search results
- `TrendingItemsRequest` (referenced in `__init__.py` but not implemented yet)
- `TrendingItemsResponse` (referenced in `__init__.py` but not implemented yet)
- `PopularGamesResponse` (referenced in `__init__.py` but not implemented yet)

### Info Models (`info.py`)

General information and utility models:

- `SteamIDFormat` - Enum for different Steam ID formats
- `SteamIDConversionRequest` - Request to convert between ID formats
- `SteamIDConversionResponse` - ID conversion results
- `GameInfo` - Basic game information
- `MarketInfo` - Marketplace information
- `CollectionItem` - Item within a CS2 collection
- `Collection` - CS2 skin collection
- `Container` - CS2 case or container
- `ContainersResponse` - List of CS2 containers
- `CollectionResponse` - Details about a specific collection
- `AutoCompleteItem` - Item for search autocomplete
- `AutoCompleteResponse` - Autocomplete search results
- `Currency` - Currency information
- `CurrencyListResponse` - List of supported currencies
- `ExchangeRate` - Currency exchange rate
- `ExchangeRatesResponse` - All currency exchange rates
- `GamesListResponse` (referenced in `__init__.py`)
- `ServerStatusResponse` (referenced in `__init__.py`)
- `SteamAppInfo` (referenced in `__init__.py`)

### Items Models (`items.py`)

Models for CS2 items and market listings:

- `SteamItem` - Base model for Steam items (name, market hash name, icon)
- `SteamItemListing` - Item listed on the Steam market
- `SteamPriceDataPoint` - Single price history data point
- `SteamPriceHistory` - Historical price data for an item
- `ItemFloatRequest` - Request for item float information
- `ItemFloatResponse` - Detailed item float data
- `OrderType` - Enum for market order types (buy, sell, cancel)
- `OrderActivity` - Single market order activity
- `OrdersActivityRequest` - Request for market order activity
- `OrdersActivityResponse` - Market order activity data

### Profile Models (`profile.py`)

User profile and inventory models:

- `SteamFriend` - Friend relationship information
- `SteamFriendList` - Complete friend list
- `SteamProfile` - Comprehensive user profile data
- `SteamInventoryItem` - Item in a user's inventory (previously in inventory.py)
- `SteamInventory` - Complete user inventory
- `TradeEligibility` - Trading eligibility status
- `InventoryPrivacySettings` - Inventory privacy configuration
- `BatchInventoryRequest` - Request for multiple inventories
- `BatchInventoryResponse` - Multiple inventory results

### Trade Models (`trade.py`)

Models for the Steam trading system:

- `TradeOfferStatus` - Enum for offer statuses
- `CreateTradeOfferRequest` - Request to create a trade offer
- `TradeOfferResponse` - Trade offer creation response
- `AcceptTradeOfferRequest` - Request to accept a trade offer
- `AcceptTradeOfferResponse` - Acceptance response
- `TradeHistoryRequest` - Request for trade history
- `TradeItem` - Item in a completed trade
- `TradeOfferItem` - Item in a trade offer
- `Trade` - Completed trade transaction
- `TradeOffer` - Trade offer details
- `CancelTradeOfferRequest` - Request to cancel an offer
- `DeclineTradeOfferRequest` - Request to decline an offer
- `TradeStatusResponse` - Trade status check response

## Model Relationships

- The `SteamItem` model serves as a base for `SteamItemListing` and `SteamInventoryItem`
- Profile models interact closely with inventory models
- Trade models utilize item models for trade contents
- Most response models include a `success` field and optional `error` field

## Implementation Status

All core models have been implemented as Pydantic models with appropriate field types and validation. The models follow consistent patterns:

1. Each model extends `BaseModel` from Pydantic
2. Fields use the `Field` constructor with descriptions
3. Configuration options like `allow_population_by_field_name` are used consistently
4. Models include comprehensive documentation in docstrings
5. Optional fields are marked with `Optional[Type]` and default to `None`

The more recent models have been updated to use the newer Pydantic v2 syntax with `model_config` instead of the older `Config` inner class.

## Next Steps

1. Complete any missing models referenced in `__init__.py` but not fully implemented
2. Add validation functions for complex field relationships
3. Implement serialization methods for special cases
4. Add model examples for testing and documentation
5. Consider adding model versioning for API compatibility tracking
