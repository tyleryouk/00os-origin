# USE WHEN implementing Steam Web API functionality in back-end components

## Overview

This guide provides comprehensive implementation guidance for integrating Steam Web API functionality into the GigaSwap back-end application. It covers essential components including authentication, inventory data retrieval, market data access, and trading operations.

## Implementation Approach

Follow this phased implementation approach for the back-end Steam Web API integration:

### Phase 1: Authentication Implementation

1. **Create Authentication Endpoints**:
   - Implement Steam OpenID authentication routes
   - Develop token validation and session management
   - Create user profile data retrieval endpoint

2. **Authentication Flow Implementation**:
   - Initialize Steam OpenID authentication
   - Handle callback and token exchange
   - Implement session creation and management
   - Create secure logout functionality

3. **Security Implementation**:
   - Implement token validation mechanisms
   - Create CSRF protection
   - Add rate limiting for authentication endpoints
   - Implement secure cookie handling

### Phase 2: Inventory Implementation

1. **Create Inventory Endpoints**:
   - Implement Steam inventory retrieval routes
   - Develop item data transformation
   - Create caching middleware for inventory data

2. **Inventory Retrieval Logic**:
   - Implement Steam inventory API client
   - Create item structure mapping
   - Add inventory filtering capabilities
   - Implement inventory refresh functionality

3. **Caching System**:
   - Create tiered caching system for inventory data
   - Implement cache invalidation strategies
   - Add background refresh mechanisms
   - Create cache monitoring and analytics

### Phase 3: Market Data Implementation

1. **Create Market Data Endpoints**:
   - Implement market price retrieval routes
   - Develop price history endpoints
   - Create market listing retrieval

2. **Market Data Services**:
   - Implement Steam market API client
   - Create price aggregation services
   - Add historical data processing
   - Implement market trend analysis

3. **Data Processing System**:
   - Create data normalization utilities
   - Implement price conversion services
   - Add market data analytics
   - Create data visualization endpoints

### Phase 4: Trading Implementation

1. **Create Trading Endpoints**:
   - Implement trade offer creation routes
   - Develop trade status endpoints
   - Create trade history retrieval

2. **Trading Services**:
   - Implement Steam trading API client
   - Create trade validation service
   - Add trade status tracking
   - Implement trade history recording

3. **Security Implementation**:
   - Create trade validation checks
   - Implement fraud prevention
   - Add trade limits and safeguards
   - Create security audit logging

## Implementation Details

### Authentication Implementation

```python
# app/routers/steam_auth.py
from fastapi import APIRouter, Depends, HTTPException, Request, Response
from fastapi.responses import RedirectResponse
from app.services.steam_auth_service import SteamAuthService
from app.core.config import settings
from app.models.steam_user import SteamUser
from app.core.logger import logger

router = APIRouter(prefix="/auth/steam", tags=["authentication"])
auth_service = SteamAuthService()

@router.get("/login")
async def login():
    """
    Initiate Steam OpenID authentication
    """
    try:
        # Log authentication attempt
        logger.info("Steam login initiated")
        
        # Generate Steam OpenID URL
        login_url = auth_service.get_steam_login_url()
        
        # Redirect to Steam for authentication
        return RedirectResponse(url=login_url)
    except Exception as e:
        logger.error(f"Steam login error: {str(e)}")
        raise HTTPException(status_code=500, detail="Authentication initialization failed")

@router.get("/callback")
async def callback(request: Request, response: Response):
    """
    Handle Steam authentication callback
    """
    try:
        # Extract parameters from request
        params = dict(request.query_params)
        
        # Validate OpenID response
        steam_id = auth_service.validate_steam_response(params)
        
        if not steam_id:
            raise HTTPException(status_code=401, detail="Authentication failed")
        
        # Get user profile data
        user_data = await auth_service.get_steam_user_data(steam_id)
        
        # Create session
        token = auth_service.create_session(user_data)
        
        # Set secure cookie
        response = RedirectResponse(url=settings.FRONTEND_URL)
        response.set_cookie(
            key="steam_session",
            value=token,
            httponly=True,
            secure=settings.PRODUCTION,
            samesite="lax",
            max_age=settings.SESSION_LIFETIME
        )
        
        logger.info(f"Steam authentication successful for user {steam_id}")
        return response
    except Exception as e:
        logger.error(f"Steam callback error: {str(e)}")
        return RedirectResponse(
            url=f"{settings.FRONTEND_URL}/auth-error?message={str(e)}"
        )

@router.get("/status")
async def auth_status(user: SteamUser = Depends(auth_service.get_current_user)):
    """
    Get current authentication status
    """
    if user:
        return {"authenticated": True, "user": user.dict()}
    return {"authenticated": False}

@router.post("/logout")
async def logout(response: Response):
    """
    Log out user by clearing session
    """
    response.delete_cookie(key="steam_session")
    return {"success": True}
```

