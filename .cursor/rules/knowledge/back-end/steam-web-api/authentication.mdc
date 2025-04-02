# USE WHEN implementing Steam authentication in back-end components

## Overview

This knowledge file provides implementation guidance for integrating Steam OpenID authentication into the GigaSwap marketplace back-end components. It covers authentication flow, session management, security considerations, and API endpoints for handling Steam user authentication.

## Authentication Flow

The Steam OpenID authentication flow follows these steps:

1. **Initiate Authentication**: User clicks login button on front-end which redirects to back-end authentication endpoint
2. **Redirect to Steam**: Back-end creates an OpenID request and redirects user to Steam login page
3. **Steam Authentication**: User authenticates on Steam's website
4. **Return to Application**: Steam redirects back to our callback endpoint with authentication data
5. **Validate Authentication**: Back-end validates the authentication response from Steam
6. **Create User Session**: Back-end creates a secure session for the authenticated user
7. **Return Session Token**: Back-end returns session token to front-end

## Implementation Components

### Steam Authentication Router

```python
# app/routes/auth/steam.py

from fastapi import APIRouter, Request, Depends, HTTPException, Response
from fastapi.responses import RedirectResponse
from pydantic import BaseModel
from app.services.steam_auth import SteamAuthService
from app.services.user_service import UserService
from app.services.session_service import SessionService
from app.core.logger import logger
from app.core.config import settings

router = APIRouter(prefix="/auth/steam", tags=["auth"])

# Dependency injection
steam_auth_service = SteamAuthService()
user_service = UserService()
session_service = SessionService()


@router.get("/")
async def steam_login(request: Request):
    """Initiate Steam OpenID authentication"""
    try:
        logger.info("Initiating Steam login")
        # Generate the Steam OpenID URL
        redirect_url = await steam_auth_service.get_auth_url(
            return_url=f"{settings.API_BASE_URL}/auth/steam/callback"
        )
        return RedirectResponse(redirect_url)
    except Exception as e:
        logger.error(f"Error initiating Steam login: {str(e)}")
        raise HTTPException(status_code=500, detail="Authentication initiation failed")


@router.get("/callback")
async def steam_callback(request: Request):
    """Process Steam authentication callback"""
    try:
        # Extract OpenID parameters from request
        params = dict(request.query_params)
        logger.info("Received Steam authentication callback")
        
        # Validate the authentication response
        steam_id = await steam_auth_service.validate_auth_response(params)
        if not steam_id:
            logger.error("Steam authentication validation failed")
            return RedirectResponse(f"{settings.FRONTEND_URL}/login?error=auth_failed")
        
        # Get or create user from Steam ID
        user_data = await steam_auth_service.get_steam_user_data(steam_id)
        user = await user_service.get_or_create_steam_user(
            steam_id=steam_id,
            display_name=user_data.get("personaname", f"User_{steam_id}"),
            avatar_url=user_data.get("avatarfull", ""),
            profile_url=user_data.get("profileurl", "")
        )
        
        # Create session token
        session = await session_service.create_session(user_id=user.id, auth_type="steam")
        
        # Set HTTP-only cookie with session token
        response = RedirectResponse(f"{settings.FRONTEND_URL}/market")
        session_service.set_session_cookie(response, session.token)
        
        logger.info(f"Steam authentication successful for user {user.id}")
        return response
        
    except Exception as e:
        logger.error(f"Error in Steam callback: {str(e)}")
        return RedirectResponse(f"{settings.FRONTEND_URL}/login?error=callback_error")


@router.get("/status")
async def check_auth_status(request: Request, session=Depends(session_service.get_current_session)):
    """Check current authentication status"""
    if session and session.user:
        # Get fresh Steam user data if needed
        steam_user = None
        if session.user.steam_id:
            try:
                steam_user = await user_service.get_steam_user_profile(session.user.steam_id)
            except Exception as e:
                logger.error(f"Error fetching Steam profile: {str(e)}")
        
        return {
            "authenticated": True,
            "user": {
                "id": session.user.id,
                "steamId": session.user.steam_id,
                "displayName": steam_user.display_name if steam_user else session.user.display_name,
                "avatarUrl": steam_user.avatar_url if steam_user else session.user.avatar_url,
                "profileUrl": steam_user.profile_url if steam_user else session.user.profile_url,
                "inventoryPrivacy": steam_user.inventory_privacy if steam_user else "unknown"
            }
        }
    
    return {"authenticated": False}


@router.post("/logout")
async def logout(request: Request, response: Response, session=Depends(session_service.get_current_session)):
    """Log out the current user by invalidating their session"""
    if session:
        await session_service.delete_session(session.token)
        session_service.clear_session_cookie(response)
        logger.info(f"User {session.user.id if session.user else 'unknown'} logged out")
        
    return {"success": True}
```

