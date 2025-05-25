# Steam API Client Documentation

This document provides detailed information about the `SteamWebAPIClient` implementation in `back-end/app/steam/client.py`, which serves as the core component for integrating with the Steam Web API.

## Overview

The `SteamWebAPIClient` is a robust wrapper around the [SteamWebAPI.com](https://steamwebapi.com) service, providing a reliable and efficient way to interact with Steam's data. It implements best practices for API client design, including authentication, error handling, rate limiting, and retry logic.

## Key Features

- **Async Support**: Fully async-compatible for non-blocking API requests
- **Automatic Rate Limiting**: Respects API rate limits to prevent throttling
- **Intelligent Retry Logic**: Implements exponential backoff for transient errors
- **Comprehensive Error Handling**: Custom exceptions for different error types
- **Request Logging**: Detailed logging for debugging and monitoring
- **Configurable Timeouts**: Prevents requests from hanging indefinitely

## Client Initialization

```python
from app.steam.client import SteamWebAPIClient

# Initialize with API key from environment variables
client = SteamWebAPIClient()

# Or provide API key explicitly
client = SteamWebAPIClient(api_key="your-api-key", base_url="https://steamwebapi.com")
```

## Making API Requests

The client provides a low-level `_request` method which handles all the complexities of making requests to the API:

```python
# Example of using the base request method
response = await client._request(
    method="GET",
    endpoint="/api/v2/items/730/market",
    params={"limit": 10, "sort": "price"},
    retries=3,
    timeout=30
)
```

Higher-level methods are implemented for specific API endpoints:

```python
# Example of a higher-level method for getting CS2 items
items = await client.get_cs2_items(limit=10, sort_by="price")

# Example of getting user profile data
profile = await client.get_user_profile(steam_id="76561198028121353")
```

## Error Handling

The client uses a hierarchy of custom exceptions to provide detailed error information:

```
SteamAPIException (base)
├── SteamAPIRateLimitException (429)
├── SteamAPIAuthenticationException (401/403)
├── SteamAPINotFoundException (404)
├── SteamAPIServerException (5xx)
└── SteamAPIRequestException (other 4xx)
```

These can be caught and handled appropriately:

```python
from app.steam.exceptions import (
    SteamAPIException,
    SteamAPIRateLimitException,
    SteamAPINotFoundException
)

try:
    items = await client.get_cs2_items(limit=10)
except SteamAPIRateLimitException as e:
    # Handle rate limiting
    retry_after = e.retry_after
    logger.warning(f"Rate limited, retry after {retry_after} seconds")
except SteamAPINotFoundException:
    # Handle not found
    logger.error("Requested resource not found")
except SteamAPIException as e:
    # Handle any other API error
    logger.error(f"API error: {e}")
```

## Rate Limiting

The client automatically handles rate limits using response headers:

1. Tracks remaining requests via `X-RateLimit-Remaining`
2. Monitors reset time via `X-RateLimit-Reset`
3. Implements pre-emptive waiting when approaching limits
4. Respects `Retry-After` headers when rate limited

```python
# Internal rate limit checking
async def _check_rate_limit(self):
    """
    Checks if we're approaching rate limits and waits if necessary.
    """
    if self.rate_limit_remaining is not None and self.rate_limit_reset is not None:
        # If we're getting close to the limit, implement proactive waiting
        if self.rate_limit_remaining <= 5:
            now = time.time()
            time_until_reset = max(0, self.rate_limit_reset - now)
            
            if time_until_reset > 0:
                logger.warning(f"Approaching rate limit. Waiting {time_until_reset:.2f}s for reset")
                await asyncio.sleep(time_until_reset)
```

## Retry Mechanism

The client implements intelligent retry logic for different types of failures:

1. **Rate Limits**: Uses `Retry-After` header or exponential backoff
2. **Server Errors**: Uses exponential backoff with jitter
3. **Network Errors**: Uses exponential backoff with jitter
4. **Non-Retryable Errors**: Authentication, not found, bad request (not retried)

```python
# Example of retry logic from the implementation
if attempt < retries:
    sleep_time = backoff_factor * (2 ** attempt)
    log_message = f"Server error ({e.status_code}). Retrying in {sleep_time:.2f}s. (Attempt {attempt + 1}/{retries + 1})"
    logger.warning(log_message)
    await asyncio.sleep(sleep_time)
    continue
```

## Response Handling

All responses are automatically checked for errors and parsed as JSON:

```python
# Internal response handling
if not response.ok:
    try:
        # Attempt to get error details from response body
        error_detail = response.json().get("error", {}).get("message", response.text)
    except ValueError:
        error_detail = response.text
        
    error_message = f"HTTP Error {response.status_code} for {url}: {error_detail}"
    logger.error(error_message)
    
    # Raise the specific custom exception based on the status code
    raise_for_status_code(response.status_code, error_message, original_exception=None)

# Successful response handling
return response.json()
```

## Extending the Client

To extend the client with new API endpoints:

1. **Add a new method to the client class**:

```python
async def get_new_steam_resource(self, resource_id, **params):
    """
    Gets a new type of resource from the Steam Web API.
    
    Args:
        resource_id (str): ID of the resource
        **params: Additional query parameters
        
    Returns:
        dict: The resource data
    """
    endpoint = f"/api/v2/new-resource/{resource_id}"
    return await self._request("GET", endpoint, params=params)
```

2. **Update models for the new data**:
   - Create or update model classes in `steam/models/`
   - Ensure proper type validation and documentation

3. **Add appropriate error handling**:
   - Consider if new endpoints might return specific error codes
   - Update the exception hierarchy if needed

## Caching Integration

The client works seamlessly with the caching layer in `steam/cache.py`:

```python
from app.steam.cache import cache_response

class SteamWebAPIClient:
    # ...
    
    @cache_response(ttl=300)  # Cache for 5 minutes
    async def get_frequently_accessed_data(self, data_id):
        endpoint = f"/api/v2/data/{data_id}"
        return await self._request("GET", endpoint)
```

## Testing and Mocking

The client is designed to be easily mocked for testing:

```python
# Example test with mocking
async def test_get_cs2_items():
    # Create a mock client
    mock_client = AsyncMock(spec=SteamWebAPIClient)
    mock_client._request.return_value = {"items": [{"id": "1", "name": "Test Item"}]}
    
    # Test the service that uses the client
    service = ItemService(client=mock_client)
    items = await service.get_items()
    
    # Verify the client was called correctly
    mock_client._request.assert_called_once_with(
        "GET", 
        "/api/v2/items/730/market", 
        params={"limit": 10}
    )
    
    # Verify the result
    assert len(items) == 1
    assert items[0]["name"] == "Test Item"
```

## Best Practices for Using the Client

1. **Always use async/await**:
   ```python
   # Correct
   result = await client.get_data()
   
   # Incorrect - will return a coroutine, not the actual result
   result = client.get_data()
   ```

2. **Handle specific exceptions**:
   ```python
   try:
       result = await client.get_data()
   except SteamAPIRateLimitException:
       # Handle rate limiting specifically
   except SteamAPIException as e:
       # Handle other API errors
   ```

3. **Configure appropriate timeouts**:
   ```python
   # For potentially slow operations
   result = await client.get_large_inventory(timeout=60)
   
   # For time-sensitive operations
   result = await client.get_market_price(timeout=5)
   ```

4. **Use dependency injection**:
   ```python
   # In FastAPI route
   @router.get("/items")
   async def get_items(
       client: SteamWebAPIClient = Depends(get_steam_client)
   ):
       return await client.get_cs2_items()
   ```

## Related Documentation

- [Steam Models](./steam-models.md) - Data models used with the client
- [Steam Routes](./steam-routes.md) - API endpoints using the client
- [Steam Services](./steam-services.md) - Business logic built on the client 