---
description: Sync all coffee offerings for a roaster — fetches the current listing and adds new beans not yet in the Beans DB
allowed-tools: Bash, mcp__notion__notion-search, mcp__notion__notion-fetch, mcp__notion__notion-create-pages, mcp__notion__notion-update-page
---

Sync coffee offerings for the roaster: $ARGUMENTS

## Process

### 1. Fetch roaster from Notion

- Search the Roasters DB for "$ARGUMENTS" — see `specs/notion-databases.md` for the data source ID. Use `notion-search` with `data_source_url`, `page_size: 3`, `max_highlight_length: 0`
- Record: **Shop URL**, roaster's Notion page URL (needed for the Roaster relation on each bean)
- Fetch the roaster page to get its **Beans** relation — collect the **name and Notion page URL** of all beans already in Notion

### 2. Get current offerings from the roaster site

- Open Shop URL with Playwright (headed): `playwright-cli open --headed <Shop URL>`
- Collect **only the name and product page URL** of each offering from the listing — do not open individual product pages yet
- Handle pagination if present (look for "next page" or "load more")

### 3. Diff

- Compare offering names from the site against existing bean names from Notion
- Use case-insensitive, fuzzy matching — names may differ slightly (accents, punctuation, short vs full name)
- Classify each offering as: **new** (on site, not in Notion), **existing** (already tracked), or **missing** (in Notion, not on site)
- Present the diff clearly before proceeding: list new offerings to be added, existing ones being skipped, and missing ones to be marked Unavailable

### 4. Add new offerings

For each new offering:
- Open its product page
- Extract all fields following the add-bean skill field extraction table (see `.claude/skills/add-bean/SKILL.md`)
- Set Roaster relation to the roaster's Notion page URL
- Set Availability to 'Available'
- Create the entry in the Beans DB — see `specs/notion-databases.md` for the data source ID
- Set Last Updated to today's date

### 5. Mark missing offerings as Unavailable

For each missing offering (in Notion, not found on site):
- Update its Notion page: set `Availability` to `Unavailable` and `Last Updated` to today's date

### 6. Report

- Summary: N new offerings added, M already existed, P marked Unavailable
- List names of added entries with their Notion page URLs
- List names of entries marked Unavailable

## Rules

- Do not re-extract or overwrite data fields (origin, price, etc.) for existing entries — only update Availability when marking a bean Unavailable
- If Shop URL is missing from the roaster's Notion entry, stop and ask the user to add it first
- If the listing page requires scrolling or pagination, handle it before diffing
