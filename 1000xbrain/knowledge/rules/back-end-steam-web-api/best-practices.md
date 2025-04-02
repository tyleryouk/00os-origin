# USE WHEN implementing best practices for Steam API integration in back-end components

## Overview

This file provides comprehensive guidance on best practices for integrating the Steam Web API in back-end components of the GigaSwap marketplace. It covers authentication implementation, API proxy design, caching strategies, error handling, and security best practices.

## Key Patterns

### Authentication Endpoint Pattern

Best practices for implementing Steam OpenID authentication endpoints:

1. **OpenID Flow Pattern**:
   - Maintain a clean separation of OpenID concerns
   - Implement a dedicated authentication service
   - Handle all OpenID validation securely

2. **Session Management Pattern**:
   - Use secure token generation for session tokens
   - Implement proper token expiration and rotation
   - Store tokens with appropriate security measures

3. **User Profile Management Pattern**:
   - Keep Steam user profiles updated
   - Implement privacy setting awareness
   - Handle profile data changes gracefully

### API Proxy Pattern

For creating secure proxy endpoints to the Steam Web API:

1. **API Key Protection Pattern**:
   - Never expose Steam API keys to clients
   - Use server-side proxy for all Steam API calls
   - Implement rate limiting to protect API keys

2. **Response Transformation Pattern**:
   - Transform Steam API responses to fit your data models
   - Strip unnecessary data to reduce payload size
   - Normalize response formats across different endpoints

3. **Error Normalization Pattern**:
   - Convert Steam API errors to consistent formats
   - Provide clear error messages to clients
   - Log detailed error information server-side

### Caching Strategy Pattern

For optimizing Steam API usage with caching:

1. **Multi-Level Caching Pattern**:
   - Implement memory cache for high-frequency data
   - Use Redis for distributed caching
   - Add database persistence for critical data

2. **TTL-Based Invalidation Pattern**:
   - Set appropriate TTLs based on data volatility
   - Implement longer TTLs for static data
   - Use shorter TTLs for volatile data like prices

3. **Cache Refresh Strategy Pattern**:
   - Implement background refresh for critical data
   - Use stale-while-revalidate pattern
   - Add cache warming for frequently accessed data

### Security Implementation Pattern

For securing Steam-related functionality:

1. **Authentication Verification Pattern**:
   - Verify authentication for all protected endpoints
   - Implement proper token validation
   - Add rate limiting for authentication attempts

2. **API Key Management Pattern**:
   - Store API keys securely using environment variables
   - Implement API key rotation procedures
   - Monitor API usage for unusual patterns

3. **CORS Security Pattern**:
   - Implement restrictive CORS policy
   - Allow only trusted origins
   - Enable credentials only for trusted domains

## Implementation Guidelines

### API Endpoint Design

Organize Steam-related endpoints using this structure:

```
/api
  /auth
    /steam
      GET  /               # Initiate Steam login
      GET  /callback       # Process OpenID callback
      GET  /status         # Check authentication status
      POST /logout         # Logout user
  /inventory
    GET  /steam            # Get authenticated user's inventory
    GET  /steam/:steamId   # Get specific user's inventory
  /market
    GET  /steam/prices     # Get market prices
    GET  /steam/history    # Get price history
  /trading
    POST /steam/offers     # Create trade offer
    GET  /steam/offers     # Get trade offers
    GET  /steam/history    # Get trade history
```

### Authentication Implementation

1. **OpenID Service**:
   - Implement a dedicated OpenID authentication service
   - Handle all OpenID validation and verification
   - Manage user profile creation and updates

