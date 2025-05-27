# Steam API Testing Strategy

> **[Updated 2025-06-26]** - **Proxy Pattern Implementation**

## ⚠️ CRITICAL: TERMINAL SETUP REQUIRED ⚠️

**BEFORE running ANY Steam API tests or scripts, you MUST run these commands:**

```powershell
# 1. Change to back-end directory
cd back-end

# 2. Activate virtual environment
.\.gigaland\Scripts\Activate.ps1

# 3. Verify (.gigaland) appears in your prompt
# Correct prompt: (.gigaland) PS C:\...\back-end>
```

**❌ WRONG:** Running `python scripts/test_*.py` from workspace root  
**✅ CORRECT:** Running from back-end directory with virtual environment activated

**This is documented here because it's required for ALL Steam testing work.**

## Overview

GigaSwap uses a **simple proxy pattern** for Steam API integration with a dual-approach testing strategy:

**Architecture**: All Steam profile endpoints proxy steamwebapi.com responses directly (no mapping/transformation)

**Testing Strategy**:
1. **Script-based Testing** (`back-end/scripts/`): Direct API validation scripts for development
2. **Formal Test Suite** (`back-end/tests/`): Structured pytest-based testing for CI/CD and regression

## Testing Architecture

### Script-based Testing Structure

```
back-end/scripts/
├── test_steam_api.py         # Basic Steam Web API connectivity testing
├── test_profile_endpoint.py  # Testing Steam profile endpoints
└── test_steam_inventory.py   # Testing Steam inventory endpoints
```

### Formal Test Suite Structure

```
back-end/tests/
└── test_steam_profile.py     # Comprehensive Steam profile endpoint tests
```

## Proxy Pattern Testing Approach

Both approaches test the **proxy pattern implementation**:

1. **External API Testing**: Direct calls to Steam Web API (steamwebapi.com) for validation
2. **Internal API Testing**: Tests against our FastAPI proxy endpoints

### Benefits of Proxy Pattern Testing

- Validates direct passthrough of upstream responses
- Tests that status codes match steamwebapi.com behavior exactly
- Ensures frontend receives expected steamwebapi.com response format
- Validates error handling from upstream API
- Tests performance and timeout handling of proxy layer

## Script-Based Testing

Our `scripts/` directory contains focused scripts that directly test individual Steam API endpoints.

### Example: Inventory API Testing

```python
def test_inventory_endpoint():
    """Test the inventory endpoint with a direct API call."""
    
    # Construct the URL
    endpoint = "/steam/api/inventory"
    url = f"{BASE_URL}{endpoint}"
    
    # Set up parameters
    params = {
        "steam_id": STEAM_ID,
        "game": GAME,
        "key": API_KEY
    }
    
    try:
        # Make the request
        response = requests.get(url, params=params, timeout=30)
        
        # Save response to file for analysis
        with open("steam_inventory_response.json", "w") as f:
            json.dump(response.json(), f, indent=2)
        
        print(f"Status code: {response.status_code}")
        if response.status_code == 200:
            print(f"Success! Found {len(response.json().get('items', []))} items in inventory")
        else:
            print(f"Error: {response.json().get('message', 'Unknown error')}")
    except Exception as e:
        print(f"Exception occurred: {e}")
```

### Running Script-Based Tests

```powershell
# Change to back-end directory
cd C:\Users\ethde\Desktop\GigaSwap\back-end

# Activate virtual environment
.\.gigaland\Scripts\Activate.ps1

# Run individual test scripts
python scripts/test_steam_api.py;
python scripts/test_profile_endpoint.py;
python scripts/test_steam_inventory.py;
```

## Formal Test Suite

Our `tests/` directory contains comprehensive test suites using pytest and httpx for async testing.

### Example: Proxy Pattern Testing

