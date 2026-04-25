# Nerja Coffee Roasters (nerjacoffeeroasters.com) — field locations

Notion page URL: https://www.notion.so/34df2b14316c8152a7b4d141138c0660

Spanish labels. WooCommerce site. Fields in the description body. Country not labeled — extract from page `<title>` (pattern: "Café [descriptor] de [Region], [Country] - Nerja Coffee Roasters").

| Field | Label on page |
|---|---|
| Country | Not labeled — take last word before " - Nerja" in page `<title>` |
| Region | "Región:" in description body |
| Farm | Not labeled — check description for "Finca" or producer name |
| Altitude | "Altitud:" — strip trailing "m" and range separator (e.g. "1900 m – 2200 m" → "1900-2200") |
| Variety | "Variedades:" in description body |
| Process | "Proceso:" in description body |
| Cata Notes | "Notas de cata:" (also shown in the short description above the price) |
| SCA Score | Not present — leave blank |
| Roast Profile | "Perfil de tueste:" in description body — "Omniroast" → Omni, "Filtro" → Filter; if both listed → Omni (most common for their beans) |

## Pricing and images — WooCommerce

Not a Shopify store. Prices come from `data-product_variations` attribute on the product page:

```js
JSON.parse(document.querySelector('[data-product_variations]').getAttribute('data-product_variations'))
```

Price 250g → variant where `attributes.attribute_peso === "250g"` → `display_price`
Price 1kg → variant where `attributes.attribute_peso === "1kg"` → `display_price`

Image → `document.querySelector('.woocommerce-product-gallery img')?.src`

## Roast Profile note

Products offer multiple roast profiles on the same page (e.g. "1. Omniroast – Medio, 2. Filtro – Ligero"). Set Roast Profile to the first listed (usually Omni). The Notion field only holds one value.

## Exclusions

Skip: gift packs (Pack de Regalos category), accessories (Accesorios category), equipment (Aeropress, V60, etc.). Only add products from the Café category (`/product-category/cafe/`).
