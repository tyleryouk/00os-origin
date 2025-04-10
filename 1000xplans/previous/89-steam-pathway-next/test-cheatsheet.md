# Test Cheatsheet: Steam Web API Integration

This document provides a comprehensive set of test scenarios and verification approaches for the Steam Web API integration.

## Authentication Testing

### 1. Steam Login Flow

**Test Scenario**:
```
- User clicks "Login with Steam" button
- User is redirected to Steam login page
- User enters credentials and authorizes GigaSwap
- User is redirected back to GigaSwap with auth token
- GigaSwap validates token and creates session
- User sees authenticated state
```

**Verification Points**:
- Successful redirect to Steam
- Proper token handling
- Correct session creation
- Appropriate UI state changes
- Error handling for declined authorization

**UX Situation Command**:
```
recreate-ux-situation: Test Steam login flow - user completes authentication successfully
```

### 2. Session Management

**Test Scenario**:
```
- User has existing authenticated session
- User refreshes page
- Session is maintained
- User can access authenticated features
```

**Verification Points**:
- Session persistence
- Token refresh functionality
- Proper handling of expired sessions
- Security validation

**UX Situation Command**:
```
recreate-ux-situation: Test Steam session persistence across page refreshes
```

### 3. Authentication Error Handling

**Test Scenario**:
```
- User starts authentication flow
- Authentication process is interrupted or fails
- GigaSwap shows appropriate error message
- User can retry authentication
```

**Verification Points**:
- Graceful error handling
- User-friendly error messages
- Recovery options
- Security handling of failed auth

**UX Situation Command**:
```
recreate-ux-situation: Test Steam authentication error handling when auth flow is interrupted
```

## Inventory Testing

### 1. Inventory Loading

**Test Scenario**:
```
- Authenticated user visits inventory page
- System loads user's Steam CS2 inventory
- Items display with proper information
- Loading states are properly shown
```

**Verification Points**:
- Correct data fetching
- Progressive loading behavior
- Empty state handling
- Performance metrics

**UX Situation Command**:
```
recreate-ux-situation: Test Steam inventory loading for authenticated user
```

### 2. Inventory Filtering and Search

**Test Scenario**:
```
- User has loaded inventory
- User filters by item type
- User searches for specific item
- Results update in real-time
```

**Verification Points**:
- Filter accuracy
- Search responsiveness
- Combined filter and search
- Empty results handling

**UX Situation Command**:
```
recreate-ux-situation: Test Steam inventory filtering and search functionality
```

### 3. Inventory Caching

**Test Scenario**:
```
- User loads inventory for the first time (cold cache)
- User navigates away from inventory
- User returns to inventory (cached load)
- User manually refreshes inventory
```

**Verification Points**:
- Initial load time
- Cached load time
- Cache invalidation
- Refresh behavior

**UX Situation Command**:
```
recreate-ux-situation: Test Steam inventory caching and refresh behavior
```

## Market Data Testing

### 1. Item Price Display

**Test Scenario**:
```
- User views item in inventory
- System displays current market price
- User clicks for price history
- Price history chart displays
```

**Verification Points**:
- Accurate price data
- Proper formatting
- Currency handling
- History visualization

**UX Situation Command**:
```
recreate-ux-situation: Test Steam market price display for inventory items
```

### 2. Market Listings View

**Test Scenario**:
```
- User navigates to market listings
- System displays available market listings
- User filters listings by price
- User sorts listings by various criteria
```

**Verification Points**:
- Listing accuracy
- Filter functionality
- Sort functionality
- Pagination behavior

**UX Situation Command**:
```
recreate-ux-situation: Test Steam market listings view with filtering and sorting
```

### 3. Price Alert Creation

**Test Scenario**:
```
- User selects item for price alert
- User sets target price
- System confirms alert creation
- Alert triggers when condition is met
```

**Verification Points**:
- Alert creation flow
- Validation of inputs
- Alert persistence
- Notification system

**UX Situation Command**:
```
recreate-ux-situation: Test Steam price alert creation and management
```

## Trading Testing

### 1. Trade Offer Creation

**Test Scenario**:
```
- User selects items to trade
- User creates trade offer
- System validates trade
- Trade offer is created
```

**Verification Points**:
- Item selection UI
- Validation logic
- Creation confirmation
- Error handling

**UX Situation Command**:
```
recreate-ux-situation: Test Steam trade offer creation process
```

### 2. Trade Status Tracking

**Test Scenario**:
```
- User has active trade offers
- User views trade status
- System updates status in real-time
- User can cancel pending trades
```

