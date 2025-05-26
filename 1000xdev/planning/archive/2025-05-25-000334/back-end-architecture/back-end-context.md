# Back-End Context for Steam Integration

This document describes the specific implementation details of the GigaSwap back-end as they relate to current development tasks, especially Steam integration. It is based on the current codebase and should be checked for accuracy each cycle. Always cross-reference with the actual codebase.

## API Structure & Connection Points

The FastAPI application provides several integration points for Steam Web API:

- **Steam Routes**: The `app/steam/routes` directory contains endpoints that interface with Steam's Web API
- **Steam Models**: The `app/steam/models` directory contains Pydantic models for Steam data structures
- **Steam Services**: The `app/steam/services` directory contains business logic for Steam operations

### Current Implementation Status

The Steam integration is currently structured as follows:

- API client for Steam Web API exists with basic authentication and request functionality
- Models for CS2 items (skins) are defined but may need extension
- Basic routes for Steam authentication and inventory fetching are in place
- Integration with user authentication system is partially implemented

## Database Schema for Steam Data

The database schema includes the following tables/models relevant to Steam integration:

- **UserSteamProfile**: Links GigaSwap user accounts to Steam accounts
- **CS2Item**: Stores CS2 item details (skins, weapons, etc.)
- **CS2Inventory**: Tracks items owned by users
- **CS2MarketListing**: Represents items listed for sale

### Database Integration Points

- **User Service**: Extended to support Steam account linking
- **Auth Middleware**: Handles Steam OpenID authentication flow
- **Repository Layer**: Provides data access methods for Steam-related operations

## Core Integration Flows

### Steam Authentication Flow

```python
# Current implementation pattern for Steam authentication
@router.get("/auth/steam/return")
async def steam_auth_return(
    request: Request,
    response: Response,
    steam_service: SteamService = Depends(get_steam_service),
    user_service: UserService = Depends(get_user_service)
):
    # 1. Validate Steam OpenID response
    steam_id = await steam_service.validate_steam_auth(request.query_params)
    
    # 2. Link Steam account to current user or create new user
    current_user = request.state.user
    if current_user:
        # Link Steam account to existing user
        await user_service.link_steam_account(current_user.id, steam_id)
    else:
        # Create new user from Steam account
        current_user = await user_service.create_user_from_steam(steam_id)
    
    # 3. Generate session token
    token = await generate_session_token(current_user)
    response.set_cookie("auth_token", token, httponly=True)
    
    return RedirectResponse(url="/market")
```

### Inventory Fetching Flow

```python
# Current implementation pattern for inventory fetching
@router.get("/inventory/steam", response_model=List[CS2ItemResponse])
async def get_steam_inventory(
    current_user: User = Depends(get_current_user),
    steam_service: SteamService = Depends(get_steam_service),
    cs2_repository: CS2Repository = Depends(get_cs2_repository)
):
    # 1. Get user's Steam ID
    steam_profile = await cs2_repository.get_user_steam_profile(current_user.id)
    if not steam_profile:
        raise HTTPException(status_code=404, detail="Steam account not linked")
    
    # 2. Fetch inventory from Steam API
    inventory_items = await steam_service.get_user_inventory(steam_profile.steam_id)
    
    # 3. Transform and return inventory items
    return [transform_inventory_item(item) for item in inventory_items]
```

### Marketplace Listing Flow

```python
# Current implementation pattern for marketplace listings
@router.post("/market/list", response_model=CS2MarketListingResponse)
async def create_market_listing(
    listing: CS2MarketListingCreate,
    current_user: User = Depends(get_current_user),
    cs2_repository: CS2Repository = Depends(get_cs2_repository),
    steam_service: SteamService = Depends(get_steam_service)
):
    # 1. Verify item ownership
    if not await steam_service.verify_item_ownership(
        current_user.steam_id, listing.asset_id
    ):
        raise HTTPException(status_code=403, detail="Item not owned by user")
    
    # 2. Create market listing
    market_listing = await cs2_repository.create_market_listing(
        user_id=current_user.id,
        item_id=listing.item_id,
        asset_id=listing.asset_id,
        price=listing.price,
        description=listing.description
    )
    
    # 3. Return created listing
    return market_listing
```

## Caching Strategy

The current caching implementation uses Redis for:

- Steam inventory data (cached for 5 minutes)
- CS2 item metadata (cached for 1 hour)
- Market listings (cached for 30 seconds)

Example cache implementation:

```python
async def get_cached_inventory(steam_id: str, redis: Redis = Depends(get_redis)):
    cache_key = f"inventory:{steam_id}"
    cached = await redis.get(cache_key)
    
    if cached:
        return json.loads(cached)
    
    # Fetch from Steam API if not cached
    inventory = await steam_api_client.get_inventory(steam_id)
    
    # Cache for 5 minutes
    await redis.set(cache_key, json.dumps(inventory), ex=300)
    
    return inventory
```

## Error Handling for Steam API

The system implements the following error handling strategies for Steam API:

- Retry mechanism for transient errors (3 retries with exponential backoff)
- Rate limiting compliance (using Redis-based rate limiter)
- Fallback to cached data when API is unavailable
- Comprehensive error logging and monitoring

## Testing & Development Patterns

For Steam integration testing:

- Mock Steam API responses using pytest fixtures
- Use VCR cassettes for API response recording/playback
- Maintain a development Steam account for integration testing
- Use dependency overrides to inject test services

## Extension Points

Key extension points for ongoing Steam integration work:

1. **Trade Offer System**: Implement trade offer creation and acceptance
2. **Pricing Service**: Add integration with CS2 pricing APIs
3. **Notification System**: Add webhooks for inventory changes
4. **Market Analytics**: Implement market data collection and analysis

## Best Practices

- Always use the Steam API client from `app/steam/services` rather than direct HTTP calls
- Use dependency injection consistently for all services
- Validate all Steam API responses using Pydantic models
- Implement proper error handling and rate limit compliance
- Cache frequently accessed data to reduce Steam API calls
- Use background tasks for long-running operations

---

This documentation is a living reference and must be updated as the codebase evolves. Always verify with the current source code before making significant changes. 