# workflow: back-end-workflow | pathway: steam-web-api | message-command: direct-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/back-end/direct-mode/steam-web-api.md

## Parameter Purpose

This parameter provides specialized implementation guidance for Steam Web API integration in back-end components while in Direct Mode.

## Knowledge Access

For detailed implementation guidance, access the following knowledge components:

```typescript
fetch_rules(["knowledge/back-end/steam-web-api/authentication"], 
           "Understanding Steam authentication implementation in back-end")

fetch_rules(["knowledge/back-end/steam-web-api/inventory"], 
           "Understanding Steam inventory API implementation")

fetch_rules(["knowledge/back-end/steam-web-api/market-data"], 
           "Understanding Steam market data API implementation")

fetch_rules(["knowledge/back-end/steam-web-api/trading"], 
           "Understanding Steam trading API implementation")
```

## Direct Implementation Pattern

In Direct Mode, follow these research-first steps before implementation:

1. **Research Phase** (minimum 20 tool calls):
   - Analyze existing back-end structure
   - Examine FastAPI implementation patterns
   - Investigate API endpoint organization
   - Understand database models and schemas
   - Identify error handling strategies
   - Research caching mechanisms

2. **Implementation Phase**:
   - Follow FastAPI best practices
   - Implement components with clear separation of concerns
   - Test at each implementation stage
   - Document through code comments
   - Ensure proper error handling and logging

## Component Implementation Guide

### Authentication Implementation