```python
import pytest
import httpx
from httpx import AsyncClient

# Constants for testing
VALID_STEAM_ID = "76561199487496862"
INVALID_STEAM_ID = "invalid12345"

@pytest.mark.asyncio
async def test_get_steam_profile_valid():
    """Test that proxy returns steamwebapi.com response format."""
    async with AsyncClient(base_url="http://127.0.0.1:8000") as client:
        response = await client.get(f"/api/steam/profile/{VALID_STEAM_ID}")
        assert response.status_code == 200
        # Expect steamwebapi.com response format (not internal format)
        data = response.json()
        assert "steam_id" in data or "id" in data  # steamwebapi.com format

@pytest.mark.asyncio
async def test_get_steam_friendlist_no_friends():
    """Test that proxy returns steamwebapi.com 406 status for no friends."""
    async with AsyncClient(base_url="http://127.0.0.1:8000") as client:
        response = await client.get(f"/api/steam/profile/friendlist/{VALID_STEAM_ID}")
        # Expect steamwebapi.com status codes (406 = "No friends found")
        assert response.status_code in [200, 406, 408]  # Valid upstream responses

@pytest.mark.asyncio
async def test_get_steam_profile_invalid():
    """Test that proxy returns steamwebapi.com error format."""
    async with AsyncClient(base_url="http://127.0.0.1:8000") as client:
        response = await client.get(f"/api/steam/profile/{INVALID_STEAM_ID}")
        # steamwebapi.com returns 404 for invalid Steam IDs
        assert response.status_code == 404
        # Expect upstream error format, not internal {"detail": "..."} format
        data = response.json()
        assert "error" in data  # steamwebapi.com error format
```

### Running Formal Tests

```powershell
# Change to back-end directory
cd C:\Users\ethde\Desktop\GigaSwap\back-end

# Activate virtual environment
.\.gigaland\Scripts\Activate.ps1

# Run the entire test suite
python -m pytest;

# Run specific Steam tests
python -m pytest tests/test_steam_profile.py;

# Run with verbose output
python -m pytest tests/test_steam_profile.py -v;
```

## Key Proxy Endpoints Tested

All endpoints use **simple proxy pattern** - direct passthrough to steamwebapi.com:

1. **Profile Endpoints** (Proxy to steamwebapi.com)
   - `/api/steam/profile/{steam_id}` → `steamwebapi.com/steam/api/profile`
   - `/api/steam/profile/friendlist/{steam_id}` → `steamwebapi.com/steam/api/friendlist`
   - `/api/steam/profile/inventory/{steam_id}` → `steamwebapi.com/steam/api/inventory`
   - `/api/steam/profile/inventory/{steam_id}/items` → `steamwebapi.com/steam/api/inventory` (parsed)
   - `/api/steam/profile/eligibility/{steam_id}` → Custom eligibility logic
   - `/api/steam/profile/privacy/{steam_id}` → `steamwebapi.com/steam/api/profile` (privacy fields)

## Test Data Management

We use a consistent test Steam ID (`76561199487496862`) across all tests for consistency and to avoid rate limiting issues with multiple different accounts.

## Required Setup for Testing

1. **Running Server**: The FastAPI backend must be running on `http://127.0.0.1:8000`
2. **API Key**: Valid Steam Web API key must be configured in config.json or .env file
3. **Dependencies**: httpx and pytest-asyncio must be installed

## Proxy Pattern Testing Best Practices

1. **Upstream Response Format**: Tests must expect steamwebapi.com response format, not internal format
2. **Status Code Matching**: Assert on steamwebapi.com status codes (e.g., 406 for "No friends found")
3. **Error Format Validation**: Expect upstream error format (`{"error": "message"}`) not internal format
4. **Response Passthrough**: Validate that responses are passed through without transformation
5. **Timeouts**: Configure appropriate timeouts for proxy + external API calls
6. **Logging**: Log all API responses for debugging proxy behavior
7. **Parameterized Tests**: Use pytest's parameterize to test multiple scenarios

## Log Analysis

All Steam API responses are logged to:
- `back-end/logs/steam/YYYY-MM-DD/` - Daily log files by endpoint and Steam ID

## Future Improvements

1. **Mock Responses**: Add option to use mock responses for faster testing
2. **Expanded Coverage**: Add tests for remaining Steam endpoints
3. **Rate Limiting**: Implement test rate limiting to avoid API throttling
4. **Fixtures**: Develop reusable test fixtures for common operations

---

This documentation is continuously updated as our testing strategy evolves. For the most current information, refer to the implemented tests in `back-end/tests/` and scripts in `back-end/scripts/`.