**Verification Points**:
- Status accuracy
- Real-time updates
- Cancellation flow
- Historical view

**UX Situation Command**:
```
recreate-ux-situation: Test Steam trade status tracking and management
```

### 3. Trade Completion

**Test Scenario**:
```
- Trade offer is accepted
- System processes completed trade
- Inventory is updated
- Trade history records transaction
```

**Verification Points**:
- Completion handling
- Inventory sync
- Transaction recording
- Notification system

**UX Situation Command**:
```
recreate-ux-situation: Test Steam trade completion and inventory synchronization
```

## Integration Testing

### 1. Authentication to Inventory Flow

**Test Scenario**:
```
- New user logs in with Steam
- System immediately loads their inventory
- User can view and interact with items
```

**Verification Points**:
- End-to-end flow
- Performance metrics
- State management
- Error recovery

**UX Situation Command**:
```
recreate-ux-situation: Test end-to-end flow from Steam login to inventory viewing
```

### 2. Inventory to Trading Flow

**Test Scenario**:
```
- User selects items from inventory
- User initiates trade process
- System creates valid trade offer
```

**Verification Points**:
- Component interaction
- Data consistency
- State transitions
- User experience

**UX Situation Command**:
```
recreate-ux-situation: Test flow from inventory selection to trade creation
```

### 3. Market to Inventory to Trading Flow

**Test Scenario**:
```
- User monitors market prices
- User checks inventory items
- User creates trade based on market value
```

**Verification Points**:
- Cross-feature integration
- Data consistency
- Performance impact
- User experience

**UX Situation Command**:
```
recreate-ux-situation: Test comprehensive flow from market analysis to trade execution
```

## Performance Testing

### 1. Inventory Load Performance

**Test Metrics**:
- Initial load time: < 2 seconds
- Cached load time: < 500ms
- Memory usage
- Network requests

**Verification Script**:
```typescript
// Measure inventory load performance
console.time('inventoryLoad');
// Load inventory
console.timeEnd('inventoryLoad');
```

### 2. Market Data Refresh Performance

**Test Metrics**:
- Data refresh time: < 1 second
- Update frequency
- Backend API call efficiency
- UI update performance

**Verification Script**:
```typescript
// Measure market data refresh performance
console.time('marketRefresh');
// Refresh market data
console.timeEnd('marketRefresh');
```

### 3. Trading Operation Performance

**Test Metrics**:
- Trade creation time: < 3 seconds
- Validation time
- Confirmation time
- Transaction recording time

**Verification Script**:
```typescript
// Measure trade operation performance
console.time('tradeOperation');
// Execute trade operation
console.timeEnd('tradeOperation');
```

## Error Scenario Testing

### 1. Steam API Unavailability

**Test Scenario**:
```
- Steam API becomes unresponsive
- System detects timeout
- User sees appropriate error
- System implements retry logic
```

**Verification Points**:
- Error detection
- User notification
- Graceful degradation
- Recovery approach

**UX Situation Command**:
```
recreate-ux-situation: Test system behavior when Steam API is unavailable
```

### 2. Authentication Failure Recovery

**Test Scenario**:
```
- Authentication token becomes invalid
- System detects authentication failure
- User is prompted to re-authenticate
- Session is properly reset
```

**Verification Points**:
- Failure detection
- Security handling
- User experience
- Data protection

**UX Situation Command**:
```
recreate-ux-situation: Test authentication failure recovery flow
```

### 3. Network Interruption Handling

**Test Scenario**:
```
- Network connection is interrupted during operation
- System detects connectivity issue
- Operation is paused or saved
- System recovers when connection returns
```

**Verification Points**:
- Interruption detection
- Data preservation
- Recovery process
- User experience

**UX Situation Command**:
```
recreate-ux-situation: Test system behavior during network interruption
```

## Security Testing

### 1. Authentication Token Handling

**Security Checks**:
- Tokens stored securely
- No token exposure in URLs
- Proper token validation
- Token refresh mechanism
- Token revocation on logout

**Verification Approach**:
- Code review of token handling
- Network request analysis
- Storage inspection

### 2. Trade Security Validation

**Security Checks**:
- Trade validation logic
- Verification steps
- Fraud prevention
- Rate limiting

**Verification Approach**:
- Security review of trade process
- Attempt manipulated trades
- Test validation bypass scenarios

### 3. API Request Security

**Security Checks**:
- Request authentication
- CSRF protection
- Rate limiting
- Input validation

**Verification Approach**:
- API request analysis
- Security headers verification
- Input fuzzing tests 