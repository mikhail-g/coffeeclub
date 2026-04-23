# La Hacienda (lahacienda.es) — field locations

Notion page URL: https://www.notion.so/344f2b14316c81bd81bad3713a3e735c

Spanish labels; WooCommerce (WordPress). Product pages use uppercase label prefixes like "REGIÓN:", "VARIEDAD:", etc. Country is often the product heading (e.g., "Brasil"). Images are served from wp-content uploads.

La Hacienda packages commonly: 250g, 500g, 1.000g.

| Field | Label on page |
|---|---|
| Country | Not labeled — use product title (heading) for country (e.g., "Brasil") |
| Region | "REGIÓN" |
| Farm | Not present / Not labeled — none found (no "FINCA" line) |
| Altitude | "ALTURA" — values include units (m.) — strip non-numeric when parsing |
| Variety | "VARIEDAD" |
| Process | "PROCESO" |
| Cata Notes | "NOTAS DE CATA" |
| SCA Score | "PUNTUACIÓN SCA*" (or similar) — use numeric value if present |

Also: not a Shopify store — use page DOM for prices and images (main images live under `wp-content/uploads`).

Price rules:
- Price for 250g is the visible product price when 250 GRS. is selected (page shows prices per selected size).
- Price 1kg (1.000 GRS.) is available via the size radio — read the price element after selecting that option when scraping.

Image rule:
- Use the product gallery images (first image under product media, typically a `/wp-content/uploads/` URL).

Exclusions
- Skip bundle products (e.g., "Pack Degustación") when adding beans — those are multi-origin packs, not single-origin beans.
