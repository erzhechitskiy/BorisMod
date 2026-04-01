Initialize the Boris Cherny task tracking workflow for this project.

## Step 1: Detect environment

Check if any of these exist in the project root:
- `.planning/` directory
- Any `/gsd:*` command files in `.claude/commands/`
- A `gsd-tools.cjs` file anywhere under `.claude/`

If ANY of these exist, report: "GSD framework detected." and recommend GSD-aware mode.
If NONE exist, recommend Full mode.

Then ask the user:

> **Which mode should I enable?**
> 1. **Full mode** — Task planning (todo.md), progress tracking, AND lesson capture. Use this if you are NOT using GSD or another planning framework.
> 2. **GSD-aware mode** — Lesson capture ONLY. Skips todo.md planning and status tracking since GSD handles that. Adds self-improvement rules that complement GSD's workflow.

Wait for the user to choose before proceeding.

## Step 2: Write mode config

Create `.claude/boris-mode` containing exactly one word: `full` or `gsd` (based on choice).

## Step 3: Create shared files (both modes)

Create `LESSONS.md` in the project root if it doesn't exist:

```
# Lessons Learned

<!-- Read at session startup. Write a new rule after every correction. -->
<!-- Format: - **[YYYY-MM-DD]** category: description -->
<!-- Categories: code-style | architecture | testing | tooling | domain | process -->
```

## Step 4a: Full mode — create tracking files

Only if the user chose Full mode:

Create `tasks/todo.md` if it doesn't exist:

```
# Task Tracker

<!-- Active tasks below. Archive completed blocks to tasks/archive/ -->
<!-- Format: ## Task: <title> (YYYY-MM-DD) -->
<!-- Items: - [ ] pending, - [x] complete, - [-] skipped -->
<!-- Results: summarize at end of each task block -->
```

Create `tasks/archive/` directory if it doesn't exist.

## Step 4b: GSD-aware mode — no tracking files

Skip todo.md and tasks/ entirely. GSD owns planning via `.planning/`.

## Step 5: Append workflow rules to CLAUDE.md

Check if the project's `CLAUDE.md` already contains "Boris Workflow". If it does, stop and report "Boris Workflow rules already present in CLAUDE.md — skipping." Otherwise, append the appropriate block:

### If Full mode, append:

```
## Boris Workflow (full mode)

### Session startup:
- Read `LESSONS.md` (project root) and `~/.claude/LESSONS.md` (global) if they exist.

### Before starting a task (when /user:boris-plan is used OR task has 3+ steps):
1. Write a structured plan to `tasks/todo.md` under a new `## Task: <title> (YYYY-MM-DD)` heading.
2. Use checkbox format: `- [ ]` pending, `- [x]` done, `- [-]` skipped.
3. If the user invoked /user:boris-plan, read the plan back and wait for confirmation.
4. If the user gave a direct instruction without /user:boris-plan, write the plan and proceed without blocking.

### While working:
5. Mark items `[x]` in `tasks/todo.md` as you complete them.
6. After each meaningful change, give a one-line explanation of what changed and why.

### After completion:
7. Append a `**Results:**` line at the end of the task block summarizing outcomes.

### After ANY correction or mistake:
8. Append a rule to `LESSONS.md` that prevents the same class of mistake.
   Format: `- **[YYYY-MM-DD]** category: description`
   Only append to `~/.claude/LESSONS.md` if the lesson is universal (not project-specific).
9. For minor typo-level fixes, batch them — don't write a lesson for every trivial correction.

### Maintenance:
- After /compact, re-read `tasks/todo.md` and `LESSONS.md` to restore context.
- If `tasks/todo.md` exceeds 200 lines, move completed task blocks to `tasks/archive/YYYY-MM.md`.
```

### If GSD-aware mode, append:

```
## Boris Workflow (GSD-aware mode)

### Session startup:
- Read `LESSONS.md` (project root) and `~/.claude/LESSONS.md` (global) if they exist.
- Apply relevant lessons as constraints for the current session.
- Do NOT create or manage tasks/todo.md — GSD owns planning via .planning/.

### While working (direct interaction, not GSD subagents):
- After each meaningful change, give a one-line explanation of what changed and why.
  This aids real-time error catching and produces better context for lesson capture.

### After ANY correction or mistake:
1. Identify the root cause (the assumption or missing knowledge, not the surface symptom).
2. Append a rule to `LESSONS.md` that prevents the same CLASS of mistake.
   Format: `- **[YYYY-MM-DD]** category: description`
   Only append to `~/.claude/LESSONS.md` if the lesson is universal (not project-specific).
3. For minor typo-level fixes, batch them — don't write a lesson for every trivial correction.

### After /compact:
- Re-read `LESSONS.md` to restore learned constraints.

### What this workflow does NOT do (GSD handles these):
- Task planning and breakdown — use /gsd:* commands
- Progress tracking — GSD manages .planning/ state
- Verification — GSD has its own verify phase
```

## Step 6: Confirm

Report what was created, which mode was set, and list available commands:
- Full mode: `/user:boris-plan`, `/user:boris-lesson`, `/user:boris-status`, `/user:boris-review`, `/user:boris-audit`
- GSD-aware mode: `/user:boris-lesson`, `/user:boris-review`, `/user:boris-audit`
