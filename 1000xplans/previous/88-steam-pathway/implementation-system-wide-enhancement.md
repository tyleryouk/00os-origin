# Implementation Plan: System-Wide Enhancement for Steam Web API

## Implementation Phases

### Phase 1: Preparation and Dependency Analysis

1. **System Architecture Analysis**
   - Complete cognitive architecture mapping
   - Identify cross-system patterns
   - Define integration points between subsystems
   - Document knowledge dependencies

2. **Component Dependency Mapping**
   - Map dependencies between knowledge, parameters, and workflows
   - Identify file relationships across different workflows
   - Document dependency requirements
   - Create visual architecture maps

3. **Implementation Sequence Planning**
   - Define implementation sequence based on dependencies
   - Prioritize components with high dependency impact
   - Establish verification points
   - Create implementation progress tracking system

   **Tool Call Sequence**:
   ```typescript
   // Analyze existing CS2 implementation in front-end
   read_file("front-end/src/models/CS2Gun.model.ts", should_read_entire_file=true)
   read_file("front-end/src/data/counter-strike-database.ts", should_read_entire_file=true)
   read_file("front-end/src/api/cs2-sales.ts", should_read_entire_file=true)
   
   // Examine back-end structure
   list_dir("back-end/app")
   read_file("back-end/app/main.py", should_read_entire_file=true)
   
   // Update implementation progress
   edit_file("planning/88-steam-workflow/implementation-progress.md",
             "Update implementation progress with dependency analysis",
             "// ... existing content ...\n\n## Dependency Analysis Results\n\n### Front-End Dependencies\n- CS2Gun model extensions required\n- API integration with SteamWebAPI.com needed\n- UI components need real data binding\n\n### Back-End Dependencies\n- Steam OpenID authentication needed\n- Proxy endpoints for SteamWebAPI.com\n- Caching layer implementation\n\n// ... existing content ...")
   ```

### Phase 2: Core Component Implementation

1. **Directory Structure Creation**
   - Create knowledge/front-end/steam-web-api/
   - Create knowledge/back-end/steam-web-api/
   - Create knowledge/rules/front-end-steam-web-api/
   - Create knowledge/rules/back-end-steam-web-api/
   - Ensure all mode directories exist in parameters/front-end/, parameters/back-end/, and parameters/rules/
   - Verify workflow directory structure

   **Tool Call Sequence**:
   ```typescript
   // Create front-end knowledge directories
   run_terminal_cmd("mkdir -p 1000xbrain/knowledge/front-end/steam-web-api", false)
   run_terminal_cmd("mkdir -p 1000xbrain/knowledge/back-end/steam-web-api", false)
   run_terminal_cmd("mkdir -p 1000xbrain/knowledge/rules/front-end-steam-web-api", false)
   run_terminal_cmd("mkdir -p 1000xbrain/knowledge/rules/back-end-steam-web-api", false)
   
   // Create parameter directories (if they don't exist)
   run_terminal_cmd("mkdir -p 1000xbrain/parameters/front-end/plan-mode", false)
   run_terminal_cmd("mkdir -p 1000xbrain/parameters/front-end/dev-mode", false)
   run_terminal_cmd("mkdir -p 1000xbrain/parameters/front-end/direct-mode", false)
   run_terminal_cmd("mkdir -p 1000xbrain/parameters/back-end/plan-mode", false)
   run_terminal_cmd("mkdir -p 1000xbrain/parameters/back-end/dev-mode", false)
   run_terminal_cmd("mkdir -p 1000xbrain/parameters/back-end/direct-mode", false)
   run_terminal_cmd("mkdir -p 1000xbrain/parameters/rules/plan-mode", false)
   run_terminal_cmd("mkdir -p 1000xbrain/parameters/rules/dev-mode", false)
   run_terminal_cmd("mkdir -p 1000xbrain/parameters/rules/direct-mode", false)
   
   // Create workflow directories (if they don't exist)
   run_terminal_cmd("mkdir -p 1000xbrain/workflows/front-end", false)
   run_terminal_cmd("mkdir -p 1000xbrain/workflows/back-end", false)
   
   // Verify directory structure
   run_terminal_cmd("find 1000xbrain -type d -name '*steam-web-api*' | sort", false)
   ```