```python
# Step 1: Create core configuration with Steam API settings
edit_file("back-end/app/core/config.py",
          "Create application configuration with Steam API settings",
          "import os\nfrom pydantic import BaseSettings\n\nclass Settings(BaseSettings):\n    # Application settings\n    API_BASE_URL: str = os.getenv(\"API_BASE_URL\", \"http://localhost:8000\")\n    FRONTEND_URL: str = os.getenv(\"FRONTEND_URL\", \"http://localhost:3000\")\n    ENVIRONMENT: str = os.getenv(\"ENVIRONMENT\", \"development\")\n    \n    # Database settings\n    DATABASE_URL: str = os.getenv(\"DATABASE_URL\", \"sqlite:///./app.db\")\n    \n    # Steam API settings\n    STEAM_API_KEY: str = os.getenv(\"STEAM_API_KEY\", \"\")\n    STEAMWEBAPI_KEY: str = os.getenv(\"STEAMWEBAPI_KEY\", \"LITUJ4KSYS7D1QC0\")\n    \n    # Session settings\n    SESSION_COOKIE_NAME: str = os.getenv(\"SESSION_COOKIE_NAME\", \"gigaswap_session\")\n    SESSION_COOKIE_MAX_AGE: int = int(os.getenv(\"SESSION_COOKIE_MAX_AGE\", \"604800\"))  # 7 days\n    \n    class Config:\n        env_file = \".env\"\n\nsettings = Settings()")

# Step 2: Create user and session models
edit_file("back-end/app/models/user.py",
          "Create User models",
          "from pydantic import BaseModel\nfrom datetime import datetime\nfrom typing import Optional\n\nclass User(BaseModel):\n    id: Optional[int] = None\n    steam_id: str\n    display_name: str\n    avatar_url: str\n    profile_url: str\n    trade_url: Optional[str] = None\n    created_at: Optional[datetime] = None\n    updated_at: Optional[datetime] = None\n    \n    class Config:\n        orm_mode = True\n\nclass SteamUserProfile(BaseModel):\n    steam_id: str\n    display_name: str\n    avatar_url: str\n    profile_url: str\n    trade_url: Optional[str] = None\n    inventory_privacy: str  # \"private\", \"friends\", or \"public\"")

edit_file("back-end/app/models/session.py",
          "Create Session model",
          "from pydantic import BaseModel\nfrom typing import Optional\nfrom app.models.user import User\n\nclass Session(BaseModel):\n    id: Optional[int] = None\n    token: str\n    user_id: int\n    auth_type: str  # \"steam\", \"email\", etc.\n    expires_at: int  # Unix timestamp\n    user: Optional[User] = None\n    \n    class Config:\n        orm_mode = True")

# Step 3: Create Steam authentication service
edit_file("back-end/app/services/steam_auth.py",
          "Create Steam authentication service",
          "import re\nimport aiohttp\nimport hashlib\nfrom urllib.parse import urlencode\nfrom app.core.logger import logger\nfrom app.core.config import settings\n\n# OpenID constants\nSTEAM_OPENID_URL = 'https://steamcommunity.com/openid/login'\nSTEAM_API_KEY = settings.STEAM_API_KEY\n\nclass SteamAuthService:\n    \"\"\"Service for handling Steam OpenID authentication\"\"\"\n    \n    async def get_auth_url(self, return_url: str) -> str:\n        \"\"\"Generate Steam OpenID authentication URL\"\"\"\n        params = {\n            'openid.ns': 'http://specs.openid.net/auth/2.0',\n            'openid.mode': 'checkid_setup',\n            'openid.return_to': return_url,\n            'openid.realm': settings.API_BASE_URL,\n            'openid.identity': 'http://specs.openid.net/auth/2.0/identifier_select',\n            'openid.claimed_id': 'http://specs.openid.net/auth/2.0/identifier_select',\n        }\n        return f\"{STEAM_OPENID_URL}?{urlencode(params)}\"\n    \n    async def validate_auth_response(self, params: dict) -> str:\n        \"\"\"Validate the OpenID authentication response\"\"\"\n        if not params.get('openid.claimed_id'):\n            return None\n            \n        # Extract Steam ID from claimed_id\n        match = re.search(r'steamcommunity.com/openid/id/(.*?)$', params.get('openid.claimed_id', ''))\n        if not match:\n            logger.error(\"Failed to extract Steam ID from claimed_id\")\n            return None\n            \n        steam_id = match.group(1)\n        \n        # Verify the authentication with Steam\n        verification_params = {\n            'openid.assoc_handle': params.get('openid.assoc_handle'),\n            'openid.signed': params.get('openid.signed'),\n            'openid.sig': params.get('openid.sig'),\n            'openid.ns': params.get('openid.ns'),\n            'openid.mode': 'check_authentication'\n        }\n        \n        # Copy over all signed fields\n        signed_fields = params.get('openid.signed', '').split(',')\n        for field in signed_fields:\n            verification_params[f'openid.{field}'] = params.get(f'openid.{field}', '')\n        \n        # Verify with Steam OpenID\n        async with aiohttp.ClientSession() as session:\n            async with session.post(STEAM_OPENID_URL, data=verification_params) as resp:\n                response_text = await resp.text()\n                if 'is_valid:true' not in response_text:\n                    logger.error(f\"Steam OpenID verification failed: {response_text}\")\n                    return None\n        \n        return steam_id\n    \n    async def get_steam_user_data(self, steam_id: str) -> dict:\n        \"\"\"Get user data from Steam API using the Steam ID\"\"\"\n        if not STEAM_API_KEY:\n            logger.warning(\"STEAM_API_KEY not set, using SteamWebAPI.com instead\")\n            return await self._get_user_data_from_steamwebapi(steam_id)\n        \n        url = f\"https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key={STEAM_API_KEY}&steamids={steam_id}\"\n        \n        try:\n            async with aiohttp.ClientSession() as session:\n                async with session.get(url) as response:\n                    if response.status != 200:\n                        logger.error(f\"Steam API error: {response.status}\")\n                        return {}\n                        \n                    data = await response.json()\n                    players = data.get('response', {}).get('players', [])\n                    if not players:\n                        return {}\n                        \n                    return players[0]\n        except Exception as e:\n            logger.error(f\"Error fetching Steam user data: {str(e)}\")\n            return {}\n    \n    async def _get_user_data_from_steamwebapi(self, steam_id: str) -> dict:\n        \"\"\"Fallback to SteamWebAPI.com for user data\"\"\"\n        url = f\"https://api.steamwebapi.com/profile/{steam_id}\"\n        api_key = settings.STEAMWEBAPI_KEY\n        \n        if not api_key:\n            logger.error(\"Neither STEAM_API_KEY nor STEAMWEBAPI_KEY are set\")\n            return {}\n            \n        try:\n            async with aiohttp.ClientSession() as session:\n                async with session.get(url, headers={\"Authorization\": f\"Bearer {api_key}\"}) as response:\n                    if response.status != 200:\n                        logger.error(f\"SteamWebAPI error: {response.status}\")\n                        return {}\n                        \n                    data = await response.json()\n                    return {\n                        \"personaname\": data.get(\"personaname\", f\"User_{steam_id}\"),\n                        \"avatarfull\": data.get(\"avatarfull\", \"\"),\n                        \"profileurl\": data.get(\"profileurl\", \"\"),\n                    }\n        except Exception as e:\n            logger.error(f\"Error fetching Steam user data from SteamWebAPI: {str(e)}\")\n            return {}")

# Step 4: Create Steam authentication router
edit_file("back-end/app/routes/auth/steam.py",
          "Create Steam authentication router",
          "from fastapi import APIRouter, Request, Depends, HTTPException, Response\nfrom fastapi.responses import RedirectResponse\nfrom pydantic import BaseModel\nfrom app.services.steam_auth import SteamAuthService\nfrom app.services.user_service import UserService\nfrom app.services.session_service import SessionService\nfrom app.core.logger import logger\nfrom app.core.config import settings\n\nrouter = APIRouter(prefix=\"/auth/steam\", tags=[\"auth\"])\n\n# Dependency injection\nsteam_auth_service = SteamAuthService()\nuser_service = UserService()\nsession_service = SessionService()\n\n\n@router.get(\"/\")\nasync def steam_login(request: Request):\n    \"\"\"Initiate Steam OpenID authentication\"\"\"\n    try:\n        logger.info(\"Initiating Steam login\")\n        # Generate the Steam OpenID URL\n        redirect_url = await steam_auth_service.get_auth_url(\n            return_url=f\"{settings.API_BASE_URL}/auth/steam/callback\"\n        )\n        return RedirectResponse(redirect_url)\n    except Exception as e:\n        logger.error(f\"Error initiating Steam login: {str(e)}\")\n        raise HTTPException(status_code=500, detail=\"Authentication initiation failed\")\n\n\n@router.get(\"/callback\")\nasync def steam_callback(request: Request):\n    \"\"\"Process Steam authentication callback\"\"\"\n    try:\n        # Extract OpenID parameters from request\n        params = dict(request.query_params)\n        logger.info(\"Received Steam authentication callback\")\n        \n        # Validate the authentication response\n        steam_id = await steam_auth_service.validate_auth_response(params)\n        if not steam_id:\n            logger.error(\"Steam authentication validation failed\")\n            return RedirectResponse(f\"{settings.FRONTEND_URL}/login?error=auth_failed\")\n        \n        # Get or create user from Steam ID\n        user_data = await steam_auth_service.get_steam_user_data(steam_id)\n        user = await user_service.get_or_create_steam_user(\n            steam_id=steam_id,\n            display_name=user_data.get(\"personaname\", f\"User_{steam_id}\"),\n            avatar_url=user_data.get(\"avatarfull\", \"\"),\n            profile_url=user_data.get(\"profileurl\", \"\")\n        )\n        \n        # Create session token\n        session = await session_service.create_session(user_id=user.id, auth_type=\"steam\")\n        \n        # Set HTTP-only cookie with session token\n        response = RedirectResponse(f\"{settings.FRONTEND_URL}/market\")\n        session_service.set_session_cookie(response, session.token)\n        \n        logger.info(f\"Steam authentication successful for user {user.id}\")\n        return response\n        \n    except Exception as e:\n        logger.error(f\"Error in Steam callback: {str(e)}\")\n        return RedirectResponse(f\"{settings.FRONTEND_URL}/login?error=callback_error\")\n\n\n@router.get(\"/status\")\nasync def check_auth_status(request: Request, session=Depends(session_service.get_current_session)):\n    \"\"\"Check current authentication status\"\"\"\n    if session and session.user:\n        # Get fresh Steam user data if needed\n        steam_user = None\n        if session.user.steam_id:\n            try:\n                steam_user = await user_service.get_steam_user_profile(session.user.steam_id)\n            except Exception as e:\n                logger.error(f\"Error fetching Steam profile: {str(e)}\")\n        \n        return {\n            \"authenticated\": True,\n            \"user\": {\n                \"id\": session.user.id,\n                \"steamId\": session.user.steam_id,\n                \"displayName\": steam_user.display_name if steam_user else session.user.display_name,\n                \"avatarUrl\": steam_user.avatar_url if steam_user else session.user.avatar_url,\n                \"profileUrl\": steam_user.profile_url if steam_user else session.user.profile_url,\n                \"inventoryPrivacy\": steam_user.inventory_privacy if steam_user else \"unknown\"\n            }\n        }\n    \n    return {\"authenticated\": False}\n\n\n@router.post(\"/logout\")\nasync def logout(request: Request, response: Response, session=Depends(session_service.get_current_session)):\n    \"\"\"Log out the current user by invalidating their session\"\"\"\n    if session:\n        await session_service.delete_session(session.token)\n        session_service.clear_session_cookie(response)\n        logger.info(f\"User {session.user.id if session.user else 'unknown'} logged out\")\n        \n    return {\"success\": True}")
```

