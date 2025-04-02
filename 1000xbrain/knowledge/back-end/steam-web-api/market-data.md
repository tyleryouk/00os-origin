# USE WHEN implementing Steam market data functionality in back-end components

## Overview

This knowledge file provides implementation guidance for Steam market data API endpoints in the GigaSwap marketplace back-end. It covers market price data retrieval, caching strategies, rate limiting, and error handling for Steam Web API integration.

## Key Concepts

- **Market Price Data**: Current and historical price information for CS2 items
- **Caching Strategies**: Techniques for optimizing API calls and reducing rate limit impact
- **Rate Limiting**: Managing SteamWebAPI.com API request limitations
- **Price Aggregation**: Combining and processing market data from multiple sources

## Implementation Components

### Market Data Router

```python
from fastapi import APIRouter, Request, Depends, HTTPException, Query
from app.services.session_service import SessionService
from app.services.market_service import MarketService
from app.core.logger import logger
from typing import Optional, List
from datetime import datetime

router = APIRouter(prefix="/market", tags=["market"])

# Dependency injection
session_service = SessionService()
market_service = MarketService()

@router.get("/price/{item_name}")
async def get_item_price(
    request: Request,
    item_name: str,
    session=Depends(session_service.get_current_session)
):
    """Get current market price for an item"""
    try:
        logger.info(f"Getting market price for {item_name}")
        price_data = await market_service.get_item_price(item_name)
        return price_data
    except Exception as e:
        logger.error(f"Error getting market price for {item_name}: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to retrieve market price")

@router.get("/history/{item_name}")
async def get_price_history(
    request: Request,
    item_name: str,
    time_range: str = Query("7d", regex="^(24h|7d|30d|90d|all)$"),
    session=Depends(session_service.get_current_session)
):
    """Get price history for an item"""
    try:
        logger.info(f"Getting price history for {item_name} ({time_range})")
        history_data = await market_service.get_price_history(item_name, time_range)
        return history_data
    except Exception as e:
        logger.error(f"Error getting price history for {item_name}: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to retrieve price history")

@router.get("/listings/{item_name}")
async def get_market_listings(
    request: Request,
    item_name: str,
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100),
    session=Depends(session_service.get_current_session)
):
    """Get market listings for an item"""
    try:
        logger.info(f"Getting market listings for {item_name} (page {page})")
        listings_data = await market_service.get_market_listings(item_name, page, page_size)
        return listings_data
    except Exception as e:
        logger.error(f"Error getting market listings for {item_name}: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to retrieve market listings")
        
@router.post("/alerts")
async def create_price_alert(
    request: Request,
    alert_data: dict,
    session=Depends(session_service.get_current_session)
):
    """Create a price alert for an item"""
    if not session or not session.user:
        raise HTTPException(status_code=401, detail="Authentication required")
        
    try:
        item_name = alert_data.get("itemName")
        target_price = alert_data.get("targetPrice")
        alert_type = alert_data.get("alertType")
        
        if not item_name or target_price is None or alert_type not in ["above", "below"]:
            raise HTTPException(status_code=400, detail="Invalid alert data")
            
        logger.info(f"Creating price alert for {item_name} at {target_price} ({alert_type})")
        result = await market_service.create_price_alert(
            user_id=session.user.id,
            item_name=item_name,
            target_price=target_price,
            alert_type=alert_type
        )
        return result
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error creating price alert: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to create price alert")
```

### Market Service

