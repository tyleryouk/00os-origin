# Items Endpoints

## GET /steam/api/items

**Description:** 🎯 Retrieve, search, and download game items - the best API for Steam items.

**Base URL Example:** `https://www.steamwebapi.com/steam/api/items?key=YOUR_API_KEY&game=cs2`

**Details:**

*   🎮 Retrieve all items for a specific game such as CS2, Rust, or Dota2.
*   🔍 Search for specific items using the `search` parameter.
*   🛠️ Apply filters like `price_min`, `price_max`, `item_group`, or `wear`.
*   📊 Retrieve detailed item information, including prices, metadata, and market data.

**Important Notes:**

*   This endpoint can return a large amount of data. Use the `max` parameter to limit results.
*   For better performance, apply filters like `search` or `price_min` to narrow down the results.

---

## GET /steam/api/item

**Description:** 📦 Retrieve Item Details with Pricing of all Markets and History.

**Base URL Example:** `https://www.steamwebapi.com/steam/api/item?key=YOUR_API_KEY&market_hash_name=AK-47%20%7C%20Redline%20(Field-Tested)`

**Details:**

*   🔍 Retrieve details of a specific item using its `market_hash_name`, `slug`, or `hashId`.
*   📊 Provides enriched details like pricing information, tags, metadata, and a brief price history.

**Use Case:**

*   Focuses on a single item with detailed data for advanced use cases like market analytics or item tracking.

**Note:**

*   Similar to `/steam/api/items`, but focused on a single item with more detailed information.

---

## GET /steam/api/history

**Description:** 📈 Price History of an Item with Daily Prices from Steam or Real Market Data.

**Base URL Example:** `https://www.steamwebapi.com/steam/api/history?key=YOUR_API_KEY&market_hash_name=ITEM_NAME`

**Details:**

*   Retrieves the price history of an item.
*   🗓️ Provides daily prices from Steam (default) or lowest real market prices (if `origin=markets`).

**Important Notes:**

*   Use the `interval` parameter for optimized queries.
*   Specifying `origin=markets` results in slower responses but provides detailed real market data.

---

## GET /steam/api/float

**Description:** 🔍 Retrieve Float Information for an Item.

**Base URL Example:** `https://www.steamwebapi.com/steam/api/float?key=YOUR_API_KEY&url=INSPECT_LINK`

**Details:**

*   Retrieves float information for a specific CS:GO or CS2 item using its inspect link.

**Usage:**

*   Requires the `url` parameter containing a valid inspect link (e.g., `steam://rungame/...`).
*   Authenticate with your API key.

---

## GET /steam/api/itemordersactivity

**Description:** 📦 Retrieve Realtime Order Activity for a Steam Item.

**Base URL Example:** `https://www.steamwebapi.com/steam/api/itemordersactivity?key=YOUR_API_KEY&nameid=UNIQUE_NAMEID` (Note: Example uses `nameid`, but parameter description uses `market_hash_name`. Clarification needed.)

**Details:**

*   Retrieves order activity details for a specified Steam item.
*   Includes regional data (country), language-specific details, and price information (currency).

**Usage:**

*   Provide the `market_hash_name` parameter to specify the item.
*   Optionally customize `country`, `language`, and `currency`.

---

# Info Endpoints

## GET /steam/api/info/items

**Description:** 🎮 Get Item Information for a Specific Game

**Base URL Example:** `https://www.steamwebapi.com/steam/api/info/items`

**Details:**

*   Retrieves all possible item names for a specific game (e.g., CS2, Dota 2, Rust).
*   Supports filtering by item types (`groups`, `items`, `types`, `structed`).
*   Supports retrieving real-time data by disabling the cache (`no_cache=1`).

**Usage:**

*   Specify the game using the `game` parameter (default: `cs2`).
*   Filter results using the `type` parameter.

## GET /steam/api/info/steamid

**Description:** 🔄 Convert a SteamID into Multiple Formats

**Base URL Example:** `https://www.steamwebapi.com/steam/api/info/steamid?key=YOUR_API_KEY&steam_id=STEAM_ID`

