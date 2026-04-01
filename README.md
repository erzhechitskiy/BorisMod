# Boris Workflow for Claude Code

## Why BorisMod?

Boris Cherny's 6-step system adds tracking discipline: 
- write the plan to tasks/todo.md
- verify before starting 
- mark items complete as you go
- explain changes at each step
- document results
- capture lessons by updating LESSONS.md after every correction.

> "Every time Claude makes a mistake and gets corrected, Boris has it write a rule that prevents the same mistake. Over time, Claude literally teaches itself to be better at your specific project."

A self-improving lesson capture and task tracking system for Claude Code, based on Boris Cherny's methodology. Claude writes a rule after every correction, teaching itself to avoid the same class of mistake in future sessions.

**Two modes** to fit your workflow:

| | Full Mode | GSD-Aware Mode |
|---|---|---|
| Lesson capture | ✓ | ✓ |
| Reads LESSONS.md at startup | ✓ | ✓ |
| Task planning (todo.md) | ✓ | ✗ (GSD owns this) |
| Progress tracking | ✓ | ✗ (GSD owns this) |
| End-of-session review | ✓ (tasks + lessons) | ✓ (lessons only) |

## Quick Start

```bash
# Install globally (one-time)
chmod +x install.sh
./install.sh

# In any Claude Code project — auto-detects GSD
/user:boris-init
```

The init command checks for a `.planning/` directory and GSD command files. If found, it recommends GSD-aware mode. You choose.

## Commands

### Setup & Config

| Command | Description |
|---|---|
| `/user:boris-init` | Bootstrap workflow for current project. Detects GSD and asks which mode. |
| `/user:boris-switch` | Toggle between full and GSD-aware modes without re-initializing. |

### Full Mode Only

| Command | Description |
|---|---|
| `/user:boris-plan <task>` | Break task into steps, write to todo.md, wait for confirmation. |
| `/user:boris-status` | Progress report on current task block. |

These commands gracefully redirect to GSD equivalents if the project is in GSD-aware mode.

### Both Modes

| Command | Description |
|---|---|
| `/user:boris-lesson <context>` | Capture a correction as a persistent rule in LESSONS.md. |
| `/user:boris-review` | End-of-session wrap-up. Adapts output to the active mode. |
| `/user:boris-audit` | Deduplicate, consolidate, and prune the lessons file. |

## How the Learning Loop Works

1. You correct Claude (or run `/user:boris-lesson "what happened"`)
2. Claude identifies the root cause — the assumption, not the symptom
3. Claude writes a rule to `LESSONS.md` that prevents the entire class of mistake
4. Next session, Claude reads `LESSONS.md` at startup
5. The mistake doesn't recur

Rules are scoped to two tiers:
- **Project** `LESSONS.md` — domain rules ("this API paginates, always handle it")
- **Global** `~/.claude/LESSONS.md` — universal rules ("always check file existence before reading")

## File Layout

### Global (all projects)

```
~/.claude/
├── CLAUDE.md                      # Global startup rules
├── LESSONS.md                     # Cross-project lessons
└── commands/
    ├── boris-init.md              # /user:boris-init
    ├── boris-switch.md            # /user:boris-switch
    ├── boris-plan.md              # /user:boris-plan (full mode)
    ├── boris-status.md            # /user:boris-status (full mode)
    ├── boris-lesson.md            # /user:boris-lesson (both modes)
    ├── boris-review.md            # /user:boris-review (both modes)
    └── boris-audit.md             # /user:boris-audit (both modes)
```

### Per-project — Full Mode

```
<project>/
├── CLAUDE.md                      # Contains "## Boris Workflow (full mode)" block
├── LESSONS.md                     # Project-specific lessons
├── .claude/
│   └── boris-mode                 # Contains: full
└── tasks/
    ├── todo.md                    # Active task tracker
    └── archive/                   # Completed task blocks
```

### Per-project — GSD-Aware Mode

```
<project>/
├── CLAUDE.md                      # Contains "## Boris Workflow (GSD-aware mode)" block
├── LESSONS.md                     # Project-specific lessons
├── .claude/
│   └── boris-mode                 # Contains: gsd
└── .planning/                     # GSD's own state (untouched by Boris)
```

## Why Two Modes?

GSD is a comprehensive spec-driven development framework. It handles project planning, task breakdown, progress tracking, verification, and context management through subagent orchestration and `.planning/` state files.

Boris's **tracking layer** (todo.md, checkboxes, status reports) overlaps significantly with GSD's planning pipeline. Running both creates two sources of truth — noise, not signal.

Boris's **learning layer** (LESSONS.md, rule capture after corrections) has no equivalent in GSD. This is the unique value: persistent, accumulating self-improvement across sessions. GSD-aware mode gives you exactly this layer without the redundant tracking.

## Switching Modes

```
/user:boris-switch
```

This updates `.claude/boris-mode` and rewrites the CLAUDE.md workflow block. Transitions are safe:
- **Full → GSD**: `tasks/todo.md` and `tasks/archive/` are left in place as historical records. They're just no longer actively used.
- **GSD → Full**: `tasks/todo.md` and `tasks/archive/` are created if they don't exist.

## Lessons File Maintenance

Over time, `LESSONS.md` grows. Run `/user:boris-audit` periodically (monthly or when the file feels large). It identifies duplicates, contradictions, rules that should be promoted to global scope, and rules that have become second nature and can be archived.

Rules are dated (`**[YYYY-MM-DD]**`) so you can track learning velocity. If new lessons keep appearing in the same category, something structural needs attention beyond a single rule.

## Compatibility

### Claude Code Plan Mode / Ultrathink
No conflict. Boris is the **tracking and learning layer** (persistent files). Plan mode is the **thinking layer** (ephemeral, in-conversation reasoning). The CLAUDE.md rules state this explicitly.

### GSD Framework
Designed for coexistence. Use GSD-aware mode. Boris handles lesson capture; GSD handles everything else.

### /compact
After compaction, Claude re-reads `LESSONS.md` (both modes) and `tasks/todo.md` (full mode) from disk. This is specified in the CLAUDE.md workflow rules.

### Other spec-driven frameworks (BMAD, Speckit, Taskmaster, etc.)
GSD-aware mode works for any framework that owns its own planning state. If your framework uses a different state directory than `.planning/`, init-tracking might not auto-detect it — just choose GSD-aware mode manually when prompted.

## Uninstall

```bash
./uninstall.sh
```

Removes global commands. Preserves all project files, lessons, and task history.
