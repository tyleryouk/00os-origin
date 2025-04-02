# USE WHEN verifying Steam Web API implementation in back-end components

## Overview

This guide provides a comprehensive approach to verifying the Steam Web API integration in the GigaSwap back-end. It includes verification processes, test scenarios, and quality assurance procedures for ensuring a robust implementation.

## Verification Framework

The verification process follows a structured approach with these key phases:

1. **Component Verification**: Testing individual API endpoints and services
2. **Cross-System Verification**: Testing integration between front-end and back-end
3. **Performance Verification**: Testing under load and with real-world data volumes
4. **Security Verification**: Testing authentication, authorization, and data protection

## Authentication Verification

### OpenID Flow Verification

**Verification Steps**:
1. Initiate authentication flow with Steam OpenID
2. Verify redirect to Steam login page
3. Complete authentication with test account
4. Verify callback handling and token creation
5. Verify secure cookie setting

**Test Scenarios**:
```python
# Authentication Flow Test
def test_authentication_flow():
    # Initiate authentication
    response = client.get("/api/auth/steam/login")
    assert response.status_code == 302  # Redirect status
    
    # Extract Steam URL from redirect
    redirect_url = response.headers["location"]
    assert "steamcommunity.com/openid/login" in redirect_url
    
    # Mock successful callback
    callback_params = {
        'openid.mode': 'id_res',
        'openid.ns': 'http://specs.openid.net/auth/2.0',
        'openid.op_endpoint': 'https://steamcommunity.com/openid/login',
        'openid.claimed_id': 'https://steamcommunity.com/openid/id/76561198xxxxxxxxx',
        'openid.identity': 'https://steamcommunity.com/openid/id/76561198xxxxxxxxx',
        # Add other required OpenID parameters
    }
    
    # Mock Steam validation response
    with requests_mock.Mocker() as m:
        m.post('https://steamcommunity.com/openid/login', text='is_valid:true')
        
        # Mock Steam API user data
        m.get(
            'https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/',
            json={
                'response': {
                    'players': [{
                        'steamid': '76561198xxxxxxxxx',
                        'personaname': 'TestUser',
                        'avatar': 'https://example.com/avatar.jpg',
                        'avatarfull': 'https://example.com/avatar_full.jpg',
                        'profileurl': 'https://steamcommunity.com/profiles/76561198xxxxxxxxx'
                    }]
                }
            }
        )
        
        response = client.get("/api/auth/steam/callback", params=callback_params)
        
        # Verify redirect to frontend
        assert response.status_code == 302
        assert settings.FRONTEND_URL in response.headers["location"]
        
        # Verify cookie was set
        cookies = response.cookies
        assert "steam_session" in cookies
```

### Session Management Verification

**Verification Steps**:
1. Create an authenticated session
2. Verify token validation
3. Test session expiration
4. Verify token refresh
5. Test logout functionality

**Test Scenarios**:
```python
# Session Management Test
def test_session_management():
    # Create test token
    user_data = SteamUser(
        steam_id="76561198xxxxxxxxx",
        personaname="TestUser",
        avatar="https://example.com/avatar.jpg",
        avatarfull="https://example.com/avatar_full.jpg",
        profileurl="https://steamcommunity.com/profiles/76561198xxxxxxxxx"
    )
    
    auth_service = SteamAuthService()
    token = auth_service.create_session(user_data)
    
    # Test with valid token
    response = client.get(
        "/api/auth/steam/status",
        cookies={"steam_session": token}
    )
    assert response.status_code == 200
    data = response.json()
    assert data["authenticated"] is True
    assert data["user"]["steam_id"] == "76561198xxxxxxxxx"
    
    # Test logout
    response = client.post(
        "/api/auth/steam/logout",
        cookies={"steam_session": token}
    )
    assert response.status_code == 200
    assert response.cookies.get("steam_session") is None
```

## Inventory Verification

### Inventory Retrieval Verification