### Steam Auth Service

```python
# app/services/steam_auth.py

import re
import aiohttp
import hashlib
from urllib.parse import urlencode
from app.core.logger import logger
from app.core.config import settings

# OpenID constants
STEAM_OPENID_URL = 'https://steamcommunity.com/openid/login'
STEAM_API_KEY = settings.STEAM_API_KEY

class SteamAuthService:
    """Service for handling Steam OpenID authentication"""
    
    async def get_auth_url(self, return_url: str) -> str:
        """Generate Steam OpenID authentication URL"""
        params = {
            'openid.ns': 'http://specs.openid.net/auth/2.0',
            'openid.mode': 'checkid_setup',
            'openid.return_to': return_url,
            'openid.realm': settings.API_BASE_URL,
            'openid.identity': 'http://specs.openid.net/auth/2.0/identifier_select',
            'openid.claimed_id': 'http://specs.openid.net/auth/2.0/identifier_select',
        }
        return f"{STEAM_OPENID_URL}?{urlencode(params)}"
    
    async def validate_auth_response(self, params: dict) -> str:
        """Validate the OpenID authentication response"""
        if not params.get('openid.claimed_id'):
            return None
            
        # Extract Steam ID from claimed_id
        match = re.search(r'steamcommunity.com/openid/id/(.*?)$', params.get('openid.claimed_id', ''))
        if not match:
            logger.error("Failed to extract Steam ID from claimed_id")
            return None
            
        steam_id = match.group(1)
        
        # Verify the authentication with Steam
        verification_params = {
            'openid.assoc_handle': params.get('openid.assoc_handle'),
            'openid.signed': params.get('openid.signed'),
            'openid.sig': params.get('openid.sig'),
            'openid.ns': params.get('openid.ns'),
            'openid.mode': 'check_authentication'
        }
        
        # Copy over all signed fields
        signed_fields = params.get('openid.signed', '').split(',')
        for field in signed_fields:
            verification_params[f'openid.{field}'] = params.get(f'openid.{field}', '')
        
        # Verify with Steam OpenID
        async with aiohttp.ClientSession() as session:
            async with session.post(STEAM_OPENID_URL, data=verification_params) as resp:
                response_text = await resp.text()
                if 'is_valid:true' not in response_text:
                    logger.error(f"Steam OpenID verification failed: {response_text}")
                    return None
        
        return steam_id
    
    async def get_steam_user_data(self, steam_id: str) -> dict:
        """Get user data from Steam API using the Steam ID"""
        if not STEAM_API_KEY:
            logger.warning("STEAM_API_KEY not set, using SteamWebAPI.com instead")
            return await self._get_user_data_from_steamwebapi(steam_id)
        
        url = f"https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key={STEAM_API_KEY}&steamids={steam_id}"
        
        try:
            async with aiohttp.ClientSession() as session:
                async with session.get(url) as response:
                    if response.status != 200:
                        logger.error(f"Steam API error: {response.status}")
                        return {}
                        
                    data = await response.json()
                    players = data.get('response', {}).get('players', [])
                    if not players:
                        return {}
                        
                    return players[0]
        except Exception as e:
            logger.error(f"Error fetching Steam user data: {str(e)}")
            return {}
    
    async def _get_user_data_from_steamwebapi(self, steam_id: str) -> dict:
        """Fallback to SteamWebAPI.com for user data"""
        url = f"https://api.steamwebapi.com/profile/{steam_id}"
        api_key = settings.STEAMWEBAPI_KEY
        
        if not api_key:
            logger.error("Neither STEAM_API_KEY nor STEAMWEBAPI_KEY are set")
            return {}
            
        try:
            async with aiohttp.ClientSession() as session:
                async with session.get(url, headers={"Authorization": f"Bearer {api_key}"}) as response:
                    if response.status != 200:
                        logger.error(f"SteamWebAPI error: {response.status}")
                        return {}
                        
                    data = await response.json()
                    return {
                        "personaname": data.get("personaname", f"User_{steam_id}"),
                        "avatarfull": data.get("avatarfull", ""),
                        "profileurl": data.get("profileurl", ""),
                    }
        except Exception as e:
            logger.error(f"Error fetching Steam user data from SteamWebAPI: {str(e)}")
            return {}
```

### Session Service

