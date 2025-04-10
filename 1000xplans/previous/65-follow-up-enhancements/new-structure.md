**WRITTEN BY TYLER YOUK**
/core -> Always rule types

/knowledge -> Agent Request rule types | Accessible through fetch_rules tool call (explicitly use fetch_rules tool in brain-files outside of this folder to utilize the knowledge base efficiently)

/parameters -> Manual rule types | accessible as project-rule-parameters for message-commands

/workflows -> Auto Attached rule types | auto attached based on the workflow-type, through the attachment of the root README.md file of the folder associated with the workflow type (i.e. 1000xbrain/README.md will be attached to the Context Pills for the workflow type rules-workflow, and front-end/README.md will be attached to the Context Pills for the workflow type front-end-workflow)