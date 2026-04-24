# Cocóra (cocoracoffee.es) — field locations

Notion page URL: https://www.notion.so/34cf2b14316c80f08f8dc51f9bdd9123

Shopify store with English labels. Fields are in the product `body_html` as an icon-based HTML table — each row has an `<img alt="FieldName">` and a text cell with the value.

| Field | Icon alt text | Notes |
|---|---|---|
| Country | `"Origin"` | Value format: "Region, Country" — take the part **after** the last comma |
| Region | `"Origin"` | Value format: "Region, Country" — take the part **before** the last comma |
| Farm | `"Producer"` | Cooperative or farm name |
| Altitude | `"Growing altitude"` | Strip trailing "m." |
| Variety | `"Beans"` | Comma-separated cultivar names |
| Process | `"Process"` | Already in English |
| Cata Notes | `"Notes"` | Short tasting descriptor line |
| SCA Score | `"SCA rating"` | Format: "84 +" — take the number, ignore "+" |

## Shopify JSON API

```
curl https://cocoracoffee.es/products/<slug>.json
```

Price 250g → variant where `option1 == "250g"` and `option2 == "Whole beans"` → `price`
Price 1kg → variant where `option1 == "1kg"` and `option2 == "Whole beans"` → `price`
Image → `product.images[0].src`

**Roast Profile:** Inferred from available `Grind size` option values:
- Both "Espresso" and any of (Aeropress / Pour over / French press) present → **Omni**
- "Espresso" only → **Espresso**
- Filter options only (no Espresso) → **Filter**

Note: grinding costs €0.50 extra vs. Whole beans — always use Whole beans price for the DB.

## Exclusions

Skip: drip bag packs (`/collections/drip-bag-coffee`), posters, La Marzocco equipment, accessories, CHEMEX® equipment.