```python
# app/services/session_service.py

import uuid
import time
from fastapi import Request, Response, Depends, HTTPException
from app.models.session import Session
from app.db.repositories.session_repository import SessionRepository
from app.db.repositories.user_repository import UserRepository
from app.core.config import settings
from app.core.logger import logger

class SessionService:
    def __init__(self):
        self.session_repository = SessionRepository()
        self.user_repository = UserRepository()
        self.cookie_name = settings.SESSION_COOKIE_NAME
        self.cookie_max_age = settings.SESSION_COOKIE_MAX_AGE
    
    async def create_session(self, user_id: int, auth_type: str = "steam") -> Session:
        """Create a new session for a user"""
        token = str(uuid.uuid4())
        expires_at = int(time.time()) + self.cookie_max_age
        
        session = Session(
            token=token,
            user_id=user_id,
            auth_type=auth_type,
            expires_at=expires_at
        )
        
        # Save session to database
        await self.session_repository.create(session)
        return session
    
    async def get_session(self, token: str) -> Session:
        """Get a session by token"""
        session = await self.session_repository.get_by_token(token)
        
        # Check if session exists and is valid
        if not session:
            return None
        
        # Check if session is expired
        if session.expires_at < int(time.time()):
            await self.delete_session(token)
            return None
            
        return session
    
    async def delete_session(self, token: str) -> bool:
        """Delete a session by token"""
        return await self.session_repository.delete(token)
    
    def set_session_cookie(self, response: Response, token: str) -> None:
        """Set session cookie in response"""
        response.set_cookie(
            key=self.cookie_name,
            value=token,
            max_age=self.cookie_max_age,
            httponly=True,
            secure=settings.ENVIRONMENT != "development",
            samesite="lax"
        )
    
    def clear_session_cookie(self, response: Response) -> None:
        """Clear session cookie from response"""
        response.delete_cookie(
            key=self.cookie_name,
            httponly=True,
            secure=settings.ENVIRONMENT != "development",
            samesite="lax"
        )
    
    async def get_current_session(self, request: Request) -> Session:
        """Get current session from request cookies"""
        token = request.cookies.get(self.cookie_name)
        if not token:
            return None
            
        session = await self.get_session(token)
        if not session:
            return None
            
        # Load user object
        session.user = await self.user_repository.get_by_id(session.user_id)
        return session
```

### User Service

```python
# app/services/user_service.py

from app.models.user import User, SteamUserProfile
from app.db.repositories.user_repository import UserRepository
from app.core.logger import logger

class UserService:
    def __init__(self):
        self.user_repository = UserRepository()
    
    async def get_or_create_steam_user(self, steam_id: str, display_name: str, avatar_url: str, profile_url: str) -> User:
        """Get existing user by Steam ID or create a new one"""
        # Check if user with Steam ID exists
        user = await self.user_repository.get_by_steam_id(steam_id)
        
        if user:
            # Update user info if needed
            if (
                user.display_name != display_name or 
                user.avatar_url != avatar_url or
                user.profile_url != profile_url
            ):
                user.display_name = display_name
                user.avatar_url = avatar_url
                user.profile_url = profile_url
                await self.user_repository.update(user)
            return user
        
        # Create new user
        user = User(
            steam_id=steam_id,
            display_name=display_name,
            avatar_url=avatar_url,
            profile_url=profile_url,
        )
        
        user_id = await self.user_repository.create(user)
        user.id = user_id
        
        return user
    
    async def get_steam_user_profile(self, steam_id: str) -> SteamUserProfile:
        """Get Steam user profile including inventory privacy settings"""
        # Get Steam user profile from database
        user = await self.user_repository.get_by_steam_id(steam_id)
        if not user:
            logger.error(f"User with Steam ID {steam_id} not found")
            return None
            
        # Get inventory privacy from Steam API
        from app.services.steam_api_service import SteamAPIService
        steam_api = SteamAPIService()
        
        try:
            privacy_settings = await steam_api.get_user_privacy_settings(steam_id)
            
            # Create user profile
            profile = SteamUserProfile(
                steam_id=steam_id,
                display_name=user.display_name,
                avatar_url=user.avatar_url,
                profile_url=user.profile_url,
                inventory_privacy=privacy_settings.get("inventory_privacy", "private")
            )
            
            return profile
        except Exception as e:
            logger.error(f"Error fetching Steam privacy settings: {str(e)}")
            
            # Return basic profile without privacy settings
            return SteamUserProfile(
                steam_id=steam_id,
                display_name=user.display_name,
                avatar_url=user.avatar_url,
                profile_url=user.profile_url,
                inventory_privacy="unknown"
            )
```

