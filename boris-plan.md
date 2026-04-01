## Pre-flight check

Read `.claude/boris-mode` if it exists.
- If it contains `gsd`: respond with "This project uses GSD-aware mode. Task planning is handled by GSD — use `/gsd:new-milestone` or `/gsd:quick` instead. If you want to switch to full Boris tracking, run `/user:boris-init` again." Then STOP.
- If it contains `full` or the file doesn't exist: proceed below.

## Create task plan

1. Read `LESSONS.md` (project root) and `~/.claude/LESSONS.md` (global) if they exist. Apply relevant lessons to your plan.
2. Read `tasks/todo.md` to check for any in-progress work that might relate.
3. Break the task into discrete, verifiable steps. Each step should be:
   - Small enough to complete and verify independently
   - Ordered by dependency
   - Specific enough that "done" is unambiguous
4. Write the plan to `tasks/todo.md` under a new heading: `## Task: <title> (YYYY-MM-DD)`
5. Use checkbox format: `- [ ]` for each step.
6. Read the plan back to me and WAIT for my confirmation before doing anything.

Task: $ARGUMENTS
