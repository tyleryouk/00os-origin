# Steam Web API Integration Workflow

## Implementation Phases

### Phase 1: Core Client & Market Items (Current Phase)
- **Focus**: Implement basic Steam Web API client and market items display
- **Key Components**:
  - Backend Steam API client foundation
  - Items API implementation
  - Frontend item models and components
  - Basic marketplace UI

### Phase 2: Authentication & Inventory
- **Focus**: Implement Steam authentication and user inventory access
- **Key Components**:
  - Steam OpenID authentication flow
  - User inventory retrieval and display
  - Session management
  - Inventory browser UI

### Phase 3: Trading System
- **Focus**: Implement trading functionality for CS2 items
- **Key Components**:
  - Trade offer creation and management
  - Trade state tracking
  - Notifications system
  - Trade history and audit

### Phase 4: Advanced Features & Optimization
- **Focus**: Enhance marketplace functionality and optimize performance
- **Key Components**:
  - Advanced filtering and search
  - Performance optimizations
  - Responsive design improvements
  - Analytics and monitoring

### Phase 5: Blockchain Integration
- **Focus**: Connect Steam items with decentralized payment system
- **Key Components**:
  - Escrow system for trades
  - Asset bridging mechanism
  - Smart contract for payments
  - Transaction verification

## Current Development Focus

We are currently in **Phase 1: Core Client & Market Items**, with the primary focus on:

1. **Backend Priorities**:
   - ✅ Implementing the base `SteamWebAPIClient` class
   - ✅ Creating the `ItemsClient` module for market items
   - ✅ Implementing the `InventoryClient` module for inventory access
   - ✅ Implementing the `TradeClient` module for trade offers
   - 🔄 **Current Priority: Minimal Functional Testing**
     - Basic verification of endpoint functionality
     - Simple tests for successful API requests
     - Basic error handling tests
     - Verification of data model parsing
   - 🔄 Finalizing API routes for frontend integration
   - 🔄 Ensuring reliable endpoint functionality

2. **Frontend Priorities**:
   - 🔄 Defining TypeScript interfaces for Steam items, inventory, and trades
   - 🔄 Implementing API service layer
   - 🔄 Creating basic marketplace UI components
   - 🔄 Setting up proper loading and error states
   - 🔜 Connecting frontend components to backend API endpoints

## Development Approach

### Backend Implementation (Python)

#### API Client Architecture
```
back-end/
  └── app/
      └── steam/                 # Root directory for Steam integration backend code
          ├── client.py              # Base SteamWebAPIClient
          ├── exceptions.py          # Custom exception classes
          ├── models/                # Data models
          │   ├── __init__.py
          │   ├── item.py            # Item models
          │   ├── inventory.py       # Inventory models
          │   └── trade.py           # Trade models
          └── services/              # Service modules
              ├── __init__.py
              ├── items.py           # ItemsClient
              ├── inventory.py       # InventoryClient
              └── trades.py          # TradesClient
```

#### Implementation Pattern

1. **Base Client**:
   ```python
   # In back-end/app/steam/client.py
   class SteamWebAPIClient:
       def __init__(self, api_key, base_url="https://api.steamwebapi.com"):
           self.api_key = api_key
           self.base_url = base_url
           self.session = self._create_session()
           self.logger = self._setup_logger()
           
       def _create_session(self):
           session = requests.Session()
           session.headers.update({
               "Authorization": f"Bearer {self.api_key}",
               "Content-Type": "application/json",
               "Accept": "application/json"
           })
           return session
           
       async def _request(self, method, endpoint, params=None, data=None, **kwargs):
           """Make a request to the Steam Web API with error handling and retries"""
           # Implementation with proper error handling, logging, and retries
   ```

2. **Service Modules**:
   ```python
   # In back-end/app/steam/services/items.py (or similar)
   class ItemsClient:
       def __init__(self, client):
           self.client = client
           self.cache = RedisCache(prefix="steam:items:", ttl=3600)
           
       async def get_item_info(self, item_id):
           """Get information about a specific item"""
           cache_key = f"item:{item_id}"
           cached = await self.cache.get(cache_key)
           if cached:
               return Item.from_dict(cached)
               
           response = await self.client._request(
               "GET", 
               f"/steam/api/items/{item_id}"
           )
           item = Item.from_dict(response)
           await self.cache.set(cache_key, item.to_dict())
           return item
   ```

3. **Data Models**:
   ```python
   # In back-end/app/steam/models/item.py (or similar)
   @dataclass
   class Item:
       id: str
       name: str
       icon_url: str
       price: float
       market_hash_name: str
       wear_value: Optional[float] = None
       category: Optional[str] = None
       rarity: Optional[str] = None
       
       @classmethod
       def from_dict(cls, data):
           """Create an Item from API response data"""
           return cls(
               id=data.get("id"),
               name=data.get("name"),
               icon_url=data.get("icon_url"),
               price=float(data.get("price", 0)),
               market_hash_name=data.get("market_hash_name"),
               wear_value=float(data.get("wear_value", 0)) if data.get("wear_value") else None,
               category=data.get("category"),
               rarity=data.get("rarity")
           )
   ```