```python
# app/services/steam_auth_service.py
import requests
import time
import jwt
from urllib.parse import urlencode
from app.core.config import settings
from app.models.steam_user import SteamUser
from app.core.logger import logger

class SteamAuthService:
    def __init__(self):
        self.api_key = settings.STEAM_API_KEY
        self.realm = settings.API_URL
        self.return_url = f"{settings.API_URL}/auth/steam/callback"
        self.jwt_secret = settings.JWT_SECRET
    
    def get_steam_login_url(self):
        """
        Generate Steam OpenID authentication URL
        """
        params = {
            'openid.ns': 'http://specs.openid.net/auth/2.0',
            'openid.mode': 'checkid_setup',
            'openid.return_to': self.return_url,
            'openid.realm': self.realm,
            'openid.identity': 'http://specs.openid.net/auth/2.0/identifier_select',
            'openid.claimed_id': 'http://specs.openid.net/auth/2.0/identifier_select'
        }
        
        return f"https://steamcommunity.com/openid/login?{urlencode(params)}"
    
    def validate_steam_response(self, params):
        """
        Validate Steam OpenID response
        """
        # Check if response has required parameters
        if 'openid.mode' not in params or params['openid.mode'] != 'id_res':
            return None
        
        # Prepare validation parameters
        validation_params = {
            'openid.assoc_handle': params['openid.assoc_handle'],
            'openid.signed': params['openid.signed'],
            'openid.sig': params['openid.sig'],
            'openid.ns': params['openid.ns']
        }
        
        # Add signed fields
        signed_fields = params['openid.signed'].split(',')
        for field in signed_fields:
            key = f'openid.{field}'
            if key in params:
                validation_params[key] = params[key]
        
        # Change mode to check_authentication
        validation_params['openid.mode'] = 'check_authentication'
        
        # Validate with Steam
        response = requests.post('https://steamcommunity.com/openid/login', data=validation_params)
        
        if 'is_valid:true' not in response.text:
            return None
        
        # Extract Steam ID from identity URL
        claimed_id = params['openid.claimed_id']
        steam_id = claimed_id.split('/')[-1]
        
        return steam_id
    
    async def get_steam_user_data(self, steam_id):
        """
        Get Steam user profile data
        """
        url = f"https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/"
        params = {
            'key': self.api_key,
            'steamids': steam_id
        }
        
        try:
            response = requests.get(url, params=params)
            data = response.json()
            
            if 'response' in data and 'players' in data['response'] and len(data['response']['players']) > 0:
                player = data['response']['players'][0]
                
                return SteamUser(
                    steam_id=steam_id,
                    personaname=player.get('personaname', ''),
                    avatar=player.get('avatar', ''),
                    avatarfull=player.get('avatarfull', ''),
                    profileurl=player.get('profileurl', '')
                )
            
            return None
        except Exception as e:
            logger.error(f"Error fetching Steam user data: {str(e)}")
            return None
    
    def create_session(self, user_data):
        """
        Create JWT session token
        """
        if not user_data:
            return None
        
        payload = {
            'steam_id': user_data.steam_id,
            'exp': int(time.time()) + settings.SESSION_LIFETIME
        }
        
        token = jwt.encode(payload, self.jwt_secret, algorithm='HS256')
        return token
    
    def get_current_user(self, request: Request):
        """
        Get current user from session token
        """
        token = request.cookies.get('steam_session')
        
        if not token:
            return None
        
        try:
            payload = jwt.decode(token, self.jwt_secret, algorithms=['HS256'])
            steam_id = payload.get('steam_id')
            
            if not steam_id:
                return None
            
            # Get user data from database or cache
            # For now, we'll assume we have a get_user_by_steam_id function
            user = get_user_by_steam_id(steam_id)
            
            return user
        except jwt.ExpiredSignatureError:
            return None
        except jwt.InvalidTokenError:
            return None
```

