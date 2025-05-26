# Back-End Endpoint Test Coverage Checklist (Revised)

## Cycle Focus: Steam Profile Endpoints Only
This cycle has been revised to focus specifically on implementing httpx/pytest-asyncio-based tests for the Steam profile endpoints against a running server and creating comprehensive testing documentation. All other endpoints are out of scope for this cycle and will be addressed in future cycles.

## Test Data
**Steam ID for Testing:** `76561199487496862` (Bot account with inventory data)
- Use this Steam ID for all Steam profile endpoint tests to ensure consistent test data
- This account has been confirmed to have accessible profile and inventory data

## Test Environment
- **Server:** Live backend server running at http://127.0.0.1:8000
- **Testing Framework:** pytest with pytest-asyncio
- **HTTP Client:** httpx for async HTTP requests
- **Response Logging:** All API responses will be logged to back-end/logs directory

### Root & Logs (Out of Scope - To Be Reimplemented Later)
- [ ] `GET /` — Root welcome endpoint *(TO BE REIMPLEMENTED WITH HTTPX)*
- [ ] `POST /logs-main` — Log entry endpoint *(TO BE REIMPLEMENTED WITH HTTPX)*

### Auth (Out of Scope for this Cycle)
- [ ] `POST /auth/request` — Request wallet authentication *(OUT OF SCOPE)*
- [ ] `POST /auth/verify` — Verify wallet signature *(OUT OF SCOPE)*

### Users (Out of Scope for this Cycle)
- [ ] `POST /users/create-user/` — Create user *(OUT OF SCOPE)*
- [ ] `GET /users/wallet/{polygon_wallet_address}` — Get user by wallet *(OUT OF SCOPE)*
- [ ] `PUT /users/wallet/{polygon_wallet_address}` — Update user *(OUT OF SCOPE)*
- [ ] `DELETE /users/wallet/{polygon_wallet_address}` — Delete user *(OUT OF SCOPE)*
- [ ] `GET /users/all_users/` — List all users *(OUT OF SCOPE)*
- [ ] `GET /users/profile` — Get current user profile *(OUT OF SCOPE)*
- [ ] `GET /users/{wallet_address}/analytics` — Wallet analytics *(OUT OF SCOPE)*
- [ ] `GET /profile/completion` — Profile completion status *(OUT OF SCOPE)*
- [ ] `PUT /profile` — Update profile *(OUT OF SCOPE)*

### Orders (Out of Scope for this Cycle)
- [ ] `POST /orders/create-order/` — Create order *(OUT OF SCOPE)*
- [ ] `GET /orders/user/{wallet_address}` — Get user orders *(OUT OF SCOPE)*
- [ ] `GET /orders/{order_id}` — Get order details *(OUT OF SCOPE)*
- [ ] `PATCH /orders/{order_id}/status` — Update order status *(OUT OF SCOPE)*
- [ ] `POST /orders/{order_id}/cancel` — Cancel order *(OUT OF SCOPE)*
- [ ] `GET /orders/summary/` — Get order summary *(OUT OF SCOPE)*

### Steam: Profile (CURRENT CYCLE FOCUS)
- [ ] `GET /api/steam/profile/{steam_id}` — Get Steam profile
  - **Test Cases:**
    - Should return 200 and valid profile data for `76561199487496862`
    - Should return 404 for non-existent Steam ID
    - Should return appropriate error for invalid Steam ID format
    - Should include all expected profile fields in response
    - Should handle authentication requirements appropriately
    - Should log response to back-end/logs directory
  
- [ ] `GET /api/steam/profile/inventory/{steam_id}` — Get inventory
  - **Test Cases:**
    - Should return 200 and valid inventory data for `76561199487496862`
    - Should return 404 for non-existent Steam ID
    - Should return appropriate error for invalid Steam ID format
    - Should handle empty inventories gracefully
    - Should include pagination if implemented
    - Should handle authentication requirements appropriately
    - Should log response to back-end/logs directory
  
- [ ] `GET /api/steam/profile/inventory/{steam_id}/items` — Get inventory items
  - **Test Cases:**
    - Should return 200 and valid items list for `76561199487496862`
    - Should return 404 for non-existent Steam ID
    - Should return appropriate error for invalid Steam ID format
    - Should handle filtering parameters correctly (if implemented)
    - Should handle empty item lists gracefully
    - Should handle authentication requirements appropriately
    - Should log response to back-end/logs directory
  
- [ ] `GET /api/steam/profile/eligibility/{steam_id}` — Trade eligibility
  - **Test Cases:**
    - Should return 200 and valid eligibility status for `76561199487496862`
    - Should return 404 for non-existent Steam ID
    - Should return appropriate error for invalid Steam ID format
    - Should include all eligibility criteria in response
    - Should handle authentication requirements appropriately
    - Should log response to back-end/logs directory
  
- [ ] `GET /api/steam/profile/privacy/{steam_id}` — Inventory privacy
  - **Test Cases:**
    - Should return 200 and valid privacy settings for `76561199487496862`
    - Should return 404 for non-existent Steam ID
    - Should return appropriate error for invalid Steam ID format
    - Should include all privacy fields in response
    - Should handle authentication requirements appropriately
    - Should log response to back-end/logs directory
  
- [ ] `GET /api/steam/profile/friendlist/{steam_id}` — Friend list
  - **Test Cases:**
    - Should return 200 and valid friend list for `76561199487496862`
    - Should return 404 for non-existent Steam ID
    - Should return appropriate error for invalid Steam ID format
    - Should handle empty friend lists gracefully
    - Should include pagination if implemented
    - Should handle authentication requirements appropriately
    - Should log response to back-end/logs directory
  
