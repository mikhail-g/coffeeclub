# Artisan Coffee (artisancoffee.es) — field locations

Labels are in English inside the description body, not as dedicated page labels:

| Field | Label in description |
|---|---|
| Country | "Origin:" |
| Region | "Region:" |
| Farm | "Estate:" |
| Altitude | "Altitude:" |
| Variety | "Varietal:" |
| Process | "Process:" |
| Cata Notes | "Sensory Profile:" |

Prices and image are not reliably rendered on the page — use the Shopify JSON API instead:
`curl https://artisancoffee.es/en/products/<slug>.json`

Price 250g → first variant with "250" in title and "Bean" in title → `price`
Price 1kg → first variant with "1 Kg" in title and "Bean" in title → `price`
Image → `product.images[0].src`
Roast Profile → check variant titles: if any contain "Filter" AND any contain "Espresso" → Omni; Filter only → Filter; Espresso only → Espresso
