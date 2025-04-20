# Standardized Tool Call Processes

This document outlines the standard sequences of tool calls for common operations in the Steam API integration project, focusing on testing and debugging procedures.

## Backend Testing Procedures

### Setting Up the Testing Environment

```bash
# Navigate to the backend directory
cd back-end

# Activate the virtual environment
.\.gigaland\Scripts\activate  # Windows
# OR
source .gigaland/bin/activate  # Linux/Mac

# Install any missing dependencies if needed
pip install -r requirements.txt
```

### Starting the FastAPI Server for Testing

```bash
# Navigate to the backend directory if not already there
cd back-end

# Activate the virtual environment if not already activated
.\.gigaland\Scripts\activate  # Windows
# OR
source .gigaland/bin/activate  # Linux/Mac

# Start the FastAPI server with reload enabled
uvicorn app.main:app --reload
```

The server will start on http://127.0.0.1:8000 by default. Keep this terminal open and running.

### Running API Tests

In a separate terminal window:

```bash
# Navigate to the backend directory
cd back-end

# Activate the virtual environment
.\.gigaland\Scripts\activate  # Windows
# OR
source .gigaland/bin/activate  # Linux/Mac

# Run all Steam API tests
python -m pytest tests/steam/ -v

# Run specific test file
python -m pytest tests/steam/test_live_items_routes.py -v

# Run a specific test function
python -m pytest tests/steam/test_live_items_routes.py::test_get_item_float -v
```

### Debugging Failed Tests

When a test fails, follow these steps:

1. Check the server logs in the first terminal for error messages
2. Examine the test output for failed assertions
3. Verify the expected vs. actual response data
4. Check for any model validation errors in the server logs
5. Debug the relevant endpoint implementation in the `back-end/app/steam` directory

### Testing with SwaggerUI

You can also test endpoints manually using SwaggerUI:

1. Start the FastAPI server as described above
2. Open your browser and go to http://127.0.0.1:8000/docs
3. Find the relevant Steam API endpoint in the documentation
4. Click "Try it out" and provide the necessary parameters
5. Click "Execute" to send the request
6. Check the response and status code

## Common Issues and Fixes

### Pydantic Model Errors

If you encounter Pydantic validation errors:

1. Check if the model is using the correct Pydantic v2 syntax
2. Ensure all required fields are properly defined
3. Verify that field types match the expected API response
4. For models with `Config` classes, ensure they use Pydantic v2 naming conventions:
   - Replace `allow_population_by_field_name = True` with `populate_by_name = True`
   - Replace `schema_extra` with `json_schema_extra`
5. For custom types like `OrderType`, ensure they implement `__get_pydantic_core_schema__` or use built-in Enum types

### Import and File Naming Issues

If you encounter import errors or module not found errors:

1. Check for file naming discrepancies:
   - The current codebase has an issue where imports use `app.steam.models.item` but the file is named `items.py`
   - Fix by either:
     - Renaming the file to match imports: `items.py` → `item.py`
     - OR updating all import statements to use the correct module name
2. Ensure all `__init__.py` files correctly expose the needed modules
3. Check import statement paths for typos
4. Verify the virtual environment has all required packages installed

### API Connection Issues

If tests fail due to API connection issues:

1. Verify the API key is correctly set in the `.env` file
2. Check for rate limiting issues in the API response
3. Ensure the network connection is stable
4. Add retries with backoff to handle temporary connectivity issues

## Continuous Integration Workflow

For implementing new endpoints:

1. Define the endpoint in the appropriate router file
2. Implement the service method in the relevant client class
3. Create a test file or add test functions to an existing file
4. Start the server and run the tests to verify functionality
5. Update the `endpoint-integration-progress.md` file with the current status

## Standardized Testing Output Format

When reporting test results, use the following format:

```
Test: [TEST_NAME]
Status: [PASS/FAIL]
Endpoint: [ENDPOINT_PATH]
Expected: [EXPECTED_BEHAVIOR]
Actual: [ACTUAL_BEHAVIOR]
Fix (if failed): [PROPOSED_FIX]
```

