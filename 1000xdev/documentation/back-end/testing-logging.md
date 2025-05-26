# Back-End Testing & Logging

> **[Updated 2025-06-26]**

This document provides concise, actionable guidance for back-end testing and logging in the GigaSwap project.

## Testing Architecture

GigaSwap uses a dual-approach testing strategy:

### 1. Script-based Testing (`/scripts`)
- **Direct API Testing**: Simple scripts for direct, ad-hoc API validation
- **Development Tools**: Used during active development for quick feedback
- **Real API Calls**: Makes actual HTTP requests to external APIs (e.g., Steam Web API)
- **Manual Execution**: Run individually as needed during development

### 2. Formal Test Suite (`/tests`)
- **Structured Testing**: Pytest-based formal tests for CI/CD and regression testing
- **Automated Validation**: Run as part of automated pipelines
- **Comprehensive Coverage**: Designed to test all API endpoints systematically
- **Isolated Environment**: Can use either mock data or real API calls as needed

## Test Categories

- **Unit Tests**: Test individual functions and classes in isolation
- **API Tests**: Test FastAPI endpoints using both TestClient and httpx
- **Integration Tests**: Test interactions between services
- **Live API Tests**: Test actual API calls to external services (Steam Web API)

## Setting Up the Test Environment

- Use Python 3.9+ and pip
- Install dependencies with `pip install -r requirements-dev.txt` in the `back-end` directory
- External packages needed: pytest, pytest-asyncio, httpx, pytest-cov

## Running Tests

### Script-Based Testing
```powershell
# Change to back-end directory
cd C:\Users\ethde\Desktop\GigaSwap\back-end

# Activate virtual environment
.\.gigaland\Scripts\Activate.ps1

# Run a specific test script
python scripts/test_steam_api.py;
python scripts/test_profile_endpoint.py;
python scripts/test_steam_inventory.py;
```

### Formal Test Suite
```powershell
# Change to back-end directory
cd C:\Users\ethde\Desktop\GigaSwap\back-end

# Activate virtual environment
.\.gigaland\Scripts\Activate.ps1

# Run all tests
python -m pytest;

# Run tests for a specific module
python -m pytest tests/test_steam_profile.py;

# Run a specific test
python -m pytest tests/test_steam_profile.py::test_get_steam_profile_valid;

# Run with coverage
python -m pytest --cov=app --cov-report=html;
```

## Testing Approaches

### 1. TestClient (Fast, Isolated)
```python
from fastapi.testclient import TestClient
from app.main import app
client = TestClient(app)

def test_get_user_profile_authenticated():
    response = client.get("/api/users/profile", headers={"Authorization": "Bearer test_token"})
    assert response.status_code == 200
```

### 2. httpx with Live Server (Integration, Real API)
```python
import pytest
import httpx
import asyncio
from pytest_asyncio import fixture

@pytest.mark.asyncio
async def test_get_steam_profile_valid():
    async with httpx.AsyncClient(base_url="http://127.0.0.1:8000") as client:
        response = await client.get(f"/api/steam/profile/{VALID_STEAM_ID}")
        assert response.status_code == 200
        data = response.json()
        assert "steam_id" in data
```

## Script-Based Testing Best Practices

1. **Focused Scripts**: Each script should test one specific functionality
2. **Clear Output**: Print clear success/failure messages
3. **Error Handling**: Include try/except blocks to gracefully handle errors
4. **Documentation**: Include docstrings explaining the script's purpose
5. **Save Results**: Save API responses to files for later analysis when needed

Example script structure:
```python
"""
Test script to verify Steam Web API profile endpoint connectivity.
This script makes a direct call to the Steam Web API profile endpoint.
"""

import requests
import json
import os

# Constants
API_KEY = "YOUR_API_KEY"  # Use environment variables in production
BASE_URL = "https://www.steamwebapi.com"
STEAM_ID = "76561199487496862"  # Test Steam ID

def test_profile_endpoint():
    """Test the profile endpoint with a direct API call."""
    
    # Construct the URL
    endpoint = "/steam/api/profile"
    url = f"{BASE_URL}{endpoint}"
    
    # Set up parameters
    params = {
        "id": STEAM_ID,
        "key": API_KEY
    }
    
    try:
        # Make the request
        response = requests.get(url, params=params, timeout=30)
        
        # Save response to file
        with open("steam_profile_response.json", "w") as f:
            json.dump(response.json(), f, indent=2)
            
        print(f"Request status: {response.status_code}")
        print("Response saved to steam_profile_response.json")
        return True
    except Exception as e:
        print(f"Error: {e}")
        return False

if __name__ == "__main__":
    test_profile_endpoint()
```

## Formal Test Suite Best Practices

1. **Fixtures**: Use pytest fixtures for setup/teardown
2. **Parameterization**: Test multiple scenarios with `@pytest.mark.parametrize`
3. **Async Testing**: Use `pytest-asyncio` for async endpoint testing
4. **Response Validation**: Validate response structure, not just status codes
5. **Testing Edge Cases**: Include tests for error conditions and edge cases

## Logging

### Logger Configuration
- Use Python's standard logging module for structured logging
- Log levels: ERROR, WARNING, INFO, DEBUG
- Configure log rotation and output format as needed
- Store logs in dedicated directories by domain (e.g., /logs/steam/)

### Usage Example
```python
import logging
logger = logging.getLogger("gigaswap.steam")
logger.info("Profile retrieved successfully", extra={"steam_id": "76561199487496862"})
```

### Error Tracking
- Log exceptions with stack traces for debugging
- Use log analysis tools to monitor application health
- Include relevant context in log messages

---
This document is updated as practices evolve. For the most current testing strategy, refer to the implemented tests in `back-end/tests/` and scripts in `back-end/scripts/`. 