2. **Knowledge Component Implementation**
   - Implement Steam API reference knowledge files
     - Authentication flow documentation
     - Inventory data structures
     - Market data documentation
     - Trading process documentation
   - Create cross-reference system between knowledge files
   - Implement specialized knowledge for each domain
     - Front-end UI pattern documentation
     - Back-end API implementation guidance
     - Error handling strategies
     - Security best practices

   **Example Knowledge Component (Authentication)**:
   ```markdown
   # USE WHEN implementing Steam authentication in front-end or back-end components
   
   ## Overview
   
   This file provides implementation guidance for Steam OpenID authentication flow in the GigaSwap marketplace. It covers both front-end components and back-end API endpoints.
   
   ## Key Concepts
   
   - **Steam OpenID**: Authentication protocol used by Steam to verify user identity
   - **Authentication Flow**: Multi-step process for user authentication through Steam
   - **Security Tokens**: Tokens used to maintain authenticated state
   - **Session Management**: Techniques for maintaining user sessions
   
   ## Implementation Guidelines
   
   ### Front-End Implementation
   
   1. **Login Button Component**:
   ```tsx
   const SteamLoginButton: React.FC = () => {
     return (
       <Button
         variant="contained"
         startIcon={<SteamIcon />}
         onClick={() => window.location.href = '/api/auth/steam'}
         sx={{ backgroundColor: '#171a21', '&:hover': { backgroundColor: '#2a475e' } }}
       >
         Login with Steam
       </Button>
     );
   };
   ```
   
   2. **Authentication State Management**:
   ```tsx
   const useSteamAuth = () => {
     const [user, setUser] = useState<SteamUser | null>(null);
     const [loading, setLoading] = useState(true);
     
     useEffect(() => {
       const checkAuth = async () => {
         try {
           const response = await fetch('/api/auth/steam/status');
           const data = await response.json();
           
           if (data.authenticated) {
             setUser(data.user);
           }
         } catch (error) {
           console.error('Authentication check failed', error);
         } finally {
           setLoading(false);
         }
       };
       
       checkAuth();
     }, []);
     
     return { user, loading, isAuthenticated: !!user };
   };
   ```
   
   ### Back-End Implementation
   
   1. **OpenID Endpoint**:
   ```python
   from fastapi import APIRouter, Request, Depends, HTTPException
   from pydantic import BaseModel
   from app.utils.steam_auth import authenticate_steam_user
   
   router = APIRouter(prefix="/auth/steam", tags=["auth"])
   
   @router.get("/")
   async def steam_login(request: Request):
       """Initiate Steam OpenID authentication"""
       return authenticate_steam_user(request)
       
   @router.get("/callback")
   async def steam_callback(request: Request):
       """Process Steam authentication callback"""
       user_data = await process_steam_callback(request)
       if not user_data:
           raise HTTPException(status_code=401, detail="Authentication failed")
       
       # Create session token
       token = create_session_token(user_data)
       
       # Return redirect with token
       redirect_url = f"/market?token={token}"
       return RedirectResponse(url=redirect_url)
   ```
   
   ## Cross-References
   
   - Front-end state management: `knowledge/front-end/steam-web-api/state-management.md`
   - Back-end security: `knowledge/back-end/steam-web-api/security.md`
   - Session handling: `knowledge/back-end/steam-web-api/session-management.md`
   ```