### Frontend Implementation (TypeScript)

#### Component Architecture
```
frontend/
  └── src/
      ├── api/
      │   └── steam.ts           # Steam API service
      ├── components/
      │   └── market/
      │       ├── ItemCard.tsx   # Individual item card
      │       ├── ItemGrid.tsx   # Grid of items
      │       ├── ItemDetail.tsx # Detailed item view
      │       └── Filters.tsx    # Marketplace filters
      ├── context/
      │   └── MarketContext.tsx  # Market state management
      ├── models/
      │   └── steamItem.ts       # TypeScript interfaces
      └── pages/
          └── Market.tsx         # Marketplace page
```

#### Implementation Pattern

1. **TypeScript Models**:
   ```typescript
   // models/steamItem.ts
   export interface SteamItem {
     id: string;
     name: string;
     iconUrl: string;
     price: number;
     marketHashName: string;
     wearValue?: number;
     category?: string;
     rarity?: string;
   }
   
   export interface CS2Weapon extends SteamItem {
     weaponType: string;
     condition: string;
     statTrak?: boolean;
     souvenir?: boolean;
   }
   ```

2. **API Service**:
   ```typescript
   // api/steam.ts
   import { SteamItem } from '../models/steamItem';
   
   const API_BASE = '/api/steam';
   
   export async function fetchMarketItems(
     page = 1, 
     limit = 20, 
     filters?: Record<string, any>
   ): Promise<{ items: SteamItem[], total: number }> {
     // Implementation with proper error handling and query params
   }
   
   export async function fetchItemDetails(itemId: string): Promise<SteamItem> {
     // Implementation with proper error handling
   }
   ```

3. **React Components**:
   ```tsx
   // components/market/ItemCard.tsx
   import { SteamItem } from '../../models/steamItem';
   
   interface ItemCardProps {
     item: SteamItem;
     onClick?: (item: SteamItem) => void;
   }
   
   export function ItemCard({ item, onClick }: ItemCardProps) {
     return (
       <div className="item-card" onClick={() => onClick?.(item)}>
         <img src={item.iconUrl} alt={item.name} />
         <h3>{item.name}</h3>
         <p className="price">${item.price.toFixed(2)}</p>
         {item.rarity && <span className={`rarity ${item.rarity.toLowerCase()}`}>{item.rarity}</span>}
       </div>
     );
   }
   ```

## Testing Strategy

### Minimal Testing Approach

For our MVP, we're implementing a simplified testing strategy focused on:

1. **Endpoint Functionality**: Verifying our API endpoints correctly communicate with the Steam Web API
2. **Data Validation**: Ensuring response data is properly mapped to our models

#### Essential Tests

**1. Base Client Tests:**
- Test successful API requests with mocked responses
- Test basic error handling for common error codes
- Verify retry mechanism for server errors

**2. Service Tests:**
- Test core data retrieval for each service (Items, Inventory, Trade)
- Verify basic caching behavior
- Test error response handling

**3. Data Model Tests:**
- Verify API responses can be parsed into our Pydantic models
- Test field mapping for renamed attributes

#### Implementation

We're using a streamlined testing approach with:
- Simple mock responses based on documented API patterns
- Basic tests for the critical path of each endpoint
- Focus on functionality rather than exhaustive edge cases

Test directory structure:
```
back-end/tests/steam/
├── conftest.py             # Common fixtures for mocking
├── test_client.py          # Tests for SteamWebAPIClient
├── models/                 # Basic model validation tests
└── services/               # Service functionality tests
```

See the dedicated [Backend Testing Strategy](./back-end-context/testing.md) for more details on this simplified approach.

## Error Handling Strategy

### Backend Errors
- Use custom exception classes for key error types
- Implement basic retries for server errors
- Log errors with contextual information
- Return consistent fallback values on failure

### Frontend Errors
- Implement error states for components
- Create user-friendly error messages
- Add simple fallback UI for failed requests

## Development Workflow

1. **Research and Plan**:
   - Analyze API endpoints and response formats
   - Define data models and interfaces
   - Plan component structure and interactions

2. **Backend Implementation**:
   - Create base client and error handling
   - Implement service modules for each API area
   - Add caching for performance
   - Write minimal tests to verify functionality

3. **Frontend Implementation**:
   - Define TypeScript interfaces
   - Create API service functions
   - Build UI components
   - Implement state management

4. **Integration and Testing**:
   - Connect frontend to backend endpoints
   - Test basic user flows
   - Fix critical bugs
   - Ensure reliable endpoint functionality

5. **Documentation**:
   - Update progress tracking
   - Document endpoint interfaces
   - Create usage examples for frontend team

## Development Principles

1. **Functionality First**: Focus on getting core endpoints working reliably
2. **Type Safety**: Use strong typing in both frontend and backend
3. **Basic Error Handling**: Implement reasonable error recovery for common issues
4. **Performance**: Use caching to avoid rate limits and improve speed
5. **User Experience**: Create intuitive UI with appropriate loading and error states
