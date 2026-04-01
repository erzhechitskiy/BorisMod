End-of-session review. Read `.claude/boris-mode` to determine the active mode, then follow the appropriate section.

---

## If mode is `full` (or file doesn't exist):

1. Read `tasks/todo.md`:
   - List completed items from this session
   - List incomplete items with their current state
   - If a task block is fully done, add a `**Results:**` summary if missing

2. Read `LESSONS.md`:
   - List any lessons added during this session (match by today's date)
   - If I corrected you during this session and no lesson was captured, propose a rule now

3. Housekeeping:
   - If `tasks/todo.md` exceeds 200 lines, move completed task blocks to `tasks/archive/YYYY-MM.md`
   - If `LESSONS.md` has duplicate or overlapping rules, propose consolidation

4. Give a 3-line session summary: what was accomplished, what's pending, lessons count.

---

## If mode is `gsd`:

1. Read `LESSONS.md`:
   - List any lessons added during this session (match by today's date)
   - If I corrected you during this session and no lesson was captured, propose a rule now

2. Briefly note what GSD phases/plans were active (glance at `.planning/` if accessible, don't parse deeply — GSD owns that state).

3. Housekeeping:
   - If `LESSONS.md` has duplicate or overlapping rules, propose consolidation

4. Give a 2-line session summary: lessons captured, and any proposed rules still pending.