### Inventory Implementation

```python
# app/routers/steam_inventory.py
from fastapi import APIRouter, Depends, HTTPException, Query
from app.services.steam_inventory_service import SteamInventoryService
from app.services.steam_auth_service import SteamAuthService
from app.models.steam_user import SteamUser
from app.core.logger import logger

router = APIRouter(prefix="/inventory/steam", tags=["inventory"])
inventory_service = SteamInventoryService()
auth_service = SteamAuthService()

@router.get("/")
async def get_inventory(
    refresh: bool = Query(False),
    user: SteamUser = Depends(auth_service.get_current_user)
):
    """
    Get user's Steam CS2 inventory
    """
    if not user:
        raise HTTPException(status_code=401, detail="Authentication required")
    
    try:
        # Log inventory access
        logger.info(f"Retrieving inventory for user {user.steam_id}")
        
        # Get inventory items
        items = await inventory_service.get_user_inventory(
            user.steam_id, 
            force_refresh=refresh
        )
        
        return items
    except Exception as e:
        logger.error(f"Inventory retrieval error: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/item/{asset_id}")
async def get_inventory_item(
    asset_id: str,
    user: SteamUser = Depends(auth_service.get_current_user)
):
    """
    Get specific item from user's inventory
    """
    if not user:
        raise HTTPException(status_code=401, detail="Authentication required")
    
    try:
        item = await inventory_service.get_inventory_item(user.steam_id, asset_id)
        
        if not item:
            raise HTTPException(status_code=404, detail="Item not found")
        
        return item
    except Exception as e:
        logger.error(f"Item retrieval error: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))
```

