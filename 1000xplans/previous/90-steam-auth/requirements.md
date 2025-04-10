# back-end-workflow | steam-web-api

## Overview

The GigaSwap platform will implement Steam authentication as the primary user authentication system. The existing crypto-based authentication will be isolated to trading platform functionality only.

### Key Architectural Decisions
- Steam authentication will handle user profiles and identity
- Crypto wallet authentication will be used ONLY for trading platform fund transfers
- Polygon wallet addresses will NOT be associated with user accounts
- Clear separation between Steam auth and crypto auth systems

## Core Requirements

### Steam OpenID Authentication
- [ ] Implement Steam OpenID authentication flow
- [ ] Create secure session management system
- [ ] Handle Steam login callback and validation
- [ ] Store and manage Steam user data securely
- [ ] Implement secure logout functionality

### User Management
- [ ] Create/update user profiles based on Steam data
- [ ] Store essential Steam user information (ID, username, avatar)
- [ ] Handle user session persistence
- [ ] Implement user profile update mechanisms
- [ ] Support user account linking/unlinking

### Security Requirements
- [ ] Implement secure API key management for Steam Web API
- [ ] Add CSRF protection for authentication endpoints
- [ ] Create rate limiting for auth-related endpoints
- [ ] Add request validation and sanitization
- [ ] Implement secure session token management

### API Endpoints
- [ ] POST /api/auth/steam/login - Initiate Steam login
- [ ] GET /api/auth/steam/callback - Handle Steam OpenID callback
- [ ] POST /api/auth/steam/logout - Handle user logout
- [ ] GET /api/auth/steam/status - Check authentication status
- [ ] GET /api/auth/steam/user - Get current user data

### Error Handling
- [ ] Handle Steam API errors gracefully
- [ ] Provide clear error messages for failed authentication
- [ ] Implement retry mechanisms for transient failures
- [ ] Log authentication errors for monitoring
- [ ] Handle edge cases (API downtime, invalid responses)

## Success Criteria
1. Users can successfully authenticate using their Steam accounts
2. Steam user data is correctly stored and managed
3. Clear separation between Steam and crypto authentication systems
4. Secure session management with proper token handling
5. Robust error handling and monitoring

## Technical Constraints
- Must use FastAPI for API implementation
- Must follow Steam Web API best practices
- Must implement proper rate limiting
- Must use secure session management
- Must maintain clear separation from crypto authentication

## Next Steps
After completing the back-end implementation:
1. Create a new planning folder for front-end Steam authentication called 91-steam-auth-front-end in planning/**
2. Implement front-end authentication flow separately
3. Ensure complete separation between Steam and crypto auth pathways
4. Ensure you make more than enough tool calls to understand the current steam and crypto auth pathways
5. In the new planning folder, ask me to add the json files to the planning folder @