```python
import aiohttp
import time
import asyncio
from typing import List, Dict, Any, Optional
from datetime import datetime, timedelta
from app.core.logger import logger
from app.core.config import settings
from app.core.cache import cache
from app.db.models import PriceAlert
from app.db.database import database

class MarketService:
    """Service for handling market data operations"""
    
    def __init__(self):
        self.api_key = settings.STEAMWEBAPI_KEY
        self.price_cache_ttl = 300  # 5 minutes
        self.history_cache_ttl = 3600  # 1 hour
        self.listings_cache_ttl = 120  # 2 minutes
        
    @cache(ttl=300)
    async def get_item_price(self, item_name: str) -> Dict[str, Any]:
        """Get current market price for an item"""
        url = f"https://api.steamwebapi.com/market/item/730/{item_name}/price"
        
        try:
            async with aiohttp.ClientSession() as session:
                headers = {
                    "Authorization": f"Bearer {self.api_key}"
                }
                
                async with session.get(url, headers=headers) as response:
                    if response.status != 200:
                        logger.error(f"SteamWebAPI error: {response.status}")
                        error_text = await response.text()
                        logger.error(f"Error details: {error_text}")
                        raise Exception(f"API error: {response.status}")
                    
                    data = await response.json()
                    
                    # Transform the data to match front-end expectations
                    return {
                        "itemName": item_name,
                        "currentPrice": data.get("current_price", 0),
                        "previousPrice": data.get("previous_price", 0),
                        "lowestPrice": data.get("lowest_price", 0),
                        "highestPrice": data.get("highest_price", 0),
                        "volume": data.get("volume", 0),
                        "updated": data.get("updated_at", datetime.now().isoformat())
                    }
        except Exception as e:
            logger.error(f"Error fetching item price: {str(e)}")
            raise
            
    @cache(ttl=3600)
    async def get_price_history(self, item_name: str, time_range: str) -> List[Dict[str, Any]]:
        """Get price history for an item"""
        # Convert time range to API parameter
        days = self._time_range_to_days(time_range)
        
        url = f"https://api.steamwebapi.com/market/item/730/{item_name}/history"
        params = {"days": days} if days else {}
        
        try:
            async with aiohttp.ClientSession() as session:
                headers = {
                    "Authorization": f"Bearer {self.api_key}"
                }
                
                async with session.get(url, headers=headers, params=params) as response:
                    if response.status != 200:
                        logger.error(f"SteamWebAPI error: {response.status}")
                        error_text = await response.text()
                        logger.error(f"Error details: {error_text}")
                        raise Exception(f"API error: {response.status}")
                    
                    data = await response.json()
                    
                    # Transform the data to match front-end expectations
                    return [
                        {
                            "date": entry.get("date"),
                            "price": entry.get("price"),
                            "volume": entry.get("volume")
                        }
                        for entry in data
                    ]
        except Exception as e:
            logger.error(f"Error fetching price history: {str(e)}")
            raise
            
    @cache(ttl=120)
    async def get_market_listings(
        self, 
        item_name: str, 
        page: int = 1, 
        page_size: int = 10
    ) -> Dict[str, Any]:
        """Get market listings for an item"""
        url = f"https://api.steamwebapi.com/market/item/730/{item_name}/listings"
        params = {
            "page": page,
            "limit": page_size
        }
        
        try:
            async with aiohttp.ClientSession() as session:
                headers = {
                    "Authorization": f"Bearer {self.api_key}"
                }
                
                async with session.get(url, headers=headers, params=params) as response:
                    if response.status != 200:
                        logger.error(f"SteamWebAPI error: {response.status}")
                        error_text = await response.text()
                        logger.error(f"Error details: {error_text}")
                        raise Exception(f"API error: {response.status}")
                    
                    data = await response.json()
                    
                    # Transform the data to match front-end expectations
                    listings = [
                        {
                            "listingId": item.get("id"),
                            "itemName": item_name,
                            "price": item.get("price"),
                            "seller": {
                                "steamId": item.get("seller_id"),
                                "displayName": item.get("seller_name")
                            },
                            "wear": item.get("float_value"),
                            "patternId": item.get("pattern_index"),
                            "listedAt": item.get("listed_at")
                        }
                        for item in data.get("listings", [])
                    ]
                    
                    return {
                        "listings": listings,
                        "total": data.get("total", 0)
                    }
        except Exception as e:
            logger.error(f"Error fetching market listings: {str(e)}")
            raise
            
    async def create_price_alert(
        self,
        user_id: int,
        item_name: str,
        target_price: float,
        alert_type: str
    ) -> Dict[str, Any]:
        """Create a price alert for an item"""
        try:
            # Get current item price to validate alert
            current_price = None
            try:
                price_data = await self.get_item_price(item_name)
                current_price = price_data.get("currentPrice")
            except Exception as e:
                logger.warning(f"Failed to get current price for alert validation: {str(e)}")
            
            # Check if alert is already triggered
            is_triggered = False
            if current_price is not None:
                if alert_type == "above" and current_price >= target_price:
                    is_triggered = True
                elif alert_type == "below" and current_price <= target_price:
                    is_triggered = True
            
            # Create alert in database
            query = PriceAlert.__table__.insert().values(
                user_id=user_id,
                item_name=item_name,
                target_price=target_price,
                alert_type=alert_type,
                is_triggered=is_triggered,
                created_at=datetime.now(),
                updated_at=datetime.now()
            )
            
            # Execute query and get the last row id
            result = await database.execute(query)
            
            return {
                "success": True,
                "alertId": str(result),
                "isTriggered": is_triggered
            }
        except Exception as e:
            logger.error(f"Error creating price alert: {str(e)}")
            raise
    
    def _time_range_to_days(self, time_range: str) -> Optional[int]:
        """Convert time range string to days for API parameter"""
        if time_range == "24h":
            return 1
        elif time_range == "7d":
            return 7
        elif time_range == "30d":
            return 30
        elif time_range == "90d":
            return 90
        elif time_range == "all":
            return None
        return 7  # Default to 7 days
```

### Database Models for Price Alerts