**Verification Steps**:
1. Authenticate with test account
2. Request inventory data
3. Verify correct item transformation
4. Test inventory caching
5. Verify refresh functionality

**Test Scenarios**:
```python
# Inventory Retrieval Test
def test_inventory_retrieval():
    # Create authenticated session
    auth_token = create_test_auth_token()
    
    # Mock Steam inventory API response
    with requests_mock.Mocker() as m:
        m.get(
            'https://api.steampowered.com/IEconItems_730/GetPlayerItems/v1/',
            json={
                'result': {
                    'status': 1,
                    'items': [
                        {
                            'id': '1234567890',
                            'defindex': 7,
                            'classid': '123456',
                            'instanceid': '654321',
                            'name': 'AK-47 | Redline (Field-Tested)',
                            'market_hash_name': 'AK-47 | Redline (Field-Tested)',
                            'tradable': 1,
                            'marketable': 1,
                            'attributes': [
                                {'defindex': 8, 'float_value': 0.25}
                            ]
                        }
                    ]
                }
            }
        )
        
        # Test inventory endpoint
        response = client.get(
            "/api/inventory/steam",
            cookies={"steam_session": auth_token}
        )
        assert response.status_code == 200
        items = response.json()
        
        # Verify item transformation
        assert len(items) == 1
        item = items[0]
        assert item["asset_id"] == "1234567890"
        assert item["name"] == "AK-47 | Redline (Field-Tested)"
        assert item["weapon"] == "AK-47"
        assert item["skin"] == "Redline"
        assert item["wear"] == 0.25
        assert item["tradable"] is True
        assert item["marketable"] is True
        
        # Test caching (second request should use cache)
        client.get(
            "/api/inventory/steam",
            cookies={"steam_session": auth_token}
        )
        
        # Only one request should be made to Steam API
        assert m.call_count == 1
        
        # Test force refresh
        client.get(
            "/api/inventory/steam?refresh=true",
            cookies={"steam_session": auth_token}
        )
        
        # A second request should be made to Steam API
        assert m.call_count == 2
```

### Inventory Caching Verification

**Verification Steps**:
1. Request inventory data for initial caching
2. Verify cached data is used for subsequent requests
3. Test cache invalidation with forced refresh
4. Verify cache expiration
5. Test cache performance under load

**Test Scenarios**:
```python
# Cache Performance Test
async def test_cache_performance():
    # Create test Redis client
    redis_client = fakeredis.FakeStrictRedis()
    
    # Mock inventory data
    inventory_data = [{"asset_id": "1234", "name": "Test Item"}]
    
    # Set cache
    await redis_client.set(
        "inventory:76561198xxxxxxxxx",
        json.dumps(inventory_data),
        ex=3600
    )
    
    # Measure performance (should be sub-millisecond)
    start_time = time.time()
    cached_data = await redis_client.get("inventory:76561198xxxxxxxxx")
    end_time = time.time()
    
    # Verify performance and data integrity
    assert json.loads(cached_data) == inventory_data
    assert (end_time - start_time) < 0.01  # Less than 10ms
```

## Market Data Verification

### Price Data Verification

**Verification Steps**:
1. Request market price for test item
2. Verify price data format and accuracy
3. Test price history retrieval
4. Verify data caching mechanism
5. Test data updates

**Test Scenarios**:
```python
# Market Price Test
def test_market_price_data():
    # Mock market API response
    with requests_mock.Mocker() as m:
        m.get(
            'https://steamcommunity.com/market/priceoverview/',
            json={
                'success': True,
                'lowest_price': '$10.50',
                'volume': '1,234',
                'median_price': '$11.25'
            }
        )
        
        # Test price endpoint
        response = client.get(
            "/api/market/steam/price/AK-47%20%7C%20Redline%20%28Field-Tested%29"
        )
        assert response.status_code == 200
        data = response.json()
        
        # Verify price data
        assert data["success"] is True
        assert data["lowest_price"] == "$10.50"
        assert data["volume"] == "1,234"
        assert data["median_price"] == "$11.25"
```

