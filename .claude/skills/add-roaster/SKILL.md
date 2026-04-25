---
description: Add a new roaster to the Roasters DB, create an add-bean reference file, and add structured info to the Notion page content
allowed-tools: Bash, mcp__notion__notion-create-pages, mcp__notion__notion-fetch, mcp__notion__notion-search
---

Add a new roaster from the homepage at: $ARGUMENTS

## Process

### 0. Check if roaster already exists

Search the Roasters DB for the roaster name — use `notion-search` with `data_source_url`, `page_size: 3`, `max_highlight_length: 0` (see `specs/notion-databases.md` for the data source ID). If a match is found, stop and update the existing entry instead of creating a new one.

### 1. Open homepage with Playwright

`playwright-cli open --headed $ARGUMENTS`

Extract:
- **Roaster name** — from page `<title>`, `<h1>`, or logo alt text
- **Instagram URL** — from any `<a href*="instagram.com">` link in page
- **Location / city** — from About, Contact, or footer text
- **Geographic scope** — Malaga / rest of Spain / Canary Islands (determines which roasters markdown page to update). If not determinable from the site, ask the user before continuing.

### 2. Find the shop/products URL

- Look for navigation links: "Shop", "Tienda", "Coffees", "Productos", "Collections", "Cafés"
- Record as **Shop URL** — the URL of the full products listing page

### 3. Visit one product page to build the add-bean reference

- Open the shop/products URL and pick one individual coffee product page (not a bundle or equipment)
- Detect platform: try fetching `<product-url-slug>.json` — if it returns product JSON, it is a Shopify store
- Note label language (Spanish / English / mixed)
- For each field below, find the exact label text as it appears on the page:

| Field | What to look for |
|---|---|
| Country / Origin | Label before country name |
| Region | Label before region/area name |
| Farm | Label before farm name |
| Altitude | Label before altitude number |
| Variety | Label before variety/cultivar name |
| Process | Label before processing method |
| Cata Notes | Label before tasting descriptors |
| SCA Score | Label before score number, if present |
| Roast Profile | Label or variant option indicating Filter / Espresso / Omni |

- Note pricing structure: Are there weight variants (100g/250g/1kg)? Or a single price per product?
- Note image extraction: Shopify API (`product.images[0].src`) or page gallery

### 4. Extract delivery / logistics info

- Check FAQ, Shipping Policy, About, or footer
- Extract: free delivery threshold (€), courier/carrier name if named, whether there is a physical store or pickup option, address if available

### 5. Create Roasters DB entry in Notion

Use `mcp__notion__notion-create-pages` — see `specs/notion-databases.md` for the Roasters data source ID.

Set all fields found: Name, Site, Shop URL, Instagram, Free Delivery From (€), Delivery Organization, Buy In Person, Address, Notes (quirks).

**If a physical address was found in step 4**, geocode it with Nominatim to get coordinates for the `Location` place field:

```bash
curl "https://nominatim.openstreetmap.org/search?q=<url-encoded-address>&format=json&limit=1" \
  -H "User-Agent: coffai-project"
```

Extract `lat` and `lon` from the first result. Include in the create call:
- `place:Location:name` → roaster name
- `place:Location:address` → full address string
- `place:Location:latitude` → lat (number)
- `place:Location:longitude` → lon (number)

If Nominatim returns no results, try a shorter query (street + city, drop the local/unit number). See `specs/notion-databases.md` for full documentation of the place field format.

Also pass the bullet-list page body directly in the `content` field of the same `notion-create-pages` call:

```
- **Location:** <city> (<physical store / online only>)
- **Website / Instagram:** [<domain>](<site url>) / [@<handle>](<instagram url>)
- **Buy in person:** yes / no
- **Ships:** yes (<free from €X via Carrier>) / no / unknown
- **Price range:** ~€X/250g
- **Roast style:** Filter / Espresso / Omni
- **Transparency level:** <SCA score per product / farm named / country only>
- **Available at:** [<shop url label>](<shop url>)
```

