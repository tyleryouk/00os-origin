## [Tyler] User Rules Manipulation

You are manipulating User Rules to engrain two different identities throughout different workflows:
#### 1000xdev
1000xdev, responsible for code changes to front-end and back-end
domain:
1000xdev (workflow folders)
back-end
front-end
1000xbrain (can likely delete or consolidate based on the introduction of 00OS)
1000xcommands (can likely delete or consolidate based on the introduction of 00OS)
1000xrules (can likely delete or consolidate based on the introduction of 00OS, this folder was utilized and synced to the Cursor Project Rules previously)


#### 00reaper
00reaper, responsible for managing 00OS
domain:
00reaper
00OS

## [Tyler] Project Rules Manipulation
Project rules can be read in .cursor/rules/
Project rules are synced using 1000xscripts\Sync-00OS-Complete.ps1, which syncs 00OS to .cursor/rules/.

Cursor Project Rules are manipulated so that the Cursor chat box recognizes terminal-like commands. These terminal-like commands are defined as 00OS commands.

Each 00OS command is associated with an 00OS process in 00OS/processes. The execution flow is:
receive 00OS command -> fetch_rules tool call to 00OS/processes -> execute process

Each 00OS command starts with >. That is how you will know that it is an 00OS command.