**Details:**

*   Converts a SteamID (`SteamID2`, `SteamID3`, or `SteamID64`) into all three formats.
*   Returns the result as JSON.

**Usage:**

*   Provide the `steam_id` to convert.

## GET /steam/api/cs/containers

**Description:** 🎯 Retrieve All CS2/CS:GO Containers and Collections

**Base URL Example:** `https://www.steamwebapi.com/steam/api/cs/containers`

**Details:**

*   Retrieves a list of all CS2/CS:GO containers (cases, stickers, etc.) and their collections.
*   Supports filtering by type (`all`, `sticker`, `case`).
*   Allows searching and sorting (name, price, release date).

**Usage:**

*   Specify the container `type`.
*   Use `search` and `sortBy` for filtering and ordering.

## GET /steam/api/cs/collection/{slug}

**Description:** 🎯 Retrieve a CS2/CS:GO Collection or Case

**Base URL Example:** `https://www.steamwebapi.com/steam/api/cs/collection/{slug}`

**Details:**

*   Retrieves detailed information and items (skins) for a specific CS2/CS:GO collection or case.
*   Identifies the collection using its unique `slug`.

**Usage:**

*   Provide the collection or case `slug` in the path.

## GET /steam/api/info/markets

**Description:** 📈 Get Supported Market Information

**Base URL Example:** `https://www.steamwebapi.com/steam/api/info/markets`

**Details:**

*   Retrieves a list of all markets supported by the API provider.
*   Includes market names, logos, and other relevant data.

**Usage:**

*   Requires only the API key.

## GET /steam/api/complete/items

**Description:** 🔍 Auto-Complete Game Items - e.g for using on Input fields (for free)

**Base URL Example:** `https://www.steamwebapi.com/steam/api/complete/items?search=SEARCH_TERM&game=cs2`

**Details:**

*   Provides real-time auto-completion suggestions for game items (name and image URL).
*   Requires a `search` term (min 3 chars).
*   Supports filtering by `game` (default `cs2`).

**Usage:**

*   Ideal for input field auto-completion.
*   API key is optional but recommended.
*   Currently free (future cost planned).

## GET /currency/api/list

**Description:** 💱 List All Available Currencies for Conversion

**Base URL Example:** `https://www.steamwebapi.com/currency/api/list?key=YOUR_API_KEY&base=USD`

**Details:**

*   Retrieves a list of all available currencies for conversion.
*   Defaults to USD as the base currency and Steam as the data source.

**Usage:**

*   Optionally specify a `base` currency and `source`.

## GET /currency/api/exchange

**Description:** 💱 Retrieve Currency Exchange Rates

**Base URL Example:** `https://www.steamwebapi.com/currency/api/exchange?key=YOUR_API_KEY&change=EUR&base=USD`

**Details:**

*   Provides the exchange rate between two currencies (ISO 4217 codes).
*   Requires the target `change` currency.
*   Optionally specify the `base` currency (default `USD`).

**Usage:**

*   Use `change` and `base` parameters to define the conversion.

# Explore Endpoints

## GET /explore/api/random

**Description:** 🎲 Get Random Steam Profiles with Inventory Data

**Base URL Example:** `https://www.steamwebapi.com/explore/api/random?key=YOUR_API_KEY&limit=5`

**Details:**

*   Fetches random Steam profiles with inventory information and items.
*   By default, 5 profiles are returned.
*   Adjustable profile count with the `limit` parameter.
*   Provides inventory and item data for each profile.

**Usage:**

*   Use your API key for authentication.
*   Optionally, set the `limit` parameter to specify the number of profiles to return (e.g., `limit=10`).
*   Set `production=1` for production environments.

## GET /explore/api/toplist

**Description:** 🏆 Get Top Profiles by Inventory Value

**Base URL Example:** `https://www.steamwebapi.com/explore/api/toplist?key=YOUR_API_KEY&limit=5`

**Details:**

