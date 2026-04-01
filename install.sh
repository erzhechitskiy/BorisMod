#!/usr/bin/env bash
set -euo pipefail

# Boris Workflow — Installer
# Deploys slash commands globally to ~/.claude/commands/
# Project-level files are bootstrapped per-project via /user:boris-init

COMMANDS_DIR="$HOME/.claude/commands"
GLOBAL_LESSONS="$HOME/.claude/LESSONS.md"
GLOBAL_CLAUDE="$HOME/.claude/CLAUDE.md"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

COMMANDS=(boris-init.md boris-plan.md boris-lesson.md boris-status.md boris-review.md boris-audit.md boris-switch.md)

echo "=== Boris Workflow Installer ==="
echo ""

# Create global commands directory
mkdir -p "$COMMANDS_DIR"
echo "[✓] Commands directory: $COMMANDS_DIR"

# Copy command files
for cmd in "${COMMANDS[@]}"; do
    src="$SCRIPT_DIR/$cmd"
    dest="$COMMANDS_DIR/$cmd"
    if [ ! -f "$src" ]; then
        echo "[✗] Missing: $cmd (skipping)"
        continue
    fi
    if [ -f "$dest" ]; then
        echo "[!] $cmd exists — backing up to ${cmd}.bak"
        cp "$dest" "${dest}.bak"
    fi
    cp "$src" "$dest"
    echo "[✓] Installed: $cmd"
done

# Create global LESSONS.md if missing
if [ ! -f "$GLOBAL_LESSONS" ]; then
    cat > "$GLOBAL_LESSONS" << 'LESSONSEOF'
# Global Lessons Learned

<!-- Universal rules across all projects. Read at session startup. -->
<!-- Format: - **[YYYY-MM-DD]** category: description -->
<!-- Categories: code-style | architecture | testing | tooling | domain | process -->
LESSONSEOF
    echo "[✓] Created: $GLOBAL_LESSONS"
else
    echo "[·] Global LESSONS.md already exists — skipping"
fi

# Handle global CLAUDE.md
if [ -f "$GLOBAL_CLAUDE" ]; then
    echo "[·] Global CLAUDE.md already exists — not overwriting"
    if ! grep -q "LESSONS.md" "$GLOBAL_CLAUDE" 2>/dev/null; then
        echo ""
        echo "    [!] Your CLAUDE.md does not reference LESSONS.md."
        echo "    Add these lines to enable the self-improvement loop:"
        echo ""
        echo '    ## Process'
        echo '    - After /compact, re-read LESSONS.md and any active task files to restore context.'
        echo '    - When corrected, update the project LESSONS.md with a rule that prevents the same class of mistake.'
        echo ""
        echo '    ## Read at startup'
        echo '    - `~/.claude/LESSONS.md` (global lessons, if it exists)'
    fi
    echo ""
    echo "    To see the recommended starter template:"
    echo "    cat $SCRIPT_DIR/global-claude.md"
else
    cat > "$GLOBAL_CLAUDE" << 'CLAUDEEOF'
# Global Rules

## Code
- TypeScript strict mode. No `any`. Explicit return types on public functions.
- Prefer functional composition. Use classes only where the framework requires them.
- Check if logic already exists before writing new code.
- Never silently swallow errors. Use specific error types with actionable messages.

## Process
- Run typecheck and relevant tests before declaring work done.
- After /compact, re-read LESSONS.md and any active task files to restore context.
- When corrected, update the project's LESSONS.md with a rule that prevents the same class of mistake.

## Communication
- Explain what changed and why after each meaningful edit.
- Be direct. Skip preamble.

## Read at startup
- `~/.claude/LESSONS.md` (global lessons, if it exists)
CLAUDEEOF
    echo "[✓] Created: $GLOBAL_CLAUDE (recommended starter — edit to match your preferences)"
fi

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Available commands (global):"
echo ""
echo "  Setup & config:"
echo "    /user:boris-init       — Bootstrap workflow for a project (detects GSD)"
echo "    /user:boris-switch     — Toggle between full and GSD-aware modes"
echo ""
echo "  Full mode only:"
echo "    /user:boris-plan <task> — Create a structured task plan"
echo "    /user:boris-status     — Check task progress"
echo ""
echo "  Both modes:"
echo "    /user:boris-lesson <context> — Capture a correction as a persistent rule"
echo "    /user:boris-review     — End-of-session wrap-up (adapts to mode)"
echo "    /user:boris-audit      — Consolidate and clean up lessons"
echo ""
echo "Next step: open a project in Claude Code and run /user:boris-init"
