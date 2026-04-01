# Claude Code + BorisMod + GSD — Workflow Cheatsheet

## The 3-Layer Stack

| Layer | Tool | Owns | Key Files |
|-------|------|------|-----------|
| **Runtime** | **Claude Code** | CLI, tools, hooks, context | `~/.claude/CLAUDE.md`, `settings.json` |
| **Planning** | **GSD** | Project breakdown, execution, verification | `.planning/` directory |
| **Learning** | **BorisMod** | Persistent lessons from corrections | `LESSONS.md`, `.claude/boris-mode` |

They don't share state — they coexist through file-based conventions and mode detection.

---

## Example 1: Mini-Project Bootstrap (new TODO API)

```
# ── Step 1: Create project & init GSD ──────────────────
cd ~/projects/todo-api && git init

/gsd:new-project
# → Interactive Q&A about what you're building
# → Creates: .planning/PROJECT.md, REQUIREMENTS.md, ROADMAP.md, STATE.md
# → Roadmap might have phases like:
#   Phase 1: Core data model & CRUD
#   Phase 2: Auth middleware
#   Phase 3: Filtering & pagination

# ── Step 2: Add Boris learning layer ───────────────────
/boris-init
# → Detects .planning/ → recommends "GSD-aware" mode
# → Creates: LESSONS.md, .claude/boris-mode (contains "gsd")
# → Appends workflow block to CLAUDE.md

# ── Step 3: Work through Phase 1 ──────────────────────
/gsd:discuss-phase 1          # Lock in decisions (DB choice, ORM, etc.)
/gsd:plan-phase 1             # Creates PLAN.md with task breakdown
/gsd:execute-phase 1          # Spawns agents, writes code, commits per task
/gsd:verify-work 1            # Conversational UAT — you test, it fixes

# ── Step 4: If Claude makes a mistake, capture it ─────
/boris-lesson "Used raw SQL instead of query builder — missed the ORM pattern"
# → Appends to LESSONS.md:
#   - **[2026-03-31]** architecture: Use query builder, not raw SQL — ORM is the standard

# ── Step 5: Continue to Phase 2, 3... ─────────────────
/gsd:plan-phase 2
/gsd:execute-phase 2
# ...repeat...

# ── Step 6: End of session ─────────────────────────────
/boris-review
# → Lists today's lessons
# → Glances at .planning/ progress (doesn't duplicate GSD tracking)

# ── Step 7: Next session, everything restores ──────────
# Claude reads LESSONS.md at startup → won't repeat mistakes
# /gsd:resume-work → restores planning context
```

---

## Example 2: Mini Improvement (add pagination to existing API)

```
# ── Option A: Quick task (no full phase ceremony) ─────
/gsd:quick "add cursor-based pagination to GET /todos"
# → Plans, executes, verifies in one shot
# → Commits atomically

# ── Option B: Fast inline (truly trivial) ─────────────
/gsd:fast "add limit/offset query params to GET /todos"
# → No subagents, no planning files — just does it

# ── Option C: Insert into roadmap (if it's bigger) ────
/gsd:insert-phase 2.1         # Slots between existing phases
/gsd:plan-phase 2.1
/gsd:execute-phase 2.1
```

---

## Command Cheatsheet

### GSD Core Lifecycle

| Command | When to use |
|---------|------------|
| `/gsd:new-project` | Start fresh project with requirements & roadmap |
| `/gsd:discuss-phase N` | Clarify decisions before planning (optional) |
| `/gsd:plan-phase N` | Create detailed task breakdown |
| `/gsd:execute-phase N` | Run all plans, commit code |
| `/gsd:verify-work N` | UAT — test what was built |
| `/gsd:next` | Auto-detect and do the next logical step |
| `/gsd:autonomous` | Run all remaining phases hands-off |
| `/gsd:progress` | Where am I? What's next? |

### GSD Quick Work (outside roadmap)

| Command | When to use |
|---------|------------|
| `/gsd:fast "..."` | Trivial change, no overhead |
| `/gsd:quick "..."` | Small task with atomic commits |
| `/gsd:insert-phase N.M` | Urgent work between existing phases |
| `/gsd:add-todo` | Park an idea for later |

### GSD Management

| Command | When to use |
|---------|------------|
| `/gsd:stats` | Project metrics dashboard |
| `/gsd:health` | Diagnose .planning/ issues |
| `/gsd:resume-work` | Restore context from previous session |
| `/gsd:session-report` | End-of-session summary with token usage |
| `/gsd:debug` | Systematic bug investigation |
| `/gsd:ship` | Commit + push + create MR |

### Boris (Learning Layer)

| Command | When to use |
|---------|------------|
| `/boris-init` | First time in a project |
| `/boris-lesson "..."` | After correcting Claude |
| `/boris-review` | End of session |
| `/boris-audit` | Monthly — deduplicate lessons |
| `/boris-switch` | Toggle full ↔ GSD-aware mode |

### Boris Full-Mode Only

| Command | When to use |
|---------|------------|
| `/boris-plan "..."` | Break task into steps (no GSD) |
| `/boris-status` | Progress check (no GSD) |

---

## Decision Tree: What to Use When

```
Starting a project?
├── Has multiple phases/features → /gsd:new-project + /boris-init (GSD-aware)
└── Simple, no roadmap needed  → /boris-init (full mode)

Got a task?
├── Trivial (1-2 lines)         → /gsd:fast "..."
├── Small (< 30 min)            → /gsd:quick "..."
├── Medium (fits in a phase)    → /gsd:plan-phase + /gsd:execute-phase
└── Large (multi-phase)         → /gsd:new-project or /gsd:add-phase

Claude made a mistake?
└── Always → /boris-lesson "what went wrong"

End of session?
└── Always → /boris-review

Starting a new session?
└── /gsd:resume-work (context) — LESSONS.md loads automatically
```

---

## File Layout (GSD + Boris together)

```
project/
├── .claude/
│   └── boris-mode            # "gsd"
├── .planning/                # GSD owns this
│   ├── PROJECT.md            # Vision & requirements
│   ├── ROADMAP.md            # Phase structure
│   ├── STATE.md              # Progress memory
│   ├── REQUIREMENTS.md       # REQ-IDs
│   └── phases/
│       ├── 01-core-crud/
│       │   ├── 01-CONTEXT.md
│       │   ├── 01-01-PLAN.md
│       │   ├── 01-01-SUMMARY.md
│       │   └── 01-UAT.md
│       └── 02-auth/
│           └── ...
├── CLAUDE.md                 # Project rules + Boris workflow block
├── LESSONS.md                # Boris learning — survives forever
└── src/                      # Your actual code
```

---

**Key insight:** GSD handles *what to build and how*. Boris handles *what Claude learned along the way*. Claude Code is the runtime that executes both.