3. **Parameter File Implementation**
   - Front-end workflow parameter files
     - parameters/front-end/plan-mode/steam-web-api.md
     - parameters/front-end/dev-mode/steam-web-api.md
     - parameters/front-end/direct-mode/steam-web-api.md
   - Back-end workflow parameter files
     - parameters/back-end/plan-mode/steam-web-api.md
     - parameters/back-end/dev-mode/steam-web-api.md
     - parameters/back-end/direct-mode/steam-web-api.md
   - Rules workflow parameter files for front-end-steam-web-api pathway
     - parameters/rules/plan-mode/front-end-steam-web-api.md
     - parameters/rules/dev-mode/front-end-steam-web-api.md
     - parameters/rules/direct-mode/front-end-steam-web-api.md
   - Rules workflow parameter files for back-end-steam-web-api pathway
     - parameters/rules/plan-mode/back-end-steam-web-api.md
     - parameters/rules/dev-mode/back-end-steam-web-api.md
     - parameters/rules/direct-mode/back-end-steam-web-api.md
   - Ensure all parameter files have proper headers
   - Implement consistent message-command processing

   **Example Parameter File (Front-End Dev Mode)**:
   ```markdown
   # workflow: front-end-workflow | pathway: steam-web-api | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/front-end/dev-mode/steam-web-api.md
   
   ## Parameter Purpose
   
   This parameter provides specialized guidance for implementing Steam Web API integration in front-end components while in Developer Mode.
   
   ## Usage Context
   
   Use this parameter when implementing or modifying front-end components that interact with the Steam Web API, including:
   
   - Authentication components
   - Inventory display components
   - Market data visualization
   - Trading interface components
   
   ## Implementation Guidelines
   
   ### Authentication Implementation
   
   1. Begin by modifying the authentication service to support Steam OpenID:
      ```typescript
      edit_file("front-end/src/api/auth.ts",
               "Add Steam authentication support",
               "// ... existing code ...\n\n// Steam authentication methods\nexport const steamAuth = {\n  login: async () => {\n    try {\n      window.location.href = '/api/auth/steam';\n    } catch (error) {\n      ConsolidatedLogger.logError(error, 'steamAuth.login');\n      throw error;\n    }\n  },\n  \n  getStatus: async () => {\n    try {\n      const response = await authAPI.get('/auth/steam/status');\n      return response.data;\n    } catch (error) {\n      ConsolidatedLogger.logError(error, 'steamAuth.getStatus');\n      return { authenticated: false };\n    }\n  },\n  \n  logout: async () => {\n    try {\n      await authAPI.post('/auth/steam/logout');\n      return true;\n    } catch (error) {\n      ConsolidatedLogger.logError(error, 'steamAuth.logout');\n      return false;\n    }\n  }\n};\n\n// ... existing code ...")
      ```
   
   2. Create a Steam login button component:
      ```typescript
      edit_file("front-end/src/components/auth/SteamLoginButton.tsx",
                "Create Steam login button component",
                "import React from 'react';\nimport Button from '@mui/material/Button';\nimport SteamIcon from 'components/icons/SteamIcon';\nimport { steamAuth } from 'api/auth';\nimport { ConsolidatedLogger } from 'utils/consolidated-logger';\n\nconst SteamLoginButton: React.FC = () => {\n  const handleLogin = () => {\n    ConsolidatedLogger.log('INFO', 'AUTH', 'Steam login clicked');\n    steamAuth.login();\n  };\n  \n  return (\n    <Button\n      variant=\"contained\"\n      startIcon={<SteamIcon />}\n      onClick={handleLogin}\n      sx={{ backgroundColor: '#171a21', '&:hover': { backgroundColor: '#2a475e' } }}\n    >\n      Login with Steam\n    </Button>\n  );\n};\n\nexport default SteamLoginButton;")
      ```
   
   ### Inventory Integration
   
   1. Extend the CS2Gun model:
      ```typescript
      edit_file("front-end/src/models/CS2Gun.model.ts",
                "Extend CS2Gun model with Steam inventory properties",
                "// ... existing code ...\n\nexport interface SteamInventoryItem extends CS2Gun {\n  assetId: string;        // Steam inventory asset ID\n  marketable: boolean;    // Whether item can be listed on market\n  tradable: boolean;      // Whether item can be traded\n  tradeHoldDuration?: number; // Trade hold duration in days\n}\n\n// ... existing code ...")
      ```
   
   2. Update the CS2 Sales API to support Steam inventory:
      ```typescript
      edit_file("front-end/src/api/cs2-sales.ts",
                "Add Steam inventory support to cs2SalesAPI",
                "// ... existing code ...\n\n  /**\n   * Get user's Steam inventory\n   * @returns Promise with inventory items\n   */\n  getSteamInventory: cache(async (): Promise<SteamInventoryItem[]> => {\n    try {\n      // Log the inventory loading operation\n      ConsolidatedLogger.logCS2('Loading Steam inventory', 'INFO', { source: 'getSteamInventory' });\n      \n      // Fetch inventory from API\n      const response = await apiClient.get('/inventory/steam');\n      \n      // Map API response to SteamInventoryItem\n      const inventory = response.data.map(item => ({\n        ...item,\n        // Add any additional processing needed\n      }));\n      \n      return inventory;\n    } catch (error) {\n      // Log any errors\n      ConsolidatedLogger.logCS2Error(\n        error instanceof Error ? error : new Error(String(error)),\n        'getSteamInventory'\n      );\n      \n      // Return fallback data in case of error\n      return getFallbackInventory();\n    }\n  }),\n\n// ... existing code ...")
      ```
   
   ## Knowledge Access
   
   For detailed implementation guidance, use the following knowledge components:
   
   ```typescript
   fetch_rules(["knowledge/front-end/steam-web-api/authentication"], 
              "Understanding Steam authentication implementation")
   
   fetch_rules(["knowledge/front-end/steam-web-api/inventory"], 
              "Understanding Steam inventory integration")
   
   fetch_rules(["knowledge/front-end/steam-web-api/market-data"], 
              "Understanding Steam market data visualization")
   
   fetch_rules(["knowledge/front-end/steam-web-api/trading"], 
              "Understanding Steam trading implementation")
   ```
   ```

### Phase 3: Dependent Component Implementation

