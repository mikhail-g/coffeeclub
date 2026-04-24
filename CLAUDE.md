# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with this repository.

## What this repository is

A specialty coffee knowledge base for Málaga, Spain — structured markdown pages backed by Notion databases, with a suite of Claude Code skills for AI-assisted research and data maintenance. The goal is to evolve into a public consumer guide.

Two layers:
- **Content layer** — markdown pages covering concepts, roasters, cafes, brewing, and tasting
- **Workflow layer** — specs, skills, and tracking files that keep the knowledge base accurate and growing

See [PROJECT_PLAN.md](PROJECT_PLAN.md) for the full vision, success definition, and task list.

## Structure

- `pages/concepts/` — foundational knowledge (what specialty means, the full chain, organizations, how to spot fakes, coffee tiers)
- `pages/roasters/` — reference notes on roasters in Malaga, Spain, and Canary Islands (structured tracking lives in Notion)
- `pages/cafes/` — cafes in Malaga
- `pages/brewing/` — AeroPress and Clever Dripper recipes, water guide
- `pages/tasting/` — personal tasting log
- `specs/` — specs for all content before implementation
- `STATUS_BOARD.md` — topic tracker with status per file
- `GAPS.md` — blank or uncertain fields per roaster, updated by the add-roaster skill

## External tools

- **Notion Roasters DB** (data source `d38df7d9-d3b7-4a6b-8db2-dcc0398baad4`) — primary tracking tool for all roasters: quality signals, offerings, delivery logistics
- **Notion Beans DB** (data source `c08fa0f2-84a0-494f-967d-1842a961b10a`) — every coffee offering from tracked roasters: origin, process, variety, SCA score, price, image
- **Notion Tries DB** — personal tasting records linked to beans

## Skills

Claude Code skills live in `.claude/skills/`. Each skill automates a recurring workflow:

- `/add-roaster <URL>` — researches a roaster's homepage with Playwright, creates a Notion Roasters DB entry, writes a field-mapping reference file for future bean imports, updates GAPS.md, and adds structured content to the Notion page body
- `/add-bean <URL>` — opens a product page, extracts all fields (origin, process, variety, SCA score, prices, image), and creates a Beans DB entry
- `/update-roaster <name>` — fetches the roaster's current product listing and adds any offerings not yet in the Beans DB

Roaster-specific field mappings (label language, size variants, image extraction method) live in `.claude/skills/add-bean/references/`.

## Workflow

Spec-driven: before creating or significantly changing any content — a markdown file, a Notion database, a Notion page structure — write a spec first.

Specs live in `specs/`. Each spec covers:
- **Intent** — why this exists and what decisions it should enable
- **Scope** — what is included and explicitly what is not
- **Structure** — fields, sections, or schema with the expected depth per item
- **Open questions** — anything unresolved before implementation

Implementation only starts after the spec is reviewed and agreed. If reality diverges from the spec during implementation, update the spec first.

## Conventions

- English only
- Files link to related files using relative paths
- `STATUS_BOARD.md` should be updated when files are added or their status changes
- `GAPS.md` should be updated when missing fields are filled in or new roasters are added
- `LESSONS_LEARNED.md` should be updated when something non-obvious is discovered during work — unexpected API behaviour, a pattern that proved reliable or brittle, a mistake worth avoiding next time. Suggest adding an entry whenever such a moment comes up in a session.

## Content scope

- Malaga-first, then Spain, then Canary Islands
- Filter brewing focus (AeroPress, Clever Dripper) — not espresso
- Consumer-facing tone — not industry-insider language
- Conceptual depth with practical output (the reader should be able to act on it)

## Known issues

- **WebSearch unavailable** — WebSearch calls fail with a `400 BedrockException` when routed through litellm to AWS Bedrock. Root cause: the tool's input schema passes `type` as a plain string (`"string"`) but Bedrock requires an array (`["string"]`). No fallback model is configured. Until fixed on the proxy side, use Playwright (`playwright-cli`) or WebFetch with a known URL instead of WebSearch for research tasks.

## Owner context

The owner is a deep coffee enthusiast living in Malaga, using AeroPress and Clever Dripper with a manual grinder and scale. Trusted local roasters (with known flaws): Mountain Coffee, Artisan, La Hacienda, Kima, Bertani, Delicotte, Santa Coffee.
