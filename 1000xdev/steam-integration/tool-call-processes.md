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

## Backend Testing

This sequence runs the backend pytest tests for the Steam integration module **one file at a time**. 
Ensure the virtual environment is activated first (see setup sequence above).

**Note:** `test_auth.py` is currently skipped as it depends on unimplemented Phase 2 features.

1.  **Test Base Client (`test_base_client.py`):**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run pytest for test_base_client.py.", command="cd back-end; .\\.gigaland\\Scripts\\activate; python -m pytest tests/steam/test_base_client.py -v", is_background=False))
    ```

2.  **Test Items Service (`test_items_service.py`):**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run pytest for test_items_service.py.", command="cd back-end; .\\.gigaland\\Scripts\\activate; python -m pytest tests/steam/test_items_service.py -v", is_background=False))
    ```

3.  **Test Inventory Service (`test_inventory_service.py`):**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run pytest for test_inventory_service.py.", command="cd back-end; .\\.gigaland\\Scripts\\activate; python -m pytest tests/steam/test_inventory_service.py -v", is_background=False))
    ```

4.  **Test Trade Service (`test_trade_service.py`):**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run pytest for test_trade_service.py.", command="cd back-end; .\\.gigaland\\Scripts\\activate; python -m pytest tests/steam/test_trade_service.py -v", is_background=False))
    ```

5.  **Test Items Routes (`test_items_routes.py`):**
    ```tool_code
    print(default_api.run_terminal_cmd(explanation="Run pytest for test_items_routes.py.", command="cd back-end; .\\.gigaland\\Scripts\\activate; python -m pytest tests/steam/test_items_routes.py -v", is_background=False))
    ```

## Reference Commands

### Full Dependency Installation (if needed)

Use this command if dependencies need to be reinstalled from scratch.

```tool_code
print(default_api.run_terminal_cmd(explanation="Navigate to backend, activate venv, and install dependencies using PowerShell chaining.", command="cd back-end; .\\.gigaland\\Scripts\\activate; pip install -r requirements.txt", is_background=False))
```
