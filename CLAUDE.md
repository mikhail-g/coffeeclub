# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

A personal knowledge base on specialty coffee in Malaga, Spain — structured as markdown files. No code, no build system. The goal is to evolve into a public consumer guide.

See [PROJECT_PLAN.md](PROJECT_PLAN.md) for the full vision, success definition, and task list.

## Structure

- `pages/concepts/` — foundational knowledge (what specialty means, the full chain, organizations, how to spot fakes, coffee tiers)
- `pages/roasters/` — reference notes on roasters in Malaga, Spain, and Canary Islands (structured tracking lives in Notion)
- `pages/cafes/` — cafes in Malaga
- `pages/brewing/` — AeroPress and Clever Dripper recipes, water guide
- `pages/tasting/` — personal tasting log
- `specs/` — specs for all content before implementation
- `STATUS_BOARD.md` — topic tracker with status per file

## External tools

- **Notion "Roasters" database** — primary tracking tool for all roasters (Malaga, Spain, Canary Islands): quality, offerings, how to buy, delivery info. Not Malaga-specific.

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
- STATUS_BOARD.md should be updated when files are added or their status changes

## Content scope

- Malaga-first, then Spain, then Canary Islands
- Filter brewing focus (AeroPress, Clever Dripper) — not espresso
- Consumer-facing tone — not industry-insider language
- Conceptual depth with practical output (the reader should be able to act on it)

## Owner context

The owner is a deep coffee enthusiast living in Malaga, using AeroPress and Clever Dripper with a manual grinder and scale. Trusted local roasters (with known flaws): Mountain Coffee, Artisan, La Hacienda, Kima, Bertrani.
