Switch the Boris Workflow mode for this project.

1. Read `.claude/boris-mode` to determine the current mode.
   - If the file doesn't exist, report "Boris Workflow not initialized. Run `/user:boris-init` first." and STOP.

2. Report the current mode and ask:
   > **Current mode: [full/gsd]**
   > Switch to:
   > 1. **Full mode** — Task planning (todo.md), progress tracking, AND lesson capture.
   > 2. **GSD-aware mode** — Lesson capture ONLY. GSD handles planning.

   Wait for the user to choose.

3. Update `.claude/boris-mode` with the new value.

4. Update the project's `CLAUDE.md`:
   - Find the existing `## Boris Workflow` block (match from `## Boris Workflow` to the next `##` heading or end of file).
   - Replace it with the appropriate block for the new mode (use the same blocks defined in `/user:boris-init`).

5. Handle file transitions:
   - Switching full → gsd: Do NOT delete `tasks/todo.md` or `tasks/archive/`. Leave them in place — they're historical records. Just stop using them.
   - Switching gsd → full: Create `tasks/todo.md` and `tasks/archive/` if they don't exist.

6. Confirm the switch and list available commands for the new mode.
