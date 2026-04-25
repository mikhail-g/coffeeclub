---
description: Sync all coffee offerings for a roaster — fetches the current listing and adds new beans not yet in the Beans DB
allowed-tools: Bash, mcp__notion__notion-search, mcp__notion__notion-fetch, mcp__notion__notion-create-pages, mcp__notion__notion-update-page
---

Sync coffee offerings for the roaster: $ARGUMENTS

## Running in parallel

When syncing multiple roasters at once, spawn one Agent per roaster using the Agent tool. Pass each agent this skill's full instructions plus the roaster name and a unique Playwright session name (e.g. `-s=<domain>`). Do not run multiple roasters inline in the main conversation.

## Process

### 1. Fetch roaster from Notion

- Check `.claude/skills/add-bean/references/` for a file matching this roaster's domain. If found, read the `Notion page URL` line — use it directly with `notion-fetch`. This is faster and deterministic.
- Only fall back to `notion-search` (Roasters DB, `data_source_url`, `page_size: 3`, `max_highlight_length: 0`) if no reference file match exists.
- `notion-fetch` the roaster page to get: **Shop URL**, roaster's Notion page URL (needed for the Roaster relation on each bean), and the **Beans** relation — collect the **name and Notion page URL** of all beans already in Notion

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
- Set Last Updated to today's date

Once all new offerings are extracted, create them all in a **single batched `notion-create-pages` call** — pass all new pages as an array. Do not call `notion-create-pages` once per bean.

### 5. Mark missing offerings as Unavailable

For each missing offering (in Notion, not found on site):
- Update its Notion page: set `Availability` to `Unavailable` and `Last Updated` to today's date

### 6. Update roaster Roast Style and Decaf Available

**Roast Style** — Derive the union of all distinct Roast Profile values across every bean now linked to this roaster (existing + newly added). Update the roaster page's **Roast Style** multi-select to match.

- **Single value** — use `notion-update-page` (`update_properties`): `"Roast Style": "<value>"`
- **Multiple values** — MCP cannot set multiple options; use the script instead:
  ```bash
  .claude/skills/sync-roaster/scripts/set-multi-select.sh "<page-id-dashed>" "Roast Style" Value1 Value2 ...
  ```
  The script reads `NOTION_ACCESS_KEY` from the environment (loaded from `.env`). Page ID must be dashed UUID format.

**Decaf Available** — If any bean has `decaf: true` (or `Decaf` checkbox checked), set the roaster's `Decaf Available` checkbox to checked via `notion-update-page`: `"Decaf Available": "__YES__"`. Do not set it to unchecked — only set it when decaf is confirmed present.

**Last Synced** — Set the roaster page's `Last Synced` date to today via `notion-update-page`: `"date:Last Synced:start": "<YYYY-MM-DD>"`, `"date:Last Synced:is_datetime": 0`.

### 7. Report

- Summary: N new offerings added, M already existed, P marked Unavailable
- List names of added entries with their Notion page URLs
- List names of entries marked Unavailable
- Confirm the Roast Style value(s) set on the roaster page

### 8. Update the local cache

After all Notion writes complete, overwrite `.claude/cache/<domain>.json` with the full current bean list:
- Build the complete list from: existing beans (from the Notion relation fetched in step 1) + newly added beans — with final Availability values applied (including any just marked Unavailable in step 5)
- Use the cache format defined in `fetch-db/SKILL.md`
- Populate the `roaster` section from the reference file (`Notion page URL` line → derive `id` from URL)
- Set `beans_last_synced` to now; set `cached_at` on each bean record to now
- The file lives at `.claude/cache/<domain>.json` where `<domain>` matches the reference file name

## Rules

- **Never use `curl` or `WebFetch` to load product pages or listing pages.** Always use `playwright-cli` with the named session. The only permitted uses of `curl` in this skill are: Nominatim geocoding and the Shopify JSON API — and only when the roaster's reference file explicitly specifies Shopify.
- Do not re-extract or overwrite data fields (origin, price, etc.) for existing entries — only update Availability when marking a bean Unavailable
- If Shop URL is missing from the roaster's Notion entry, stop and ask the user to add it first
- If the listing page requires scrolling or pagination, handle it before diffing
