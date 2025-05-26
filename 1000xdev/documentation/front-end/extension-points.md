# Front-End Extension Points


This document describes where and how to add new features, modules, or integrations to the GigaSwap front-end. It is concise, self-contained, and directly relevant to front-end extension work.

## Adding New Features or Modules
- Create new component directories in `components/` for feature-specific UI.
- Implement models in `models/` for new business entities.
- Add API client functions in `api/` for new endpoints or integrations.
- Create new routes in `app/` for new pages or flows.
- Use the `hooks/` directory for reusable logic.

## Integrating External APIs or Services
- Follow the API client pattern for external APIs.
- Use React Query or SWR for data fetching and caching.
- Implement appropriate TypeScript interfaces for new data.
- Use the mock system for rapid development and testing of new API features.

## Extending UI Components
- Extend the UI component library in `components/ui/` for reusable elements.
- Use composition to create feature-specific components.

## Steam and Marketplace Integration
- Extend the CS2Gun model and related components for Steam/CS2 features.
- Add or update API modules for Steam or marketplace endpoints as needed.

---
This document is updated as extension points evolve. Remove or revise any section not directly relevant to the current cycle. 