```python
from sqlalchemy import (
    Column, Integer, String, Float, Boolean,
    DateTime, ForeignKey, Table, MetaData, UniqueConstraint
)
from sqlalchemy.orm import relationship
from datetime import datetime

# Define metadata
metadata = MetaData()

# Price alerts table
PriceAlert = Table(
    "price_alerts",
    metadata,
    Column("id", Integer, primary_key=True, index=True),
    Column("user_id", Integer, ForeignKey("users.id"), nullable=False),
    Column("item_name", String, nullable=False),
    Column("target_price", Float, nullable=False),
    Column("alert_type", String, nullable=False),  # "above" or "below"
    Column("is_triggered", Boolean, default=False),
    Column("created_at", DateTime, default=datetime.now),
    Column("updated_at", DateTime, default=datetime.now, onupdate=datetime.now),
    # Unique constraint to prevent duplicate alerts
    UniqueConstraint("user_id", "item_name", "target_price", "alert_type", name="uq_price_alert")
)
```

### Cache Implementation

```python
from functools import wraps
from typing import Any, Callable, Dict, Optional
from datetime import datetime, timedelta
import asyncio
import inspect
import hashlib
import json

# Simple in-memory cache
cache_store = {}

def cache(ttl: int = 300):
    """
    Cache decorator for async functions
    
    Args:
        ttl: Time to live in seconds
        
    Returns:
        Decorated function with caching
    """
    def decorator(func):
        @wraps(func)
        async def wrapper(*args, **kwargs):
            # Generate cache key
            cache_key = _generate_cache_key(func, *args, **kwargs)
            
            # Check if cache_key exists and is not expired
            if cache_key in cache_store:
                entry = cache_store[cache_key]
                if entry['expiry'] > datetime.now():
                    return entry['data']
            
            # Call the function and cache the result
            result = await func(*args, **kwargs)
            cache_store[cache_key] = {
                'data': result,
                'expiry': datetime.now() + timedelta(seconds=ttl)
            }
            
            return result
        return wrapper
    return decorator

def _generate_cache_key(func: Callable, *args, **kwargs) -> str:
    """Generate a cache key from function name and arguments"""
    # Convert args and kwargs to a string representation
    key_parts = [func.__module__, func.__name__]
    
    # Add args
    for arg in args:
        if isinstance(arg, (str, int, float, bool, type(None))):
            key_parts.append(str(arg))
        else:
            # For complex types, use their string representation
            key_parts.append(str(arg))
    
    # Add kwargs in sorted order
    sorted_kwargs = sorted(kwargs.items())
    for k, v in sorted_kwargs:
        if isinstance(v, (str, int, float, bool, type(None))):
            key_parts.append(f"{k}:{v}")
        else:
            # For complex types, use their string representation
            key_parts.append(f"{k}:{str(v)}")
    
    # Join and hash to create final key
    key_string = ":".join(key_parts)
    return hashlib.md5(key_string.encode()).hexdigest()

async def clear_cache():
    """Clear expired cache entries"""
    now = datetime.now()
    keys_to_remove = [
        key for key, entry in cache_store.items()
        if entry['expiry'] < now
    ]
    
    for key in keys_to_remove:
        del cache_store[key]

async def invalidate_cache(pattern: str = None):
    """
    Invalidate cache entries
    
    Args:
        pattern: Optional pattern to match cache keys
    """
    if pattern:
        keys_to_remove = [
            key for key in cache_store.keys()
            if pattern in key
        ]
        for key in keys_to_remove:
            del cache_store[key]
    else:
        cache_store.clear()
```

## Rate Limiting Strategies

### Implementing Rate Limiting for SteamWebAPI.com

