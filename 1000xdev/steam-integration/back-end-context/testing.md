# Backend Testing Strategy for Steam Integration

This document outlines the testing strategy for the `back-end/app/steam/` module, which handles integration with the Steam Web API.

## Testing Framework

- **Framework:** `pytest` will be used, consistent with existing backend tests.
- **Test Client:** FastAPI's `TestClient` will be used for testing any potential API routes exposed by the `steam` module (if applicable later).
- **Location:** All tests for the `steam` module will reside within `back-end/tests/steam/`.

## Testing Components

### 1. `SteamWebAPIClient` (`back-end/app/steam/client.py`)

- **Goal:** Verify the client's request logic, error handling, and retry mechanisms.
- **Approach:** Unit tests using mocking.
- **Mocking:**
    - Mock the `requests.Session.request` method (or the underlying HTTP library if switched to async like `httpx`) using `unittest.mock.patch` or `pytest-mock`.
    - Simulate various API responses:
        - Successful responses (200 OK) with expected JSON payloads.
        - Error responses (401, 403, 404, 429, 500, 503) to test custom exception mapping (`raise_for_status_code`).
        - Responses with rate limit headers (simulated) to test rate limit parsing (once implemented).
        - Malformed JSON responses or non-JSON responses.
        - Network errors (e.g., `requests.exceptions.Timeout`, `requests.exceptions.ConnectionError`).
- **Fixtures:** A `pytest` fixture can provide a configured `SteamWebAPIClient` instance.
- **Assertions:**
    - Assert that the correct custom exceptions (`SteamAPIAuthenticationException`, `SteamAPIRateLimitException`, etc.) are raised for specific error status codes.
    - Assert that the correct URL, method, parameters, and headers are used in the underlying request call.
    - Assert that retry logic (sleep, number of attempts) is triggered correctly for retryable errors (5xx, 429, network errors).
    - Assert that successful responses are parsed correctly (returning the JSON dict).

### 2. Exception Classes (`back-end/app/steam/exceptions.py`)

- **Goal:** Ensure custom exceptions behave as expected.
- **Approach:** Simple unit tests.
- **Assertions:**
    - Verify that exceptions can be raised and caught correctly.
    - Check the string representation (`__str__`) includes the status code and original exception details when provided.
    - Verify specific attributes like `retry_after` in `SteamAPIRateLimitException`.

### 3. Pydantic Models (`back-end/app/steam/models/item.py`, etc.)

- **Goal:** Verify data validation and parsing.
- **Approach:** Unit tests.
- **Fixtures:** Use dictionaries representing valid and invalid API response data based on research from `steam-web-api-research/`.
- **Assertions:**
    - Test successful parsing of valid data using `Model.parse_obj()`.
    - Test that `ValidationError` is raised for invalid data (missing required fields, incorrect types).
    - Verify field aliases (like `wear_value` aliased to `wear`) work correctly.
    - Check default values and optional fields.

### 4. Service Clients (`back-end/app/steam/services/items.py`, etc.)

- **Goal:** Verify the business logic, interaction with the base client, caching, and model handling.
- **Approach:** Unit tests using mocking.
- **Mocking:**
    - Mock the `SteamWebAPIClient` instance passed to the service client.
    - Mock the caching mechanism (`MockCache` initially, then the real cache implementation).
    - Set return values for mocked client's `_request` method to simulate API responses.
    - Set return values for mocked cache's `get` and `set` methods.
- **Fixtures:**
    - Fixture for a mocked `SteamWebAPIClient`.
    - Fixture for a mocked cache instance.
    - Fixture for an instance of the service client (e.g., `ItemsClient`) initialized with mocked dependencies.
- **Assertions:**
    - Verify that the service method calls the correct `_request` method on the base client with expected arguments.
    - Verify that the cache is checked (`cache.get`) before making an API call.
    - Verify that successful API responses are parsed into the correct Pydantic models.
    - Verify that the parsed data (as a dictionary) is stored in the cache (`cache.set`) with the correct key and TTL.
    - Verify that cached data is returned correctly when available.
    - Verify correct handling of API errors (e.g., returning `None` or empty list as appropriate).
    - Verify correct handling of cache parsing errors.

