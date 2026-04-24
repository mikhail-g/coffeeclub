---
description: Add a new coffee offering to the Beans DB from a product page URL
allowed-tools: Bash, mcp__notion__notion-search, mcp__notion__notion-create-pages
---

Add a new entry to the Notion Beans DB from the product page at: $ARGUMENTS

## Process

1. Open the URL with Playwright in headed mode: `playwright-cli open --headed $ARGUMENTS`
2. Take a snapshot. Extract every field available from the main product view.
3. If an "Información adicional" tab exists, click it and check for extra data (usually just weight/grind options — no new bean data).
4. Look up the roaster's Notion page URL from the reference file for this domain (`.claude/skills/add-bean/references/<domain>.md`) — read the `Notion page URL` line. Use it directly without calling `notion-search`.
   Only fall back to `notion-search` (Roasters DB, `data_source_url`, `page_size: 5`, `max_highlight_length: 0`) if no reference file exists for this domain or it contains no URL.
5. Create a new page in the Beans DB — see `specs/notion-databases.md` for the data source ID. Include all extracted fields plus the `content` field (see step 5a).

   **5a. Page content — Info from web**
   Pass the `content` field in the `notion-create-pages` call with an `## Info from web` section. Only include lines for fields that required interpretation or mapping (not fields taken verbatim). See `specs/beans.md` for format. Minimum: always include the raw roast profile label as it appeared on the page.

   ```
   ## Info from web
   - **Roast profile (as listed):** "<exact label from page>" → mapped to <canonical value>
   ```

6. Set `Last Updated` to today's date.
7. **Update the local cache** — after `notion-create-pages` succeeds, update `.claude/cache/<domain>.json`:
   - If the file exists: read it, append the new bean record to the `beans` array, update `beans_last_synced` to now, write back.
   - If the file does not exist: create it using the cache format from `fetch-db/SKILL.md`. Populate the `roaster` section from the reference file (`Notion page URL` line → derive `id` from URL). Add the new bean as the first entry.
   - The cache file lives at `.claude/cache/<domain>.json` where `<domain>` matches the reference file name (e.g. `specialtymountaincoffee.json`).

## Fields to extract

| Field | Where to find it |
|---|---|
| Name | Product heading (h1) |
| Roaster | Match to Notion Roasters DB by roaster name or site domain |
| URL | The product page URL from $ARGUMENTS — use property key `userDefined:URL` |
| Country | "ORIGEN:" label — country part only |
| Region | "ORIGEN:" label — region/area after the country |
| Farm | "FINCA:" label |
| Altitude | "ALTITUD:" label — number only, strip "msnm" |
| Variety | "VARIEDAD:" label |
| Process | "PROCESO:" label → map to: Washed / Natural / Honey / Anaerobic / Other |
| Cata Notes | "NOTAS:" label (short tasting descriptor line) |
| SCA Score | Score if listed, else leave blank |
| Roast Profile | Follow the canonical mapping in `specs/beans.md`. Infer from grind variants if no explicit label. Leave blank if neither is available. |
| Decaf | `__YES__` if "descafeinado" appears in name or labels, else `__NO__` |
| Price 250g online (€) | Price for 250g option |
| Price 1kg online (€) | Price for 1000g option |
| Price 250g in person (€) | Leave blank unless page explicitly states a different in-store price |
| Price 1kg in person (€) | Leave blank unless page explicitly states a different in-store price |
| Image | URL of the main product image — first `/url:` link pointing to a `.jpg` on the roaster's domain in the product gallery |
| Description | Full text from the "Descripción" tab |
| Availability | Always set to 'Available' on creation |
| Notes | Leave blank — personal field, filled manually after receiving the beans |

## Roaster-specific references

If the product page is from a roaster with known quirks, read the corresponding reference before extracting fields:

- [Artisan Coffee](references/artisancoffee.md) — English labels in description body, Shopify API for prices/images
- [Kima Coffee](references/kimacoffee.md) — Spanish labels with different names ("Perfil Sensorial:", "Región:", etc.), no explicit Country/Farm label, Shopify API for prices/images
- [Bertani Café](references/bertanicafe.md) — Spanish labels, simple site builder (no JSON API), single price per product (bag size unstated), image from Pinterest share link
- [Brewing Dealers](references/brewingdealers.md) — English labels, Shopify API for prices/images, Country embedded in Region string, skip X2/X3/X4 bundle packs
- [Delicotte](references/delicotte.md) — Spanish labels, WooCommerce (data-product_variations for prices/images), 200g/500g sizes (not 250g/1kg), "Perfil en taza" for cata notes, "Puntaje:" for SCA
- [Santa Coffee](references/santacoffee.md) — English labels, WooCommerce (data-product_variations for prices/images), 250g/1kg standard sizes, "TASTING NOTES:" for cata notes, "SCA:" for score (strip " points")
- [La Hacienda](references/lahacienda.es.md) — Spanish labels, WooCommerce (WordPress); country in title, sizes 250/500/1kg, images from wp-content uploads
- [Mountain Coffee](references/specialtymountaincoffee.md) — Spanish labels, WooCommerce; ORIGEN contains country+region on one line, no SCA score, always Omni
- [Cocóra](references/cocoracoffee.es.md) — English labels, Shopify; fields in body_html icon table (img alt text), Origin is "Region, Country", grind variants used to infer roast profile

## Rules

- Include Image in the initial `notion-create-pages` call — no separate update step needed. The Files property accepts a plain external HTTPS URL string. Do not pass a local file path — Notion will reject it. If only a local file is available, leave Image blank and note it for manual upload.
- Leave any field blank if not found on the page. Do not guess or infer origin from the coffee name.
- Roaster relation value: use the full Notion page URL of the matched roaster entry (e.g. `https://www.notion.so/342f2b14316c812ebde7dd61f69f6900`).
- The `URL` field requires the property key `userDefined:URL` in create/update calls — not `URL`.
- If the roaster is not found in Notion, note it and create the entry without the Roaster relation.