```python
# services/steam_auth_service.py
class SteamAuthService:
    def __init__(self, config, logger):
        self.api_key = config.STEAM_API_KEY
        self.openid_url = "https://steamcommunity.com/openid"
        self.logger = logger
        
    async def get_auth_url(self, return_url):
        """Generate Steam OpenID authentication URL"""
        params = {
            'openid.ns': 'http://specs.openid.net/auth/2.0',
            'openid.mode': 'checkid_setup',
            'openid.return_to': return_url,
            'openid.realm': return_url,
            'openid.identity': 'http://specs.openid.net/auth/2.0/identifier_select',
            'openid.claimed_id': 'http://specs.openid.net/auth/2.0/identifier_select',
        }
        return f"{self.openid_url}/login?{urlencode(params)}"
        
    async def validate_auth_response(self, params):
        """Validate the OpenID authentication response"""
        # Convert mode to verification mode
        verification = dict(params)
        verification['openid.mode'] = 'check_authentication'
        
        # Verify with Steam
        async with aiohttp.ClientSession() as session:
            async with session.post(self.openid_url, data=verification) as resp:
                response_text = await resp.text()
                if 'is_valid:true' not in response_text:
                    self.logger.error(f"Steam validation failed: {response_text}")
                    return None
                    
        # Extract Steam ID from claimed_id
        match = re.search(r'steamcommunity.com/openid/id/(.*?)$', 
                          params.get('openid.claimed_id', ''))
        if not match:
            self.logger.error("Failed to extract Steam ID")
            return None
            
        return match.group(1)
        
    async def get_user_profile(self, steam_id):
        """Get user profile from Steam API"""
        url = f"https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/"
        params = {
            "key": self.api_key,
            "steamids": steam_id
        }
        
        try:
            async with aiohttp.ClientSession() as session:
                async with session.get(url, params=params) as resp:
                    if resp.status != 200:
                        self.logger.error(f"Steam API error: {resp.status}")
                        return None
                        
                    data = await resp.json()
                    players = data.get('response', {}).get('players', [])
                    if not players:
                        return None
                        
                    return players[0]
        except Exception as e:
            self.logger.error(f"Error fetching user profile: {str(e)}")
            return None
```

2. **Token Management**:
   - Implement secure token generation and validation
   - Use Redis for token storage
   - Add proper token expiration

```python
# services/token_service.py
import secrets
import time
import json
from typing import Optional

class TokenService:
    def __init__(self, redis_client, logger, config):
        self.redis = redis_client
        self.logger = logger
        self.token_prefix = "steam_token:"
        self.token_expiry = config.TOKEN_EXPIRY  # in seconds
        
    async def create_token(self, user_data):
        """Create a new authentication token"""
        # Generate secure token
        token = secrets.token_hex(32)
        
        # Store in Redis with expiration
        key = f"{self.token_prefix}{token}"
        await self.redis.set(key, json.dumps(user_data), expire=self.token_expiry)
        
        self.logger.info(f"Created token for user {user_data.get('steam_id')}")
        return token
        
    async def validate_token(self, token) -> Optional[dict]:
        """Validate token and return user data"""
        if not token:
            return None
            
        key = f"{self.token_prefix}{token}"
        data = await self.redis.get(key)
        
        if not data:
            return None
            
        try:
            user_data = json.loads(data)
            
            # Extend token expiration on successful validation
            await self.redis.expire(key, self.token_expiry)
            
            return user_data
        except Exception as e:
            self.logger.error(f"Error validating token: {str(e)}")
            return None
            
    async def invalidate_token(self, token):
        """Invalidate/delete token"""
        if not token:
            return False
            
        key = f"{self.token_prefix}{token}"
        result = await self.redis.delete(key)
        
        return result > 0
```

### Caching Implementation

1. **Redis Caching Service**:
   - Implement a dedicated caching service
   - Add methods for different cache operations
   - Use appropriate TTLs for different data types