1. **Workflow Component Enhancement**
   - Update existing front-end workflow files
     - Add Steam-specific behavior patterns
     - Enhance auto-attachment criteria
     - Update workflow documentation
   - Create minimal back-end workflow files
     - Define basic workflow structure
     - Implement Steam-specific behavior patterns
     - Create proper auto-attachment criteria

   **Tool Call Sequence**:
   ```typescript
   // Read existing front-end workflow files
   list_dir("1000xbrain/workflows/front-end")
   read_file("1000xbrain/workflows/front-end/front-end-workflow.md", should_read_entire_file=true)
   
   // Create new workflow files
   edit_file("1000xbrain/workflows/front-end/steam-web-api.md",
             "Create Steam Web API workflow file for front-end",
             "# Steam Web API Workflow for Front-End\n\n## Overview\n\nThis workflow provides specialized behavior for front-end components that interact with the Steam Web API.\n\n## File Patterns\n\n- `**/components/steam/*.tsx`\n- `**/pages/steam/*.tsx`\n- `**/hooks/useSteam*.ts`\n- `**/api/steam*.ts`\n\n## Behavior Specialization\n\nThis workflow specializes behavior for Steam Web API integration by:\n\n- Activating Steam authentication patterns\n- Applying inventory display patterns\n- Implementing market data visualization patterns\n- Enabling trading interface patterns\n\n## Related Parameters\n\n- Plan Mode: `parameters/front-end/plan-mode/steam-web-api.md`\n- Dev Mode: `parameters/front-end/dev-mode/steam-web-api.md`\n- Direct Mode: `parameters/front-end/direct-mode/steam-web-api.md`")
   
   edit_file("1000xbrain/workflows/back-end/steam-web-api.md",
             "Create Steam Web API workflow file for back-end",
             "# Steam Web API Workflow for Back-End\n\n## Overview\n\nThis workflow provides specialized behavior for back-end components that interact with the Steam Web API.\n\n## File Patterns\n\n- `**/app/steam/*.py`\n- `**/app/routes/steam*.py`\n- `**/app/models/steam*.py`\n- `**/app/services/steam*.py`\n\n## Behavior Specialization\n\nThis workflow specializes behavior for Steam Web API integration by:\n\n- Activating Steam authentication endpoints\n- Applying inventory data processing\n- Implementing market data aggregation\n- Enabling trading API endpoints\n\n## Related Parameters\n\n- Plan Mode: `parameters/back-end/plan-mode/steam-web-api.md`\n- Dev Mode: `parameters/back-end/dev-mode/steam-web-api.md`\n- Direct Mode: `parameters/back-end/direct-mode/steam-web-api.md`")
   ```

2. **Rules Workflow Pathway Implementation**
   - Create front-end-steam-web-api pathway
     - Define pathway-specific behavior
     - Implement cross-references to front-end pathways
     - Ensure parameter compatibility
   - Create back-end-steam-web-api pathway
     - Define pathway-specific behavior
     - Implement cross-references to back-end pathways
     - Ensure parameter compatibility

   **Tool Call Sequence**:
   ```typescript
   // Implement rules workflow pathways
   
   // Create front-end-steam-web-api pathway files
   edit_file("1000xbrain/knowledge/rules/front-end-steam-web-api/best-practices.md",
             "Create best practices for front-end Steam API integration",
             "# USE WHEN implementing best practices for Steam API integration in front-end components\n\n## Overview\n\nThis file provides comprehensive guidance on best practices for integrating the Steam Web API in front-end components.\n\n## Key Patterns\n\n- Authentication flow patterns\n- Inventory management patterns\n- Trade offer creation patterns\n- Market data visualization patterns\n\n## Implementation Guidelines\n\n// ... detailed guidelines ...")
   
   edit_file("1000xbrain/parameters/rules/dev-mode/front-end-steam-web-api.md",
             "Create dev-mode parameter file for front-end-steam-web-api pathway",
             "# workflow: rules-workflow | pathway: front-end-steam-web-api | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/dev-mode/front-end-steam-web-api.md\n\n## Parameter Purpose\n\nThis parameter provides specialized guidance for enhancing and maintaining the Steam Web API integration in front-end components while in Developer Mode.\n\n## Usage Context\n\nUse this parameter when implementing or modifying rules related to front-end Steam Web API integration.\n\n## Implementation Guidelines\n\n// ... detailed guidelines ...")
   
   // Create back-end-steam-web-api pathway files
   edit_file("1000xbrain/knowledge/rules/back-end-steam-web-api/best-practices.md",
             "Create best practices for back-end Steam API integration",
             "# USE WHEN implementing best practices for Steam API integration in back-end components\n\n## Overview\n\nThis file provides comprehensive guidance on best practices for integrating the Steam Web API in back-end components.\n\n## Key Patterns\n\n- Authentication endpoint patterns\n- Inventory data processing patterns\n- Trade offer validation patterns\n- Market data aggregation patterns\n\n## Implementation Guidelines\n\n// ... detailed guidelines ...")
   
   edit_file("1000xbrain/parameters/rules/dev-mode/back-end-steam-web-api.md",
             "Create dev-mode parameter file for back-end-steam-web-api pathway",
             "# workflow: rules-workflow | pathway: back-end-steam-web-api | message-command: dev-mode | standard-parameter(s): none | project-rule-parameter-filepath: parameters/rules/dev-mode/back-end-steam-web-api.md\n\n## Parameter Purpose\n\nThis parameter provides specialized guidance for enhancing and maintaining the Steam Web API integration in back-end components while in Developer Mode.\n\n## Usage Context\n\nUse this parameter when implementing or modifying rules related to back-end Steam Web API integration.\n\n## Implementation Guidelines\n\n// ... detailed guidelines ...")
   ```

3. **Cross-System Pattern Implementation**
   - Implement consistent terminology across all files
   - Ensure error handling pattern consistency
   - Standardize message-command processing
   - Implement mode-specific behavior patterns

### Phase 4: System-Wide Verification

