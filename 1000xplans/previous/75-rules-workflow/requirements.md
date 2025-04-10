Intelligently optimize the usage of templates.

This is a new folder you created on the last implementation. It is not correctly documented in the README.md files. Additionally, it will likely be best if we move the /templates folder to one of the original folders:
/core
/knowledge
/workflows
/parameters

You also need to move cross-references.md


The only folders you can edit are `core` (Always Rule Types), `knowledge` (Agent Requested Rule Types), `parameters` (Manual Rule Types) and `workflows` (Auto Attached Rule Types).

Creating cross-references.md and the knowledge folder was a hallucination on your end during rules-workflow. Edit rules-workflow so that it is more strict AND concise. The hallucinations are likely rising from a lot of workflow-specific files (in workflows/rules-workflow) and a lot of rules in /core. You are only able to process so much information at a time.