```python
import time
import asyncio
from typing import Dict, List, Optional
from datetime import datetime, timedelta
from app.core.logger import logger

class RateLimiter:
    """Rate limiter for API requests"""
    
    def __init__(self, requests_per_minute: int = 10):
        self.requests_per_minute = requests_per_minute
        self.request_timestamps: List[datetime] = []
        self.lock = asyncio.Lock()
    
    async def acquire(self) -> bool:
        """
        Acquire permission to make a request
        
        Returns:
            bool: True if request is allowed, False if rate limited
        """
        async with self.lock:
            now = datetime.now()
            
            # Remove timestamps older than 1 minute
            cutoff = now - timedelta(minutes=1)
            self.request_timestamps = [
                ts for ts in self.request_timestamps if ts > cutoff
            ]
            
            # Check if we're at the rate limit
            if len(self.request_timestamps) >= self.requests_per_minute:
                return False
            
            # Add current timestamp and allow the request
            self.request_timestamps.append(now)
            return True
    
    async def wait_for_slot(self, timeout: float = 60.0) -> bool:
        """
        Wait for a rate limit slot to become available
        
        Args:
            timeout: Maximum time to wait in seconds
            
        Returns:
            bool: True if slot became available, False if timed out
        """
        start_time = time.time()
        
        while (time.time() - start_time) < timeout:
            if await self.acquire():
                return True
            
            # Wait a bit before trying again
            await asyncio.sleep(1.0)
        
        return False

class SteamApiRateLimiter:
    """Rate limiter specifically for Steam API calls"""
    
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
            cls._instance.rate_limiters = {
                "default": RateLimiter(10),  # 10 requests per minute by default
                "inventory": RateLimiter(5),  # 5 inventory requests per minute
                "market": RateLimiter(8),    # 8 market requests per minute
                "profile": RateLimiter(10),   # 10 profile requests per minute
            }
        return cls._instance
    
    async def acquire(self, endpoint_type: str = "default") -> bool:
        """
        Acquire permission to make a request to a specific endpoint type
        
        Args:
            endpoint_type: Type of endpoint (inventory, market, profile)
            
        Returns:
            bool: True if request is allowed, False if rate limited
        """
        limiter = self.rate_limiters.get(endpoint_type, self.rate_limiters["default"])
        return await limiter.acquire()
    
    async def wait_for_slot(self, endpoint_type: str = "default", timeout: float = 60.0) -> bool:
        """
        Wait for a rate limit slot to become available for a specific endpoint type
        
        Args:
            endpoint_type: Type of endpoint (inventory, market, profile)
            timeout: Maximum time to wait in seconds
            
        Returns:
            bool: True if slot became available, False if timed out
        """
        limiter = self.rate_limiters.get(endpoint_type, self.rate_limiters["default"])
        return await limiter.wait_for_slot(timeout)

# Usage in MarketService
async def get_item_price(self, item_name: str) -> Dict[str, Any]:
    """Get current market price for an item with rate limiting"""
    rate_limiter = SteamApiRateLimiter()
    
    # Wait for a rate limit slot
    if not await rate_limiter.wait_for_slot("market", timeout=30.0):
        logger.warning(f"Rate limit timeout for market price request: {item_name}")
        raise Exception("Rate limit exceeded for market data requests")
    
    # Proceed with API request
    # ...
```

## Error Handling Patterns

1. **API Error Types**:
   - Rate limit errors (429 Too Many Requests)
   - Authorization errors (401 Unauthorized, 403 Forbidden)
   - Service unavailability (502 Bad Gateway, 503 Service Unavailable)
   - Invalid data (400 Bad Request)
   - Item not found (404 Not Found)

2. **Error Response Standardization**:
   ```python
   async def handle_api_error(response, operation_description):
       """Standard handler for API errors"""
       status = response.status
       error_text = await response.text()
       
       logger.error(f"API error ({status}) during {operation_description}: {error_text}")
       
       if status == 429:
           # Rate limit error
           retry_after = response.headers.get("Retry-After", "60")
           raise HTTPException(
               status_code=429,
               detail=f"Rate limit exceeded. Retry after {retry_after} seconds."
           )
       elif status == 401 or status == 403:
           # Authorization error
           raise HTTPException(
               status_code=403,
               detail="API authorization failed. Please check API key."
           )
       elif status == 404:
           # Not found
           raise HTTPException(
               status_code=404,
               detail="Item not found in Steam marketplace."
           )
       elif status >= 500:
           # Server error
           raise HTTPException(
               status_code=503,
               detail="Steam API service currently unavailable. Please try again later."
           )
       else:
           # Other errors
           raise HTTPException(
               status_code=500,
               detail=f"Error retrieving data: {error_text[:100]}"
           )
   ```

3. **Graceful Degradation**:
   - Implement fallback data mechanisms
   - Use cached data when API is unavailable
   - Provide estimated prices when precise data is unavailable
   - Implement circuit breaker pattern for failing endpoints

## Best Practices

1. **API Key Management**:
   - Store API keys in environment variables or secrets management
   - Implement key rotation mechanism
   - Avoid exposing API keys in responses or logs
   - Use different keys for development and production

2. **Performance Optimization**:
   - Implement multi-level caching (memory, Redis, database)
   - Use appropriate cache TTLs for different data types
   - Implement background refresh for high-value data
   - Batch API requests when possible

3. **Security Considerations**:
   - Implement proper user authentication for sensitive operations
   - Validate all input data
   - Sanitize API responses before forwarding to client
   - Implement proper CORS and request validation

## Cross-References

- **Authentication**: See `knowledge/back-end/steam-web-api/authentication.md`
- **Inventory API**: See `knowledge/back-end/steam-web-api/inventory.md`
- **Trading API**: See `knowledge/back-end/steam-web-api/trading.md`
- **Front-End Market Data**: See `knowledge/front-end/steam-web-api/market-data.md` 