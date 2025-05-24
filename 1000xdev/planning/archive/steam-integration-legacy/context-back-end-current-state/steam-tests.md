# Current State of Steam Tests 

## Overview

The `back-end/tests/steam/` directory contains tests specifically designed to interact with a live, running instance of the FastAPI application. The testing approach focuses on live endpoint testing rather than unit testing with mocks.

## Directory Structure

```
back-end/tests/steam/
├── test_live_items_routes.py  # Tests for Steam items API endpoints
├── README.md                  # Documentation on testing approach
└── __pycache__/               # Python cache directory
```

## Testing Approach

- **Live Testing**: Tests are designed to interact with a running FastAPI server, making actual HTTP requests.
- **No Mocking**: These tests do not use FastAPI's `TestClient` or `unittest.mock` - they interact with the application as an external client would.
- **Framework**: `pytest` is used as the primary testing framework.
- **HTTP Client**: The `requests` library is used to make HTTP requests to the defined `BASE_URL` (typically `http://127.0.0.1:8000`).

## Current Test Coverage

### `test_live_items_routes.py`

Currently implements two test functions:

1. **`test_get_item_categories_success()`**
   - Tests the GET `/api/steam/items/categories` endpoint
   - Verifies successful retrieval of CS2 item categories
   - Validates response structure and data types

2. **`test_get_float_info_success()`**
   - Tests the GET `/api/steam/items/float` endpoint
   - Uses an example CS2 inspect link
   - Handles multiple valid status codes (200, 400, 404)
   - Validates response structure based on status code

### Planned/Commented Tests

The file includes commented placeholders for additional tests:
- `test_get_item_details_success()`
- `test_search_items_success()`
- `test_get_item_listings_success()`
- `test_get_price_history_success()`

## Test Execution

Tests are run from the `back-end` directory using:

```bash
# First, ensure the virtual environment is active:
# .\.gigaland\Scripts\activate 
# Then, run the tests:
python -m pytest tests/steam/test_live_items_routes.py -v
```

## Prerequisites for Testing

1. The FastAPI backend must be running locally (typically on port 8000)
2. Environment variables must be properly configured (loaded via `dotenv`)
3. Actual Steam API connectivity is required for many tests
4. Note that some tests may fail if using invalid or outdated item IDs/inspect links

## Current Issues and Limitations

1. **Limited Test Coverage**: Only two endpoint tests are currently implemented.
2. **Reliance on External API**: Tests depend on the external Steam API, which may cause tests to fail if the Steam API is unavailable.
3. **Hard-coded Test Data**: The test for float info uses a static inspect link that may become invalid over time.
4. **No Comprehensive Test Suite**: Tests currently focus only on the items-related endpoints, not covering profiles or inventory.

## Logging and Debugging

- Application logs for debugging are found in the root folder `logs-main` and its subdirectories.
- Test output from `pytest` shows pass/fail status with detailed information in verbose mode.

## Future Development Priorities

1. **Expand Test Coverage**: Implement the commented test functions and add tests for profiles and inventory endpoints.
2. **Improve Test Data Management**: Create a system for maintaining valid test data.
3. **Add Negative Test Cases**: Test error handling with invalid inputs.
4. **Implement Authorization Tests**: Test endpoints that require authentication.
5. **Create Test Suite**: Organize tests into suites for systematic testing.

## Current Pydantic v2 Compatibility Issues

The test files themselves may not exhibit Pydantic issues directly, but they interact with API endpoints that use Pydantic models. Current issues in the main codebase include:

1. **OrderType Schema Generation Error**: 
   ```
   PydanticSchemaGenerationError: Unable to generate pydantic-core schema for <class 'app.steam.models.item.OrderType'>
   ```
   
2. **Configuration Migration Warning**:
   ```
   UserWarning: Valid config keys have changed in V2:
   * 'allow_population_by_field_name' has been renamed to 'validate_by_name'
   ```

These issues need to be addressed in the model definitions, not in the test files themselves, as they cause the FastAPI application to fail at startup, preventing the tests from running successfully.
