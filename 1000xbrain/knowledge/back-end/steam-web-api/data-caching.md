# USE WHEN implementing data caching for Steam Web API in back-end components

## Overview

This file provides implementation guidance for caching data from the Steam Web API to optimize performance and stay within rate limits. It covers multi-level caching strategies, TTL management, and cache invalidation patterns.

## Key Concepts

- **Multi-Level Caching**: Using both in-memory and Redis caching for different data types
- **TTL Management**: Different cache expiration times based on data volatility
- **Cache Invalidation**: Strategies for keeping cache data fresh
- **Rate Limit Protection**: Using caching to avoid hitting rate limits

## Implementation Guidelines

### Caching Service Implementation

```python
from redis import Redis
from fastapi import Depends
import json
from datetime import timedelta
from app.core.config import settings

class CachingService:
    """Service for multi-level caching of Steam API data"""
    
    def __init__(self, redis: Redis = Depends(get_redis_client)):
        self.redis = redis
        self.memory_cache = {}
    
    async def get_cache(self, key: str, use_memory: bool = False):
        """Get data from cache"""
        # Try memory cache first if enabled
        if use_memory and key in self.memory_cache:
            return self.memory_cache[key]
        
        # Try Redis cache
        cache_data = await self.redis.get(key)
        if cache_data:
            # Parse JSON data
            data = json.loads(cache_data)
            
            # Also store in memory cache if enabled
            if use_memory:
                self.memory_cache[key] = data
                
            return data
            
        return None
    
    async def set_cache(self, key: str, data, ttl_seconds: int, use_memory: bool = False):
        """Set data in cache with TTL"""
        # Convert data to JSON
        json_data = json.dumps(data)
        
        # Store in Redis with TTL
        await self.redis.setex(key, ttl_seconds, json_data)
        
        # Also store in memory cache if enabled
        if use_memory:
            self.memory_cache[key] = data
    
    async def invalidate_cache(self, key: str):
        """Invalidate cache for a specific key"""
        # Remove from memory cache
        if key in self.memory_cache:
            del self.memory_cache[key]
        
        # Remove from Redis cache
        await self.redis.delete(key)
```

### Redis Client Setup

```python
import aioredis
from fastapi import Depends
from app.core.config import settings

# Redis client singleton
_redis_client = None

async def get_redis_client() -> aioredis.Redis:
    """Get or create Redis client"""
    global _redis_client
    
    if _redis_client is None:
        _redis_client = await aioredis.create_redis_pool(
            settings.REDIS_URL,
            password=settings.REDIS_PASSWORD,
            minsize=5,
            maxsize=20
        )
    
    return _redis_client

async def close_redis_client():
    """Close Redis client connection"""
    global _redis_client
    
    if _redis_client is not None:
        _redis_client.close()
        await _redis_client.wait_closed()
        _redis_client = None
```

## Caching Strategies by Data Type

| Data Type | Memory Cache | Redis Cache | TTL |
|-----------|--------------|-------------|-----|
| User Profile | Yes | Yes | 1 hour |
| Inventory Data | No | Yes | 15 minutes |
| Market Prices | Yes | Yes | 5 minutes |
| Price History | No | Yes | 1 hour |
| Market Listings | No | Yes | 2 minutes |

### Inventory Caching Implementation

```python
class SteamInventoryService:
    """Service for handling Steam inventory operations"""
    
    def __init__(self, caching_service: CachingService = Depends(get_caching_service)):
        self.steam_api = SteamWebAPI(api_key=settings.STEAM_API_KEY)
        self.cache = caching_service
    
    async def get_user_inventory(self, steam_id: str):
        """Get user's Steam inventory with caching"""
        # Generate cache key
        cache_key = f"inventory:{steam_id}"
        
        # Try to get from cache first
        cached_data = await self.cache.get_cache(cache_key)
        if cached_data:
            return cached_data
        
        # Cache miss - fetch from API
        try:
            inventory_data = await self.steam_api.get_inventory(steam_id)
            
            # Process inventory data
            processed_inventory = self._process_inventory_data(inventory_data)
            
            # Cache the processed data (15 minute TTL)
            await self.cache.set_cache(cache_key, processed_inventory, 900)
            
            return processed_inventory
        except Exception as e:
            logger.error(f"Error fetching inventory: {str(e)}")
            raise
```

