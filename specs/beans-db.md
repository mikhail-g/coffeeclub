# Spec: Beans Database (Notion)

## Intent

A catalogue of every coffee product encountered — whether sourced, tried, or just on the radar. The goal is to answer at a glance:

1. What is this coffee and where does it come from?
2. What did it cost?
3. Has it been tried, and how did it go?

This DB is the link between the Roasters DB (who to buy from) and the Tries DB (what it tasted like). It holds product facts that do not change across sessions — origin, process, price. Session-specific observations (flavor, score, recipe) belong in Tries.

---

## Scope

One entry per unique coffee product as offered by a roaster. If the same coffee appears in two bag sizes or under a seasonal label, it is one entry.

Not in scope:

- Tasting notes or brew observations (Tries DB)
- Roaster-level information (Roasters DB)
- Blends from non-specialty commercial brands

---

## Fields

### Identity

| Field | Type | Depth |
|---|---|---|
| Name | Title | Coffee name as labeled by the roaster |
| Roaster | Relation → Roasters DB | Which roaster offers this coffee. Two-way: Roasters DB gains a "Beans" column. |
| URL | URL | Link to the product page on the roaster's website |
| Availability | Select | Available / Unavailable. Set to Available on creation; update-roaster marks Unavailable when no longer found on the roaster's site. |

### Origin

| Field | Type | Depth |
|---|---|---|
| Country | Text | Origin country (e.g. Ethiopia, Colombia) |
| Region | Text | Growing region or area (e.g. Yirgacheffe, Huila) |
| Farm | Text | Farm or cooperative name, if known |
| Altitude | Text | Growing altitude in msnm. Single value ("1250") or range ("1200–1500"). |

### Coffee details

| Field | Type | Depth |
|---|---|---|
| Variety | Text | Cultivar (e.g. Bourbon, Gesha, Caturra). Leave blank if not labeled. |
| Process | Select | Washed / Natural / Honey / Anaerobic / Other |
| Roast Profile | Select | Filter / Espresso / Omni |
| SCA Score | Number | If listed on bag or roaster site. Leave blank if not provided. |
| Cata Notes | Text | Roaster's tasting descriptors as written on product page or bag (e.g. "cacao, nuez, especiado"). Different from personal Flavor Notes in Tries. |
| Decaf | Checkbox | Is this a decaf or low-caf coffee? |

### Pricing

| Field | Type | Depth |
|---|---|---|
| Price 250g online (€) | Number | Price per 250g from online shop |
| Price 250g in person (€) | Number | Price per 250g in-store, if different. Leave blank if same as online or unknown. |
| Price 1kg online (€) | Number | Price per 1kg from online shop. Leave blank if not offered. |
| Price 1kg in person (€) | Number | Price per 1kg in-store, if different. Leave blank if same as online or unknown. |

### Tasting link

| Field | Type | Depth |
|---|---|---|
| Tries | Relation → Tries DB | All tasting sessions for this bean. Two-way: Tries DB holds the primary relation. |

### Media

| Field | Type | Depth |
|---|---|---|
| Image | Files | Photo of the package. Linked from product page or uploaded. Low resolution is fine. |

### Description

| Field | Type | Depth |
|---|---|---|
| Description | Text | Full product description from the roaster — farm story, origin narrative, any brewing recommendations. |

### Notes

| Field | Type | Depth |
|---|---|---|
| Notes | Text | Personal observations: roaster transparency, freshness on arrival, packaging quality. |
| Last Updated | Date | Date when this entry's data was last collected or verified. |

---

## Implementation reference

**Notion database URL:** https://www.notion.so/9a9ec97ce2934ca38b1a3b2f3f9378ad
**Data source ID:** c08fa0f2-84a0-494f-967d-1842a961b10a

Column order and types as implemented (do not reorder):

| # | Field | Notion type | Values |
|---|---|---|---|
| 1 | Name | title | |
| 2 | Roaster | relation | → Roasters DB, two-way |
| 3 | URL | url | Product page link. Property key is `userDefined:URL` in page create/update calls. |
| 3a | Availability | select | Available / Unavailable |
| 4 | Country | text | |
| 5 | Region | text | |
| 6 | Farm | text | |
| 7 | Variety | text | |
| 8 | Altitude | text | msnm, single value or range |
| 9 | Process | select | Washed / Natural / Honey / Anaerobic / Other |
| 10 | Cata Notes | text | |
| 11 | SCA Score | number | blank if not provided |
| 12 | Roast Profile | select | Filter / Espresso / Omni |
| 13 | Decaf | checkbox | `__YES__` / `__NO__` |
| 14 | Image | files | |
| 15 | Price 250g online (€) | number | blank if unknown |
| 16 | Price 1kg online (€) | number | blank if not offered |
| 17 | Price 1kg in person (€) | number | blank if same as online or unknown |
| 18 | Price 250g in person (€) | number | blank if same as online or unknown |
| 19 | Description | text | |
| 20 | Notes | text | |
| 21 | Last Updated | date | |
| 22 | Tries | relation | → Tries DB, two-way (synced from Tries side) |

---

## Open questions

None.