### Price History Verification

**Verification Steps**:
1. Request price history for test item
2. Verify history data format and completeness
3. Test different time ranges
4. Verify data is properly normalized
5. Test performance with large datasets

**Test Scenarios**:
```python
# Price History Test
def test_price_history():
    # Mock history API response
    with requests_mock.Mocker() as m:
        m.get(
            'https://steamcommunity.com/market/pricehistory/',
            json={
                'success': True,
                'price_prefix': '$',
                'prices': [
                    [1609459200000, 10.25, 123],  # [timestamp, price, volume]
                    [1609545600000, 10.50, 145],
                    [1609632000000, 10.75, 156]
                ]
            }
        )
        
        # Test history endpoint
        response = client.get(
            "/api/market/steam/history/AK-47%20%7C%20Redline%20%28Field-Tested%29?days=7"
        )
        assert response.status_code == 200
        data = response.json()
        
        # Verify history data
        assert data["success"] is True
        assert len(data["prices"]) == 3
        
        # Verify data format
        first_point = data["prices"][0]
        assert len(first_point) == 3
        assert isinstance(first_point[0], int)  # timestamp
        assert isinstance(first_point[1], float)  # price
        assert isinstance(first_point[2], int)  # volume
```

## Trading Verification

### Trade Creation Verification

**Verification Steps**:
1. Authenticate with test account
2. Create test trade offer
3. Verify offer creation and structure
4. Test trade validation
5. Verify trade status tracking

**Test Scenarios**:
```python
# Trade Creation Test
def test_trade_creation():
    # Create authenticated session
    auth_token = create_test_auth_token()
    
    # Mock Steam trading API response
    with requests_mock.Mocker() as m:
        m.post(
            'https://api.steampowered.com/IEconService/CreateTradeOffer/v1/',
            json={
                'response': {
                    'tradeofferid': '12345',
                    'needs_confirmation': False
                }
            }
        )
        
        # Test trade creation endpoint
        trade_data = {
            'partner_steam_id': '76561198yyyyyyyy',
            'items_to_give': ['1234567890'],
            'items_to_receive': ['9876543210']
        }
        
        response = client.post(
            "/api/trading/steam/create",
            json=trade_data,
            cookies={"steam_session": auth_token}
        )
        assert response.status_code == 200
        data = response.json()
        
        # Verify trade data
        assert data["trade_offer_id"] == "12345"
        assert data["needs_confirmation"] is False
        assert data["status"] == "Created"
```

### Trade Status Verification

**Verification Steps**:
1. Create test trade offer
2. Request trade status updates
3. Verify status changes are tracked correctly
4. Test different trade states
5. Verify completion handling

**Test Scenarios**:
```python
# Trade Status Test
def test_trade_status():
    # Create authenticated session
    auth_token = create_test_auth_token()
    
    # Mock Steam trading API response
    with requests_mock.Mocker() as m:
        m.get(
            'https://api.steampowered.com/IEconService/GetTradeOffer/v1/',
            json={
                'response': {
                    'offer': {
                        'tradeofferid': '12345',
                        'accountid_other': 98765,
                        'trade_offer_state': 2,  # Active state
                        'items_to_give': [{'assetid': '1234567890'}],
                        'items_to_receive': [{'assetid': '9876543210'}],
                        'time_created': 1609459200,
                        'time_updated': 1609459200,
                        'escrow_end_date': 0
                    }
                }
            }
        )
        
        # Test trade status endpoint
        response = client.get(
            "/api/trading/steam/status/12345",
            cookies={"steam_session": auth_token}
        )
        assert response.status_code == 200
        data = response.json()
        
        # Verify trade status
        assert data["trade_offer_id"] == "12345"
        assert data["status"] == "Active"
        assert data["items_to_give"][0]["asset_id"] == "1234567890"
        assert data["items_to_receive"][0]["asset_id"] == "9876543210"
        assert data["escrow_duration"] == 0
```