### Market Data Caching Implementation

```python
class SteamMarketService:
    """Service for handling Steam market operations"""
    
    def __init__(self, caching_service: CachingService = Depends(get_caching_service)):
        self.steam_api = SteamWebAPI(api_key=settings.STEAM_API_KEY)
        self.cache = caching_service
    
    async def get_item_price(self, item_name: str):
        """Get current price for a specific item with caching"""
        # Generate cache key
        cache_key = f"price:{item_name}"
        
        # Try to get from cache first (use memory cache for prices)
        cached_data = await self.cache.get_cache(cache_key, use_memory=True)
        if cached_data:
            return cached_data
        
        # Cache miss - fetch from API
        try:
            price_data = await self.steam_api.get_item_price(item_name)
            
            # Cache the data (5 minute TTL)
            await self.cache.set_cache(cache_key, price_data, 300, use_memory=True)
            
            return price_data
        except Exception as e:
            logger.error(f"Error fetching price: {str(e)}")
            raise
```

## Rate Limit Protection

Implement rate limit protection with the following strategies:

1. **Cache Prioritization**: Always check cache before making API calls
2. **Batch Processing**: Combine multiple requests when possible
3. **Request Queuing**: Queue requests when approaching rate limits
4. **Fallback Data**: Use slightly older cached data when rate limited

### Rate Limit Middleware

```python
from fastapi import Request
from fastapi.responses import JSONResponse
from app.utils.redis_config import get_redis_client
import time
import json

async def rate_limit_middleware(request: Request, call_next):
    """Middleware to enforce rate limits for Steam API calls"""
    # Only apply to Steam API endpoints
    path = request.url.path
    if not path.startswith("/api/steam") and not path.startswith("/api/inventory/steam") and not path.startswith("/api/market"):
        return await call_next(request)
    
    # Get Redis client
    redis = await get_redis_client()
    
    # Get current minute as rate limit window
    current_minute = int(time.time() / 60)
    rate_limit_key = f"rate_limit:{current_minute}"
    
    # Increment request count
    request_count = await redis.incr(rate_limit_key)
    
    # Set expiry if this is a new key
    if request_count == 1:
        await redis.expire(rate_limit_key, 120)  # 2 minutes expiry to be safe
    
    # Check if we're over the limit (9 requests per minute to stay under 10)
    if request_count > 9:
        # We're at the rate limit, return cached data if available
        response_headers = {"X-Rate-Limit-Exceeded": "true"}
        
        # For GET requests, try to use cached data
        if request.method == "GET":
            # Try to get a slightly older cached version
            cache_key = f"path:{path}:{request.query_params}"
            cached_response = await redis.get(f"response_cache:{cache_key}")
            
            if cached_response:
                return JSONResponse(
                    content=json.loads(cached_response),
                    headers=response_headers
                )
        
        # No cached data available
        return JSONResponse(
            status_code=429,
            content={"detail": "Rate limit exceeded. Please try again later."},
            headers=response_headers
        )
    
    # Process the request
    response = await call_next(request)
    
    # For successful GET responses, cache them for future use
    if request.method == "GET" and response.status_code == 200:
        # Get the response body
        body = b""
        async for chunk in response.body_iterator:
            body += chunk
        
        # Cache the response
        cache_key = f"path:{path}:{request.query_params}"
        await redis.setex(f"response_cache:{cache_key}", 300, body)  # 5 minute cache
        
        # Create a new response with the same body
        return Response(
            content=body,
            status_code=response.status_code,
            headers=dict(response.headers),
            media_type=response.media_type
        )
    
    return response
```

## Cache Invalidation Strategies

### Time-Based Invalidation

The primary cache invalidation strategy is time-based using TTL (Time To Live):

1. **Short TTL for Volatile Data**: 
   - Market prices: 5 minutes
   - Market listings: 2 minutes
   - Active trades: 1 minute

2. **Medium TTL for Semi-Stable Data**:
   - User inventories: 15 minutes
   - Item details: 30 minutes

