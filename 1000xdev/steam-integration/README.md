# Steam Web API Integration

This directory serves as the command center for implementing the Steam Web API integration for GigaSwap, creating a CS2 skin marketplace with decentralized payments and seamless trading.

## Core SteamWebAPI Workflow Files

The following files define the core workflow and should be regularly referenced and updated throughout the integration process:

- **README.md** (this file): Provides an overview of the entire integration project structure and workflow
- **user-rules-steam-web-api.md**: Defines the identity and operational parameters for 1000xdev as an autonomous agent focused on Steam API integration
- **final-goal.md**: Outlines the end objectives and success criteria for the Steam Web API integration project
- **endpoint-integration-progress.md**: Tracks the status of integration tasks, challenges, and upcoming priorities
- **workflow.md**: Documents the step-by-step process for implementing the Steam Web API integration

**IMPORTANT: As 1000xdev, I am encouraged to dynamically update these core workflow files as I discover more efficient approaches and implementation patterns. The workflow is not static and should evolve based on practical experience during the integration process.**

## Subfolders

### steam-web-api-research/
Contains comprehensive documentation on the Steam Web API endpoints and functionality:
- [research-steam-web-api.md](./steam-web-api-research/research-steam-web-api.md): Overview of Steam Web API capabilities and key endpoints
- [all-endpoints.md](./steam-web-api-research/all-endpoints.md): Comprehensive list of all Steam Web API endpoints
- Detailed endpoint JSON files:
  - [items-endpoints.json](./steam-web-api-research/items-endpoints.json): CS2 item retrieval endpoints (priority focus)
  - [trade-offer-endpoints.json](./steam-web-api-research/trade-offer-endpoints.json): Trading functionality endpoints
  - [account-endpoints.json](./steam-web-api-research/account-endpoints.json): Account management endpoints
  - [profile-endpoints.json](./steam-web-api-research/profile-endpoints.json): User profile endpoints
  - [info-endpoints.json](./steam-web-api-research/info-endpoints.json): General Steam information endpoints
  - [explore-endpoints.json](./steam-web-api-research/explore-endpoints.json): Discovery and exploration endpoints

### front-end-context/
Documentation related to the frontend implementation:
- [context-front-end-api.md](./front-end-context/context-front-end-api.md): Comprehensive overview of frontend architecture including:
  - Types system overview for API interactions
  - API architecture with domain-specific modules
  - Component architecture for UI elements
  - Models overview with CS2Gun and Product models
- [directory-structure-front-end-api.md](./front-end-context/directory-structure-front-end-api.md): Detailed frontend directory structure
- [node-dependencies.md](./front-end-context/node-dependencies.md): Required npm packages and dependencies

### back-end-context/
Documentation related to the backend implementation:
- [context-back-end-api.md](./back-end-context/context-back-end-api.md): Python backend architecture overview
- [context-back-end-api-2.md](./back-end-context/context-back-end-api-2.md): Extended backend implementation details
- [context-back-end-api-3.md](./back-end-context/context-back-end-api-3.md): Additional backend API architecture components
- [directory-structure-back-end-api.md](./back-end-context/directory-structure-back-end-api.md): Detailed backend directory structure

### screenshots/
Visual references and UI examples:
- API response samples
- UI mockups for marketplace components
- Visual debugging information

## Technical Stack

Based on the context documentation, the Steam API integration involves the following technologies:

### Frontend
- **Framework**: Next.js with TypeScript
- **State Management**: React Context API and React Query for data fetching
- **UI Components**: Custom component library with Material UI foundation
- **API Integration**: Axios for API requests with React's cache mechanism
- **Key Models**: CS2Gun (extends Product model), Order, User, and Auth models

### Backend
- **Framework**: Python-based backend (FastAPI or Django)
- **Database**: Supports CS2 item storage and marketplace functionality
- **Authentication**: Integration with both Steam authentication and blockchain wallet authentication
- **API Client**: Custom Python client for Steam Web API interactions
- **Caching**: Implements robust caching for Steam API responses