## Security Verification

### API Key Protection Verification

**Verification Steps**:
1. Verify API key is not exposed in client responses
2. Test API key rotation process
3. Verify key storage security
4. Test API key usage logging
5. Verify key access controls

**Test Scenarios**:
```python
# API Key Protection Test
def test_api_key_protection():
    # Create test environment with API key
    test_key = "TEST_API_KEY_12345"
    os.environ["STEAM_API_KEY"] = test_key
    
    # Initialize service with key
    service = SteamAuthService()
    
    # Generate login URL
    login_url = service.get_steam_login_url()
    
    # Verify API key is not in URL
    assert test_key not in login_url
    
    # Verify logs don't contain API key
    with open("app.log", "r") as f:
        log_content = f.read()
        assert test_key not in log_content
```

### Token Security Verification

**Verification Steps**:
1. Verify token storage in HTTP-only cookies
2. Test token expiration and renewal
3. Verify token validation logic
4. Test against token tampering
5. Verify token revocation

**Test Scenarios**:
```python
# Token Security Test
def test_token_security():
    # Create test user
    user = SteamUser(
        steam_id="76561198xxxxxxxxx",
        personaname="TestUser",
        avatar="https://example.com/avatar.jpg",
        avatarfull="https://example.com/avatar_full.jpg",
        profileurl="https://steamcommunity.com/profiles/76561198xxxxxxxxx"
    )
    
    # Create token with service
    auth_service = SteamAuthService()
    token = auth_service.create_session(user)
    
    # Verify token validation
    request = Request(scope={"type": "http"})
    request._cookies = {"steam_session": token}
    validated_user = auth_service.get_current_user(request)
    assert validated_user is not None
    assert validated_user.steam_id == user.steam_id
    
    # Test tampered token
    tampered_token = token[:-5] + "XXXXX"
    request._cookies = {"steam_session": tampered_token}
    validated_user = auth_service.get_current_user(request)
    assert validated_user is None
    
    # Test expired token
    with patch("time.time") as mock_time:
        # Set time to future (after token expiration)
        mock_time.return_value = time.time() + settings.SESSION_LIFETIME + 3600
        request._cookies = {"steam_session": token}
        validated_user = auth_service.get_current_user(request)
        assert validated_user is None
```

## Performance Verification

### Rate Limiting Verification

**Verification Steps**:
1. Test API rate limiting configuration
2. Verify correct retry behavior
3. Test exponential backoff implementation
4. Verify error handling during rate limiting
5. Test performance under load

**Test Scenarios**:
```python
# Rate Limiting Test
def test_rate_limiting():
    # Mock rate limited response from Steam
    with requests_mock.Mocker() as m:
        # First call returns rate limited response
        m.get(
            'https://api.steampowered.com/IEconItems_730/GetPlayerItems/v1/',
            status_code=429
        )
        
        # Second call succeeds
        m.get(
            'https://api.steampowered.com/IEconItems_730/GetPlayerItems/v1/',
            json={'result': {'status': 1, 'items': []}}
        )
        
        # Create service with retry capability
        service = SteamInventoryService()
        
        # Start timer
        start_time = time.time()
        
        # Call method that should retry
        result = await service.get_user_inventory_with_retry("76561198xxxxxxxxx")
        
        # End timer
        end_time = time.time()
        
        # Verify retry occurred (with backoff)
        assert m.call_count == 2
        assert result == []
        
        # Verify backoff delay (should be at least 1 second)
        assert (end_time - start_time) >= 1.0
```

### Caching Performance Verification

**Verification Steps**:
1. Test cache hit performance
2. Verify cache miss performance
3. Test cache under high load
4. Verify memory usage with large datasets
5. Test cache expiration performance