```python
# services/cache_service.py
import json
from typing import Optional, Any, Dict, List

class CacheService:
    def __init__(self, redis_client, logger):
        self.redis = redis_client
        self.logger = logger
        self.ttls = {
            "inventory": 15 * 60,  # 15 minutes
            "market_price": 5 * 60,  # 5 minutes
            "price_history": 60 * 60,  # 1 hour
            "user_profile": 24 * 60 * 60,  # 24 hours
        }
        
    async def get(self, cache_key: str) -> Optional[Any]:
        """Get data from cache"""
        try:
            data = await self.redis.get(cache_key)
            if not data:
                return None
                
            return json.loads(data)
        except Exception as e:
            self.logger.error(f"Cache get error for {cache_key}: {str(e)}")
            return None
            
    async def set(self, cache_key: str, data: Any, cache_type: str = "inventory") -> bool:
        """Set data in cache with appropriate TTL"""
        try:
            ttl = self.ttls.get(cache_type, 15 * 60)  # Default 15 minutes
            
            await self.redis.set(
                cache_key,
                json.dumps(data),
                expire=ttl
            )
            return True
        except Exception as e:
            self.logger.error(f"Cache set error for {cache_key}: {str(e)}")
            return False
            
    async def delete(self, cache_key: str) -> bool:
        """Delete data from cache"""
        try:
            result = await self.redis.delete(cache_key)
            return result > 0
        except Exception as e:
            self.logger.error(f"Cache delete error for {cache_key}: {str(e)}")
            return False
            
    async def get_inventory(self, steam_id: str) -> Optional[List[Dict]]:
        """Get cached inventory data"""
        return await self.get(f"inventory:{steam_id}")
        
    async def set_inventory(self, steam_id: str, inventory_data: List[Dict]) -> bool:
        """Cache inventory data"""
        return await self.set(f"inventory:{steam_id}", inventory_data, "inventory")
        
    async def get_market_price(self, item_name: str) -> Optional[Dict]:
        """Get cached market price data"""
        return await self.get(f"market_price:{item_name}")
        
    async def set_market_price(self, item_name: str, price_data: Dict) -> bool:
        """Cache market price data"""
        return await self.set(f"market_price:{item_name}", price_data, "market_price")
```

### API Proxy Implementation

1. **Steam API Proxy Service**:
   - Create a proxy service for Steam Web API calls
   - Add caching to reduce API calls
   - Implement proper error handling

```python
# services/steam_api_service.py
import aiohttp
from typing import Dict, List, Optional

class SteamAPIService:
    def __init__(self, config, logger, cache_service):
        self.api_key = config.STEAM_API_KEY
        self.logger = logger
        self.cache = cache_service
        self.base_url = "https://api.steampowered.com"
        self.backup_url = "https://api.steamwebapi.com"  # Backup API service
        
    async def get_inventory(self, steam_id: str) -> List[Dict]:
        """Get user's CS2 inventory"""
        # Check cache first
        cached_inventory = await self.cache.get_inventory(steam_id)
        if cached_inventory:
            self.logger.info(f"Returning cached inventory for {steam_id}")
            return cached_inventory
            
        # Fetch from Steam API
        try:
            url = f"https://steamcommunity.com/inventory/{steam_id}/730/2"
            params = {
                "l": "english",
                "count": 5000
            }
            
            async with aiohttp.ClientSession() as session:
                async with session.get(url, params=params) as resp:
                    if resp.status != 200:
                        self.logger.error(f"Steam inventory API error: {resp.status}")
                        return []
                        
                    data = await resp.json()
                    
                    # Process inventory data
                    inventory = self._process_inventory_data(data)
                    
                    # Cache the results
                    await self.cache.set_inventory(steam_id, inventory)
                    
                    return inventory
        except Exception as e:
            self.logger.error(f"Error fetching inventory: {str(e)}")
            return []
            
    def _process_inventory_data(self, data: Dict) -> List[Dict]:
        """Process raw inventory data into standardized format"""
        inventory = []
        
        if not data or 'assets' not in data or 'descriptions' not in data:
            return inventory
            
        # Create lookup for descriptions
        descriptions = {
            f"{item['classid']}_{item['instanceid']}": item
            for item in data['descriptions']
        }
        
        # Process assets
        for asset in data['assets']:
            key = f"{asset['classid']}_{asset['instanceid']}"
            if key in descriptions:
                desc = descriptions[key]
                
                # Create standardized item format
                item = {
                    'asset_id': asset['assetid'],
                    'class_id': asset['classid'],
                    'instance_id': asset['instanceid'],
                    'name': desc.get('name', 'Unknown Item'),
                    'market_name': desc.get('market_name', 'Unknown Item'),
                    'type': desc.get('type', 'Unknown Type'),
                    'rarity': self._extract_rarity(desc),
                    'marketable': bool(int(desc.get('marketable', 0))),
                    'tradable': bool(int(desc.get('tradable', 0))),
                    'icon_url': f"https://steamcommunity-a.akamaihd.net/economy/image/{desc.get('icon_url', '')}",
                    'name_color': f"#{desc.get('name_color', '')}",
                    'inspect_link': self._extract_inspect_link(desc, asset['assetid'], steam_id),
                }
                
                inventory.append(item)
                
        return inventory
        
    def _extract_rarity(self, desc: Dict) -> str:
        """Extract item rarity from description tags"""
        if 'tags' not in desc:
            return 'Common'
            
        for tag in desc['tags']:
            if tag.get('category') == 'Rarity':
                return tag.get('name', 'Common')
                
        return 'Common'
        
    def _extract_inspect_link(self, desc: Dict, asset_id: str, steam_id: str) -> Optional[str]:
        """Extract or build inspect link for the item"""
        actions = desc.get('actions', [])
        for action in actions:
            if 'link' in action and 'steam://rungame' in action['link']:
                return action['link'].replace('%assetid%', asset_id).replace('%owner_steamid%', steam_id)
                
        return None
```

