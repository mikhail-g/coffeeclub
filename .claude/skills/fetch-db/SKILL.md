---
description: Query a Coffee Club Notion database by name or keyword
allowed-tools: Bash, mcp__notion__notion-search, mcp__notion__notion-fetch
---

Fetch entries from: $ARGUMENTS

## Process

### 1. Parse arguments

- **database** (required): `roasters` / `beans` / `tries` / `recipes`
- **query** (optional): search text or keyword

### 2. Resolve data source ID

See `specs/notion-databases.md` for all IDs and query patterns.

### 3. Retrieve

If $ARGUMENTS is a Notion URL or page ID → use `notion-fetch` directly.

**If the query involves a known roaster** (e.g. "Mountain Coffee Colombia", "Kima beans"):

1. **Reference file lookup** — scan `.claude/skills/add-bean/references/` for a file whose heading (`# Roaster Name (domain.com) — field locations`) matches the roaster name. Extract the domain from the parentheses in the heading. Use the `Notion page URL` line from that file directly — skip `notion-search`.

2. **Cache check** — look for `.claude/cache/<domain>.json`. If it exists and `beans_last_synced` is within 7 days of today, return results from the cache. Note "(cached, synced <date>)" in the output. Apply any additional filters (Country, Process, Availability) client-side from the cached records. Stop here.

3. **Cache miss / expired** — fetch from Notion: `notion-fetch` the roaster page (using URL from step 1) → extract all `Beans` relation URLs → `notion-fetch` all bean pages in parallel. Then write or overwrite `.claude/cache/<domain>.json` with the full result (see cache format below) before returning.

This is the only reliable way to get all beans for a roaster — `notion-search` cannot filter by relation field values, and searching by roaster name or UUID in the Beans DB returns incomplete, mixed results.

**If the query is country/keyword only** (no specific roaster):
- `notion-search` with:
  - `data_source_url`: `"collection://<id>"`
  - `query`: the search text
  - `page_size`: 25
  - `max_highlight_length`: 0
- Note: results may be incomplete for beans where the keyword doesn't appear prominently in the page content

### 4. Return

Name, key properties, and Notion page URL for each result.

## Cache format

`.claude/cache/<domain>.json` — one file per roaster:

```json
{
  "roaster": {
    "name": "Roaster Name",
    "domain": "domain.com",
    "id": "<notion-page-uuid>",
    "notion_url": "https://www.notion.so/<id>",
    "cached_at": "2026-04-23T14:30:00Z"
  },
  "beans_last_synced": "2026-04-23T14:30:00Z",
  "beans": [
    {
      "id": "<notion-page-uuid>",
      "notion_url": "https://www.notion.so/<id>",
      "name": "Bean Name — Roaster",
      "country": "...",
      "region": "...",
      "variety": "...",
      "process": "...",
      "altitude": "...",
      "sca_score": null,
      "roast_profile": "...",
      "cata_notes": "...",
      "price_250g": 0.0,
      "price_1kg": 0.0,
      "availability": "Available",
      "decaf": false,
      "url": "https://roastersite.com/...",
      "cached_at": "2026-04-23T14:30:00Z"
    }
  ]
}
```

The `id` field is the Notion page UUID (last path segment of `notion_url`, stripped of dashes). Extract it from the page URL returned by `notion-fetch`.

## Rules

- Never call `notion-search` without `data_source_url` when the target database is known
- Use `notion-fetch` when you already have the page URL — do not re-search
- For beans results, always include Availability status
- Never try to filter by roaster using a UUID or name query in `notion-search` — it does not work (fuzzy text match, not relation field lookup)
- Always write the cache after a fresh Notion fetch — do not skip it
