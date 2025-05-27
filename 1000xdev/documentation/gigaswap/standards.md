# Full-Stack Standards

> **[Migrated from full-stack-workflow/full-stack-standards.md, 2024-06-11]**

This document defines shared standards, best practices, and architectural principles that apply to both front-end and back-end development in the GigaSwap project. It is concise, self-contained, and directly relevant to full-stack tasks.

## Code Organization
- Organize code by feature/domain for both front-end and back-end.
- Use composition and modularity to maximize reusability.
- Separate concerns (UI, business logic, data access).

## Type Safety
- Use TypeScript (front-end) and type annotations/Pydantic (back-end).
- Define interfaces for all data structures and services.
- Use strict type checking and document complex types.

## API Design
- Use consistent resource naming and standard HTTP methods.
- Implement pagination for list endpoints.
- Document all endpoints with OpenAPI.
- Maintain backward compatibility and document breaking changes.

## Error Handling
- Use consistent error codes and standardized error response formats across stack.
- Implement proper error boundaries and fallbacks.
- Log errors with appropriate context and provide user-friendly error messages.

## Performance Optimization
- Implement code splitting, lazy loading, and caching where appropriate.
- Optimize database queries and use async operations for I/O-bound tasks.
- Monitor and optimize bundle size and memory usage.

## Workflow Integration
- Use feature branches and descriptive commit messages.
- Run tests and linters automatically on PR creation.
- Update documentation with code changes.
- Implement application performance monitoring and error tracking.

## Data Flow & Integration
- Maintain consistent data models between front-end and back-end.
- Use type generators or shared types where possible.
- Implement clear serialization/deserialization patterns.

## Authentication
- Implement JWT-based authentication and consistent token handling across stack.
- Secure all sensitive API endpoints and handle authentication errors gracefully.

## Feature Flags
- Use consistent feature flag implementation across stack.
- Document feature flag usage and test both enabled and disabled states.

## Terminal Context & Application Runtime Protocol

**CRITICAL: Tyler Youk manages all application runtime**

### Application Runtime Boundaries
- **Frontend**: Always running on http://localhost:3000/ (Tyler manages via @node terminal)
- **Backend**: Always running on http://127.0.0.1:8000/ (Tyler manages via @uvicorn terminal)
- **1000xdev**: Code implementation and documentation only
- **Tyler**: All application startup, shutdown, and runtime management

### Prohibited Actions for 1000xdev
- **NEVER** use `npm run dev`, `npm start`, `npm run build`, `uvicorn`, or similar runtime commands
- **NEVER** attempt to start, stop, restart, or build applications
- Applications are always running when Tyler provides context

### Terminal Context Usage
- Tyler provides @node and @uvicorn terminal outputs for debugging context
- Use terminal logs to understand current application state before making changes
- Reference error logs and API responses to validate implementation correctness

---
This document is updated as standards evolve. Remove or revise any section not directly relevant to the current cycle. 