# Steam API Endpoints Documentation

> **Frontend Integration Guide** - **Simple Proxy Pattern**

## Base URLs

### GigaSwap Proxy Endpoints
- **Local Development**: `http://127.0.0.1:8000`
- **Production**: `https://gigaland-backend-537p.onrender.com`

### Original steamwebapi.com Endpoints
- **Base URL**: `https://www.steamwebapi.com`

---

## Steam Profile Endpoints

All GigaSwap endpoints proxy steamwebapi.com responses directly with no transformation.

**Test Steam ID**: `76561199487496862` (Used consistently throughout documentation)

### 1. Get Steam Profile

**GigaSwap Proxy**:
- **Endpoint**: `/api/steam/profile/{steam_id}`  
- **Method**: `GET`  
- **Status**: ✅ **Implemented**
- **Example**: `http://127.0.0.1:8000/api/steam/profile/76561199487496862`

**Original steamwebapi.com**:
- **Endpoint**: `/steam/api/profile`
- **Example**: `https://www.steamwebapi.com/steam/api/profile?id=76561199487496862&key=YOUR_API_KEY`
- **Parameters**: 
  - `key` (required): API key for authentication
  - `id` (required): Steam ID, profile URL, or username (SteamID recommended for speed and accuracy)
  - `no_cache` (optional): Set to 1 to bypass cache and fetch data directly from Steam
  - `state` (optional): `minimal` (default) or `detailed` for additional profile details
  - `force_from_db_if_exists` (optional): Set to 1 to retrieve from database if available
  - `production` (optional): Set to 1 for production (default: 0)

**Response**: steamwebapi.com profile format
**Error Codes**: `200` (Success), `400` (Missing ID), `404` (Invalid ID)

---

### 2. Get Steam Friends List

**GigaSwap Proxy**:
- **Endpoint**: `/api/steam/profile/friendlist/{steam_id}`  
- **Method**: `GET`  
- **Status**: ✅ **Implemented**
- **Example**: `http://127.0.0.1:8000/api/steam/profile/friendlist/76561199487496862`

**Original steamwebapi.com**:
- **Endpoint**: `/steam/api/friendlist`
- **Example**: `https://www.steamwebapi.com/steam/api/friendlist?id=76561199487496862&key=YOUR_API_KEY`
- **Parameters**: 
  - `key` (required): API key for authentication
  - `id` (required): Steam ID (64-bit) or Steam Vanity URL
  - `no_cache` (optional): Set to 1 to bypass caching (default: cached for 1 day)
  - `production` (optional): Set to 1 for production (default: 0)

**Response**: steamwebapi.com friendlist format (array)
**Error Codes**: `200` (Success), `400` (Invalid Steam ID/Vanity URL), `404` (Missing Steam ID/Vanity URL), `406` (No friends found), `407` (Network error), `408` (Profile private)

---

### 3. Get Steam Inventory

**GigaSwap Proxy**:
- **Endpoint**: `/api/steam/profile/inventory/{steam_id}`  
- **Method**: `GET`  
- **Status**: ✅ **Implemented**
- **Example**: `http://127.0.0.1:8000/api/steam/profile/inventory/76561199487496862`

**Original steamwebapi.com**:
- **Endpoint**: `/steam/api/inventory`
- **Example**: `https://www.steamwebapi.com/steam/api/inventory?steam_id=76561199487496862&game=cs2&key=YOUR_API_KEY`
- **Parameters**: 
  - `key` (required): API key for authentication
  - `steam_id` (required): Steam ID (accepts steamid, steamid3, or steamid64 formats)
  - `game` (optional): Game short name (default: `cs2`)
  - `state` (optional): Inventory state - `active` (default), `fallback`, `takedb`
  - `parse` (optional): Enable data parsing for detailed item information (default: `1`)
  - `language` (optional): Preferred language for response (default: `English`)
  - `no_cache` (optional): Bypass default 1-day cache (requires additional credits)
  - `currency` (optional): Currency for item prices (default: `USD`)
  - `sort` (optional): Sort criterion - `price_max` (default), `price_min`, `count`, `name`
  - `group` (optional): Group identical items (default: `0` - duplicates removed)
  - `with_no_tradable` (optional): Include non-tradable items (default: `0`)
  - `trade_url` (optional): Trade URL instead of Steam ID (for CS2 7-10 day blocked items)
  - `select` (optional): Select specific item properties (e.g., `markethashname,price`)
  - `offset` (optional): Pagination offset (default: `0`)
  - `limit` (optional): Pagination limit (default: `10000`)
  - `production` (optional): Set to 1 for production (default: `0`)

