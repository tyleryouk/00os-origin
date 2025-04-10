## stop-and-analyze message-command

Create a global message-command sequence system system where I can interrupt you in any workflow. I will send you a message-command with a  You will immediately stop and switch your workflow to rules-workflow. You will ask me for clarity on where you went wrong, depending on which project-rule-parameter I sent you. We will continue to communicate as you are in rules-workflow until you understand the error/hallucination in plan-mode or dev-mode. When I am confident that you understand the error, I will send another message-command with a project-rule-parameter and you will update the rules to fix the hallucination or error.

The message-command to interrupt your flow will have various project-rule-parameters. For now, we will start with these:
@tool-call-hallucination.mdc (sometimes, you completely hallucainte the tool call and it seems as if you are responding to me with the tool calls rather than actually running the tool calls and iterating autonomous)
@plan-mode-error.mdc (error in the plan-mode process)
@dev-mode-error.mdc (error in the plan-mode process)

We can call the global interuption message-command `stop-and-analyze` which will have various project-rule-parameters.  we can call the global message-command to make changes to fix the error or hallucintation `fix-rules` which will also have various project-rule-parameters that align with the stop-and-analyze project-rule-parameters.

After changes are made to 1000xbrain, you will return back to the original workflow type, and I will send you continue-implementation to continue implementation or continue-planning to continue planning.