*   Retrieves the top profiles based on the highest combined inventory value.
*   By default, 5 profiles are returned.
*   Adjustable profile count using the `limit` parameter (maximum: 50).
*   Provides detailed inventory information, including items and combined values.
*   Costs 2 credits per profile (e.g., `limit=5` costs 10 credits).

**Usage:**

*   Use your API key for authentication.
*   Optionally, set the `limit` parameter to specify the number of profiles to retrieve.

## GET /explore/api/last

**Description:** 📜 Retrieve the Latest Steam Profiles with Inventory Data

**Base URL Example:** `https://www.steamwebapi.com/explore/api/last?key=YOUR_API_KEY&limit=5`

**Details:**

*   Fetches the last Steam profiles added to the system with inventory information and items.
*   By default, 5 profiles are returned.
*   Adjustable profile count using the `limit` parameter (maximum: 50).
*   Provides inventory and item data for each profile.

**Usage:**

*   Use your API key for authentication.
*   Optionally, set the `limit` parameter to specify the number of profiles to return (e.g., `limit=10`).

## GET /explore/api/profile

**Description:** 🔍 Search Steam Profiles by Name, Country, or Worth

**Base URL Example:** `https://www.steamwebapi.com/explore/api/profile?key=YOUR_API_KEY&search=example`

**Details:**

*   Searches for Steam profiles based on various criteria such as name, country, or inventory worth.
*   By default, retrieves profiles matching the provided search criteria.
*   Filter results using the `search`, `country`, or `worth` parameters.
*   Supports pagination with `limit` and `page` parameters.
*   Sort results by criteria like `personaname`, `timecreated`, `fame`, `worth`, or `size`.

**Usage:**

*   Use the `search` parameter for a name, account name, or description.
*   Optionally, filter by `country` or `worth` to refine your search.
*   Adjust `limit` and `page` for paginated results.
*   Use `order_by` to specify the sorting order (e.g., `worth` for inventory value).

---

# Profile Endpoints

## GET /steam/api/friendlist

**Description:** 👥 Retrieve a Steam User's Friendlist

**Base URL Example:** `https://www.steamwebapi.com/steam/api/friendlist?id=76561198012345678&key=YOUR_API_KEY`

**Details:**

*   Fetches a Steam user's friends list with detailed information.
*   By default, the data is parsed (`parsed=1`) for better readability.
*   For raw data directly from Steam, set `parsed=0`.
*   Retrieve detailed information about a user's friends, such as online status, game activity, and profile details.
*   Optimized for better response times by utilizing caching.

**Usage:**

*   Provide the user's Steam ID (64-bit) or Vanity URL using the `id` parameter.
*   Use the `no_cache` parameter to bypass caching if real-time data is required.
*   Set `production=1` for production environments.

## GET /steam/api/inventory

**Description:** ⚡ Fetch Detailed Steam Inventory with Pricing Data - Best API in the World!

**Base URL Example:** `https://www.steamwebapi.com/steam/api/inventory?steam_id=760000022222&game=cs2&key=YOUR_API_KEY`

**Details:**

*   🚀 Fetch detailed Steam inventory data while bypassing rate limits.
*   Provides either Steam's raw response or a parsed version with item prices and metadata (controlled via `parse` parameter).
*   Supports inventory tracking for daily updates and insights.
*   Handles private inventories by fetching cached or fallback data when possible.
*   Supports Trade URL for CS2 inventories to access previously blocked items (7-10 days).
*   Can fetch inventory without the 10-day block using the `steam_login_secure` parameter.

**Usage:**

*   Provide either `steam_id` or `trade_url` to identify the inventory.
*   Use `state` parameter to specify inventory state (active, fallback, takedb).
*   Set `parse=1` for detailed item information (default).
*   Use `currency` parameter to specify the currency for item prices.
*   Set `with_no_tradable=1` to include non-tradable items.

## GET /steam/api/inventory/batch

**Description:** ⚡ Batch Fetch Steam Inventories with Pricing Data - Up to 20 IDs!

