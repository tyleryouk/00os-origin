# Steam Web API Workflow for Back-End

## Overview

This workflow provides specialized behavior for back-end components that interact with the Steam Web API.

## File Patterns

This workflow is activated for files matching these patterns:

- `**/app/routes/auth/steam*.py`
- `**/app/routes/inventory/steam*.py`
- `**/app/routes/market/steam*.py`
- `**/app/routes/trading/steam*.py`
- `**/app/services/steam*.py`
- `**/app/models/steam*.py`
- `**/app/schemas/steam*.py`

## Behavior Specialization

This workflow specializes behavior for Steam Web API integration by:

1. **Authentication Patterns**:
   - Providing specialized Steam OpenID authentication patterns
   - Offering security token handling for Steam users
   - Supporting secure session management patterns
   - Enhancing user profile data storage and retrieval

2. **Inventory Patterns**:
   - Supporting Steam inventory data fetching and caching
   - Offering CS2 skin data transformation patterns
   - Providing inventory privacy handling
   - Supporting inventory data validation and normalization

3. **Market Data Patterns**:
   - Enhancing price data aggregation patterns
   - Supporting historical price tracking
   - Providing market trend analysis
   - Offering exchange rate conversion

4. **Trading Patterns**:
   - Supporting trade offer creation and validation
   - Enhancing trade status tracking and management
   - Providing trade history storage and retrieval
   - Supporting secure trade verification patterns

## Related Parameters

This workflow integrates with the following parameter files:

- **Plan Mode**: `parameters/back-end/plan-mode/steam-web-api.md`
- **Dev Mode**: `parameters/back-end/dev-mode/steam-web-api.md`
- **Direct Mode**: `parameters/back-end/direct-mode/steam-web-api.md`

## Knowledge Integration

This workflow references the following knowledge components:

- **Authentication**: `knowledge/back-end/steam-web-api/authentication.md`
- **Inventory**: `knowledge/back-end/steam-web-api/inventory.md`
- **Market Data**: `knowledge/back-end/steam-web-api/market-data.md`
- **Trading**: `knowledge/back-end/steam-web-api/trading.md`

## Implementation Patterns

### Router Structure Pattern

```python
# Standard pattern for Steam API routers
from fastapi import APIRouter, Request, Depends, HTTPException
from app.services.steam_service import SteamService
from app.services.session_service import SessionService
from app.core.logger import logger

router = APIRouter(prefix="/steam", tags=["steam"])

# Dependency injection
steam_service = SteamService()
session_service = SessionService()

@router.get("/endpoint")
async def steam_endpoint(request: Request, session=Depends(session_service.get_current_session)):
    """Steam API endpoint description"""
    # Authentication check
    if not session or not session.user:
        raise HTTPException(status_code=401, detail="Authentication required")
    
    try:
        # Log the operation
        logger.info(f"Steam operation for user {session.user.id}")
        
        # Service call
        result = await steam_service.some_operation(session.user.steam_id)
        
        return result
    except Exception as e:
        # Log error
        logger.error(f"Error in Steam operation: {str(e)}")
        
        # Return appropriate error
        raise HTTPException(status_code=500, detail="Operation failed")
```

### Service Structure Pattern

```python
# Standard pattern for Steam services
import aiohttp
from typing import Dict, List, Any
from app.core.logger import logger
from app.core.config import settings
from app.core.cache import cache

class SteamService:
    """Service for Steam API operations"""
    
    def __init__(self):
        self.api_key = settings.STEAMWEBAPI_KEY
    
    @cache(ttl=300)
    async def some_operation(self, steam_id: str) -> Dict[str, Any]:
        """Description of the operation"""
        try:
            # Construct API URL
            url = f"https://api.steamwebapi.com/endpoint/{steam_id}"
            
            # Make API request
            async with aiohttp.ClientSession() as session:
                headers = {"Authorization": f"Bearer {self.api_key}"}
                
                async with session.get(url, headers=headers) as response:
                    # Handle non-200 responses
                    if response.status != 200:
                        logger.error(f"SteamWebAPI error: {response.status}")
                        error_text = await response.text()
                        logger.error(f"Error details: {error_text}")
                        return {"error": "API request failed"}
                    
                    # Process response
                    data = await response.json()
                    return self._transform_data(data)
        except Exception as e:
            # Log error
            logger.error(f"Error in Steam operation: {str(e)}")
            return {"error": "Operation failed"}
    
    def _transform_data(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """Transform data from API format to application format"""
        # Transformation logic
        return data
```

### Error Handling Pattern

```python
# Standard pattern for Steam error handling
try:
    # Steam API operation
except aiohttp.ClientResponseError as e:
    if e.status == 429:
        # Rate limiting error
        logger.error(f"Rate limit exceeded: {str(e)}")
        # Implement exponential backoff
    elif e.status == 403:
        # Authentication error
        logger.error(f"Authentication failed: {str(e)}")
        # Return appropriate error
    else:
        # General API error
        logger.error(f"API error: {str(e)}")
        # Return appropriate error
except aiohttp.ClientError as e:
    # Network error
    logger.error(f"Network error: {str(e)}")
    # Return appropriate error
except Exception as e:
    # Unexpected error
    logger.error(f"Unexpected error: {str(e)}")
    # Return appropriate error
```

### Caching Pattern

```python
# Standard pattern for Steam data caching
from app.core.cache import cache

@cache(ttl=300)  # 5 minutes TTL
async def cached_operation(self, params):
    # Operation implementation
    return result

# Manual cache implementation
async def get_data(self, key, refresh=False):
    # Skip cache if refresh requested
    if refresh:
        return await self._fetch_data()
    
    # Try to get from cache
    cache_key = f"steam_data_{key}"
    cached_data = await self._get_cached_data(cache_key)
    
    if cached_data:
        return cached_data
    
    # Fetch new data
    data = await self._fetch_data()
    
    # Cache the data
    await self._cache_data(cache_key, data)
    
    return data
``` 