### Error Handling

1. **Standardized Error Response Pattern**:
   - Create standardized error responses
   - Include appropriate HTTP status codes
   - Log detailed error information

```python
# utils/error_handling.py
from fastapi import HTTPException
from typing import Dict, Any, Optional

class APIError(Exception):
    """Base API error class with standardized format"""
    def __init__(
        self,
        status_code: int,
        error_code: str,
        message: str,
        details: Optional[Dict[str, Any]] = None
    ):
        self.status_code = status_code
        self.error_code = error_code
        self.message = message
        self.details = details or {}
        super().__init__(self.message)
        
    def to_dict(self) -> Dict[str, Any]:
        """Convert error to dictionary for response"""
        return {
            "error": True,
            "error_code": self.error_code,
            "message": self.message,
            "details": self.details
        }
        
# Common Steam API errors
class SteamAPIError(APIError):
    """Error when Steam API fails"""
    def __init__(self, message: str, details: Optional[Dict[str, Any]] = None):
        super().__init__(
            status_code=502,
            error_code="steam_api_error",
            message=message,
            details=details
        )
        
class SteamAuthError(APIError):
    """Error when Steam authentication fails"""
    def __init__(self, message: str, details: Optional[Dict[str, Any]] = None):
        super().__init__(
            status_code=401,
            error_code="steam_auth_error",
            message=message,
            details=details
        )
        
class SteamInventoryError(APIError):
    """Error when inventory fetching fails"""
    def __init__(self, message: str, details: Optional[Dict[str, Any]] = None):
        super().__init__(
            status_code=400,
            error_code="steam_inventory_error",
            message=message,
            details=details
        )
        
class PrivacySettingsError(APIError):
    """Error when privacy settings prevent access"""
    def __init__(self, message: str, details: Optional[Dict[str, Any]] = None):
        super().__init__(
            status_code=403,
            error_code="privacy_settings_error",
            message=message,
            details=details
        )

# Error handler for routers
def steam_error_handler(func):
    """Decorator to handle Steam API errors in routes"""
    async def wrapper(*args, **kwargs):
        try:
            return await func(*args, **kwargs)
        except APIError as e:
            # Already formatted error, just raise HTTP exception
            raise HTTPException(
                status_code=e.status_code,
                detail=e.to_dict()
            )
        except Exception as e:
            # Unexpected error, log it and return generic error
            logger.error(f"Unexpected error in {func.__name__}: {str(e)}")
            raise HTTPException(
                status_code=500,
                detail={
                    "error": True,
                    "error_code": "internal_server_error",
                    "message": "An unexpected error occurred",
                    "details": {"original_error": str(e)} if DEBUG else {}
                }
            )
    return wrapper
```

### Rate Limiting

1. **Rate Limiting Implementation**:
   - Protect Steam API endpoints with rate limiting
   - Implement user-specific rate limits
   - Add Redis-based rate limiter