**Base URL Example:** `https://www.steamwebapi.com/steam/api/inventory/batch?steam_ids=76561199146708568,76561198047543612&game=cs2&key=YOUR_API_KEY`

**Details:**

*   🚀 Fetch inventories for multiple Steam IDs in one request, bypassing rate limits.
*   Provides detailed inventory data with item prices and metadata for up to 20 Steam IDs.
*   Supports multiple Steam IDs in a single request (comma-separated, max 20 IDs).
*   Allows selection of specific item properties with the `select` parameter.
*   Provides currency conversion and language localization for detailed item data.
*   Works with all Steam games, including CS2, Dota 2, and Rust.
*   Includes fallback options for private inventories or unavailable data.
*   ⚡ Optimized for high performance with asynchronous data fetching.

**Usage:**

*   Provide a comma-separated list of Steam IDs (maximum 20) using the `steam_ids` parameter.
*   Specify the game using the `game` parameter (default: cs2).
*   Use `select` to choose specific item properties to include in the response.
*   Set `currency` to specify the currency for item prices.
*   Set `production=1` for production environments.

## GET /steam/api/inventory/history

**Description:** 📜 Retrieve Historical Inventory Changes with Value and Item Count

**Base URL Example:** `https://www.steamwebapi.com/steam/api/inventory/history?steam_id=76561198042843401&game=cs2&key=YOUR_API_KEY`

**Details:**

*   📜 Fetches all inventory changes for a specified game and Steam ID.
*   Provides details about the inventory's worth (in USD), size (number of items), and the timestamp of the change.
*   Tracks all historical changes in the inventory.
*   Calculates the total worth of items in USD (Steam market value).
*   Compatible with all Steam games, including CS2, Dota 2, and Rust.

**Usage:**

*   Use the `steam_id` and `game` parameters to retrieve historical inventory changes.
*   Includes timestamped records to track changes over time.

## GET /steam/api/profile

**Description:** 👤 Retrieve a Steam User's Profile with Flexible Options

**Base URL Example:** `https://www.steamwebapi.com/steam/api/profile?id=760000022222&key=YOUR_API_KEY`

**Details:**

*   Fetches a Steam user profile with flexible options.
*   Supports detailed or minimal data retrieval based on your needs.
*   Use the `id` parameter to identify the profile. Supports SteamID, username, or profile URL (SteamID recommended for faster and more accurate results).
*   Retrieve real-time data by setting `no_cache` to `1` (slower response).
*   Adjust the data depth using the `state` parameter (`minimal` or `detailed`).
*   Optimize responses with the `force_from_db_if_exists` parameter to fetch profiles from the database if available.

**Usage:**

*   Provide a valid `id` parameter (SteamID, profile URL, or username).
*   Use optional parameters to customize data retrieval (e.g., `state=detailed` for additional profile details).
*   Set `production=1` for production environments.

---

# Trade Endpoints

## POST /steam/api/trade/create

**Description:** 📦 Create a Trade Offer on Steam

**Base URL Example:** `https://www.steamwebapi.com/steam/api/trade/create?key=YOUR_API_KEY`

**Details:**

*   Initiates a new trade offer for a specific user.
*   Requires a valid `steamloginsecure`, retrievable from Steam cookies.
*   Supports sending items (`myitemassetids`) and requesting items (`partneritemassetids`).
*   Trade link and partner Steam ID ensure secure targeting.
*   Includes a custom message option for the trade.

**Important Notes:**

*   Authentication through `steamloginsecure` is mandatory and must be valid.
*   Either `tradelink` or `partnersteamid` must be provided to identify the trade partner.
*   Careful management of asset IDs is required to prevent trade errors.
*   Rate limits and trade offer limitations apply to prevent abuse.

**Usage:**

*   Provide required parameters in a JSON payload.
*   Use optional parameters like `game` for game-specific trade offers.
*   Set `production=1` for production environments.

---

## PUT /steam/api/trade/accept

**Description:** 🔒 Accept a Trade Offer on Steam

