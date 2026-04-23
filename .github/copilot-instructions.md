# copilot-instructions.md

Purpose
-------
Short, actionable instructions for Copilot/Copilot CLI sessions working in this repository.

Build / Test / Lint
-------------------
- No explicit build, test, or lint configuration files were found (no package.json, pyproject.toml, Makefile, etc.).
- This repository is primarily a content/knowledge-base (markdown + Claude Code skills). If tests or build steps are added, document exact commands here (including how to run a single test, e.g. `pytest tests/test_file.py::test_name` or `npm test -- test-name`).

High-level architecture
-----------------------
- Content layer: `pages/` holds markdown content (concepts, roasters, cafes, brewing, tasting). `specs/` contains specs that must be written before implementing content or Notion DB changes.
- Workflow layer: `.claude/skills/` contains Claude Code skills that automate web research and Notion updates (notably: `/add-roaster`, `/add-bean`, `/update-roaster`). Skills may use Playwright for scraping and the Notion API for writes.
- Tracking & planning: `PROJECT_PLAN.md`, `STATUS_BOARD.md`, and `GAPS.md` record roadmap, file status, and missing roaster fields.

Key conventions (project-specific)
----------------------------------
- Spec-first: write or update `specs/*.md` before creating or changing `pages/*` or Notion schema.
- Per-roaster references: `.claude/skills/add-bean/references/` holds mappings for label language, size variants, and image extraction—update when onboarding a new roaster.
- Tracking updates: after adding/edting pages or running `/add-roaster`, update `STATUS_BOARD.md` and `GAPS.md` accordingly.
- English-only content; use relative links between files.
- Scope: Malaga-first; brewing focus on AeroPress and Clever Dripper (see CLAUDE.md for owner/context).

Files to consult first
----------------------
- README.md — project overview
- CLAUDE.md — authoritative rules for Claude skills and Notion data sources
- PROJECT_PLAN.md, STATUS_BOARD.md, GAPS.md — planning and tracking
- specs/ — required specs for any substantive change
- .claude/skills/ — skill implementations and per-roaster references

Copilot/CLI behavior notes
--------------------------
- Copilot CLI respects `CLAUDE.md` and will surface `.claude/skills/`.
- Useful CLI commands: `/init` (load repo instructions), `/skills` (list skills), `/skills <name>` (run a skill). Grant file access with `/add-dir` or `/allow-all` if needed.

MCP servers
-----------
- Notion is provided via an MCP server (configured for Notion API access). Skills use the playwright-cli (playwright-cli) for browser automation rather than Playwright MCP. If desired, configure an MCP server for Notion and ensure playwright-cli is available to the agent so Copilot can run the web-scraping skills.

Maintainers
-----------
Update this file when CI/test tooling, new skills, or workflow changes are added.
