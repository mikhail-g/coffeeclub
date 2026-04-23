# Santa Coffee (santacoffee.es) — field locations

Notion page URL: https://www.notion.so/34af2b14316c8166868ce9aa0b1ffc5d

English labels. WooCommerce site — use `data-product_variations` attribute for prices/images.

| Field | Label on page |
|---|---|
| Country | "ORIGIN:" — country name only |
| Region | "DEPARTMENT:" — department/region name |
| Farm | "FINCA:" |
| Altitude | "HEIGHT:" — number only, strip "masl" |
| Variety | "VARIETY:" |
| Process | "PROCESS:" → map to: Washed / Natural / Honey / Anaerobic / Other |
| Cata Notes | "TASTING NOTES:" |
| SCA Score | "SCA:" — number only, strip " points" |
| Roast Profile | "RECOMMENDED:" label on page (e.g. "FOR FILTER") → Filter; if both filter and espresso grind options present → Omni |

## Pricing and images (WooCommerce)

No Shopify API. Variation data is embedded in the page:

```js
JSON.parse(document.querySelector('[data-product_variations]').dataset.product_variations)
```

Each variation has:
- `attributes.attribute_pa_tamano` → size: `"250-gr"` or `"1-kg"`
- `display_price` → numeric price
- `image.url` → product image URL

Sizes are **250g and 1kg** — standard sizes. Map as:
- Price 250g online (€) → price where `attribute_pa_tamano === "250-gr"`
- Price 1kg online (€) → price where `attribute_pa_tamano === "1-kg"`

Image → `v.image.url` from any variation (all share the same image).

## Exclusions

Skip equipment, merchandise, and gift packs. Filter for single-origin coffee products only.