**Base URL Example:** `https://www.steamwebapi.com/steam/api/trade/accept?key=YOUR_API_KEY`

**Details:**

*   Accepts a trade offer on Steam.
*   Requires Steam credentials and trade details.
*   Allows accepting trade offers programmatically.
*   Requires `2FA` if items are involved in the trade.

**Important Notes:**

*   Authentication through `steamloginsecure` is mandatory and must be valid.
*   The `tradeofferid` must refer to an existing trade offer.
*   The `partnersteamid` must match the sender of the trade offer.
*   Trade acceptance is subject to Steam's security policies and limitations.

**Usage:**

*   Provide required parameters (`steamloginsecure`, `tradeofferid`, and `partnersteamid`) in the request body.
*   Authenticate using your API key for access.
*   Set `production=1` for production environments.

---

## POST /steam/api/trade/history

**Description:** 🔎 Retrieve Trade History

**Base URL Example:** `https://www.steamwebapi.com/steam/api/trade/history?key=YOUR_API_KEY`

**Details:**

*   Retrieves the trade history of a user.
*   Provides a secure and efficient way to access all trades associated with the user.
*   Perfect for verifying trade success and tracking the user's trade activity.
*   Uses webhooks to deliver trade history data.

**Important Notes:**

*   **Rate Limiting:** Each `steamloginsecure` token is rate-limited. Delays may occur if too many requests are made in a short period.
*   **Real-time Data:** The `steamloginsecure` token ensures real-time data retrieval from Steam.
*   The authentication token must be valid and not expired.
*   You can use the Extension for automatic token retrieval.

**Usage:**

*   Send the `steamloginsecure` cookie value from steamcommunity.com in the request body.
*   Provide a webhook URL where trade history updates will be sent.
*   Set `production=1` for production environments.

---

## POST /steam/api/trade/sent

**Description:** 📜 List Sent Trade Offers

**Base URL Example:** `https://www.steamwebapi.com/steam/api/trade/sent?key=YOUR_API_KEY`

**Details:**

*   Lists all outgoing trade offers made by a user.
*   Requires a valid `steamloginsecure` for authentication.
*   Provides comprehensive data about each trade offer sent by the user.
*   Helps track and manage outgoing trade offers efficiently.

**Important Notes:**

*   Authentication through `steamloginsecure` is mandatory and must be valid.
*   The optional `forcesteamids` parameter can provide additional data but may result in slower response times.
*   Rate limitations apply to prevent abuse of the Steam API.

**Usage:**

*   Provide the `steamloginsecure` cookie value from steamcommunity.com in the request body.
*   Optionally, include `forcesteamids` to get Steam IDs for each trade offer (may increase response time).
*   Set `production=1` for production environments.

---

## POST /steam/api/trade/received

**Description:** 💼 Retrieve Pending Trade Offers

**Base URL Example:** `https://www.steamwebapi.com/steam/api/trade/received?key=YOUR_API_KEY`

**Details:**

*   Retrieves all incoming trade offers that are pending for acceptance.
*   Fetches trade offers waiting for acceptance by the user.
*   Provides real-time data directly from Steam using the authentication token.
*   Allows for efficient management of incoming trade requests.

**Important Notes:**

*   **Real-time Data:** Fetch trade offers in real-time using the `steamloginsecure` token.
*   **Rate Limiting:** Be mindful of the rate limits on the `steamloginsecure` token. If too many requests are made at once, delays may occur.
*   The optional `forcesteamids` parameter can provide additional data but may result in slower response times.

**Usage:**

*   Provide the `steamloginsecure` token from steamcommunity.com in the request body.
*   Optionally, include `forcesteamids` to get Steam IDs for all trade offers (may increase response time).
*   You can use the Extension for automatic token retrieval if you're unsure how to obtain it.

---

## PUT /steam/api/trade/cancel

**Description:** ❌ Cancel a Trade Offer on Steam

**Base URL Example:** `https://www.steamwebapi.com/steam/api/trade/cancel?key=YOUR_API_KEY`