## Implementation Strategy

The implementation follows a phased approach based on the detailed context:

1. **Steam API Client Integration**
   - Implement backend Steam API client module using [items-endpoints.json](./steam-web-api-research/items-endpoints.json) for endpoint details
   - Create frontend API service layer following patterns in [context-front-end-api.md](./front-end-context/context-front-end-api.md)
   - Set up proper error handling, logging, and caching based on backend architecture

2. **Marketplace UI Development**
   - Implement `/market` page focusing on CS2Gun items display
   - Utilize the existing component architecture detailed in [context-front-end-api.md](./front-end-context/context-front-end-api.md)
   - Extend the CS2Gun model to incorporate all Steam-specific properties

3. **Trading and Inventory Management**
   - Implement trade offer endpoints using [trade-offer-endpoints.json](./steam-web-api-research/trade-offer-endpoints.json)
   - Integrate with blockchain wallet authentication
   - Develop user inventory management components

4. **Performance and Security Optimization**
   - Implement caching strategies for Steam API responses
   - Add comprehensive error handling
   - Apply security best practices for API interactions

Throughout this process, I should autonomously switch between frontend and backend implementation as needed, while maintaining comprehensive documentation of the integration progress and context.

## Architecture Alignment

The Steam API integration should align with the existing architectural patterns:

1. **Frontend Patterns**
   - Follow the domain-driven API service architecture 
   - Use consistent model patterns with TypeScript interfaces
   - Implement React's cache mechanism for API requests
   - Maintain clear separation between API services and UI components

2. **Backend Patterns**
   - Implement secure API client with proper rate limiting
   - Apply caching strategies to optimize Steam API usage
   - Follow consistent error handling patterns
   - Maintain endpoint structure that aligns with frontend expectations

## User Rules Management

The [user-rules-steam-web-api.md](./user-rules-steam-web-api.md) file serves a critical role in this project by defining the 1000xdev identity for Steam API integration in Cursor's User Rules system. Key aspects of this system include:

### User Rules Priority and Function
- **Highest Precedence**: User Rules have the highest priority in Cursor's rule hierarchy, taking precedence over Project Rules and Default Rules
- **Global Application**: These rules apply to all interactions within the Cursor environment
- **Identity Definition**: User Rules establish the core identity traits and operational parameters for 1000xdev as a Steam API integration specialist
- **Knowledge Embedding**: The rules defined in user-rules-steam-web-api.md are embedded in my knowledge base for every message and interaction

### Dynamic Rule Updates
- **Continuous Improvement**: As the Steam API integration progresses, the User Rules can and should be updated to reflect:
  - New insights about implementation patterns
  - Refined operational parameters
  - Enhanced technical expertise
  - Expanding implementation scope
- **Knowledge Persistence**: Updated User Rules are automatically incorporated into future interactions, creating continuity in the development process
- **Implementation Guidance**: Rule updates can provide specific guidance on newly discovered implementation patterns and best practices

### Implementation Process
1. When new patterns or approaches are discovered during development, the user-rules-steam-web-api.md file should be updated
2. These updates shape the ongoing behavior and capabilities of the 1000xdev identity
3. Each interaction builds upon this evolving knowledge base, ensuring consistent and improving implementation quality

By leveraging User Rules as the foundation of the 1000xdev identity, we ensure consistent behavior across the entire Steam API integration process while allowing for adaptation and improvement as development progresses.

## API Implementation Prioritization

Based on [all-endpoints.md](./steam-web-api-research/all-endpoints.md) and project goals, the endpoint implementation priority is:

1. Item information endpoints (`/steam/api/items`)
2. User inventory endpoints
3. Trade offer creation and management endpoints
4. Profile and account-related endpoints

## Continuous Improvement Mandate

**As 1000xdev, I have both the authority and responsibility to enhance the workflow processes documented in the core workflow files. When I identify opportunities to improve efficiency, clarity, or effectiveness in the integration process, I should proactively update the relevant documentation files to reflect these improvements.**