Example:

```
Test: test_get_item_float
Status: FAIL
Endpoint: GET /api/steam/item/float
Expected: Return float value for valid item
Actual: Server error 500 - Pydantic model validation error
Fix: Update OrderType class to use Enum implementation compatible with Pydantic v2
```

## Backend Environment Setup

This sequence sets up the backend Python environment.

1.  **Navigate to Backend Directory and Activate Virtual Environment:**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Navigate to the backend directory.", command="cd back-end"))
    ```
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Activate the Python virtual environment.", command=".\\.gigaland\\Scripts\\activate"))
    ```

## Running the FastAPI Server

**IMPORTANT:** The live endpoint tests require a running FastAPI server instance. This sequence starts the server in the background.

1.  **Start the FastAPI Server:**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Start the FastAPI server in the background.", command="cd back-end && .\\.gigaland\\Scripts\\activate && uvicorn app.main:app --reload", is_background=true))
    ```

    Note: The server will run at http://127.0.0.1:8000 by default.

## Backend Live Endpoint Testing

This sequence runs the backend pytest live endpoint tests against a running FastAPI server. 
Ensure the virtual environment is activated and the FastAPI server is running first (see setup and server start sequences above).

### Testing Individual API Categories

Each test file corresponds to a specific category of Steam Web API endpoints, as organized in the JSON schema files in `1000xdev/steam-integration/steam-web-api-research/`.

1.  **Test Items Endpoints (`test_live_items_routes.py`):**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run pytest for items endpoints.", command="cd back-end && .\\.gigaland\\Scripts\\activate && python -m pytest tests/steam/test_live_items_routes.py -v", is_background=false))
    ```

2.  **Test Profile Endpoints (`test_live_profile_routes.py`):**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run pytest for profile endpoints.", command="cd back-end && .\\.gigaland\\Scripts\\activate && python -m pytest tests/steam/test_live_profile_routes.py -v", is_background=false))
    ```

3.  **Test Trade Endpoints (`test_live_trade_routes.py`):**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run pytest for trade endpoints.", command="cd back-end && .\\.gigaland\\Scripts\\activate && python -m pytest tests/steam/test_live_trade_routes.py -v", is_background=false))
    ```

4.  **Test Info Endpoints (`test_live_info_routes.py`):**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run pytest for info endpoints.", command="cd back-end && .\\.gigaland\\Scripts\\activate && python -m pytest tests/steam/test_live_info_routes.py -v", is_background=false))
    ```

5.  **Test Explore Endpoints (`test_live_explore_routes.py`):**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run pytest for explore endpoints.", command="cd back-end && .\\.gigaland\\Scripts\\activate && python -m pytest tests/steam/test_live_explore_routes.py -v", is_background=false))
    ```

6.  **Test Account Endpoints (`test_live_account_routes.py`):**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run pytest for account endpoints.", command="cd back-end && .\\.gigaland\\Scripts\\activate && python -m pytest tests/steam/test_live_account_routes.py -v", is_background=false))
    ```

### Running All Tests

7.  **Run All Tests:**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run all Steam API integration tests.", command="cd back-end && .\\.gigaland\\Scripts\\activate && python -m pytest tests/steam/ -v", is_background=false))
    ```

## Creating a New Test File

This sequence helps create a new test file for a specific API category.

