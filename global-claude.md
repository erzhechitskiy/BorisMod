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

# ---
# CUSTOMIZATION NOTES (delete this section after editing)
#
# This is a starter template. Customize it to YOUR preferences.
# The goal: ~15 lines, ~120 tokens. Every line must prevent mistakes.
#
# Good global rules (things you'd repeat in every project):
#   - Code style philosophy (functional vs OOP, typing strictness)
#   - Error handling philosophy
#   - Universal process rules ("run tests", "explain changes")
#   - Communication preferences
#
# Do NOT put here (save for project-level CLAUDE.md):
#   - Tech stack details (NestJS, Nx, specific frameworks)
#   - Project commands (build, test, lint invocations)
#   - Architecture conventions specific to one codebase
#   - Personality instructions ("be a senior engineer")
#   - Anything a linter/formatter handles
#
# Boris Cherny's global is ~76 tokens. His project file is ~2.5k tokens.
# The project file carries the weight. This file is the safety net.
#
# Sources:
#   - Anthropic official: https://code.claude.com/docs/en/best-practices
#   - Boris Cherny's workflow: https://howborisusesclaudecode.com/
#   - CLAUDE.md starter kit: https://github.com/abhishekray07/claude-md-templates
#   - Claude Code system prompt has ~50 instructions already (~150-200 budget)
