# workflow: rules-workflow | pathway: back-end-steam-web-api | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/dev-mode/back-end-steam-web-api.md

## Parameter Purpose

This parameter provides specialized guidance for enhancing and maintaining the Steam Web API integration in back-end components while in Developer Mode. It focuses on best practices, implementation patterns, and quality standards for creating secure, efficient, and well-structured back-end systems for the GigaSwap marketplace.

## Usage Context

Use this parameter when implementing or modifying rules related to back-end Steam Web API integration, including:

- Authentication endpoint implementation
- Inventory data processing
- Market data aggregation
- Trading API endpoints
- Caching strategies
- Security implementations
- Error handling patterns

## Implementation Guidelines

### Rule Enhancement Implementation

1. Begin by analyzing current back-end implementations and identifying enhancement opportunities:

```typescript
// Analyze current implementation
read_file("back-end/app/routers/steam_auth.py", should_read_entire_file=true)

// Check existing patterns
grep_search("Steam.*Authentication", false, "back-end/app/**/*.py")

// Identify improvement opportunities
codebase_search("Steam API proxy patterns", ["back-end/app"])
```

2. Create or enhance rules documentation following established patterns:

```typescript
// Create or update authentication patterns
edit_file("1000xbrain/knowledge/rules/back-end-steam-web-api/authentication-patterns.md",
          "Enhance authentication patterns documentation",
          "# USE WHEN implementing authentication patterns for Steam API in back-end components\n\n## Overview\n\nThis file documents best practices and patterns for implementing Steam OpenID authentication in back-end components...\n\n// ... implementation details ...")

// Create or update API proxy patterns
edit_file("1000xbrain/knowledge/rules/back-end-steam-web-api/api-proxy-patterns.md",
          "Create API proxy patterns documentation",
          "# USE WHEN implementing API proxy patterns for Steam Web API\n\n## Overview\n\nThis file documents best practices and patterns for creating secure proxy endpoints for the Steam Web API...\n\n// ... implementation details ...")
```

3. Implement cross-references between knowledge components:

```typescript
// Add cross-references between components
edit_file("1000xbrain/knowledge/rules/back-end-steam-web-api/best-practices.md",
          "Update cross-references in best practices",
          "// ... existing content ...\n\n## Cross-References\n\n- **Authentication Patterns**: `knowledge/rules/back-end-steam-web-api/authentication-patterns.md`\n- **API Proxy Patterns**: `knowledge/rules/back-end-steam-web-api/api-proxy-patterns.md`\n- **Caching Patterns**: `knowledge/rules/back-end-steam-web-api/caching-patterns.md`\n\n// ... existing content ...")
```

### Quality Standards Implementation

Ensure all rule documentation adheres to these quality standards:

1. **Documentation Standards**:
   - Clear, concise language
   - Proper markdown formatting
   - Consistent terminology
   - Comprehensive code examples

2. **Content Requirements**:
   - Problem statement and solution
   - Implementation guidelines
   - Error handling considerations
   - Security best practices
   - Performance optimization tips

3. **Code Examples**:
   - Python with proper type hints
   - FastAPI best practices
   - Error handling patterns
   - Consistent logging
   - Performance optimization

### Backend-Specific Pattern Development

When developing new patterns for back-end Steam Web API integration:

1. **API Proxy Pattern Development**:
   - Design secure proxy endpoints
   - Implement API key protection
   - Add rate limiting and caching
   - Create standardized error responses

```typescript
// Research existing patterns
codebase_search("API proxy pattern", ["back-end/app", "1000xbrain/knowledge"])

// Examine related files
read_file("1000xbrain/knowledge/back-end/steam-web-api/authentication.md", should_read_entire_file=true)

// Create new pattern documentation
edit_file("1000xbrain/knowledge/rules/back-end-steam-web-api/rate-limiting-patterns.md",
          "Create rate limiting patterns documentation",
          "# USE WHEN implementing rate limiting for Steam Web API\n\n## Overview\n\nThis pattern provides guidance for implementing rate limiting for Steam Web API calls to stay within API usage limits and protect against abuse...\n\n// ... implementation details ...")
```

2. **Caching Strategy Development**:
   - Design multi-level caching
   - Implement TTL-based invalidation
   - Create cache refresh strategies
   - Optimize for different data types