1. **Component Verification**
   - Verify all knowledge components
     - Check header format
     - Test fetch_rules accessibility
     - Validate cross-references
   - Verify all parameter files
     - Check header format
     - Validate message-command compatibility
     - Test mode-specific behavior
   - Verify all workflow components
     - Check auto-attachment criteria
     - Test behavior specialization
     - Validate file organization

   **Tool Call Sequence**:
   ```typescript
   // Verify knowledge components
   run_terminal_cmd("find 1000xbrain/knowledge -name '*.md' -exec grep -l 'USE WHEN' {} \\; | wc -l", false)
   
   // Verify parameter files
   run_terminal_cmd("find 1000xbrain/parameters -name '*.md' -exec grep -l 'workflow:' {} \\; | wc -l", false)
   
   // Test fetch_rules accessibility
   fetch_rules(["knowledge/front-end/steam-web-api/authentication"], 
              "Testing fetch_rules accessibility for Steam authentication knowledge")
   ```

2. **Cross-Component Integration Testing**
   - Test knowledge access from parameters
   - Verify workflow behavior with parameters
   - Test message-command processing flow
   - Validate cross-system pattern implementation

   **Testing Approach**:
   ```typescript
   // Test parameter access
   run_terminal_cmd("cat planning/88-steam-workflow/test-cheatsheet.md | grep 'plan-mode: front-end-workflow @parameters/front-end/plan-mode/steam-web-api.mdc'", false)
   
   // Create test messages for verification
   const testMessages = [
     "plan-mode: front-end-workflow @parameters/front-end/plan-mode/steam-web-api.mdc",
     "dev-mode: front-end-workflow @parameters/front-end/dev-mode/steam-web-api.mdc",
     "direct-mode: front-end-workflow @parameters/front-end/direct-mode/steam-web-api.mdc",
     "plan-mode: back-end-workflow @parameters/back-end/plan-mode/steam-web-api.mdc",
     "dev-mode: back-end-workflow @parameters/back-end/dev-mode/steam-web-api.mdc",
     "direct-mode: back-end-workflow @parameters/back-end/direct-mode/steam-web-api.mdc"
   ];
   ```

3. **System-Wide Consistency Verification**
   - Check terminology consistency
   - Verify pattern implementation
   - Validate header formatting
   - Test cross-references between subsystems

   **Verification Approach**:
   ```typescript
   // Check terminology consistency
   run_terminal_cmd("find 1000xbrain -name '*.md' -exec grep -l 'SteamID' {} \\;", false)
   
   // Verify pattern implementation
   run_terminal_cmd("find 1000xbrain -name '*.md' -exec grep -l 'Authentication Pattern' {} \\;", false)
   
   // Check cross-references
   run_terminal_cmd("find 1000xbrain -name '*.md' -exec grep -l 'Cross-References' {} \\;", false)
   ```

4. **Final Integration Test**
   - Test complete workflow from plan-mode to dev-mode
   - Verify successful parameter loading
   - Validate knowledge component access
   - Ensure consistent behavior across modes

## Directory Structure

The implementation will create and modify the following directory structure:

```
1000xbrain/
├── knowledge/
│   ├── front-end/
│   │   └── steam-web-api/
│   │       ├── authentication.md
│   │       ├── inventory.md
│   │       ├── market-data.md
│   │       └── trading.md
│   ├── back-end/
│   │   └── steam-web-api/
│   │       ├── api-endpoints.md
│   │       ├── authentication.md
│   │       ├── data-caching.md
│   │       └── security.md
│   └── rules/
│       ├── front-end-steam-web-api/
│       │   ├── best-practices.md
│       │   ├── authentication-patterns.md
│       │   ├── inventory-patterns.md
│       │   └── market-patterns.md
│       └── back-end-steam-web-api/
│           ├── best-practices.md
│           ├── authentication-patterns.md
│           ├── data-caching-patterns.md
│           └── security-patterns.md
│
├── parameters/
│   ├── front-end/
│   │   ├── plan-mode/
│   │   │   └── steam-web-api.md
│   │   ├── dev-mode/
│   │   │   └── steam-web-api.md
│   │   └── direct-mode/
│   │       └── steam-web-api.md
│   ├── back-end/
│   │   ├── plan-mode/
│   │   │   └── steam-web-api.md
│   │   ├── dev-mode/
│   │   │   └── steam-web-api.md
│   │   └── direct-mode/
│   │       └── steam-web-api.md
│   └── rules/
│       ├── plan-mode/
│       │   ├── front-end-steam-web-api.md
│       │   └── back-end-steam-web-api.md
│       ├── dev-mode/
│       │   ├── front-end-steam-web-api.md
│       │   └── back-end-steam-web-api.md
│       └── direct-mode/
│           ├── front-end-steam-web-api.md
│           └── back-end-steam-web-api.md
│
└── workflows/
    ├── front-end/
    │   └── steam-web-api.md (updated or new)
    └── back-end/
        └── steam-web-api.md (new)
```

## Implementation Details

### 1. Knowledge Component Implementation

Each knowledge file will follow this structure:

