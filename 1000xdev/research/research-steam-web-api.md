# Research Findings: Steam Web APIs (Official and Third-Party)

This document summarizes findings about Steam Web APIs based on information gathered from the official Steam documentation and the third-party service `steamwebapi.com`.

## 1. Official Steam Web API (Valve)

Provided directly by Valve for developers to access Steam data.

**Key Features & Concepts:**

*   **Purpose:** Allows developers to query Steam for data (news, user stats, user info, item data, economy/trading) for use in external websites and applications.
*   **Authentication:** Requires an API Key obtained from Valve. Some sensitive operations require a *Publisher* API key which must be used server-side. [Source: partner.steamgames.com, developer.valvesoftware.com, steamcommunity.com/dev]
*   **Request Format:** Standard URL format: `http://api.steampowered.com/<interface_name>/<method_name>/v<version>/?key=<api_key>&format=<format>` [Source: steamcommunity.com/dev, developer.valvesoftware.com]
*   **Output Formats:** Supports JSON (default), XML, and VDF. [Source: steamcommunity.com/dev, developer.valvesoftware.com]
*   **Service Interfaces:** Newer style of API (names ending in "Service", e.g., `IPlayerService`, `IEconService`, `IInventoryService`) that accept arguments as a single URL-encoded JSON blob via the `input_json` parameter. [Source: developer.valvesoftware.com, partner.steamgames.com]
*   **OpenID:** Steam acts as an OpenID provider for user authentication without requiring users to enter Steam credentials on third-party sites. [Source: steamcommunity.com/dev]

**Key Interfaces Mentioned:**

*   `ISteamNews`: Fetch news for Steam games. [Source: steamcommunity.com/dev, developer.valvesoftware.com]
*   `ISteamUserStats`: Fetch global achievement percentages, user stats, and player achievements for games. [Source: steamcommunity.com/dev, developer.valvesoftware.com]
*   `ISteamUser`: Fetch user profile summaries and friend lists. [Source: steamcommunity.com/dev, developer.valvesoftware.com]
*   `IPlayerService`: Get owned games and recently played games. [Source: developer.valvesoftware.com]
*   `IEconService`: Access Steam Trading (get trade history, get/decline/cancel trade offers, get trade hold durations). [Source: partner.steamgames.com, developer.valvesoftware.com]
*   `IInventoryService`: Manage Steam Inventory items (add, consume, exchange, get inventory, get item definitions, consolidate, modify properties). Requires Publisher Key for many operations. [Source: partner.steamgames.com]
*   `IEconMarketService`: Restricted access to the Steam Market (check eligibility, cancel listings, get asset IDs, get popular items). Requires Publisher Key. [Source: partner.steamgames.com]

## 2. Steamwebapi.com (Third-Party Service)

An independent, non-affiliated service providing its own API for accessing Steam data.

**Key Features & Concepts:**

*   **Purpose:** Aims to provide a non-blocking, scalable, up-to-date API solution for accessing Steam data (profiles, items, inventories, price histories, market prices, etc.) in JSON format.
*   **Focus:** Strong emphasis on trading features, marketplaces, inventory management, and avoiding Steam's rate limiting (429 errors) or blocking.
*   **API Offerings:**
    *   **Inventory API:** Access user inventories, including handling trade-locked items (0-day via `steamLoginSecure`, 7-10 day via tradelink). Includes price data.
    *   **Items API:** Get comprehensive lists of game items.
    *   **Profile API:** Retrieve Steam user profiles without blocking issues.
    *   **Item Details API:** Get price, median price, etc.
    *   **Tracking API:** Monitor item changes (entry/exit) in inventories.
    *   **History API:** Monitor item price history (7, 14 days, up to a year).
    *   **Trading API:** Facilitates automated trading bots (B2C model using `steamLoginSecure`) and P2P marketplaces (using their `SteamAuth Extension`). They offer an endpoint to retrieve `steamLoginSecure`.
*   **Developer Resources:** Provides PHP and Python packages on GitHub. Offers a free plan with access to all endpoints (not recommended for production) and paid plans.
*   **Disclaimer:** Explicitly states it is *not* affiliated with Valve, Steam, the official Steam Web API, or Steamapis.

**Use Cases Highlighted:**

*   Marketplaces (B2C or P2P)
*   Inventory Worth Calculators
*   Ingame Skin Changers (on unofficial servers)
*   Community Platforms (Esports, PUGs)
*   Discord Bots
*   Inventory/Profile Trackers

## Summary Comparison

*   **Official Steam Web API:** Direct source from Valve, requires API key, standard interface/method structure, some methods require sensitive Publisher Keys. Provides core data access and some economy/trading functions.
*   **Steamwebapi.com:** Third-party service focused on providing a more robust, potentially easier-to-use layer over Steam data, especially for inventory/trading/market use cases. Addresses common issues like rate limiting. Offers additional features like specific trading models (B2C/P2P) and helper tools (packages, extensions). Requires its *own* API key obtained after Steam login on their site.

**Sources:**

*   <https://www.steamwebapi.com/>
*   <https://www.steamwebapi.com/hub/steam-trading-api>
*   <https://www.steamwebapi.com/blog/steam-inventory-api>
*   <https://partner.steamgames.com/doc/webapi/IEconService>
*   <https://partner.steamgames.com/doc/webapi/IInventoryService>
*   <https://partner.steamgames.com/doc/webapi/IEconMarketService>
*   <https://developer.valvesoftware.com/wiki/Steam_Web_API/IEconService>
*   <https://developer.valvesoftware.com/wiki/Steam_Web_API>
*   <https://steamcommunity.com/dev>
*   <https://www.octoparse.com/blog/scrape-data-from-multiple-urls> (General web scraping context)
*   <https://stackoverflow.com/questions/24742885/parse-multiple-urls-and-extract-data> (General web scraping context)
*   <https://community.splunk.com/t5/Splunk-Search/Parse-multiple-URLs-in-a-single-event-keeping-key-values/m-p/63806> (General web scraping context)