### Inventory Implementation

```python
# Step 1: Create Steam inventory service
edit_file("back-end/app/services/steam_inventory_service.py",
          "Create Steam inventory service",
          "import aiohttp\nimport time\nimport asyncio\nfrom typing import List, Dict, Any\nfrom app.core.logger import logger\nfrom app.core.config import settings\nfrom app.core.cache import cache\n\nclass SteamInventoryService:\n    \"\"\"Service for handling Steam inventory operations\"\"\"\n    \n    def __init__(self):\n        self.api_key = settings.STEAMWEBAPI_KEY\n        self.cache_ttl = 300  # 5 minutes\n    \n    @cache(ttl=300)\n    async def get_inventory(self, steam_id: str, refresh: bool = False) -> List[Dict[str, Any]]:\n        \"\"\"Get a user's Steam inventory\"\"\"\n        # Skip cache if refresh is requested\n        if refresh:\n            return await self._fetch_inventory(steam_id)\n        \n        # Try to get from cache\n        cache_key = f\"steam_inventory_{steam_id}\"\n        inventory = await self._get_cached_inventory(cache_key)\n        \n        if inventory is not None:\n            logger.info(f\"Using cached inventory for Steam ID {steam_id}\")\n            return inventory\n        \n        # Fetch new inventory\n        inventory = await self._fetch_inventory(steam_id)\n        \n        # Cache the inventory\n        await self._cache_inventory(cache_key, inventory)\n        \n        return inventory\n    \n    async def _fetch_inventory(self, steam_id: str) -> List[Dict[str, Any]]:\n        \"\"\"Fetch inventory directly from SteamWebAPI.com\"\"\"\n        url = f\"https://api.steamwebapi.com/inventory/{steam_id}/730\"\n        \n        try:\n            async with aiohttp.ClientSession() as session:\n                headers = {\n                    \"Authorization\": f\"Bearer {self.api_key}\"\n                }\n                \n                async with session.get(url, headers=headers) as response:\n                    if response.status != 200:\n                        logger.error(f\"SteamWebAPI error: {response.status}\")\n                        error_text = await response.text()\n                        logger.error(f\"Error details: {error_text}\")\n                        return []\n                    \n                    data = await response.json()\n                    \n                    # Transform the inventory data\n                    return self._transform_inventory(data)\n        except Exception as e:\n            logger.error(f\"Error fetching Steam inventory: {str(e)}\")\n            return []\n    \n    def _transform_inventory(self, inventory_data: List[Dict[str, Any]]) -> List[Dict[str, Any]]:\n        \"\"\"Transform inventory data from API format to application format\"\"\"\n        transformed_items = []\n        \n        for item in inventory_data:\n            try:\n                # Transform the item data to match front-end expectations\n                transformed_item = {\n                    \"id\": item.get(\"assetid\"),\n                    \"assetId\": item.get(\"assetid\"),\n                    \"name\": item.get(\"market_hash_name\", \"\"),\n                    \"weapon\": self._extract_weapon_name(item.get(\"market_hash_name\", \"\")),\n                    \"imageUrl\": item.get(\"icon_url_large\") or item.get(\"icon_url\"),\n                    \"marketable\": bool(item.get(\"marketable\")),\n                    \"tradable\": bool(item.get(\"tradable\")),\n                    \"category\": self._determine_category(item),\n                    \"price\": item.get(\"price\", 0),\n                    \"wear\": item.get(\"float_value\"),\n                    \"patternId\": item.get(\"pattern_index\"),\n                    \"isStatTrak\": \"StatTrak™\" in item.get(\"market_hash_name\", \"\"),\n                    \"nameTag\": item.get(\"custom_name\"),\n                    \"inspectLink\": item.get(\"inspect_link\", \"\"),\n                    \"stickers\": self._extract_stickers(item)\n                }\n                \n                transformed_items.append(transformed_item)\n            except Exception as e:\n                logger.error(f\"Error transforming inventory item: {str(e)}\")\n        \n        return transformed_items\n    \n    def _extract_weapon_name(self, market_hash_name: str) -> str:\n        \"\"\"Extract the weapon name from market hash name\"\"\"\n        if not market_hash_name:\n            return \"\"\n        \n        # Remove StatTrak prefix if present\n        if \"StatTrak™\" in market_hash_name:\n            market_hash_name = market_hash_name.replace(\"StatTrak™ \", \"\")\n        \n        # Extract the weapon name (usually before the | character)\n        if \"|\" in market_hash_name:\n            return market_hash_name.split(\"|\")[0].strip()\n        \n        return market_hash_name\n    \n    def _determine_category(self, item: Dict[str, Any]) -> str:\n        \"\"\"Determine the item category\"\"\"\n        # Extract from tags or descriptions\n        if \"tags\" in item:\n            for tag in item[\"tags\"]:\n                if tag.get(\"category\") == \"Type\":\n                    return tag.get(\"name\", \"\")\n        \n        # Default category assignment based on market_hash_name\n        name = item.get(\"market_hash_name\", \"\")\n        \n        if any(knife in name.lower() for knife in [\"knife\", \"karambit\", \"bayonet\", \"dagger\"]):\n            return \"Knife\"\n        elif any(pistol in name.lower() for pistol in [\"deagle\", \"p250\", \"glock\", \"usp\", \"p2000\"]):\n            return \"Pistol\"\n        elif any(rifle in name.lower() for rifle in [\"ak-47\", \"m4a4\", \"m4a1\", \"awp\"]):\n            return \"Rifle\"\n        elif any(smg in name.lower() for smg in [\"mp7\", \"mp9\", \"mac-10\", \"ump-45\"]):\n            return \"SMG\"\n        \n        return \"Other\"\n    \n    def _extract_stickers(self, item: Dict[str, Any]) -> List[Dict[str, Any]]:\n        \"\"\"Extract sticker information from item\"\"\"\n        stickers = []\n        \n        if \"stickers\" in item:\n            for index, sticker in enumerate(item[\"stickers\"]):\n                stickers.append({\n                    \"name\": sticker.get(\"name\", \"\"),\n                    \"image\": sticker.get(\"icon_url\", \"\"),\n                    \"slot\": index,\n                    \"wear\": sticker.get(\"wear\", 0)\n                })\n        \n        return stickers\n    \n    async def _get_cached_inventory(self, cache_key: str) -> List[Dict[str, Any]]:\n        \"\"\"Get inventory from cache\"\"\"\n        # This would use your actual cache implementation\n        # For now, we'll return None to simulate cache miss\n        return None\n    \n    async def _cache_inventory(self, cache_key: str, inventory: List[Dict[str, Any]]) -> None:\n        \"\"\"Store inventory in cache\"\"\"\n        # This would use your actual cache implementation\n        pass")

# Step 2: Create inventory router
edit_file("back-end/app/routes/inventory/steam.py",
          "Create Steam inventory router",
          "from fastapi import APIRouter, Request, Depends, HTTPException\nfrom app.services.session_service import SessionService\nfrom app.services.steam_inventory_service import SteamInventoryService\nfrom app.core.logger import logger\n\nrouter = APIRouter(prefix=\"/inventory/steam\", tags=[\"inventory\"])\n\n# Dependency injection\nsession_service = SessionService()\nsteam_inventory_service = SteamInventoryService()\n\n@router.get(\"/\")\nasync def get_steam_inventory(request: Request, refresh: bool = False, session=Depends(session_service.get_current_session)):\n    \"\"\"Get the user's Steam inventory\"\"\"\n    if not session or not session.user:\n        raise HTTPException(status_code=401, detail=\"Authentication required\")\n    \n    if not session.user.steam_id:\n        raise HTTPException(status_code=400, detail=\"No Steam account linked\")\n    \n    try:\n        # Get inventory from service\n        inventory = await steam_inventory_service.get_inventory(session.user.steam_id, refresh)\n        \n        # Log the inventory request\n        logger.info(f\"Steam inventory retrieved for user {session.user.id}, items: {len(inventory)}\")\n        \n        return inventory\n    except Exception as e:\n        logger.error(f\"Error retrieving Steam inventory: {str(e)}\")\n        raise HTTPException(status_code=500, detail=\"Error retrieving inventory\")")
```