**Response**: steamwebapi.com inventory format (array)
**Error Codes**: `200` (Success), `400` (Missing steam_id), `401` (Invalid Steam ID), `403` (Private inventory), `404` (Not found), `410` (No items for this game), `411` (No tradeable/non-tradeable items), `451` (Processing error)

---

### 4. Get Steam Inventory Items

**GigaSwap Proxy**:
- **Endpoint**: `/api/steam/profile/inventory/{steam_id}/items`  
- **Method**: `GET`  
- **Status**: ✅ **Implemented**
- **Example**: `http://127.0.0.1:8000/api/steam/profile/inventory/76561199487496862/items`

**Original steamwebapi.com**:
- **Endpoint**: `/steam/api/inventory` (with `parse=1`)
- **Example**: `https://www.steamwebapi.com/steam/api/inventory?steam_id=76561199487496862&game=cs2&parse=1&key=YOUR_API_KEY`
- **Parameters**: Same as inventory endpoint with `parse=1` enforced for detailed item data with pricing

**Response**: steamwebapi.com parsed inventory format (array with pricing and metadata)
**Error Codes**: `200` (Success), `401` (Invalid Steam ID), `410` (No items for this game)

---

### 5. Get Trade Eligibility

**GigaSwap Proxy**:
- **Endpoint**: `/api/steam/profile/eligibility/{steam_id}`  
- **Method**: `GET`  
- **Status**: ✅ **Implemented**
- **Example**: `http://127.0.0.1:8000/api/steam/profile/eligibility/76561199487496862`

**Original steamwebapi.com**:
- **Note**: This is a custom GigaSwap endpoint - no direct steamwebapi.com equivalent
- **Implementation**: Uses steamwebapi.com profile data to determine trade eligibility
- **Logic**: Validates Steam ID format and checks if profile exists, then returns mock eligibility data

**Response**: Custom eligibility format
```json
{
  "steam_id": "76561199487496862",
  "eligible": true,
  "reason": "User is eligible for trading",
  "restrictions": []
}
```
**Error Codes**: `200` (Success), `404` (Invalid Steam ID), `422` (Invalid Steam ID format)

---

### 6. Get Privacy Settings

**GigaSwap Proxy**:
- **Endpoint**: `/api/steam/profile/privacy/{steam_id}`  
- **Method**: `GET`  
- **Status**: ✅ **Implemented**
- **Example**: `http://127.0.0.1:8000/api/steam/profile/privacy/76561199487496862`

**Original steamwebapi.com**:
- **Endpoint**: `/steam/api/profile` (with `state=detailed`)
- **Example**: `https://www.steamwebapi.com/steam/api/profile?id=76561199487496862&state=detailed&key=YOUR_API_KEY`
- **Parameters**: Same as profile endpoint with `state=detailed` for privacy information including trade ban info and friend states

**Response**: steamwebapi.com profile format with privacy fields
**Error Codes**: `200` (Success), `404` (Invalid/non-existent Steam ID)

---

## Frontend Integration Examples

### JavaScript/Fetch
```javascript
// GigaSwap Proxy
const baseUrl = process.env.NODE_ENV === 'production' 
  ? 'https://gigaland-backend-537p.onrender.com'
  : 'http://127.0.0.1:8000';

// Get profile
const profileResponse = await fetch(`${baseUrl}/api/steam/profile/76561199487496862`);

// Get friendlist
const friendsResponse = await fetch(`${baseUrl}/api/steam/profile/friendlist/76561199487496862`);

// Get inventory
const inventoryResponse = await fetch(`${baseUrl}/api/steam/profile/inventory/76561199487496862`);

// Direct steamwebapi.com (showing parameter differences)
const profileDirect = await fetch(`https://www.steamwebapi.com/steam/api/profile?id=76561199487496862&key=${apiKey}`);
const inventoryDirect = await fetch(`https://www.steamwebapi.com/steam/api/inventory?steam_id=76561199487496862&game=cs2&key=${apiKey}`);
```

### TypeScript Interfaces
```typescript
interface SteamProfile {
  steam_id: string;
  persona_name: string;
  avatar: string;
  profile_url: string;
  real_name?: string;
  country_code?: string;
  state_code?: string;
  // Additional fields when state=detailed
  level?: number;
  trade_ban_state?: string;
  is_limited_account?: boolean;
}