**Details:**

*   Cancels a trade offer on Steam.
*   Requires Steam credentials and the trade offer ID.
*   Allows programmatically canceling trade offers.
*   Provides secure authentication using `steamloginsecure`.

**Important Notes:**

*   Authentication through `steamloginsecure` is mandatory and must be valid.
*   The `tradeofferid` must refer to an existing trade offer that you have permission to cancel.
*   Only the sender of a trade offer can cancel it.
*   Trade cancellations may be subject to Steam's limitations and policies.

**Usage:**

*   Provide required parameters (`steamloginsecure` and `tradeofferid`) in the request body.
*   Authenticate using your API key to access the endpoint.
*   Set `production=1` for production environments.

---

## PUT /steam/api/trade/decline

**Description:** ❌ Decline a Trade Offer on Steam

**Base URL Example:** `https://www.steamwebapi.com/steam/api/trade/decline?key=YOUR_API_KEY`

**Details:**

*   Declines an existing trade offer on Steam.
*   Requires Steam credentials and the trade offer ID.
*   Programmatically declines trade offers.
*   Requires a valid `steamloginsecure` for authentication.

**Important Notes:**

*   Authentication through `steamloginsecure` is mandatory and must be valid.
*   The `tradeofferid` must refer to an existing trade offer that is available to be declined.
*   Only the recipient of a trade offer can decline it.
*   Declining trade offers may be subject to Steam's rate limiting and security policies.

**Usage:**

*   Provide the required parameters (`steamloginsecure` and `tradeofferid`) in the request body.
*   Authenticate using your API key for access to the endpoint.
*   Set `production=1` for production environments.

---

# Account Endpoints

## GET /account/me

**Description:** 📊 Retrieve Your Account and Usage Statistics

**Base URL Example:** `https://www.steamwebapi.com/account/me`

**Details:**

*   Retrieve details about your account and usage statistics.
*   This endpoint provides comprehensive details about your account, including usage statistics and activity records.
*   **Usage Tracking:** The endpoint tracks your API usage and provides insights into your activity.
*   **Rate Limiting:** The request generates a usage record each time it is called.
*   **Real-time Data:** Get up-to-date information about your account's API usage in different time periods (minute, hour, day, week, month).

**Important Notes:**

*   **Usage Details**: Track your API usage over the last minute, hour, day, week, and month.
*   **Subscription Info**: Get information about your subscription status and duration.

**Usage:**

*   Provide your **API key** in the request to retrieve the data.
*   The API will respond with a breakdown of your usage, subscription status, and the latest status of the Steam Web API.

---

## POST /steam/api/steamloginsecure

**Description:** 📦 Automate Steam Login Process

**Base URL Example:** `https://www.steamwebapi.com/steam/api/steamloginsecure`

**Details:**

*   Automates your Steam login process, including for trading, market, and other Steam Community features.
*   With the `steamLoginSecure` cookie, you can use the Trading API and build easy-to-use trading bots, market trackers, and more.
*   The login process is handled securely. No password is stored server-side.
*   Ideal for building trading bots, market analyzers, and automated session checkers.

**Important Notes:**

*   There are **two ways to authenticate**:
    1. **Username + Password Login**: Send a POST request with your Steam `username` and `password` in the request body.
    2. **Refresh Token Login**: Provide a `steamrefreshtoken` (JWT) instead of username/password.
*   If your account is protected by Steam Guard, include the `code` parameter from your mobile authenticator.
*   Do **not** provide both login credentials and `steamrefreshtoken` at the same time.
*   The `steamrefreshtoken` is typically valid for **up to 6 months** and can be used repeatedly to retrieve new `steamLoginSecure` cookies.

**Response:**

*   On success, you will receive the following cookies:
    *   `steamLoginSecure` – required for authenticated Steam Community actions
    *   `sessionid` – required for most web interactions
    *   `browserid` – identifies the browser/session
    *   `steamrefreshtoken` – reusable token to fetch new `steamLoginSecure` cookies later

---

