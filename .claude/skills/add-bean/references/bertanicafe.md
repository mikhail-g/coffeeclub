# Bertani Café (bertanicafe.com) — field locations

Simple website builder (not Shopify — no JSON API). Labels are in Spanish as `<strong>` tags inside the product description block. **Label names are inconsistent across products** — check all variants below.

| Field | Possible labels |
|---|---|
| Country | "País de origen:" or "Origen:" — extract the country name; everything after on the same line may be region |
| Region | Same line as country — after "región", "Zona:", or as the trailing part after the country name (e.g. "BRASIL Santa Cecilia" → region = Santa Cecilia) |
| Farm | "Finca o zona:" or "Finca :" |
| Altitude | "Altura:" or "ALTURA :" — number before "msnm" or "MSNM"; strip comma separators (e.g. "1,450" → "1450") |
| Process | "Proceso:" — map to standard values |
| Variety | "Varietal:", "Varietal :" — present only on some products |
| Cata Notes | "Notas:" or "Notas de cata:" |

No SCA Score field on any product page — always leave blank.

Some products include a one-line header (e.g. "MICROLOTE ESPECIAL") before the labeled fields — put it in Description.

## Pricing

Single price per product — no weight variants, only grind type options (En grano, Italiana, Expresso, Filtro de papel, Prensa francesa). Bag size is not stated on the site. Record the price under **Price 250g online (€)** as the best approximation.

## Roast Profile

Infer from the grind type dropdown:
- Both "Expresso" and "Filtro de papel" present → Omni
- Filtro de papel only → Filter
- Expresso / Italiana only → Espresso

## Image

Extract from the Pinterest share link in the social share section at the bottom of the page:

```
/url: https://pinterest.com/pin/create/button/?url=...&media=<IMAGE_URL>&description=...
```

The `media=` parameter is the product image URL (CloudFront CDN, `.jpg`). URL-decode it if needed.
