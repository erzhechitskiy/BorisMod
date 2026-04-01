## Pre-flight check

Read `.claude/boris-mode` if it exists.
- If it contains `gsd`: respond with "This project uses GSD-aware mode. Progress tracking is handled by GSD — use GSD's own status or verification commands instead. To check lessons learned, use `/user:boris-audit`." Then STOP.
- If it contains `full` or the file doesn't exist: proceed below.

## Status report

Read `tasks/todo.md` and give a brief status report:

1. Current task block: title and date
2. Progress: X of Y items complete
3. What's currently in progress or next up
4. Any items that look stale or blocked
5. If ALL items in the current block are done:
   - Summarize results
   - Ask if I want to archive this task block to `tasks/archive/YYYY-MM.md`

Keep the report compact — no more than 10 lines.