```python
# middleware/rate_limiter.py
from fastapi import Request, HTTPException
from datetime import datetime
import time
import hashlib

class RateLimiter:
    def __init__(self, redis_client, logger, config):
        self.redis = redis_client
        self.logger = logger
        self.rate_limits = {
            "auth": 10,         # 10 requests per minute for auth endpoints
            "inventory": 5,     # 5 requests per minute for inventory endpoints
            "market": 20,       # 20 requests per minute for market data
            "trading": 10       # 10 requests per minute for trading endpoints
        }
        self.window_seconds = 60  # 1 minute window
        
    async def check_rate_limit(self, request: Request, endpoint_type: str):
        """Check if request is rate limited"""
        ip = self._get_client_ip(request)
        user_id = self._get_user_id(request)
        
        # Create unique key for this client and endpoint type
        client_key = f"rate_limit:{endpoint_type}:{user_id or ip}:{int(time.time() / self.window_seconds)}"
        
        # Increment counter
        current = await self.redis.incr(client_key)
        
        # Set expiry if new key
        if current == 1:
            await self.redis.expire(client_key, self.window_seconds)
            
        # Get rate limit for this endpoint type
        limit = self.rate_limits.get(endpoint_type, 10)
        
        # Check if exceeded
        if current > limit:
            self.logger.warning(f"Rate limit exceeded for {endpoint_type} by {user_id or ip}")
            raise HTTPException(
                status_code=429,
                detail={
                    "error": True,
                    "error_code": "rate_limit_exceeded",
                    "message": f"Rate limit exceeded for {endpoint_type} endpoints",
                    "details": {
                        "limit": limit,
                        "current": current,
                        "reset": self.window_seconds - (int(time.time()) % self.window_seconds)
                    }
                }
            )
            
        # Set headers for rate limit info
        request.state.rate_limit = {
            "limit": limit,
            "current": current,
            "remaining": limit - current,
            "reset": self.window_seconds - (int(time.time()) % self.window_seconds)
        }
        
        return True
        
    def _get_client_ip(self, request: Request) -> str:
        """Get client IP from request headers or connection"""
        forwarded = request.headers.get("X-Forwarded-For")
        if forwarded:
            return forwarded.split(",")[0].strip()
        return request.client.host if request.client else "unknown"
        
    def _get_user_id(self, request: Request) -> str:
        """Get user ID from request if authenticated"""
        if hasattr(request.state, "user") and request.state.user:
            return request.state.user.get("steam_id", None)
        return None
```

## Security Considerations

### API Key Protection

1. **Secure Storage**:
   - Use environment variables or secrets manager
   - Never hardcode API keys in code
   - Implement API key rotation procedures

2. **Rate Limit Protection**:
   - Implement server-side rate limiting
   - Monitor API usage patterns
   - Add alerts for unusual API usage

3. **Proxy All Requests**:
   - Never expose API keys to clients
   - Use back-end proxy endpoints
   - Implement proper authentication

### Authentication Security

1. **OpenID Verification**:
   - Always verify OpenID responses
   - Implement proper validation checks
   - Protect against replay attacks

2. **Token Security**:
   - Use cryptographically secure tokens
   - Implement proper token expiration
   - Store tokens securely (Redis with expiration)

3. **HTTPS Requirements**:
   - Require HTTPS for all authentication endpoints
   - Use secure cookies for session management
   - Implement HSTS headers

### Error Handling Security

1. **Sanitized Error Messages**:
   - Return sanitized error messages to clients
   - Log detailed error information server-side
   - Prevent information leakage in errors

2. **Error Monitoring**:
   - Implement comprehensive error logging
   - Add alerts for security-related errors
   - Monitor for suspicious error patterns

## Cross-References

- **Back-End Authentication**: `knowledge/back-end/steam-web-api/authentication.md`
- **Back-End Inventory**: `knowledge/back-end/steam-web-api/inventory.md`
- **Back-End Market Data**: `knowledge/back-end/steam-web-api/market-data.md`
- **Back-End Trading**: `knowledge/back-end/steam-web-api/trading.md`
- **Front-End Authentication**: `knowledge/front-end/steam-web-api/authentication.md` 