We are going to systematically update the rules to align with new cursor updates:

Starting with the docs for /chat
(will have the docs in the Context Pills)

https://docs.cursor.com/chat/overview
https://docs.cursor.com/chat/agent
https://docs.cursor.com/chat/ask
https://docs.cursor.com/chat/custom-modes
https://docs.cursor.com/chat/tools
https://docs.cursor.com/chat/apply


1. For custom-modes, we want to create custom-modes to enhance our workflow types. We will be creating custom-modes for each workflow type. We will start with rules-workflow first.

2. For tools, I noticed that the Read File can only read up to 750 lines in max mode and 250 lines in other modes. We will mostly be using other modes. This is an issue because I see most times that when you read a file, you only read 250 lines. We need some type of "Always" rule system so that you first see how many lines there are in the file, then you run functions to read every single line. It is of utmost importance to read every single line. 

2.a. For plan-mode, you need to update the rules so that the plan-mode files are only 250 lines are less. This is to retain good concise context. There should also be some type of intelligence so that if you feel like the requirements are too complex, the plan will be split up into multiple planning folders. 