1.  **Create Test File Template:**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Create a new test file from template.", command="cd back-end && .\\.gigaland\\Scripts\\activate && python -c \"import os; open(os.path.join('tests', 'steam', 'test_live_CATEGORY_routes.py'), 'w').write('import pytest\\nimport requests\\nimport os\\nfrom dotenv import load_dotenv\\n\\n# Load environment variables from .env file\\nload_dotenv()\\n\\n# Base URL for the locally running FastAPI server\\nBASE_URL = \"http://127.0.0.1:8000\"\\n\\ndef test_example_endpoint_success():\\n    \"\"\"Tests the GET /api/steam/example endpoint for successful retrieval.\"\"\"\\n    endpoint = f\"{BASE_URL}/api/steam/example\"\\n    \\n    try:\\n        response = requests.get(endpoint)\\n        \\n        # Check status code\\n        assert response.status_code == 200, f\"Expected 200 OK, got {response.status_code}\"\\n        \\n        # Check response data\\n        response_data = response.json()\\n        assert isinstance(response_data, dict), \"Expected response to be a dictionary\"\\n        \\n        print(f\"\\nGET {endpoint} - Success: {response.status_code}\")\\n        \\n    except requests.exceptions.RequestException as e:\\n        pytest.fail(f\"Request to {endpoint} failed: {e}\")\\n    except Exception as e:\\n        pytest.fail(f\"An unexpected error occurred: {e}\")\\n').replace('CATEGORY', input('Enter API category (items, profile, trade, info, explore, account): '))\"", is_background=false))
    ```

## Checking Application Logs

This sequence checks the application logs to diagnose issues encountered during testing.

1.  **View Steam API Logs:**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="View the most recent Steam API logs.", command="cd logs-main/steam && type (Get-ChildItem -File | Sort-Object LastWriteTime -Descending | Select-Object -First 1).Name | Select-Object -Last 50", is_background=false))
    ```

## Service Implementation Tasks

These commands help with implementing the service classes for each API category.

1.  **Create a New Service Class:**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Create a new service class file.", command="cd back-end && .\\.gigaland\\Scripts\\activate && python -c \"import os; open(os.path.join('app', 'steam', 'services', input('Enter service name (e.g., items.py): ')), 'w').write('from typing import List, Optional, Dict, Any\\nfrom pydantic import ValidationError\\n\\n# Import app logger\\nfrom app.utils.logger import setup_logger\\n\\n# Import client, models and cache\\nfrom ..client import SteamWebAPIClient\\nfrom ..cache import RedisCache\\n\\n# Setup logger\\nlogger = setup_logger(\\'steam_SERVICE_client\\', \\'steam\\')\\n\\nclass SERVICEClient:\\n    \"\"\"Client for interacting with Steam Web API endpoints related to DESCRIPTION.\"\"\"\\n    \\n    def __init__(self, client: SteamWebAPIClient):\\n        \"\"\"Initializes the SERVICEClient.\\n        \\n        Args:\\n            client (SteamWebAPIClient): An instance of the base SteamWebAPIClient.\\n        \"\"\"\\n        self.client = client\\n        \\n        # Initialize Redis cache\\n        self.cache = RedisCache(prefix=\"steam:SERVICE:\", ttl=3600)  # 1 hour default TTL\\n        logger.info(\"SERVICEClient initialized with Redis cache\")\\n').replace('SERVICE', input('Enter service prefix (e.g., items): ')).replace('DESCRIPTION', input('Enter service description: '))\"", is_background=false))
    ```

2.  **Create Route File for a Service:**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Create a new routes file.", command="cd back-end && .\\.gigaland\\Scripts\\activate && python -c \"import os; open(os.path.join('app', 'steam', 'routes', input('Enter routes file name (e.g., items_routes.py): ')), 'w').write('from fastapi import APIRouter, Depends, HTTPException, status\\nfrom typing import List, Optional\\n\\n# Import app logger\\nfrom app.utils.logger import get_logger\\n\\n# Import Steam API client and models\\nfrom app.steam.client import SteamWebAPIClient\\nfrom app.steam.services import SERVICEClient\\n\\n# Setup router\\nrouter = APIRouter(\\n    prefix=\"/api/steam/SERVICE\",\\n    tags=[\"steam-SERVICE\"],\\n    responses={\\n        404: {\"description\": \"Not found\"},\\n        401: {\"description\": \"Unauthorized\"},\\n        403: {\"description\": \"Forbidden\"},\\n        500: {\"description\": \"Internal server error\"},\\n        429: {\"description\": \"Too many requests\"}\\n    }\\n)\\n\\n# Get logger\\nlogger = get_logger(\"steam_SERVICE_routes\", \"steam\")\\n\\n# Dependencies\\nasync def get_steam_client():\\n    \"\"\"Dependency to get Steam Web API client.\"\"\"\\n    # This should be configured with your API key\\n    # In a production environment, retrieve from environment variables\\n    from app.utils.config import get_config\\n    config = get_config()\\n    api_key = config.get(\"STEAM_API_KEY\", \"\")\\n    client = SteamWebAPIClient(api_key=api_key)\\n    return client\\n\\nasync def get_SERVICE_client(client: SteamWebAPIClient = Depends(get_steam_client)):\\n    \"\"\"Dependency to get SERVICE client.\"\"\"\\n    return SERVICEClient(client=client)\\n').replace('SERVICE', input('Enter service name (e.g., items): '))\"", is_background=false))
    ```

