# Brewing Dealers (brewingdealers.com) — field locations

Labels are in English in the product description area:

| Field | Label on page |
|---|---|
| Country | Not labeled — extract from Region string if country name appears at the end (e.g. "Huila - Colombia" → Country: Colombia, Region: Huila). Leave blank if country is not in region string. |
| Region | "Region:" — strip country name from end if present |
| Farm | "Farm:" |
| Altitude | Not present — leave blank |
| Variety | "Varietal:" |
| Process | "Process:" |
| Cata Notes | "Tasting Notes:" or "Notes:" — either label may appear, or just an unlabeled paragraph after the origin fields |
| SCA Score | Not present — leave blank |

Also a Shopify store — use the JSON API for prices and images:
`curl https://brewingdealers.com/products/<slug>.json`

Price 250g → variant with "250" in title → `price` (if no weight variants exist, use the single product price under Price 250g online)
Price 1kg → variant with "1kg" or "1000" in title → `price` (may not exist)
Image → `product.images[0].src`
Roast Profile → check "Roast:" label on page or variant titles: Espresso only → Espresso; Filter only → Filter; both present → Omni

## Bundles

Skip products with "X2", "X3", or "X4" in the title — these are multi-bag packs, not individual offerings.