Leave out any bullet where the data was not found. This eliminates the need for a separate `notion-update-page` call.

### 6. Create add-bean reference file

Write `.claude/skills/add-bean/references/<domain>.md` using this format. **Include the Notion page URL returned by step 5 as the first line after the heading** — this allows future `add-bean` and `update-roaster` calls to skip `notion-search` entirely.

```
# Roaster Name (domain.com) — field locations

<one-line description of label language and structure>

| Field | Label on page |
|---|---|
| Country | "<exact label>" or "Not labeled — <how to extract>" |
| Region | "<exact label>" |
| Farm | "<exact label>" |
| Altitude | "<exact label>" — <any stripping rules> |
| Variety | "<exact label>" |
| Process | "<exact label>" |
| Cata Notes | "<exact label>" |
| SCA Score | "<exact label>" or "Not present — leave blank" |

<If Shopify:>
Also a Shopify store — use the JSON API for prices and images:
`curl https://<domain>/products/<slug>.json`

Price 250g → <variant matching rule> → `price`
Price 1kg → <variant matching rule> → `price`
Image → `product.images[0].src`
Roast Profile → <inference rule from variant titles or page label>

<If not Shopify:>
<Describe how to extract prices and images from the page>

<If there are products to skip (bundles, equipment, etc.):>
## Exclusions
<What to skip and why>
```

### 6b. Seed the local cache

After the Notion entry is created, update `.claude/cache/<domain>.json` with what is known.

- `<domain>` is the bare hostname without `www.` and without `.com`/`.es` extension, matching the reference file name (e.g. `nerjacoffeeroasters` for `nerjacoffeeroasters.com`)
- `id` is the Notion page UUID extracted from the URL returned by step 5 (last path segment, no dashes)
- Include only the fields that were actually found; omit `free_delivery_from` or `delivery_org` if unknown

**If the file already exists** — read it first, then update only the `roaster` object and `cached_at`. Do NOT touch `beans`, `beans_last_synced`, or any bean records.

**If the file does not exist** — create it with an empty beans array:

```json
{
  "roaster": {
    "name": "<Roaster Name>",
    "domain": "<domain.com>",
    "id": "<notion-page-uuid>",
    "notion_url": "https://www.notion.so/<id-no-dashes>",
    "site": "<homepage url>",
    "shop_url": "<shop url or null>",
    "instagram": "<instagram url or null>",
    "free_delivery_from": <number or null>,
    "delivery_org": "<carrier name or null>",
    "cached_at": "<ISO timestamp>"
  },
  "beans_last_synced": null,
  "beans": []
}
```

### 7. Update add-bean/SKILL.md references section

Add a bullet to the `## Roaster-specific references` section in `.claude/skills/add-bean/SKILL.md`:

```
- [Roaster Name](references/<domain>.md) — <one-line summary of key quirks>
```

### 8. Update GAPS.md

Open `GAPS.md` at the project root. Under `## Roasters`, add an entry for the new roaster using this format:

```
### <Roaster Name>
<Notion page URL>

- **<Field>** — <why it is unknown or blank>
```

If all key fields were found, write "All key fields populated." instead of a list.

Key fields to check for gaps: Shop URL, Instagram, Free Delivery From (€), Delivery Organization, Roast Style, Roast Date Provided, Address.

Omit: Rating (expected blank until tried), Beans, Last Synced (auto-managed).

### 9. Report

- Notion page URL for the new roaster
- Path to the new reference file
- Any fields left blank that the user should fill in manually

## Rules

- If no shop/products URL is found, leave Shop URL blank and note it in the report
- If geographic scope cannot be determined from the site, ask the user before step 8
- If a reference file already exists for this domain, update it rather than overwriting
- Do not create a Notion entry if the roaster already exists — step 0 handles this check