- [ ] `POST /api/steam/profile/inventory/batch` — Batch inventories
  - **Test Cases:**
    - Should return 200 and batch inventory data including `76561199487496862`
    - Should handle empty request array gracefully
    - Should process partial successes correctly (some valid, some invalid IDs)
    - Should return appropriate error for invalid request format
    - Should handle authentication requirements appropriately
    - Should correctly validate the request payload
    - Should log response to back-end/logs directory

### Steam: Items (Out of Scope for this Cycle)
- [ ] `GET /api/steam/items/details/{item_id}` — Item details *(OUT OF SCOPE)*
- [ ] `GET /api/steam/items/search` — Search items *(OUT OF SCOPE)*
- [ ] `GET /api/steam/items/listings/{item_name}` — Item listings *(OUT OF SCOPE)*
- [ ] `GET /api/steam/items/price-history/{item_name}` — Price history *(OUT OF SCOPE)*
- [ ] `GET /api/steam/items/categories` — Item categories *(OUT OF SCOPE)*
- [ ] `GET /api/steam/items/order-activity/{item_nameid}` — Order activity *(OUT OF SCOPE)*
- [ ] `POST /api/steam/items/order-activity` — Order activity (POST) *(OUT OF SCOPE)*
- [ ] `GET /api/steam/items/float` — Item float info *(OUT OF SCOPE)*

### Steam: Trade (Out of Scope for this Cycle)
- [ ] `POST /api/steam/trade/create` — Create trade offer *(OUT OF SCOPE)*
- [ ] `PUT /api/steam/trade/accept` — Accept trade offer *(OUT OF SCOPE)*
- [ ] `POST /api/steam/trade/history` — Trade history *(OUT OF SCOPE)*
- [ ] `POST /api/steam/trade/offers` — Get trade offers *(OUT OF SCOPE)*
- [ ] `POST /api/steam/trade/cancel` — Cancel trade offer *(OUT OF SCOPE)*
- [ ] `POST /api/steam/trade/decline` — Decline trade offer *(OUT OF SCOPE)*
- [ ] `GET /api/steam/trade/status/{tradeofferid}` — Trade offer status *(OUT OF SCOPE)*

### Steam: Account (Out of Scope for this Cycle)
- [ ] `GET /api/steam/account/me` — Account info *(OUT OF SCOPE)*
- [ ] `POST /api/steam/account/steamloginsecure` — Set steamLoginSecure *(OUT OF SCOPE)*
- [ ] `POST /api/steam/account/logout` — Logout *(OUT OF SCOPE)*
- [ ] `GET /api/steam/account/quota` — API quota *(OUT OF SCOPE)*

### Steam: Info (Out of Scope for this Cycle)
- [ ] `GET /api/steam/info/steamid` — Convert SteamID *(OUT OF SCOPE)*
- [ ] `GET /api/steam/info/items` — Game items *(OUT OF SCOPE)*
- [ ] `GET /api/steam/info/markets` — Market info *(OUT OF SCOPE)*
- [ ] `GET /api/steam/info/cs/containers` — CS containers *(OUT OF SCOPE)*
- [ ] `GET /api/steam/info/cs/collection/{slug}` — CS collection *(OUT OF SCOPE)*
- [ ] `GET /api/steam/info/complete/items` — Autocomplete items *(OUT OF SCOPE)*
- [ ] `GET /api/steam/info/currency/list` — List currencies *(OUT OF SCOPE)*
- [ ] `GET /api/steam/info/currency/exchange` — Exchange rates *(OUT OF SCOPE)*

### Steam: Explore (Out of Scope for this Cycle)
- [ ] `GET /api/steam/explore/random` — Random profiles *(OUT OF SCOPE)*
- [ ] `GET /api/steam/explore/toplist` — Top profiles *(OUT OF SCOPE)*
- [ ] `GET /api/steam/explore/last` — Latest profiles *(OUT OF SCOPE)*
- [ ] `GET /api/steam/explore/profile` — Search profiles *(OUT OF SCOPE)*

## Live Server Test Implementation Approach

For each Steam profile endpoint, we will implement the following:

1. **Test File Structure:**
   - Create a dedicated test file `test_steam_profile.py` using httpx and pytest-asyncio
   - Group tests by endpoint with clear descriptive names
   - Include both positive and negative test cases
   - Log all responses to the back-end/logs directory

2. **Test Case Implementation:**
   - Make real HTTP requests to the running server (http://127.0.0.1:8000)
   - Test both successful responses and error handling against real Steam API
   - Validate response status codes, payload structure, and content types
   - Ensure proper error messages for invalid requests

3. **httpx Usage:**
   - Use httpx.AsyncClient for all tests
   - Create standardized authentication helpers if needed
   - Set up any required test dependencies
   - Use pytest-asyncio to manage async test functions

4. **Documentation Example:**
   - Each test should serve as a clear example for documentation
   - Include comments explaining testing strategy
   - Demonstrate best practices for httpx and pytest-asyncio usage

## Test Validity Approach
- **Status Code:** Each endpoint must return the correct HTTP status for valid/invalid input
- **Response Format:** Response must match OpenAPI schema or documented model
- **Data Validity:** Data must be correct, complete, and type-safe
- **Error Handling:** Invalid input must return clear, actionable error messages
- **Auth:** Endpoints requiring authentication must reject unauthorized requests
- **Edge Cases:** Test with missing, malformed, and boundary values
- **Logging:** All responses must be properly logged to back-end/logs for analysis
