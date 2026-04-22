# Notion Databases

All Coffee Club databases in Notion. Skills and instructions reference this file instead of hardcoding IDs.

| Database | Data Source ID | Notion URL |
|---|---|---|
| Roasters | d38df7d9-d3b7-4a6b-8db2-dcc0398baad4 | https://www.notion.so/cd3460f960d246bf9fac4487644442c8 |
| Beans | c08fa0f2-84a0-494f-967d-1842a961b10a | https://www.notion.so/9a9ec97ce2934ca38b1a3b2f3f9378ad |
| Tries | 953ef057-359b-4d7f-860e-1aa25acf0bc0 | https://www.notion.so/9d514be0aa5b4f1fad77973add43e294 |
| Recipes | 9c068ef8-6a96-456c-8d24-05b221062482 | https://www.notion.so/8dc99dad6d7f432e850c8a76cc724805 |

## Query patterns

**Search** — when you need to find an entry by name or keyword and don't have its URL:

Use `notion-search` with:
- `data_source_url: "collection://<Data Source ID>"` — always required to scope to the right database
- `page_size`: 3–5 for named lookups (looking for one entry), up to 25 for listings
- `max_highlight_length`: 0 (reduces response size, highlights are not needed for data lookups)

**Fetch** — when you already have the page URL or ID:

Use `notion-fetch` directly. It is faster, deterministic, and returns full content with all properties and relation lists. Do not re-search when you already have the URL.

Rule of thumb: **search to find, fetch to read.**