**Test Scenarios**:
```python
# Cache Performance Benchmark
async def benchmark_cache_performance():
    # Generate test inventory (100 items)
    test_inventory = [
        {
            "asset_id": f"item_{i}",
            "name": f"Test Item {i}",
            "marketable": i % 2 == 0,
            "tradable": True
        }
        for i in range(100)
    ]
    
    # Initialize Redis cache
    redis_cache = RedisCacheService()
    
    # Set up cache
    cache_key = "inventory:76561198xxxxxxxxx"
    await redis_cache.set(cache_key, test_inventory, expiry=3600)
    
    # Benchmark cache retrieval (100 repetitions)
    start_time = time.time()
    for _ in range(100):
        cached_data = await redis_cache.get(cache_key)
        assert len(cached_data) == 100
    end_time = time.time()
    
    # Calculate average retrieval time
    avg_time_ms = ((end_time - start_time) / 100) * 1000
    
    # Verify performance (should be under 1ms per retrieval)
    assert avg_time_ms < 1.0
```

## Cross-System Verification

### Front-End Integration Verification

**Verification Steps**:
1. Set up test environment with front-end and back-end
2. Test complete authentication flow
3. Verify inventory data correctly renders in front-end
4. Test market data integration
5. Verify trading flow works end-to-end

**Test Scenarios**:
```python
# Full Integration Test
def test_frontend_integration():
    # Mock API responses
    with requests_mock.Mocker() as m:
        # Set up auth mock
        m.get('/api/auth/steam/status', json={"authenticated": True, "user": test_user_data})
        
        # Set up inventory mock
        m.get('/api/inventory/steam', json=test_inventory_data)
        
        # Set up market mock
        m.get('/api/market/steam/price/AK-47%20%7C%20Redline%20%28Field-Tested%29', 
              json=test_market_data)
        
        # Set up trading mock
        m.post('/api/trading/steam/create', json=test_trade_data)
        
        # Run front-end integration tests using Playwright
        browser = playwright.chromium.launch()
        page = browser.new_page()
        
        # Test authentication display
        page.goto("http://localhost:3000/profile")
        assert page.query_selector("text=TestUser") is not None
        
        # Test inventory display
        page.goto("http://localhost:3000/inventory")
        assert page.query_selector("text=AK-47 | Redline") is not None
        
        # Test market data display
        page.goto("http://localhost:3000/market")
        assert page.query_selector("text=$10.50") is not None
        
        # Test trading flow
        page.goto("http://localhost:3000/trade")
        page.click("text=Create Trade")
        assert page.query_selector("text=Trade Created") is not None
        
        browser.close()
```

## Verification Summary

### Verification Matrix

| Component | Verification Approach | Test Coverage |
|-----------|------------------------|--------------|
| Authentication | Unit tests, integration tests, security analysis | Login flow, session management, token security |
| Inventory | Unit tests, integration tests, performance testing | Item retrieval, transformation, caching |
| Market Data | Unit tests, integration tests, data validation | Price accuracy, history retrieval, data formatting |
| Trading | Unit tests, integration tests, security testing | Trade creation, status tracking, validation |
| Security | Security analysis, penetration testing | API key protection, token security, input validation |
| Performance | Benchmarking, load testing | Rate limiting, caching, response times |
| Cross-System | End-to-end testing | Front-end integration, user flows |

### Verification Checklist

- [ ] Authentication flow works correctly
- [ ] Session management is secure and reliable
- [ ] Inventory retrieval and transformation is accurate
- [ ] Caching mechanisms are effective
- [ ] Market data retrieval is accurate and performant
- [ ] Trading functionality works correctly
- [ ] Security measures are properly implemented
- [ ] Performance meets requirements under load
- [ ] Front-end integration is verified
- [ ] End-to-end user flows work as expected

## Related Knowledge Components

- **Authentication**: `knowledge/back-end/steam-web-api/authentication.md`
- **Data Caching**: `knowledge/back-end/steam-web-api/data-caching.md`
- **Market Data**: `knowledge/back-end/steam-web-api/market-data.md`
- **Security**: `knowledge/back-end/steam-web-api/security.md`
- **Best Practices**: `knowledge/rules/back-end-steam-web-api/best-practices.md`