```markdown
# USE WHEN [specific description of when to use this knowledge]

## Overview

[General overview of the knowledge area]

## Key Concepts

[List of important concepts and definitions]

## Implementation Guidelines

[Specific implementation guidance]

## Examples

[Code examples and usage patterns]

## Cross-References

[References to related knowledge components]
```

### 2. Parameter File Implementation

Each parameter file will follow this structure:

```markdown
# workflow: [workflow-type] | pathway: steam-web-api | message-command: [message-command] | standard-parameter(s): none | project-rule-parameter-filepath: parameters/[workflow]/[mode]/steam-web-api.md

## Parameter Purpose

[Description of parameter purpose]

## Usage Context

[When and how to use this parameter]

## Implementation Guidelines

[Specific implementation instructions]

## Knowledge Access

[Guidance on accessing related knowledge]

```

### 3. Workflow File Implementation

Workflow files will follow this structure:

```markdown
# Steam Web API Workflow

## Overview

[Description of workflow purpose and scope]

## File Patterns

[Patterns for auto-attachment]

## Behavior Specialization

[How this workflow specializes behavior]

## Related Parameters

[References to parameter files]
```

## Success Criteria

The implementation will be considered successful when:

1. **Structural Completion**:
   - All required files are created
   - Directory structure is complete
   - Headers are properly formatted
   - File organization follows standards

2. **Functional Integration**:
   - Knowledge components are accessible via fetch_rules
   - Parameter files are accessible via message-commands
   - Workflows properly auto-attach based on file patterns
   - Cross-system patterns are consistently implemented

3. **Cognitive Enhancement**:
   - 1000xdev can effectively work with Steam Web API
   - Mode-specific behavior works consistently
   - Knowledge provides comprehensive guidance
   - Parameters enable specialized behavior

4. **Cross-System Cohesion**:
   - Terminology is consistent across all files
   - Behavior patterns are consistently applied
   - Integration points function properly
   - Knowledge cross-references are accurate

## Implementation Timeline

1. **Phase 1**: Complete within 1-2 days
2. **Phase 2**: Complete within 3-5 days
3. **Phase 3**: Complete within 2-3 days
4. **Phase 4**: Complete within 1-2 days

Total expected implementation time: 7-12 days 

## Detailed Back-End Implementation Guide for Steam OpenID Authentication

The back-end implementation for Steam OpenID authentication requires careful coordination between FastAPI endpoints, Steam's OpenID service, and the front-end application. This section provides detailed implementation guidance for creating the complete authentication flow.

### Required Dependencies

First, ensure these dependencies are added to the `requirements.txt` file:

```
# Steam OpenID Integration
python-openid>=2.2.5
pysteamwebapi>=1.0.0
requests-oauthlib>=1.3.1
```

### Steam Auth Utility Implementation

Create a new utility file at `back-end/app/utils/steam_auth.py`:

