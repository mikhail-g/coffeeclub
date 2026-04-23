# Kima Coffee (kimacoffee.com) — field locations

Notion page URL: https://www.notion.so/344f2b14316c81cd96a4e4aa44a72d59

Labels are in Spanish in the product description area, not under standard "ORIGEN:" / "FINCA:" headings:

| Field | Label on page |
|---|---|
| Country | Not labeled — infer from product title ("Cafe de kenia" → Kenya) or image alt text |
| Region | "Región:" |
| Farm | Not labeled — infer from product title and image alt text (e.g. "finca njuriga") |
| Altitude | "Altitud:" — strip "msnm", preserve range format (e.g. "1700-1815") |
| Variety | "Varietal:" |
| Process | "Proceso:" |
| Cata Notes | "Perfil Sensorial:" |

Also a Shopify store — use the JSON API for prices and images:
`curl https://kimacoffee.com/products/<slug>.json`

Price 250g → variant with "250" in title and "grano" in title (case-insensitive) → `price` (variant title may be "250 grs / Grano" or "250 grs / En grano" or "250grs / En grano")
Price 1kg → variant with "Kg" in title and "grano" in title (case-insensitive) → `price`
Image → `product.images[0].src`
Roast Profile → check variant titles: if any contain "espresso" AND any contain "filtro" → Omni; filtro only → Filter; espresso only → Espresso