interface SteamInventoryItem {
  assetid: string;
  classid: string;
  instanceid: string;
  amount: string;
  pos: number;
  id: string;
  market_hash_name: string;
  market_name: string;
  name: string;
  name_color: string;
  type: string;
  icon_url: string;
  tradable: number;
  marketable: number;
  commodity: number;
  market_tradable_restriction: number;
  // Additional fields when parse=1
  price?: number;
  currency?: string;
  rarity?: string;
  quality?: string;
}

interface SteamFriend {
  id: string;
  url: string;
  name: string;
  online: boolean;
  in_game: boolean;
  game?: string;
  avatar: string;
}

interface TradeEligibility {
  steam_id: string;
  eligible: boolean;
  reason: string;
  restrictions: string[];
}
```

---

## Error Handling

All endpoints return steamwebapi.com error format:
```json
{
  "error": "Error message description"
}
```

### Common HTTP Status Codes
- `200`: Success
- `400`: Bad request (missing required parameters like `steam_id` or `id`)
- `401`: Invalid Steam ID format
- `403`: Private inventory/profile cannot be accessed
- `404`: Not found (invalid Steam ID, missing Steam ID/Vanity URL, or resource not found)
- `406`: No data found (e.g., no friends, no inventory history)
- `407`: Unknown network error
- `408`: Profile/resource is private
- `410`: Resource exists but no items for this game
- `411`: Resource exists but no tradeable/non-tradeable items for this game
- `422`: Unprocessable entity (invalid Steam ID format - GigaSwap custom)
- `451`: Error occurred while processing request
- `500`: Internal server error

---

## Parameter Usage Summary

**Important**: steamwebapi.com uses different parameter names for different endpoints:

| Endpoint | Parameter | Description |
|----------|-----------|-------------|
| `/steam/api/profile` | `id` | Steam ID, profile URL, or username |
| `/steam/api/friendlist` | `id` | Steam ID (64-bit) or Steam Vanity URL |
| `/steam/api/inventory` | `steam_id` | Steam ID only (steamid, steamid3, or steamid64) |
| `/steam/api/inventory/batch` | `steam_ids` | Comma-separated Steam IDs (max 20) |
| `/steam/api/inventory/history` | `steam_id` | Steam ID only |

---

## Additional steamwebapi.com Endpoints (Not Proxied)

These endpoints are available directly from steamwebapi.com but not currently proxied by GigaSwap:

### Steam Inventory Batch
- **Endpoint**: `/steam/api/inventory/batch`
- **Purpose**: Fetch inventories for multiple Steam IDs (max 20)
- **Parameter**: `steam_ids` (comma-separated)
- **Example**: `https://www.steamwebapi.com/steam/api/inventory/batch?steam_ids=76561199487496862,76561198047543612&game=cs2&key=YOUR_API_KEY`

### Steam Inventory History
- **Endpoint**: `/steam/api/inventory/history`
- **Purpose**: Retrieve historical inventory changes with value and item count
- **Parameter**: `steam_id` (required)
- **Example**: `https://www.steamwebapi.com/steam/api/inventory/history?steam_id=76561199487496862&game=cs2&key=YOUR_API_KEY`

---

## Implementation Notes

1. **Proxy Pattern**: All GigaSwap endpoints use simple proxy pattern - no data transformation
2. **Error Handling**: Returns upstream steamwebapi.com error codes and messages
3. **Authentication**: API key is handled server-side, not exposed to frontend
4. **Rate Limiting**: Handled by steamwebapi.com upstream service
5. **Caching**: Controlled by steamwebapi.com parameters (`no_cache`)
6. **Parameter Mapping**: GigaSwap accepts Steam ID in URL path, backend maps to correct parameter name (`id` vs `steam_id`)
7. **Custom Endpoints**: Trade eligibility is a custom GigaSwap endpoint with mock data