## Integration Testing

- **Goal:** Test the interaction between components (e.g., service client using the base client).
- **Approach:** Limited integration tests, potentially using a mocked HTTP server (`pytest-httpserver` or similar) to simulate the Steam Web API.
- **Strategy:**
    - Create tests that instantiate a real `SteamWebAPIClient` and a real service client.
    - Use the mock HTTP server to define expected requests and provide predefined responses (based on research).
    - Test the end-to-end flow within the service method, ensuring the mock server receives the correct request and the service correctly processes the predefined response.
    - **Avoid hitting the actual Steam Web API** in automated tests to prevent rate limiting issues, API key exposure, and test flakiness.

## Running Tests

- Tests will be run using the `pytest` command from the `back-end/` directory.
- Ensure all necessary environment variables (like `STEAM_WEB_API_KEY` for potential client instantiation, even if mocked later) are accessible to the test environment, potentially using a `.env.test` file loaded by `pytest-dotenv`.

## Testing Workflow

This section describes the general process for writing and executing tests for the `back-end/app/steam/` module.

1.  **Identify Target Component:** Determine the specific class or function within `back-end/app/steam/` (e.g., `SteamWebAPIClient._request`, `ItemsClient.get_item_info`, `SteamItem` model) that requires testing.

2.  **Locate/Create Test File:**
    *   Navigate to the corresponding directory within `back-end/tests/steam/`. Create subdirectories mirroring `back-end/app/steam/` if they don't exist (e.g., `back-end/tests/steam/services/`, `back-end/tests/steam/models/`).
    *   Create a new test file named `test_<module_name>.py` (e.g., `test_client.py`, `test_items_service.py`, `test_item_model.py`) or add tests to an existing relevant file.

3.  **Import Necessary Modules:** Import `pytest`, the component to be tested, mocking libraries (`unittest.mock`, `pytest-mock`), necessary fixtures, and any dependent types (e.g., Pydantic models, custom exceptions).

4.  **Define Test Functions:** Create test functions named `test_<scenario_description>()`. Each function should test a specific behavior or scenario.

5.  **Set Up Mocks & Fixtures (if needed):**
    *   For unit tests requiring isolation, use `pytest` fixtures (defined in the test file or a central `conftest.py`) to provide instances of dependencies (like a mocked `SteamWebAPIClient` or cache).
    *   Use `@pytest.mark.parametrize` to run the same test function with different inputs and expected outputs.
    *   Use `mocker` (from `pytest-mock`) or `unittest.mock.patch` to mock methods or objects within the test function's scope (e.g., `mocker.patch.object(mock_client.session, 'request', return_value=mock_response)`).
    *   Define mock return values or side effects to simulate different API responses or dependency behaviors.

6.  **Instantiate/Call Component:** Create an instance of the class or call the function being tested, providing mocked dependencies if necessary.

7.  **Perform Assertions:**
    *   Use `assert` statements to verify the actual results against expected outcomes.
    *   Check return values, raised exceptions (`pytest.raises`), attribute values, or calls made to mocked objects (`mock_object.assert_called_once_with(...)`).

8.  **Run Tests Locally:**
    *   Execute `pytest` from the `back-end/` directory.
    *   Run specific files: `pytest tests/steam/test_client.py`
    *   Run specific tests: `pytest tests/steam/test_client.py -k test_request_success`
    *   Use flags like `-v` (verbose) or `-s` (show print statements) for more detailed output.

9.  **Debug Failures:** Analyze `pytest` output and stack traces to understand and fix failing tests. Use print statements or a debugger if necessary.

10. **Refactor and Commit:** Refactor tests for clarity and efficiency. Commit the new/updated tests along with the corresponding source code changes.
