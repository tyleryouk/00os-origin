# CS2 Skins and Steam Web API Integration Research

## Overview
This document contains research findings about integrating CS2 skins trading and inventory functionality with GigaSwap using the Steam Web API. The focus is on implementing decentralized payments while maintaining compatibility with Steam's trading system.

## Steam Web API Services

### SteamWebAPI.com
SteamWebAPI.com offers a non-blocking Steam API specifically designed for developers working with CS2 skins and inventory systems. It provides the following key features:

- **Trading Power with Inventory API**: 
  - Access to 0-day tradeable items using steamLoginSecure
  - 7-10 day trade-locked items via tradelink
  - Standard 10-day locked inventory access

- **Key API Endpoints**:
  - Inventory API: Access user inventories without 429 errors
  - Items API: Retrieve complete game item listings
  - Profile API: Access Steam user profiles
  - Item Details API: Get detailed item information (prices, median prices)
  - Tracking API: Monitor inventory changes
  - History API: Track item price history

- **Authentication**:
  - Uses API keys for access
  - Provides Steam authentication extension for P2P marketplaces

## Official Steam Economy Integration

Steam provides a comprehensive API for integrating with their economy system:

### Core Components

1. **Steam Economy**:
   - A set of features allowing in-game items from multiple games to work in a shared system
   - Items can be purchased via microtransactions, earned from achievements, or granted through promotions
   - Users can view inventories in Steam Community, include links to items in chat, and trade with others

2. **Requirements for Integration**:
   - Asset back-end (database) not stored on the game client
   - Defined set of Context IDs for item containers
   - Persistent 64-bit ID for each tradable asset
   - Inventory icons for all in-game assets via web server
   - Implementation of required Steam Trading methods
   - Implementation of Support Tool Integration methods

3. **Steam Inventory Service**:
   - Free service provided by Steam for persistent storage of items
   - Alternative to building a custom asset tracking service

### Key API Interfaces

1. **IEconService Interface**:
   - Primary interface for inventory and trading functionality
   - Provides methods to handle trade offers and history

2. **Trade Offer Methods**:
   - `GetTradeOffers`: Lists trade offers (sent/received)
   - `GetTradeOffer`: Gets details about a single trade offer
   - `DeclineTradeOffer`: Declines a received trade offer
   - `CancelTradeOffer`: Cancels a sent trade offer
   - `GetTradeHistory`: Gets history of trades
   - `GetTradeHoldDurations`: Returns estimated hold duration for trades

3. **Steam Trading API**:
   - `GetContexts`: Returns list of contexts for a user
   - `GetContextContents`: Returns asset class of each user's assets
   - `GetAssetClass`: Returns asset class and owner for assets
   - `GetAssetClassInfo`: Returns display information for asset class
   - `TradeSetUnowned`: Called to remove an asset from a user
   - `TradeSetOwned`: Called to assign an asset to a user

## CS2 Inventory Access Implementation

Based on GitHub repositories and forum discussions, there are several approaches to accessing CS2 inventory data:

1. **CS2-Inventory-Loader Extension**:
   - Browser extension that provides standardized `window.cs2inventory` API
   - Allows websites to access inventory data through the extension
   - Implementation example:
     ```javascript
     // Client-side code
     if ('cs2inventory' in window) {
       const inventory = await window.cs2inventory.loadInventory(730, 2)
       reportUserInventory(inventory)
     }
     ```

2. **Steam Inventory API**:
   - Direct access to inventory via Steam's API
   - Requires understanding of item identification
   - For CS:GO/CS2, the endpoint format is:
     ```
     http://api.steampowered.com/IEconItems_730/GetPlayerItems/v0001/?key={apiKey}&steamid={steamId}
     ```

3. **Item Identification**:
   - CS2 skins are identified by:
     - defindex: Identifies the base weapon (e.g., Tec9 has defindex 30)
     - attributes: Additional properties like skin textures
     - The attribute with defindex 6 (set item texture prefab) provides skin identification

## Technical Considerations

1. **Authentication**:
   - API key-based authentication for Steam API calls
   - OAuth or session cookie-based authentication for user inventory access

2. **Rate Limiting**:
   - Steam imposes strict rate limits on API calls
   - Using a service like SteamWebAPI.com can help avoid 429 errors

3. **Trade Hold Periods**:
   - Trade offers have various states including hold periods (escrow)
   - Need to implement proper handling of all trade states

4. **Inventory Caching**:
   - Implement proper caching strategies to reduce API calls
   - Consider Redis-based caching with adaptive TTL

5. **Security**:
   - Store API keys securely using environment variables
   - Implement proper request validation and sanitization
   - Add rate limiting to prevent API abuse

## Implementation Strategy

For GigaSwap, our implementation should follow these steps:

1. **Authentication Flow**:
   - Implement Steam OpenID authentication
   - Securely store Steam API keys and session tokens

2. **Inventory Access**:
   - Implement inventory retrieval via official Steam API
   - Add fallback options through SteamWebAPI.com

3. **Trade Offer System**:
   - Implement sending, receiving, and managing trade offers
   - Develop proper state management for trade offers

4. **Blockchain Integration**:
   - Create bridge between Steam's item system and blockchain
   - Implement escrow system for cross-platform trades

5. **UI Components**:
   - Develop inventory browser component
   - Create trade offer management interface
   - Build marketplace listing UI

## Next Steps

1. Set up authentication flow with Steam OpenID
2. Create basic inventory retrieval functionality
3. Test trade offer creation and management
4. Develop bridge between Steam items and blockchain assets
5. Build UI components for marketplace integration

## References

- [SteamWebAPI.com Documentation](https://www.steamwebapi.com/docs)
- [Steam Economy Documentation](https://partner.steamgames.com/doc/features/inventory/economy)
- [Steam Web API IEconService Documentation](https://developer.valvesoftware.com/wiki/Steam_Web_API/IEconService)
- [CS2-Inventory-Loader Extension](https://github.com/CS2-Inventory-Loader/extension)
