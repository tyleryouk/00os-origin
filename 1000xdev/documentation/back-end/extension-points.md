# Back-End Extension Points

> **[Migrated from back-end-architecture/back-end-overview.md and full-stack-workflow/back-end-development.md, 2024-06-11]**

This document describes where and how to add new features, modules, or integrations to the GigaSwap back-end. It is concise, self-contained, and directly relevant to back-end extension work.

## Adding New Features or Modules
- Create a new module in the `app/` directory for new API features.
- Implement models, routes, and services following the standard module structure.
- Register new routers in `main.py` for new endpoints.
- Use dependency injection for testability and maintainability.

## Integrating External APIs or Services
- Follow the client pattern for external APIs.
- Implement integrations in dedicated modules.
- Use dependency injection for testability.
- Use mock services and dependency overrides for testing.

## Extending Database or Caching
- Add new models to `gigaland_database/` for new entities.
- Implement new repository classes for data access.
- Use Redis or other caching strategies as needed.

## Steam and Marketplace Integration
- Extend Steam or marketplace modules for new features.
- Add or update API endpoints and services as needed.

---
This document is updated as extension points evolve. Remove or revise any section not directly relevant to the current cycle. 