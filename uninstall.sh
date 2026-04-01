#!/usr/bin/env bash
set -euo pipefail

# Boris Workflow — Uninstaller
# Removes global commands. Does NOT touch project-level files or LESSONS.md.

COMMANDS_DIR="$HOME/.claude/commands"
COMMANDS=(boris-init.md boris-plan.md boris-lesson.md boris-status.md boris-review.md boris-audit.md boris-switch.md)

echo "=== Boris Workflow Uninstaller ==="
echo ""
echo "Removing global slash commands only."
echo "Project-level files (CLAUDE.md, LESSONS.md, tasks/, .claude/boris-mode) are preserved."
echo ""

for cmd in "${COMMANDS[@]}"; do
    target="$COMMANDS_DIR/$cmd"
    if [ -f "$target" ]; then
        rm "$target"
        echo "[✓] Removed: $cmd"
    else
        echo "[·] Not found: $cmd"
    fi
    if [ -f "${target}.bak" ]; then
        rm "${target}.bak"
        echo "[✓] Removed backup: ${cmd}.bak"
    fi
done

echo ""
echo "=== Uninstall Complete ==="
echo ""
echo "Preserved:"
echo "  ~/.claude/LESSONS.md          (your global lessons)"
echo "  <project>/LESSONS.md          (per-project lessons)"
echo "  <project>/tasks/              (task history)"
echo "  <project>/.claude/boris-mode  (mode config)"
echo ""
echo "To fully clean a project, remove the '## Boris Workflow' block"
echo "from its CLAUDE.md and delete .claude/boris-mode manually."
