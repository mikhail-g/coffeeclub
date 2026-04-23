# copilot-instructions.md

Purpose
-------
Short, actionable instructions for Copilot/Copilot CLI sessions working in this repository.

**For full project context, conventions, and skill documentation see [`CLAUDE.md`](../CLAUDE.md) — that file is the authoritative source.**

Build / Test / Lint
-------------------
- No explicit build, test, or lint configuration files (no package.json, pyproject.toml, Makefile, etc.).
- This repository is primarily a content/knowledge-base (markdown + Claude Code skills). If tests or build steps are added, document exact commands here.

Files to consult first
----------------------
- `CLAUDE.md` — authoritative rules, conventions, Notion data sources, and skill overview
- `README.md` — project overview
- `PROJECT_PLAN.md`, `STATUS_BOARD.md`, `GAPS.md` — planning and tracking
- `specs/` — required specs for any substantive change
- `.claude/skills/` — skill implementations and per-roaster references

Copilot/CLI behavior notes
--------------------------
- Copilot CLI respects `CLAUDE.md` and will surface `.claude/skills/`.
- Useful CLI commands: `/init` (load repo instructions), `/skills` (list skills), `/skills <name>` (run a skill). Grant file access with `/add-dir` or `/allow-all` if needed.

MCP servers
-----------
- Notion is provided via an MCP server (configured for Notion API access). Skills use playwright-cli for browser automation rather than Playwright MCP. If desired, configure an MCP server for Notion and ensure playwright-cli is available to the agent so Copilot can run the web-scraping skills.

Maintainers
-----------
Update this file when CI/test tooling or Copilot-specific workflow changes are added. Update `CLAUDE.md` for everything else.
