# Back-End Testing & Logging

This document provides concise, actionable guidance for back-end testing and logging in the GigaSwap project.

## Testing Architecture

- **Unit Tests**: Test individual functions and classes in isolation
- **API Tests**: Test FastAPI endpoints using TestClient
- **Integration Tests**: Test interactions between services

## Test Categories

### Async Testing with httpx
```python
import pytest
import httpx

@pytest.mark.asyncio
async def test_get_steam_profile_valid():
    async with httpx.AsyncClient(base_url="http://127.0.0.1:8000") as client:
        response = await client.get(f"/api/steam/profile/{VALID_STEAM_ID}")
        assert response.status_code == 200
        data = response.json()
        assert "steam_id" in data
```

## Testing Best Practices

1. **Fixtures**: Use pytest fixtures for setup/teardown
2. **Parameterization**: Test multiple scenarios with `@pytest.mark.parametrize`
3. **Response Validation**: Validate response structure, not just status codes
4. **Testing Edge Cases**: Include tests for error conditions and edge cases

## Logging

### Logger Configuration
- Use Python's standard logging module for structured logging
- Log levels: ERROR, WARNING, INFO, DEBUG
- Store logs in dedicated directories by domain (e.g., /logs/steam/)

### Usage Example
```python
import logging
logger = logging.getLogger("gigaswap.steam")
logger.info("Profile retrieved successfully", extra={"steam_id": "76561199487496862"})
```

### Error Tracking
- Log exceptions with stack traces for debugging
- Include relevant context in log messages

### 00OS Log Analysis Command

A new 00OS command is available for quick one-off back-end log analysis and optional automated fixes:

| Command | Flags | Purpose |
|---------|-------|---------|
| `> dev-analyze-logs --back-end [--edit]` | `--back-end` (required), `--edit` (optional) | Analyze back-end logs once. Add `--edit` to automatically apply a single round of fixes based on the analysis. |

Use this command instead of ad-hoc log searches when you want a fast summary or automated one-shot remediation.

---
This document is updated as practices evolve. 