## Database Models

### User Model

```python
# app/models/user.py

from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class User(BaseModel):
    id: Optional[int] = None
    steam_id: str
    display_name: str
    avatar_url: str
    profile_url: str
    trade_url: Optional[str] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
    
    class Config:
        orm_mode = True

class SteamUserProfile(BaseModel):
    steam_id: str
    display_name: str
    avatar_url: str
    profile_url: str
    trade_url: Optional[str] = None
    inventory_privacy: str  # "private", "friends", or "public"
```

### Session Model

```python
# app/models/session.py

from pydantic import BaseModel
from typing import Optional
from app.models.user import User

class Session(BaseModel):
    id: Optional[int] = None
    token: str
    user_id: int
    auth_type: str  # "steam", "email", etc.
    expires_at: int  # Unix timestamp
    user: Optional[User] = None
    
    class Config:
        orm_mode = True
```

## Configuration

```python
# app/core/config.py

import os
from pydantic import BaseSettings

class Settings(BaseSettings):
    # Application settings
    API_BASE_URL: str = os.getenv("API_BASE_URL", "http://localhost:8000")
    FRONTEND_URL: str = os.getenv("FRONTEND_URL", "http://localhost:3000")
    ENVIRONMENT: str = os.getenv("ENVIRONMENT", "development")
    
    # Database settings
    DATABASE_URL: str = os.getenv("DATABASE_URL", "sqlite:///./app.db")
    
    # Steam API settings
    STEAM_API_KEY: str = os.getenv("STEAM_API_KEY", "")
    STEAMWEBAPI_KEY: str = os.getenv("STEAMWEBAPI_KEY", "LITUJ4KSYS7D1QC0")
    
    # Session settings
    SESSION_COOKIE_NAME: str = os.getenv("SESSION_COOKIE_NAME", "gigaswap_session")
    SESSION_COOKIE_MAX_AGE: int = int(os.getenv("SESSION_COOKIE_MAX_AGE", "604800"))  # 7 days
    
    class Config:
        env_file = ".env"

settings = Settings()
```

## Security Considerations

1. **Session Tokens**:
   - Use UUID tokens with sufficient entropy
   - Store sessions securely in the database
   - Implement session expiration and renewal
   - Use HTTP-only, secure cookies

2. **CSRF Protection**:
   - Implement proper CSRF protection for authenticated endpoints
   - Use SameSite cookie attribute (Lax or Strict)
   - Validate Origin/Referer headers for sensitive operations

3. **API Key Management**:
   - Never expose API keys in front-end code
   - Store API keys in environment variables or secrets management
   - Implement API key rotation procedures
   - Use different API keys for development and production

4. **Error Handling**:
   - Implement comprehensive error logging
   - Return generic error messages to clients
   - Log detailed error information server-side
   - Handle all exceptions to prevent information leakage

## Error Handling Patterns

1. **Authentication Failures**:
   - Log detailed error information
   - Redirect to login page with error parameter
   - Implement rate limiting for repeated failures
   - Monitor for potential brute force attempts

2. **API Service Failures**:
   - Implement fallback providers (Steam API → SteamWebAPI.com)
   - Use exponential backoff for retries
   - Cache user data to reduce API dependencies
   - Log detailed error information for debugging

3. **Session Management Errors**:
   - Handle invalid or expired sessions gracefully
   - Clear invalid session cookies
   - Redirect to appropriate authentication flows
   - Preserve intended destination for post-authentication redirect

## Best Practices

1. **Dependency Injection**:
   - Use service-based architecture with dependency injection
   - Keep clear separation of concerns
   - Isolate external API dependencies
   - Make services testable

2. **Async Performance**:
   - Use async/await for all I/O operations
   - Implement proper connection pooling
   - Use efficient HTTP client (aiohttp)
   - Optimize database queries

3. **Caching Strategy**:
   - Cache Steam profile data
   - Implement TTL-based cache invalidation
   - Use memory cache for session validation
   - Implement proper cache eviction policies

4. **Security Headers**:
   - Implement appropriate security headers
   - Use Strict-Transport-Security
   - Set X-Content-Type-Options and X-Frame-Options
   - Configure proper CORS policies

## Cross-References

- **Inventory API**: See `knowledge/back-end/steam-web-api/inventory.md`
- **Trading API**: See `knowledge/back-end/steam-web-api/trading.md`
- **Market Data API**: See `knowledge/back-end/steam-web-api/market-data.md`
- **Front-End Authentication**: See `knowledge/front-end/steam-web-api/authentication.md` 