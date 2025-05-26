# Steam Web API Integration Documentation

> **[Updated 2025-06-26]** - **Simple Proxy Pattern Implementation**

## Architecture Overview

GigaSwap uses a **simple proxy pattern** for Steam API integration:

- **No complex mapping/transformation** of responses
- **Direct passthrough** of steamwebapi.com responses to frontend
- **Frontend expects** steamwebapi.com response format directly
- **Minimal backend logic** - just proxy with httpx

## Environment Configuration

**IMPORTANT:** The Steam Web API key is configured in the `.env` file located at `back-end\.env`:

```
STEAM_WEB_API_KEY={steam-web-api-key}
```

This API key is automatically loaded by the FastAPI application and used by all Steam proxy endpoints. Do not modify or remove this configuration.

# Steam Proxy Implementation

## Proxy Pattern Architecture

The Steam integration now uses a **simple proxy pattern** instead of complex mapping/caching:

```
Frontend Request → FastAPI Proxy Endpoint → steamwebapi.com → Raw Response → Frontend
```

## Directory Structure (Simplified)

The `back-end/app/steam` directory structure for proxy pattern:

```
back-end/app/steam/
├── routes/           # Proxy endpoints (primary focus)
│   └── profile.py    # Steam profile proxy endpoints
├── models/           # Minimal models (if needed)
├── services/         # Proxy service logic
└── __init__.py       # Module initialization
```

**Note**: Complex components like `client.py`, `rate_limiter.py`, `cache.py` are **not needed** for the proxy pattern.

## Proxy Implementation Components

### Profile Proxy Endpoints

The main implementation focuses on 6 Steam profile endpoints using simple proxy pattern:

1. **`GET /api/steam/profile/{steam_id}`** → `steamwebapi.com/steam/api/profile`
2. **`GET /api/steam/profile/inventory/{steam_id}`** → `steamwebapi.com/steam/api/inventory`
3. **`GET /api/steam/profile/inventory/{steam_id}/items`** → `steamwebapi.com/steam/api/inventory` (parsed)
4. **`GET /api/steam/profile/eligibility/{steam_id}`** → Custom eligibility logic
5. **`GET /api/steam/profile/privacy/{steam_id}`** → `steamwebapi.com/steam/api/profile` (privacy fields)
6. **`GET /api/steam/profile/friendlist/{steam_id}`** → `steamwebapi.com/steam/api/friendlist`

### Proxy Implementation Pattern

```python
import httpx
from fastapi import APIRouter

@router.get("/profile/{steam_id}")
async def get_steam_profile(steam_id: str):
    """Simple proxy to steamwebapi.com profile endpoint."""
    async with httpx.AsyncClient() as client:
        response = await client.get(
            f"https://steamwebapi.com/steam/api/profile",
            params={"id": steam_id, "key": STEAM_API_KEY}
        )
        # Return raw response and status code
        return response.json(), response.status_code
```

## Benefits of Proxy Pattern

### Simplicity
- **No complex mapping** between steamwebapi.com and internal models
- **No caching layer** to maintain and debug
- **No rate limiting logic** - handled by steamwebapi.com
- **Minimal code** - just httpx forwarding

### Frontend Compatibility
- **Direct steamwebapi.com format** - frontend expects upstream response structure
- **Consistent error handling** - upstream error codes and messages
- **No transformation overhead** - responses passed through unchanged

### Maintenance
- **Fewer dependencies** - no Redis, complex client logic, or model validation
- **Easier debugging** - direct passthrough makes issues easier to trace
- **Faster development** - no need to map every field from upstream API

## Implementation Status

### Completed Endpoints (Proxy Pattern)
- ✅ **`GET /api/steam/profile/{steam_id}`** - Profile data proxy
- ✅ **`GET /api/steam/profile/eligibility/{steam_id}`** - Trade eligibility
- ✅ **`GET /api/steam/profile/friendlist/{steam_id}`** - Friends list proxy

### Remaining Endpoints (To Implement)
- ⏳ **`GET /api/steam/profile/inventory/{steam_id}`** - Inventory proxy
- ⏳ **`GET /api/steam/profile/inventory/{steam_id}/items`** - Inventory items proxy  
- ⏳ **`GET /api/steam/profile/privacy/{steam_id}`** - Privacy settings proxy

### Testing Status
- ✅ **Test suite updated** for steamwebapi.com response format expectations
- ✅ **Logging implemented** for all proxy responses
- ✅ **Status code validation** matches upstream API behavior

## Next Steps

### Immediate Tasks
1. **Implement remaining 3 proxy endpoints** using the same pattern as friendlist
2. **Update tests** for inventory and privacy endpoints to expect steamwebapi.com format
3. **Validate all 6 endpoints** work with the proxy pattern

### Implementation Pattern for Remaining Endpoints

```python
# Example: Inventory proxy endpoint
@router.get("/profile/inventory/{steam_id}")
async def get_steam_inventory(steam_id: str):
    """Proxy to steamwebapi.com inventory endpoint."""
    async with httpx.AsyncClient(timeout=30.0) as client:
        response = await client.get(
            "https://steamwebapi.com/steam/api/inventory",
            params={
                "steam_id": steam_id,
                "game": "cs2",
                "key": STEAM_API_KEY
            }
        )
        return Response(
            content=response.content,
            status_code=response.status_code,
            headers={"content-type": "application/json"}
        )
```

### Benefits of This Approach
- **Eliminates complex mapping/caching/validation** that was causing Pydantic v2 errors
- **Frontend gets expected format** directly from steamwebapi.com
- **Faster development** - no need to maintain internal models
- **Easier debugging** - direct passthrough of responses
- **MVP-ready** - simple, working solution for marketplace integration