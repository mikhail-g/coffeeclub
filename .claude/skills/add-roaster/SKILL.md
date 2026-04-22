---
description: Add a new roaster to the Roasters DB, create an add-bean reference file, and update the roasters page
allowed-tools: Bash, mcp__notion__notion-create-pages, mcp__notion__notion-fetch, mcp__notion__notion-search
---

Add a new roaster from the homepage at: $ARGUMENTS

## Process

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

Use `mcp__notion__notion-create-pages` with data source `d38df7d9-d3b7-4a6b-8db2-dcc0398baad4`.

Set all fields found: Name, Site, Shop URL, Instagram, Free Delivery From (€), Delivery Organization, Buy In Person, Address, Notes (quirks).

### 6. Create add-bean reference file

Write `.claude/skills/add-bean/references/<domain>.md` using this format:

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

### 7. Update add-bean/SKILL.md references section

Add a bullet to the `## Roaster-specific references` section in `.claude/skills/add-bean/SKILL.md`:

```
- [Roaster Name](references/<domain>.md) — <one-line summary of key quirks>
```

### 8. Add entry to the roasters markdown page

Based on geographic scope:
- **Malaga** → `pages/roasters/malaga.md` — use malaga template (Location, Buy in person, Ships, Available at, Coffees tried table)
- **Spain** → `pages/roasters/spain.md` — use spain template (City, Ships to Malaga, Price range, Roast style, Transparency level, Subscription)
- **Canary Islands** → `pages/roasters/canary-islands.md`

Insert in the `## Roasters` section. Replace `> To fill in` placeholder if it's the first entry.

### 9. Report

- Notion page URL for the new roaster
- Path to the new reference file
- Which roasters markdown page was updated
- Any fields left blank that the user should fill in manually

## Rules

- If no shop/products URL is found, leave Shop URL blank and note it in the report
- If geographic scope cannot be determined from the site, ask the user before step 8
- If a reference file already exists for this domain, update it rather than overwriting
- Do not create a Notion entry if the roaster already exists in the Roasters DB — update instead