3. **Longer TTL for Stable Data**:
   - User profiles: 1 hour
   - Price history: 1 hour
   - Game metadata: 24 hours

### Event-Based Invalidation

Implement event-based cache invalidation for specific scenarios:

1. **Trade Events**: Invalidate inventory cache after successful trades
   ```python
   async def complete_trade(trade_id: str, user_id: str):
       # Process the trade
       result = await process_trade(trade_id)
       
       # Invalidate inventory caches for both users
       await cache_service.invalidate_cache(f"inventory:{result['sender_id']}")
       await cache_service.invalidate_cache(f"inventory:{result['receiver_id']}")
       
       return result
   ```

2. **Market Events**: Invalidate price cache after market transactions
   ```python
   async def complete_market_sale(sale_id: str):
       # Process the sale
       result = await process_market_sale(sale_id)
       
       # Invalidate price cache for the item
       await cache_service.invalidate_cache(f"price:{result['item_name']}")
       
       # Invalidate inventory caches
       await cache_service.invalidate_cache(f"inventory:{result['seller_id']}")
       await cache_service.invalidate_cache(f"inventory:{result['buyer_id']}")
       
       return result
   ```

## Cache Monitoring and Management

Implement cache monitoring to optimize caching strategy:

1. **Cache Hit Rate Tracking**:
   ```python
   class CacheMetrics:
       def __init__(self):
           self.requests = 0
           self.hits = 0
           self.misses = 0
       
       def record_hit(self):
           self.requests += 1
           self.hits += 1
       
       def record_miss(self):
           self.requests += 1
           self.misses += 1
       
       def get_hit_rate(self):
           if self.requests == 0:
               return 0
           return self.hits / self.requests
   
   # Enhanced caching service with metrics
   class CachingService:
       def __init__(self, redis: Redis = Depends(get_redis_client)):
           self.redis = redis
           self.memory_cache = {}
           self.metrics = {
               "inventory": CacheMetrics(),
               "price": CacheMetrics(),
               "market": CacheMetrics()
           }
       
       async def get_cache(self, key: str, use_memory: bool = False):
           # Determine cache type for metrics
           cache_type = key.split(":")[0] if ":" in key else "other"
           if cache_type not in self.metrics:
               cache_type = "other"
           
           # Try to get from cache
           result = None
           
           # Try memory cache first if enabled
           if use_memory and key in self.memory_cache:
               result = self.memory_cache[key]
           
           # Try Redis cache if not in memory
           if result is None:
               cache_data = await self.redis.get(key)
               if cache_data:
                   result = json.loads(cache_data)
                   
                   # Also store in memory cache if enabled
                   if use_memory:
                       self.memory_cache[key] = result
           
           # Record metrics
           if result is not None:
               self.metrics[cache_type].record_hit()
           else:
               self.metrics[cache_type].record_miss()
           
           return result
   ```

2. **Adaptive TTL Based on Hit Rate**:
   ```python
   async def set_cache_with_adaptive_ttl(self, key: str, data, base_ttl: int, use_memory: bool = False):
       # Determine cache type for metrics
       cache_type = key.split(":")[0] if ":" in key else "other"
       if cache_type not in self.metrics:
           cache_type = "other"
       
       # Get current hit rate
       hit_rate = self.metrics[cache_type].get_hit_rate()
       
       # Adjust TTL based on hit rate
       # - Higher hit rate = longer TTL (data is being used frequently)
       # - Lower hit rate = shorter TTL (data is not being accessed often)
       adjusted_ttl = int(base_ttl * (0.5 + hit_rate / 2))  # Between 50% and 150% of base TTL
       
       # Set cache with adjusted TTL
       await self.set_cache(key, data, adjusted_ttl, use_memory)
   ```

## Cross-References

- Authentication implementation: `knowledge/back-end/steam-web-api/authentication.md`
- Security best practices: `knowledge/back-end/steam-web-api/security.md`
- Market data implementation: `knowledge/back-end/steam-web-api/market-data.md`
- Implementation best practices: `knowledge/rules/back-end-steam-web-api/best-practices.md` 