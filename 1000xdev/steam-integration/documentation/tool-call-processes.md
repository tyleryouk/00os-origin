# Tool Call Processes for Steam API Integration

This document defines standardized tool call sequences for implementing, testing, and validating the Steam API integration. These processes ensure consistency across development sessions and help maintain high-quality code.

## Backend Testing Processes

### Process: Run Backend Tests for Steam API Endpoints

```bash
# Navigate to the backend directory
cd back-end

# Run tests for specific Steam API module
pytest app/steam/tests/ -v
```

### Process: Test Specific Endpoint Implementation

```bash
# Navigate to the backend directory
cd back-end

# Run test for a specific endpoint
pytest app/steam/tests/test_items_endpoints.py::test_get_all_items_for_game -v
```

### Process: Run Backend Server for Manual Testing

```bash
# Navigate to the backend directory
cd back-end

# Start the development server
uvicorn app.main:app --reload --port 8000
```

## Frontend Testing Processes

### Process: Run Frontend Unit Tests for Steam Components

```bash
# Navigate to the frontend directory
cd frontend

# Run tests for Steam components
npm test -- --testPathPattern=src/components/steam
```

### Process: Start Frontend Development Server

```bash
# Navigate to the frontend directory
cd frontend

# Start the development server
npm run dev
```

## API Testing Processes

### Process: Test Steam API Client Directly

```python
# Sample code for testing Steam API client directly
from app.steam.client import SteamAPIClient

client = SteamAPIClient()
response = client.get_all_items(game_id=730)  # CS2/CS:GO game ID
print(response)
```

### Process: Test Backend API Endpoints with curl

```bash
# Test Get All Items endpoint
curl -X GET "http://localhost:8000/api/steam/items/all/730" -H "accept: application/json"

# Test Search Items endpoint
curl -X GET "http://localhost:8000/api/steam/items/search/730?query=asiimov" -H "accept: application/json"

# Test Get Item Details endpoint
curl -X GET "http://localhost:8000/api/steam/items/details/730/AWP%20%7C%20Asiimov%20%28Field-Tested%29" -H "accept: application/json"
```

## Debugging Processes

### Process: View Backend Logs

```bash
# Navigate to the backend directory
cd back-end

# View the most recent logs
tail -f logs/app.log
```

### Process: Debug API Rate Limiting

```bash
# Check rate limit status
curl -X GET "http://localhost:8000/api/steam/rate-limit-status" -H "accept: application/json"
```

## Implementation Processes

### Process: Create New Backend Endpoint

1. Define models in `back-end/app/steam/models/`
2. Implement client method in `back-end/app/steam/client.py`
3. Create route handler in `back-end/app/steam/routes/`
4. Register route in `back-end/app/steam/__init__.py`
5. Implement tests in `back-end/app/steam/tests/`

### Process: Create New Frontend Component

1. Define TypeScript interfaces in `frontend/src/types/steam.ts`
2. Implement API service in `frontend/src/services/steamApi.ts`
3. Create React component in `frontend/src/components/steam/`
4. Implement tests in `frontend/src/components/steam/__tests__/`

## Deployment and Integration Processes

### Process: Build Frontend for Production

```bash
# Navigate to the frontend directory
cd frontend

# Build the production bundle
npm run build
```

### Process: Build Backend for Production

```bash
# Navigate to the backend directory
cd back-end

# Run tests before building
pytest

# Package application (if using Docker)
docker build -t gigaswap-backend .
```

## Error Handling and Recovery Processes

### Process: Check API Client Error Logs

```bash
# Navigate to the backend directory
cd back-end

# View error logs specifically for the Steam module
grep ERROR logs/app.log | grep steam
```

### Process: Reset API Rate Limiter (Development Only)

```bash
# In development mode only
curl -X POST "http://localhost:8000/api/steam/debug/reset-rate-limits" -H "accept: application/json"
```

## Documentation Processes

### Process: Generate API Documentation

```bash
# Navigate to the backend directory
cd back-end

# Generate OpenAPI docs
python -m app.docs.generate_openapi
```

### Process: View API Documentation

Open browser at `http://localhost:8000/docs` when the backend server is running.

## End-to-End Testing Processes

### Process: Run Full Integration Tests

```bash
# Start backend server (in a separate terminal)
cd back-end
uvicorn app.main:app --reload --port 8000

# Start frontend dev server (in a separate terminal)
cd frontend
npm run dev

# Run Cypress E2E tests
cd frontend
npm run cypress:open
```

## Monitoring and Performance Processes

### Process: Monitor API Performance

```bash
# Navigate to the backend directory
cd back-end

# Check API performance metrics
curl -X GET "http://localhost:8000/api/steam/metrics" -H "accept: application/json"
```

## Security Testing Processes

### Process: Validate API Key Handling

```bash
# Test API key validation
curl -X POST "http://localhost:8000/api/steam/validate-api-key" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -d '{"api_key": "test_key"}'
```

## Cache Management Processes

### Process: Clear API Cache (Development Only)

```bash
# In development mode only
curl -X POST "http://localhost:8000/api/steam/debug/clear-cache" -H "accept: application/json"
```

## Implementation Guidelines

When implementing new features or fixing bugs, follow these guidelines:

1. **Always start with models**: Ensure data models are properly defined before implementing endpoints
2. **Test-driven development**: Write tests before implementing features
3. **Clean interfaces**: Create clear, consistent interfaces between frontend and backend
4. **Documentation first**: Document API endpoints before implementing them
5. **Error handling**: Implement comprehensive error handling for all API calls
6. **Rate limiting**: Be mindful of the rate limits imposed by the Steam Web API
7. **Caching**: Implement appropriate caching strategies to minimize API calls

## Troubleshooting Common Issues

### Steam API Connection Issues

If you encounter connection issues with the Steam Web API:

1. Check API key validity
2. Verify network connectivity
3. Ensure rate limits haven't been exceeded
4. Check for API service outages

### Rate Limiting Issues

If you hit rate limits:

1. Implement exponential backoff
2. Optimize cache usage
3. Batch requests where possible
4. Prioritize critical endpoints

### Data Inconsistency Issues

If you encounter data inconsistencies:

1. Validate response schemas
2. Check for partial responses
3. Implement retry logic for incomplete data
4. Add validation layers

## Conclusion

These standardized processes ensure consistent, high-quality implementation of the Steam API integration. Always refer to this document when implementing, testing, or debugging Steam API features.