```python
from fastapi import Request, HTTPException
from fastapi.responses import RedirectResponse
from starlette.status import HTTP_303_SEE_OTHER, HTTP_401_UNAUTHORIZED
from openid.consumer import consumer
from openid.extensions import ax
import requests
import json
import os
from app.utils.logger import get_logger
from app.models.user_models import SteamUser
from app.utils.redis_config import RedisManager

# Setup logger
logger = get_logger('steam_auth', 'auth')

# Configuration
STEAM_API_KEY = os.getenv('STEAM_API_KEY', 'LITUJ4KSYS7D1QC0')
STEAM_OPENID_URL = 'https://steamcommunity.com/openid'
FRONTEND_URL = os.getenv('FRONTEND_URL', 'http://localhost:3000')

# Redis for token storage
redis_manager = RedisManager()

class SteamAuthManager:
    """Manager for Steam OpenID authentication"""
    
    @staticmethod
    async def initiate_auth(request: Request) -> RedirectResponse:
        """Initiate Steam OpenID authentication flow"""
        try:
            # Create OpenID consumer
            oid_consumer = consumer.Consumer({}, None)
            
            # Begin authentication process
            auth_request = oid_consumer.begin(STEAM_OPENID_URL)
            
            # Get callback URL from request host
            callback_url = str(request.url_for('steam_callback'))
            
            # Create redirect URL for Steam login
            redirect_url = auth_request.redirectURL(
                return_to=callback_url,
                trust_root=str(request.base_url)
            )
            
            logger.info(f"Initiating Steam auth, redirecting to {redirect_url}")
            return RedirectResponse(url=redirect_url, status_code=HTTP_303_SEE_OTHER)
            
        except Exception as e:
            logger.error(f"Error initiating Steam auth: {str(e)}")
            raise HTTPException(
                status_code=HTTP_401_UNAUTHORIZED,
                detail=f"Failed to initiate Steam authentication: {str(e)}"
            )
    
    @staticmethod
    async def process_callback(request: Request) -> SteamUser:
        """Process Steam OpenID callback"""
        try:
            # Create OpenID consumer
            oid_consumer = consumer.Consumer({}, None)
            
            # Get query parameters
            query_params = dict(request.query_params)
            current_url = str(request.url)
            
            # Complete authentication process
            info = oid_consumer.complete(query_params, current_url)
            
            if info.status != consumer.SUCCESS:
                logger.error(f"Steam auth failed: {info.status}")
                raise HTTPException(
                    status_code=HTTP_401_UNAUTHORIZED,
                    detail=f"Steam authentication failed: {info.status}"
                )
            
            # Extract Steam ID from identity URL
            # Format: https://steamcommunity.com/openid/id/[steam_id]
            steam_id = info.identity_url.split('/')[-1]
            
            # Get user info from Steam API
            user_data = await SteamAuthManager.get_steam_user_info(steam_id)
            
            logger.info(f"Steam auth success for user: {user_data.personaname}")
            return user_data
            
        except Exception as e:
            logger.error(f"Error processing Steam callback: {str(e)}")
            raise HTTPException(
                status_code=HTTP_401_UNAUTHORIZED,
                detail=f"Failed to process Steam authentication: {str(e)}"
            )
    
    @staticmethod
    async def get_steam_user_info(steam_id: str) -> SteamUser:
        """Get user info from Steam API"""
        try:
            url = f"https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/"
            params = {
                "key": STEAM_API_KEY,
                "steamids": steam_id
            }
            
            response = requests.get(url, params=params)
            response.raise_for_status()
            
            data = response.json()
            player = data['response']['players'][0]
            
            return SteamUser(
                steam_id=player['steamid'],
                personaname=player['personaname'],
                avatar=player['avatar'],
                avatarfull=player['avatarfull'],
                profileurl=player['profileurl']
            )
            
        except Exception as e:
            logger.error(f"Error getting Steam user info: {str(e)}")
            raise HTTPException(
                status_code=HTTP_401_UNAUTHORIZED,
                detail=f"Failed to get Steam user info: {str(e)}"
            )
    
    @staticmethod
    async def create_auth_token(user: SteamUser) -> str:
        """Create authentication token for user"""
        try:
            # Generate token (in production, use more secure method)
            token = f"steam_{user.steam_id}_{os.urandom(8).hex()}"
            
            # Store in Redis with expiration (24 hours)
            await redis_manager.set_with_expiry(
                f"auth_token:{token}", 
                json.dumps(user.dict()), 
                60 * 60 * 24
            )
            
            return token
            
        except Exception as e:
            logger.error(f"Error creating auth token: {str(e)}")
            raise HTTPException(
                status_code=HTTP_401_UNAUTHORIZED,
                detail=f"Failed to create authentication token: {str(e)}"
            )
    
    @staticmethod
    async def validate_token(token: str) -> SteamUser:
        """Validate authentication token"""
        try:
            # Get user data from Redis
            user_data_str = await redis_manager.get(f"auth_token:{token}")
            
            if not user_data_str:
                return None
                
            # Parse user data
            user_data = json.loads(user_data_str)
            return SteamUser(**user_data)
            
        except Exception as e:
            logger.error(f"Error validating token: {str(e)}")
            return None
    
    @staticmethod
    async def logout(token: str) -> bool:
        """Logout user by invalidating token"""
        try:
            # Remove token from Redis
            await redis_manager.delete(f"auth_token:{token}")
            return True
            
        except Exception as e:
            logger.error(f"Error during logout: {str(e)}")
            return False

# Convenience functions
async def authenticate_steam_user(request: Request) -> RedirectResponse:
    """Convenience function to initiate Steam auth"""
    return await SteamAuthManager.initiate_auth(request)

async def process_steam_callback(request: Request) -> SteamUser:
    """Convenience function to process Steam callback"""
    return await SteamAuthManager.process_callback(request)

async def create_session_token(user: SteamUser) -> str:
    """Convenience function to create session token"""
    return await SteamAuthManager.create_auth_token(user)

async def validate_session_token(token: str) -> SteamUser:
    """Convenience function to validate session token"""
    return await SteamAuthManager.validate_token(token)

async def invalidate_session_token(token: str) -> bool:
    """Convenience function to invalidate session token"""
    return await SteamAuthManager.logout(token)
```

### User Model Implementation

Create a new model file at `back-end/app/models/user_models.py` (or update existing):

```python
from pydantic import BaseModel, Field
from typing import Optional

class SteamUser(BaseModel):
    """Steam user model"""
    steam_id: str
    personaname: str
    avatar: str
    avatarfull: str
    profileurl: str
    
class SteamAuthResponse(BaseModel):
    """Response model for Steam authentication"""
    authenticated: bool
    user: Optional[SteamUser] = None
    token: Optional[str] = None
    redirect_url: Optional[str] = None
```

### Authentication Router Implementation

Create a new router file at `back-end/app/auth/steam_routes.py`:

