#### long prompt for parsing API from steamwebapi.com/api/list (only usefule for steamwebapi.com/api/list, usually 1000xdev can read documentation and create context instantly)

You are having a hard time extracting the endpoints from the documentation in @https://www.steamwebapi.com/api/list . What we are going to do instead is, I will manually send you copied API documentation in the format below. What you are going to do is, you are going to write a high-level description of the endpoint in 1000xdev\steam-integration\steam-web-api-research\all-endpoints.md, and you will write the JSON format of the endpoint in 1000xdev\steam-integration\steam-web-api-research\trade-offer-endpoints.json. Acknowledge that you understand the process of manually documenting endpoints, and I will start sending you all Info endpoints from the third party API provider steamwebapi.com.

Example of manually copied and pasted API documentation I will be sending you:

GET
/steam/api/info/items
🎮 Get Item Information for a Specific Game

Baseurl: https://www.steamwebapi.com/steam/api/info/items

💬 **What this endpoint does:**
- Retrieves all possible item names for a specific game.
- Supports filtering by item types, groups, and individual items.

🛠️ **Features:**
- Provides comprehensive information about items in a game.
- Supports both cached and real-time data retrieval (configurable with `no_cache`).
- Compatible with popular Steam games like CS2, Dota 2, and Rust.

🌐 **How to use:**
- Use the `game` parameter to specify the game.
- Optionally, filter by `type` to refine the results (e.g., groups, items, types).
- Set `no_cache` to `1` to fetch real-time data, bypassing the cache.
Parameters
Try it out
Name	Description
key *
any
(query)
Your API key for authentication. Retrieve it from your Dashboard (top-right corner).

key
game
any
(query)
Optional. Short name of the game. Default is cs2.

game
type
any
(query)
Optional. Type of the requested list. Accepted values: - groups: Item groups. - items: Individual items. - types: Item types. - structed: Structured data (default)

type
no_cache
any
(query)
Optional. Disable caching by setting to 1. Default is cached data.

no_cache
Responses
Code	Description	Links
200	
Request was successful, and item information is returned.

No links
429	
Rate limit exceeded. Too many requests in a short time frame.

#### end