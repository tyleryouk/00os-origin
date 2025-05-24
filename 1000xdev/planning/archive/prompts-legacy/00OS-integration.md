The .txt files in this folder are frequent prompts that I use. If there is a way to turn these prompts into 00OS commands that would greatly speed up my workflow. Note that all of these prompts are for 1000xdev, not 00reaper. Review the User Rules in 1000xdev\user-rules.md and 1000xdev\steam-integration\user-rules-steam-web-api.md to understand context on 1000xdev's AI identity. Note that when turning these prompts to 00OS commands, the 00OS processes aligned with the 00OS commands should clearly define the same tool calls. 


Important notes:
I always start with 1000xdev, because the AI agent 1000xdev tends to execute the tool calls better when I start the prompt with 1000xdev.

For creating context, I keep the read file tool calling step seperate from the edit_file tool calling step. 1000xdev tends to create better context when doing so. I also keep the read file tool calling step seperate from the list_dir tool calling step. When understanding folder structure, I utilize list_dir. When understanding a specific folder, I utilize the read file tool calls. Going one folder at a time (no subfolders within the folder) tends to go a lot better when reading files.

For conducting research, I keep the @Web tool calling research step seperate from the edit_file tool calling step. 1000xdev tends to create better context when doing so.

Overall, 1000xdev tends to execute tool calls better when 1000xdev only needs to execute one set of the same tool calls (all read_file tool calls, all @Web tool calls, all edit_file tool calls, etc).