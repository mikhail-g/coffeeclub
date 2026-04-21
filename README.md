# coffai

A personal knowledge base on specialty coffee in Malaga, Spain. The goal is to build enough understanding to source good beans reliably, brew them well, and share the experience with others.

## Purpose

Three problems this project solves:

- **Memory** — a record of every roaster and bean tried, so each new bag builds on the last
- **Brewing** — reliable AeroPress and Clever Dripper recipes for different roast levels
- **Sourcing** — an honest picture of which roasters in Malaga and Spain are worth buying from

## Coffee Club

The shared entry point for club members: [Coffee Club](https://spiced-moth-434.notion.site/Coffee-Club-348f2b14316c8100af62cad26378071e)

Inline views of all three databases — Roasters, Beans, and Tries — in one published Notion page.

## Roasters

Tracked in Notion: [Roasters database](https://www.notion.so/cd3460f960d246bf9fac4487644442c8)

Covers roasters in Malaga, Spain, and the Canary Islands — quality signals, what they offer, and how to buy.

## Beans

Every coffee offering tracked in Notion: [Beans database](https://www.notion.so/9a9ec97ce2934ca38b1a3b2f3f9378ad)

Two Claude Code skills keep it up to date:

- `/add-bean <URL>` — opens a roaster's product page, extracts all fields, and creates a new entry in the Beans DB
- `/update-roaster "Name"` — fetches the roaster's full listing, diffs it against what's already in Notion, and adds any new offerings

## Plan

See [PROJECT_PLAN.md](PROJECT_PLAN.md) for the full vision, the problems being solved, and the task list.

## Structure

- `pages/` — all content: concepts, roasters, cafes, brewing guides, tasting log
- `specs/` — specifications written before any content is created or changed
- `STATUS_BOARD.md` — current status of every content file