```python
from fastapi import APIRouter, Request, Depends, Header, HTTPException, Cookie
from fastapi.responses import RedirectResponse
from typing import Optional
from app.utils.steam_auth import (
    authenticate_steam_user,
    process_steam_callback,
    create_session_token,
    validate_session_token,
    invalidate_session_token
)
from app.models.user_models import SteamAuthResponse, SteamUser
from app.utils.logger import get_logger

# Setup logger
logger = get_logger('steam_auth_routes', 'auth')

# Create router
router = APIRouter(prefix="/auth/steam", tags=["auth"])

@router.get("/")
async def steam_login(request: Request):
    """Initiate Steam OpenID authentication"""
    logger.info("Steam login initiated")
    return await authenticate_steam_user(request)

@router.get("/callback")
async def steam_callback(request: Request):
    """Process Steam authentication callback"""
    try:
        # Process callback and get user data
        user_data = await process_steam_callback(request)
        
        # Create session token
        token = await create_session_token(user_data)
        
        # Construct frontend URL with token
        frontend_url = f"{os.getenv('FRONTEND_URL', 'http://localhost:3000')}/auth/callback?token={token}"
        
        logger.info(f"Steam auth successful for user {user_data.personaname}, redirecting to frontend")
        return RedirectResponse(url=frontend_url)
        
    except Exception as e:
        logger.error(f"Steam callback error: {str(e)}")
        error_url = f"{os.getenv('FRONTEND_URL', 'http://localhost:3000')}/auth/error?message={str(e)}"
        return RedirectResponse(url=error_url)

@router.get("/status")
async def auth_status(
    request: Request,
    authorization: Optional[str] = Header(None),
    token: Optional[str] = Cookie(None)
) -> SteamAuthResponse:
    """Check authentication status"""
    # Try to get token from header or cookie
    auth_token = None
    if authorization and authorization.startswith("Bearer "):
        auth_token = authorization.replace("Bearer ", "")
    elif token:
        auth_token = token
        
    if not auth_token:
        return SteamAuthResponse(authenticated=False)
        
    # Validate token
    user = await validate_session_token(auth_token)
    
    if not user:
        return SteamAuthResponse(authenticated=False)
        
    return SteamAuthResponse(
        authenticated=True, 
        user=user,
        token=auth_token
    )

@router.post("/logout")
async def logout(
    request: Request,
    authorization: Optional[str] = Header(None),
    token: Optional[str] = Cookie(None)
) -> SteamAuthResponse:
    """Logout user"""
    # Try to get token from header or cookie
    auth_token = None
    if authorization and authorization.startswith("Bearer "):
        auth_token = authorization.replace("Bearer ", "")
    elif token:
        auth_token = token
        
    if not auth_token:
        return SteamAuthResponse(authenticated=False)
        
    # Invalidate token
    success = await invalidate_session_token(auth_token)
    
    return SteamAuthResponse(authenticated=not success)

# Dependency for protecting routes
async def get_current_steam_user(
    request: Request,
    authorization: Optional[str] = Header(None),
    token: Optional[str] = Cookie(None)
) -> SteamUser:
    """Get current authenticated Steam user"""
    # Try to get token from header or cookie
    auth_token = None
    if authorization and authorization.startswith("Bearer "):
        auth_token = authorization.replace("Bearer ", "")
    elif token:
        auth_token = token
        
    if not auth_token:
        raise HTTPException(status_code=401, detail="Not authenticated")
        
    # Validate token
    user = await validate_session_token(auth_token)
    
    if not user:
        raise HTTPException(status_code=401, detail="Invalid or expired token")
        
    return user
```

### Integration with Main Application

Update `back-end/app/main.py` to include the Steam authentication router:

```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.users.user_routes import router as user_router
from app.auth.auth_routes import router as auth_router
from app.auth.steam_routes import router as steam_auth_router  # Add this line
from app.orders.order_routes import router as order_router
from app.routes.logs_routes import router as logs_router
# ... other imports ...

app = FastAPI()

# ... existing middleware and setup ...

# Include routers
app.include_router(user_router)
app.include_router(auth_router)
app.include_router(steam_auth_router)  # Add this line
app.include_router(order_router)
app.include_router(logs_router)
# ... other routers ...
```

### Security Considerations

1. **API Key Protection**:
   - Store the Steam API key in environment variables
   - Never expose the key in client-side code
   - Consider rotating the key periodically

2. **Token Security**:
   - Use secure token generation methods in production
   - Implement proper token expiration
   - Use HTTPS for all auth-related communications

3. **CORS Configuration**:
   - Configure CORS properly to allow only trusted origins
   - Be especially careful with the callback endpoint

4. **Error Handling**:
   - Implement comprehensive error handling
   - Log authentication failures for security monitoring
   - Don't expose detailed error information to clients

### Testing the Integration

These test cases should be included in the test suite:

1. **Authentication Flow Test**:
   - Test the login endpoint redirects to Steam
   - Test callback handling with mocked Steam response
   - Verify token creation and storage

2. **Session Management Test**:
   - Test token validation works correctly
   - Test token expiration
   - Test logout functionality

3. **Error Handling Test**:
   - Test behavior when Steam service is unavailable
   - Test invalid callback parameters
   - Test token validation failures

// ... continue with the rest of the existing content ...