# Mountain Coffee (specialtymountaincoffee.com) — field locations

Notion page URL: https://www.notion.so/342f2b14316c812ebde7dd61f69f6900

Spanish labels as `<strong>` tags inline in the product summary area (not in description tabs). ORIGEN contains both country and region on one line.

| Field | Label on page |
|---|---|
| Country | "ORIGEN:" — first part before "–" (e.g. "Angola – Quibala, Cuanza Sul" → "Angola") |
| Region | "ORIGEN:" — part after "–" (e.g. "Quibala, Cuanza Sul") |
| Farm | "FINCA:" |
| Variety | "VARIEDAD:" |
| Process | "PROCESO:" → map to: Washed / Natural / Honey / Anaerobic / Other |
| Altitude | "ALTITUD:" — number only, strip "msnm" |
| Cata Notes | "NOTAS:" |
| SCA Score | Not present anywhere on site — always leave blank |

WooCommerce site — use `data-product_variations` for prices and image:

```js
JSON.parse(document.querySelector('[data-product_variations]').dataset.product_variations)
```

Each variation has:
- `attributes.attribute_pa_peso` → weight: `"250g"` or `"1000g"`
- `display_price` → numeric price
- `image.url` → full product image URL

Price 250g → variation where `attribute_pa_peso === "250g"` → `display_price`
Price 1kg → variation where `attribute_pa_peso === "1000g"` → `display_price`
Image → `v.image.url` from any variation (all share the same image)

Roast Profile → grind options include both "Molido Filtro" AND "Molido Espresso" → always **Omni**

Description → "Descripción" tab content (first tab, visible by default).

## Exclusions

Skip equipment (grinders, kettles, scales, V60, AeroPress, Chemex) — the store sells both coffee and gear.
