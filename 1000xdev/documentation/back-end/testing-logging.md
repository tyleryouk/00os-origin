# Back-End Testing & Logging

> **[Migrated from full-stack-workflow/back-end-development.md, 2024-06-11]**

This document provides concise, actionable guidance for back-end testing and logging in the GigaSwap project.

## Testing

### Testing Architecture
- **Unit Tests**: Test individual functions and classes in isolation.
- **API Tests**: Test FastAPI endpoints.
- **Integration Tests**: Test interactions between services.
- **Database Tests**: Test repository classes and database operations.

### Setting Up the Test Environment
- Use Python 3.9+ and pip.
- Install dependencies with `pip install -r requirements-dev.txt` in the `back-end` directory.

### Running Tests
- `python -m pytest` — Run all tests
- `python -m pytest tests/auth/` — Run tests for a specific module
- `python -m pytest tests/auth/test_auth_service.py` — Run a specific test file
- `python -m pytest tests/auth/test_auth_service.py::test_validate_token` — Run a specific test
- `python -m pytest --cov=app` — With coverage
- `python -m pytest --cov=app --cov-report=html` — HTML coverage report

### Mock Strategies
- Use unittest.mock or pytest fixtures for mocking services and dependencies.
- Use dependency overrides in FastAPI for test isolation.

### Example: Unit Test
```python
import pytest
from app.utils.validators import validate_email

def test_validate_email_with_valid_email():
    assert validate_email("user@example.com") == True
```

### Example: API Test
```python
from fastapi.testclient import TestClient
from app.main import app
client = TestClient(app)

def test_get_user_profile_authenticated():
    response = client.get("/api/users/profile", headers={"Authorization": "Bearer test_token"})
    assert response.status_code == 200
```

## Logging

### Logger Configuration
- Use Python's standard logging module for structured logging.
- Log levels: ERROR, WARNING, INFO, DEBUG.
- Configure log rotation and output format as needed.

### Usage Example
```python
import logging
logger = logging.getLogger("gigaswap")
logger.info("Order created successfully", extra={"order_id": 123})
```

### Error Tracking
- Log exceptions with stack traces for debugging.
- Use log analysis tools to monitor application health.

---
This document is updated as practices evolve. Remove or revise any section not directly relevant to the current cycle. 