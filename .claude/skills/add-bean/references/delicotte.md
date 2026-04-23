# Delicotte (delicotte.eu) — field locations

Notion page URL: https://www.notion.so/34af2b14316c81358962d2269ba3389c

Spanish labels. WooCommerce site — use `data-product_variations` attribute for prices/images (not Shopify JSON API).

| Field | Label on page |
|---|---|
| Country | "Origen:" — country part only (e.g. "Risaralda, Colombia" → "Colombia") |
| Region | "Región:" — city/area (separate from Origen) |
| Farm | Not labeled on observed products — leave blank if absent |
| Altitude | "Altura:" — number only, strip "msnm" |
| Variety | "Variedad:" |
| Process | "Proceso:" → map to: Washed / Natural / Honey / Anaerobic / Other |
| Cata Notes | "Perfil en taza" — descriptors separated by " · " |
| SCA Score | "Puntaje:" |

## Pricing and images (WooCommerce)

No Shopify API. Variation data is embedded in the page:

```js
JSON.parse(document.querySelector('[data-product_variations]').dataset.product_variations)
```

Each variation has:
- `attributes.attribute_pa_tamano` → size: `"200g"` or `"500g"`
- `display_price` → numeric price
- `image.url` → product image URL

Sizes are **200g and 500g** — not 250g/1kg. Map as:
- Price 250g online (€) → price where `attribute_pa_tamano === "200g"` *(note: 200g, not 250g)*
- Price 1kg online (€) → price where `attribute_pa_tamano === "500g"` *(note: 500g, not 1kg)*

> Leave a note in the bean's Notes field if the actual size matters (e.g. "200g bag").

Roast Profile → infer from grind options: both filter (V60, Chemex, Aeropress, Cafetera de filtro) and espresso present → **Omni**.

## Exclusions

No bundles or equipment observed in current product listing. All 5 products are single-origin coffees.
