---
description: Query a Coffee Club Notion database by name or keyword
allowed-tools: mcp__notion__notion-search, mcp__notion__notion-fetch
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
1. `notion-search` the Roasters DB (`collection://d38df7d9-d3b7-4a6b-8db2-dcc0398baad4`) with the roaster name to get the roaster page URL
2. `notion-fetch` the roaster page → extract all URLs from the `Beans` relation property
3. `notion-fetch` all those bean pages **in parallel**
4. Filter client-side by any additional criteria (Country, Process, etc.)

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

## Rules

- Never call `notion-search` without `data_source_url` when the target database is known
- Use `notion-fetch` when you already have the page URL — do not re-search
- For beans results, always include Availability status
- Never try to filter by roaster using a UUID or name query in `notion-search` — it does not work (fuzzy text match, not relation field lookup)
