# Standardized Tool Call Processes

This file documents standardized sequences of tool calls for common development and testing tasks related to the Steam API integration.

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