```python
# app/services/steam_inventory_service.py
import requests
import asyncio
from fastapi import HTTPException
from app.core.config import settings
from app.core.cache import redis_cache
from app.models.steam_item import SteamItem
from app.services.market_service import MarketService
from app.core.logger import logger

class SteamInventoryService:
    def __init__(self):
        self.api_key = settings.STEAM_API_KEY
        self.app_id = 730  # CS2 (previously CS:GO) App ID
        self.context_id = 2  # CS2 context ID
        self.market_service = MarketService()
    
    async def get_user_inventory(self, steam_id: str, force_refresh: bool = False):
        """
        Get user's CS2 inventory
        """
        # Check cache first if not forcing refresh
        cache_key = f"inventory:{steam_id}"
        
        if not force_refresh:
            cached_data = await redis_cache.get(cache_key)
            if cached_data:
                logger.info(f"Returning cached inventory for user {steam_id}")
                return cached_data
        
        # Fetch data from Steam
        url = f"https://api.steampowered.com/IEconItems_{self.app_id}/GetPlayerItems/v1/"
        params = {
            'key': self.api_key,
            'steamid': steam_id
        }
        
        try:
            response = requests.get(url, params=params)
            data = response.json()
            
            if 'result' not in data or data['result']['status'] != 1:
                raise HTTPException(status_code=500, detail="Failed to fetch inventory")
            
            # Process items
            raw_items = data['result'].get('items', [])
            
            # Transform to our model
            items = []
            for item in raw_items:
                try:
                    transformed_item = self._transform_item(item)
                    
                    # Fetch market price if item is marketable
                    if transformed_item.marketable:
                        market_data = await self.market_service.get_item_market_data(
                            transformed_item.market_hash_name
                        )
                        if market_data:
                            transformed_item.price = market_data.get('lowest_price')
                    
                    items.append(transformed_item)
                except Exception as e:
                    logger.error(f"Error transforming item: {str(e)}")
            
            # Cache the inventory
            await redis_cache.set(
                cache_key, 
                items, 
                expiry=settings.INVENTORY_CACHE_TTL
            )
            
            logger.info(f"Retrieved and cached {len(items)} inventory items for user {steam_id}")
            return items
        except Exception as e:
            logger.error(f"Steam inventory service error: {str(e)}")
            raise HTTPException(status_code=500, detail=str(e))
    
    async def get_inventory_item(self, steam_id: str, asset_id: str):
        """
        Get specific item from user's inventory
        """
        items = await self.get_user_inventory(steam_id)
        
        for item in items:
            if item.asset_id == asset_id:
                return item
        
        return None
    
    def _transform_item(self, raw_item):
        """
        Transform Steam inventory item to our model
        """
        # Extract basic properties
        asset_id = str(raw_item.get('id', ''))
        defindex = raw_item.get('defindex')
        classid = raw_item.get('classid')
        instanceid = raw_item.get('instanceid')
        
        # Get item details
        name = raw_item.get('name', '')
        market_hash_name = raw_item.get('market_hash_name', name)
        
        # Extract attributes
        attributes = raw_item.get('attributes', [])
        
        # Determine weapon properties
        weapon_type = self._extract_weapon_type(name)
        skin_name = self._extract_skin_name(name)
        
        # Determine wear value if present
        wear = None
        for attr in attributes:
            if attr.get('defindex') == 8:  # Float value attribute
                wear = float(attr.get('float_value', 0))
        
        # Check if item is StatTrak
        is_stattrak = 'StatTrak™' in name
        
        # Create item model
        return SteamItem(
            asset_id=asset_id,
            classid=classid,
            instanceid=instanceid,
            defindex=defindex,
            name=name,
            market_hash_name=market_hash_name,
            weapon=weapon_type,
            skin=skin_name,
            wear=wear,
            is_stattrak=is_stattrak,
            tradable=bool(raw_item.get('tradable', 0)),
            marketable=bool(raw_item.get('marketable', 0)),
            commodity=bool(raw_item.get('commodity', 0))
        )
    
    def _extract_weapon_type(self, name):
        """
        Extract weapon type from item name
        """
        # List of CS2 weapon types to check
        weapon_types = [
            'AK-47', 'M4A4', 'M4A1-S', 'AWP', 'Desert Eagle', 
            'Glock-18', 'USP-S', 'P250', 'P2000', 'Five-SeveN',
            'Tec-9', 'CZ75-Auto', 'Dual Berettas', 'R8 Revolver',
            'MP5-SD', 'MP7', 'MP9', 'MAC-10', 'UMP-45', 'P90',
            'PP-Bizon', 'M249', 'Negev', 'Nova', 'XM1014',
            'MAG-7', 'Sawed-Off', 'FAMAS', 'Galil AR', 'AUG',
            'SG 553', 'SSG 08', 'G3SG1', 'SCAR-20', 'Knife'
        ]
        
        for weapon in weapon_types:
            if weapon in name:
                return weapon
        
        return 'Other'
    
    def _extract_skin_name(self, name):
        """
        Extract skin name from item name
        """
        parts = name.split('|')
        if len(parts) > 1:
            # Remove wear information
            skin_part = parts[1].split('(')[0].strip()
            return skin_part
        
        return 'Default'
```

### Market Data Implementation

```python
# app/routers/steam_market.py
from fastapi import APIRouter, HTTPException, Query
from typing import Optional
from app.services.market_service import MarketService
from app.core.logger import logger

router = APIRouter(prefix="/market/steam", tags=["market"])
market_service = MarketService()

@router.get("/price/{item_name}")
async def get_item_price(item_name: str):
    """
    Get current market price for an item
    """
    try:
        # Log market price request
        logger.info(f"Market price requested for {item_name}")
        
        # Get market data
        market_data = await market_service.get_item_market_data(item_name)
        
        if not market_data:
            raise HTTPException(status_code=404, detail="Market data not found")
        
        return market_data
    except Exception as e:
        logger.error(f"Market price error: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/history/{item_name}")
async def get_price_history(
    item_name: str,
    days: Optional[int] = Query(7, ge=1, le=90)
):
    """
    Get price history for an item
    """
    try:
        # Log history request
        logger.info(f"Price history requested for {item_name}, days={days}")
        
        # Get price history
        history = await market_service.get_price_history(item_name, days)
        
        if not history:
            raise HTTPException(status_code=404, detail="Price history not found")
        
        return history
    except Exception as e:
        logger.error(f"Price history error: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/listings/{item_name}")
async def get_market_listings(
    item_name: str,
    limit: int = Query(10, ge=1, le=100)
):
    """
    Get current market listings for an item
    """
    try:
        # Log listings request
        logger.info(f"Market listings requested for {item_name}")
        
        # Get listings
        listings = await market_service.get_market_listings(item_name, limit)
        
        return listings
    except Exception as e:
        logger.error(f"Market listings error: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))
```

