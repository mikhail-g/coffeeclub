# Coffee Club

A specialty coffee knowledge base for Málaga, Spain — combining structured Notion databases with Claude Code skills that handle the research and data entry work.

## What this is

Two layers working together:

- **Knowledge base** — markdown pages covering roasters, cafes, brewing guides, and tasting notes, backed by Notion databases for structured tracking
- **AI workflows** — Claude Code skills that automate roaster research, bean data entry, and catalog maintenance

The goal: reliable sourcing (which roasters are worth buying from and why), better brewing (AeroPress and Clever Dripper recipes that work), and eventually a public consumer guide to specialty coffee in Málaga.

## The databases

Maintained through Claude Code skills:

- [Roasters](https://www.notion.so/cd3460f960d246bf9fac4487644442c8) — quality signals, delivery info, and buy-in-person status for every roaster evaluated
- [Beans](https://www.notion.so/9a9ec97ce2934ca38b1a3b2f3f9378ad) — every coffee offering tracked: origin, process, variety, SCA score, price, image
- [Coffee Club](https://spiced-moth-434.notion.site/Coffee-Club-348f2b14316c8100af62cad26378071e) — shared entry point with all three databases in one published Notion page

## The skills

Claude Code skills that keep the databases up to date:

- `/add-roaster <URL>` — opens a roaster's homepage, extracts all available fields, creates a Notion entry, writes a field-mapping reference for future bean imports, and records what's still unknown in `GAPS.md`
- `/add-bean <URL>` — opens a product page, extracts origin, process, variety, SCA score, prices, and image, and creates a Beans DB entry
- `/sync-roaster <name>` — fetches the roaster's current listing and adds any new offerings not yet in the Beans DB

Roaster-specific quirks (label language, size variants, image extraction) are captured in `.claude/skills/add-bean/references/` so each roaster only needs to be figured out once.

Skills cache bean data locally in `.claude/cache/<domain>.json` after each fetch. `/fetch-db` serves roaster-scoped queries from the cache when it's less than 7 days old — skipping all Notion API calls. The cache is refreshed automatically by `/add-bean` (appends the new entry) and `/sync-roaster` (overwrites with the full current list).

## Tracking

- `PROJECT_PLAN.md` — the full vision and task list
- `STATUS_BOARD.md` — completeness status for every content file
- `GAPS.md` — blank or uncertain fields per roaster, so it's clear what to follow up on

## Structure

```
pages/        concepts, roasters, cafes, brewing guides, tasting log
specs/        written before any content or database structure is created
.claude/      Claude Code skills, memory, and roaster-specific references
```
