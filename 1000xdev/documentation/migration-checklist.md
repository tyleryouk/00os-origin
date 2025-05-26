# Documentation Migration Checklist

> **Purpose:** This checklist tracks the migration of all documentation files from legacy folders (e.g., front-end-architecture/, back-end-architecture/, full-stack-workflow/) to the new modular documentation structure. Mark each file as migrated when its content has been moved and verified in the new location.

## Migrated in this cycle

### front-end/
- [x] overview.md ← front-end-architecture/front-end-overview.md
- [x] context.md ← front-end-architecture/front-end-context.md
- [x] dependencies.md ← front-end-architecture/front-end-dependencies.md
- [x] standards.md ← full-stack-workflow/full-stack-standards.md, full-stack-workflow/front-end-development.md
- [x] testing-logging.md ← full-stack-workflow/front-end-development.md
- [x] extension-points.md ← front-end-architecture/front-end-overview.md, full-stack-workflow/front-end-development.md

### back-end/
- [x] overview.md ← back-end-architecture/back-end-overview.md
- [x] context.md ← back-end-architecture/back-end-context.md
- [x] dependencies.md ← back-end-architecture/back-end-dependencies.md
- [ ] standards.md ← full-stack-workflow/full-stack-standards.md, full-stack-workflow/back-end-development.md
- [ ] testing-logging.md ← full-stack-workflow/back-end-development.md
- [ ] extension-points.md ← back-end-architecture/back-end-overview.md, full-stack-workflow/back-end-development.md

### full-stack/
- [ ] standards.md ← full-stack-workflow/full-stack-standards.md
- [ ] integration.md ← full-stack-workflow/README.md, integration-related sections of full-stack-standards.md

### integration/
- [ ] steam.md ← integration/steam.md, steam-related sections of full-stack-workflow/ _(currently empty, to be filled in a future cycle)_
- [ ] marketplace.md ← integration/marketplace.md, marketplace-related sections of full-stack-workflow/ _(currently empty, to be filled in a future cycle)_
- [ ] external-apis.md ← integration/external-apis.md, API-related sections of full-stack-workflow/ _(currently empty, to be filled in a future cycle)_

### onboarding/
- [ ] getting-started.md ← onboarding/workflow-checklists.md, onboarding/getting-started.md, onboarding and workflow sections in previous documentation _(currently empty, to be filled in a future cycle)_
- [ ] workflow-checklists.md ← onboarding/workflow-checklists.md, onboarding/getting-started.md, onboarding and workflow sections in previous documentation _(currently empty, to be filled in a future cycle)_

## To be filled in a future cycle (add to TODO.md)

### front-end/
- [ ] README.md

### back-end/
- [ ] README.md

### full-stack/
- [ ] README.md

### integration/
- [ ] README.md _(currently empty)_
- [ ] steam.md _(currently empty)_
- [ ] marketplace.md _(currently empty)_
- [ ] external-apis.md _(currently empty)_

### onboarding/
- [ ] README.md _(currently empty)_
- [ ] getting-started.md _(currently empty)_
- [ ] workflow-checklists.md _(currently empty)_

---
Add new checklist items as additional legacy files or folders are identified. If subfolders exist, add them and their files to this checklist. Only mark a file as migrated when its content is fully moved and verified in the new structure. 