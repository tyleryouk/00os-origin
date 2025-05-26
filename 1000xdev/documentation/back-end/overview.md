# Back-End Overview

> **[Migrated from back-end-architecture/back-end-overview.md, 2024-06-11]**

# Back-End Architecture Overview

This document provides a high-level overview of the GigaSwap back-end architecture. It is designed to be the starting point for understanding the back-end structure, key components, and patterns. For specific integrations like Steam, see the dedicated documentation in the `/1000xdev/documentation/steam/` folder.

## Application Framework

GigaSwap uses **FastAPI** as its core framework, providing:
- High-performance, async-compatible REST API
- Automatic OpenAPI/Swagger documentation
- Type validation via Pydantic models
- Dependency injection system
- Middleware support for cross-cutting concerns

## Directory Structure

The main application code resides in the `back-end/app` directory with the following organization:

```text
back-end/
├── app/
│   ├── auth/            - Authentication & authorization
│   ├── dependencies/    - FastAPI dependency providers
│   ├── gigaland_database/ - Database models and operations
│   ├── middleware/      - Request/response middleware
│   ├── orders/          - Order processing
│   ├── routes/          - General API routes
│   ├── steam/           - Steam API integration (see steam docs)
│   ├── users/           - User management
│   ├── utils/           - Utility functions and helpers
│   ├── __init__.py      - Package initialization
│   └── main.py          - FastAPI application setup
├── tests/               - Test suite
├── scripts/             - Utility scripts
└── requirements.txt     - Python dependencies
```

## Key Components

### Main Application (`main.py`)

The entry point for the FastAPI application that:
- Configures CORS middleware
- Registers all API routers
- Sets up startup/shutdown event handlers
- Initializes the database connection
- Configures logging

### Module Structure Pattern

Each major feature follows a consistent module structure:

```text
feature_module/
├── models/         - Pydantic models for API requests/responses
├── routes/         - API endpoints and route handlers
├── services/       - Business logic implementation
├── dependencies.py - FastAPI dependency providers
└── utils.py        - Utility functions specific to the feature
```

This pattern ensures a clear separation of concerns and makes the codebase more maintainable.

## Architecture Patterns

### Dependency Injection

FastAPI's dependency injection system is used extensively to:
- Provide database connections
- Handle authentication
- Inject service objects
- Validate request parameters

Example:
```python
from fastapi import Depends

# Dependency provider
def get_service():
    return ServiceClass()

# Usage in endpoint
@router.get("/resource")
async def get_resource(service = Depends(get_service)):
    return await service.get_data()
```

### Pydantic Models

Pydantic models are used for:
- Request validation
- Response serialization
- Data validation and conversion
- Documentation generation

Example:
```python
from pydantic import BaseModel, Field

class UserCreate(BaseModel):
    username: str = Field(..., min_length=3, max_length=50)
    email: str = Field(..., pattern=r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
    password: str = Field(..., min_length=8)
```

### Async First

The application is designed to be fully async-compatible:
- All database operations are async
- API endpoints are async functions
- External service calls use async clients
- Background tasks use async workers

## Database Structure

The application uses PostgreSQL for persistent storage, with:
- Models defined in the `gigaland_database` module
- Migrations managed through SQL scripts
- Connection pooling for performance
- Async query execution

## Authentication

Authentication is handled via JWT tokens with:
- Token-based authentication
- Role-based authorization
- Secure password hashing
- Refresh token mechanism

Implementation:
```python
# Simplified example
@router.post("/login")
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    user = await authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    access_token = create_access_token(data={"sub": user.username})
    return {"access_token": access_token, "token_type": "bearer"}
```

## Error Handling

The application uses a centralized error handling approach with:
- Custom exception classes
- Consistent error response format
- Proper HTTP status code mapping
- Detailed error logging

Example error response:
```json
{
  "status_code": 400,
  "detail": "Invalid input data",
  "errors": [
    {"field": "email", "message": "Invalid email format"}
  ],
  "request_id": "req-123456"
}
```

## Logging

Structured logging is implemented throughout the application using:
- Python's standard logging module
- JSON-formatted logs
- Component-based loggers
- Log level configuration

Example:
```python
logger = get_logger("order_service")

async def create_order(order_data):
    logger.info("Creating new order", extra={"order_id": order_data.id})
    # Implementation
    logger.info("Order created successfully", extra={"order_id": order_data.id})
```

## Testing Strategy

The application uses a dual-approach testing strategy that combines flexibility with structure:

### 1. Script-based Testing (`/scripts`)
- **Purpose**: Direct API validation during development
- **Tools**: Simple Python scripts using requests, JSON, and dotenv
- **Advantages**: Quick to write, easy to modify, focused on specific endpoints
- **Use Case**: Testing external API integrations (e.g., Steam Web API)
- **Execution**: Run individually via `python scripts/test_script.py`

### 2. Formal Test Suite (`/tests`)
- **Purpose**: Comprehensive testing for CI/CD and regression testing
- **Tools**: pytest, pytest-asyncio, httpx, pytest-cov
- **Advantages**: Structured, reusable, supports coverage reporting
- **Use Case**: System-wide testing, API contract validation
- **Execution**: Run via `pytest tests/`

### Testing Approaches
The application supports two primary testing approaches:

1. **TestClient (Isolated)**:
```python
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_get_user():
    response = client.get("/users/123")
    assert response.status_code == 200
    assert "username" in response.json()
```

2. **httpx with Live Server (Integration)**:
```python
import pytest
import httpx
from httpx import AsyncClient

@pytest.mark.asyncio
async def test_get_steam_profile():
    async with AsyncClient(base_url="http://127.0.0.1:8000") as client:
        response = await client.get("/api/steam/profile/76561199487496862")
        assert response.status_code == 200
        data = response.json()
        assert "steam_id" in data
```

### External API Testing
For external API integrations like Steam:
- API responses are logged for debugging (`/logs/steam/`)
- Direct API tests validate correct parameter structures
- Endpoint-specific tests verify proper API response handling

For more details, see [Testing and Logging](./testing-logging.md) and [Steam Tests](../steam/steam-tests.md).

## Extension Points

The architecture is designed to be extensible in the following ways:

1. **New API Features**:
   - Create a new module in the app directory
   - Implement models, routes, and services
   - Register new router in main.py

2. **External Integrations**:
   - Follow the client pattern for external APIs
   - Implement in a dedicated module
   - Use dependency injection for testability

3. **Enhanced Caching**:
   - Redis is already integrated for distributed caching
   - Implement new cache decorators as needed

## Environment Variables

The application is configured via environment variables:
- Database connection settings
- API keys for external services
- Feature flags
- Environment-specific settings

These are loaded using python-dotenv from a .env file in development.

## Further Information

For more detailed information on specific components, refer to:
- [Authentication System](./authentication.md)
- [Database Models and Migrations](./database-models.md)
- [Testing Strategy](./testing.md)
- [Steam API Integration](../steam/steam.md) 