### Application Integration

```python
# Update main app file to include the new routes
edit_file("back-end/app/main.py",
          "Update main app to include Steam routes",
          "# ... existing code ... \n\n# Import Steam routers\nfrom app.routes.auth import steam as steam_auth_router\nfrom app.routes.inventory import steam as steam_inventory_router\n\n# ... existing code ...\n\n# Include Steam routers\napp.include_router(steam_auth_router.router, prefix=\"/api\")\napp.include_router(steam_inventory_router.router, prefix=\"/api\")\n\n# ... existing code ...")
```

## Research Questions

During the research phase, answer these key questions:

1. **FastAPI Structure**
   - How is the FastAPI application currently structured?
   - What dependency injection patterns are used?
   - How are routes organized?
   - What authentication mechanisms exist?

2. **Database Integration**
   - How is the database connected and configured?
   - What ORM/database access patterns are used?
   - What models and schemas exist?
   - How are repositories structured?

3. **API Endpoint Patterns**
   - What RESTful API patterns are used?
   - How are endpoints documented?
   - What response formats are standardized?
   - How are errors handled and returned?

4. **Security Implementation**
   - How is authentication currently implemented?
   - How are sensitive keys managed?
   - What CORS configuration exists?
   - How are sessions managed?

## Error Handling Guidelines

Implement comprehensive error handling for Steam Web API integration:

1. **Authentication Errors**:
   - Log detailed error information
   - Return proper HTTP status codes (401, 403, 500)
   - Implement request validation
   - Return user-friendly error messages

2. **API Service Failures**:
   - Implement fallback strategies
   - Add retry mechanisms with exponential backoff
   - Cache responses to reduce API dependencies
   - Monitor rate limits and implement rate limiting

3. **Data Validation**:
   - Validate all input data using Pydantic models
   - Implement proper type checking
   - Add data transformation and normalization
   - Include comprehensive error handling in data processing

## Testing Guidelines

Use these methods to test your implementation:

1. **Authentication Testing**:
   ```python
   run_terminal_cmd("curl -v http://localhost:8000/api/auth/steam/status", false)
   ```

2. **Inventory Testing**:
   ```python
   run_terminal_cmd("curl -v -b \"gigaswap_session=test_session\" http://localhost:8000/api/inventory/steam", false)
   ```

3. **Error Handling Testing**:
   ```python
   run_terminal_cmd("curl -v http://localhost:8000/api/inventory/steam", false)
   ``` 