## Implementation Best Practices

1. **API Rate Limiting**:
   - Implement rate limiting for Steam API calls
   - Create exponential backoff for retries
   - Use API quotas to prevent overuse

2. **Caching Strategy**:
   - Implement multi-level caching (memory, Redis)
   - Use appropriate TTLs based on data volatility
   - Implement cache invalidation strategies

3. **Error Handling**:
   - Implement comprehensive error handling
   - Create detailed logging for API issues
   - Develop fallback mechanisms

4. **Security Best Practices**:
   - Use HTTPs for all Steam API communications
   - Store API keys securely in environment variables
   - Implement proper input validation
   - Use secure token storage

## Integration with Existing Components

### Database Integration

```python
# app/db/models/steam_user.py
from sqlalchemy import Column, String, DateTime, Boolean
from sqlalchemy.sql import func
from app.db.base import Base

class SteamUserDB(Base):
    __tablename__ = "steam_users"
    
    steam_id = Column(String, primary_key=True, index=True)
    personaname = Column(String)
    avatar = Column(String)
    avatarfull = Column(String)
    profileurl = Column(String)
    created_at = Column(DateTime, server_default=func.now())
    updated_at = Column(DateTime, server_default=func.now(), onupdate=func.now())
    
    # Relationship to inventory items, trades, etc.
```

### Item Service Integration

```python
# app/services/item_service.py
from app.models.item import Item
from app.services.steam_inventory_service import SteamInventoryService
from app.core.logger import logger

class ItemService:
    def __init__(self):
        self.steam_inventory_service = SteamInventoryService()
    
    async def get_user_items(self, user_id):
        """
        Get all items for a user from all sources
        """
        try:
            # Get items from database
            db_items = get_db_items_for_user(user_id)
            
            # Get Steam inventory items if user has Steam ID
            steam_items = []
            user = get_user_by_id(user_id)
            if user and user.steam_id:
                steam_items = await self.steam_inventory_service.get_user_inventory(user.steam_id)
            
            # Combine and return all items
            return {
                "db_items": db_items,
                "steam_items": steam_items
            }
        except Exception as e:
            logger.error(f"Error getting items for user {user_id}: {str(e)}")
            return {"db_items": [], "steam_items": []}
```

## Testing Approach

1. **API Testing**:
   - Write unit tests for all API endpoints
   - Create integration tests for Steam API interactions
   - Test error handling and rate limiting

2. **Authentication Testing**:
   - Test OpenID authentication flow
   - Verify token validation
   - Test session management

3. **Data Validation Testing**:
   - Verify data transformation accuracy
   - Test against real Steam API responses
   - Validate model conformity

## Implementation Verification

Verify the implementation using these techniques:

1. **Authentication Verification**:
   - Verify OpenID authentication flow
   - Test token generation and validation
   - Verify secure cookie handling

2. **Inventory Verification**:
   - Verify item retrieval and transformation
   - Test caching mechanisms
   - Verify rate limiting effectiveness

3. **Market Data Verification**:
   - Verify price data accuracy
   - Test historical data retrieval
   - Verify market listing data

4. **Trading Verification**:
   - Test trade offer creation
   - Verify trade validation
   - Test trade status updates

## Related Knowledge Components

- **Authentication**: `knowledge/back-end/steam-web-api/authentication.md`
- **Data Caching**: `knowledge/back-end/steam-web-api/data-caching.md`
- **Market Data**: `knowledge/back-end/steam-web-api/market-data.md`
- **Security**: `knowledge/back-end/steam-web-api/security.md` 