```typescript
// Create caching patterns documentation
edit_file("1000xbrain/knowledge/rules/back-end-steam-web-api/caching-patterns.md",
          "Create caching patterns documentation",
          "# USE WHEN implementing caching for Steam Web API data\n\n## Overview\n\nThis pattern provides guidance for implementing efficient caching strategies for different types of Steam Web API data...\n\n// ... implementation details ...")
```

3. **Security Implementation Development**:
   - Design authentication verification
   - Implement API key management
   - Create CORS security patterns
   - Develop error handling security

```typescript
// Create security patterns documentation
edit_file("1000xbrain/knowledge/rules/back-end-steam-web-api/security-patterns.md",
          "Create security patterns documentation",
          "# USE WHEN implementing security patterns for Steam Web API integration\n\n## Overview\n\nThis pattern provides guidance for implementing comprehensive security measures for Steam Web API integration...\n\n// ... implementation details ...")
```

### FastAPI-Specific Implementation Guidelines

For FastAPI-specific implementations:

1. **Router Structure**:
   - Organize endpoints by functionality
   - Use proper path parameters
   - Implement dependency injection
   - Add OpenAPI documentation

```python
# Example router structure
from fastapi import APIRouter, Depends, HTTPException
from app.services.steam_auth import SteamAuthService
from app.models.user_models import SteamUser

router = APIRouter(prefix="/steam", tags=["steam"])

@router.get("/inventory/{steam_id}", response_model=List[SteamInventoryItem])
async def get_inventory(
    steam_id: str,
    current_user: SteamUser = Depends(get_current_user),
    steam_service: SteamService = Depends()
):
    """Get Steam inventory for specified user"""
    try:
        inventory = await steam_service.get_inventory(steam_id)
        return inventory
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
```

2. **Service Pattern**:
   - Create dedicated services for functionality
   - Implement dependency injection
   - Use consistent error handling
   - Add comprehensive logging

```python
# Example service pattern
class SteamService:
    def __init__(
        self,
        cache_service: CacheService = Depends(),
        config: Settings = Depends(get_settings),
        logger: Logger = Depends(get_logger)
    ):
        self.cache = cache_service
        self.api_key = config.STEAM_API_KEY
        self.logger = logger
        
    async def get_inventory(self, steam_id: str) -> List[Dict]:
        """Get Steam inventory items with caching"""
        cache_key = f"inventory:{steam_id}"
        
        # Try to get from cache
        cached = await self.cache.get(cache_key)
        if cached:
            self.logger.info(f"Returning cached inventory for {steam_id}")
            return cached
            
        # Fetch from API
        try:
            inventory = await self._fetch_inventory_from_api(steam_id)
            
            # Cache the result
            await self.cache.set(cache_key, inventory, expires=600)
            
            return inventory
        except Exception as e:
            self.logger.error(f"Error fetching inventory: {str(e)}")
            raise
```

### Knowledge Access Pattern

Use the fetch_rules tool to access specialized knowledge for Steam Web API integration:

```typescript
fetch_rules(["knowledge/rules/back-end-steam-web-api/best-practices"], 
           "Understanding best practices for Steam API integration in back-end")

fetch_rules(["knowledge/rules/back-end-steam-web-api/authentication-patterns"], 
           "Understanding Steam authentication patterns for back-end")

fetch_rules(["knowledge/rules/back-end-steam-web-api/api-proxy-patterns"], 
           "Understanding Steam API proxy implementation patterns")

fetch_rules(["knowledge/rules/back-end-steam-web-api/caching-patterns"], 
           "Understanding caching strategies for Steam API data")
```

## Verification Guidelines

Before committing rule enhancements, verify:

1. **Documentation Quality**:
   - No typos or grammatical errors
   - Proper markdown formatting
   - Consistent terminology
   - Complete cross-references

2. **Pattern Consistency**:
   - Alignment with existing patterns
   - Consistent with back-end architecture
   - Proper error handling
   - Security considerations addressed

3. **Knowledge Accessibility**:
   - Properly organized in correct directories
   - Accessible via fetch_rules
   - Clear USE WHEN header
   - Comprehensive overview section

## Cross-References

- **Back-End Authentication**: `knowledge/back-end/steam-web-api/authentication.md`
- **Back-End Inventory**: `knowledge/back-end/steam-web-api/inventory.md`
- **Back-End Best Practices**: `knowledge/rules/back-end-steam-web-api/best-practices.md`
- **Front-End Authentication**: `knowledge/front-end/steam-web-api/authentication.md` 