## Reference Commands

### Full Dependency Installation (if needed)

Use this command if dependencies need to be reinstalled from scratch.

```tool_code
print(default_api.run_terminal_cmd(explanation="Navigate to backend, activate venv, and install dependencies using PowerShell chaining.", command="cd back-end && .\\.gigaland\\Scripts\\activate && pip install -r requirements.txt", is_background=false))
```

### Creating Initial Test Structure

This command helps create the initial test structure for all endpoint categories.

```tool_code
print(default_api.run_terminal_cmd(explanation="Create test files for all API categories.", command="cd back-end/tests/steam && echo import pytest > test_live_items_routes.py && echo import pytest > test_live_profile_routes.py && echo import pytest > test_live_trade_routes.py && echo import pytest > test_live_info_routes.py && echo import pytest > test_live_explore_routes.py && echo import pytest > test_live_account_routes.py", is_background=false))
```

## Fixing Current Model Issues

This sequence provides step-by-step commands to fix the current Pydantic v2 compatibility issues.

### Step 1: Update OrderType Class Implementation

```bash
# Navigate to backend directory
cd back-end

# Activate the virtual environment
.\.gigaland\Scripts\activate

# Open the item.py file for editing
code app/steam/models/item.py
```

Required changes in `item.py`:

1. Update `OrderType` implementation:
```python
# Replace the existing OrderType string class:
class OrderType(str):
    """Enum string for order types."""
    BUY = "buy"
    SELL = "sell"
    CANCEL = "cancel"

# With a proper Enum implementation:
from enum import Enum

class OrderType(str, Enum):
    """Enum for order types."""
    BUY = "buy"
    SELL = "sell"
    CANCEL = "cancel"
```

2. Update all `Config` classes:
```python
# Replace all instances of:
class Config:
    allow_population_by_field_name = True

# With:
model_config = {
    "populate_by_name": True,
}
```

### Step 2: Start the Server and Run Tests

```bash
# Navigate to backend directory
cd back-end

# Activate the virtual environment
.\.gigaland\Scripts\activate

# Start the FastAPI server in one terminal
uvicorn app.main:app --reload

# In a second terminal, run tests
cd back-end
.\.gigaland\Scripts\activate
python -m pytest tests/steam/test_live_items_routes.py -v
```

### Troubleshooting Model Issues

If you encounter additional model issues:

1. Check the server logs for specific error messages
2. Common errors include:
   - `schema_extra` usage in Config classes (replace with `json_schema_extra`)
   - `orm_mode` in Config classes (replace with `from_attributes`)
   - Missing `__root__` field (replace with appropriate root model)
3. Refer to Pydantic v2 migration guide at: https://docs.pydantic.dev/latest/migration/

When reporting model errors, use this format:

```
Model Error: [MODEL_NAME]
File: [FILE_PATH]
Line: [LINE_NUMBER]
Error: [ERROR_MESSAGE]
Fix: [PROPOSED_FIX]
```
