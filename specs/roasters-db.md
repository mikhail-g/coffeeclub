# Spec: Roasters Database (Notion)

## Intent

A single, structured source of truth for every roaster considered or used for sourcing. The goal is to answer three questions at a glance:

1. Is this roaster worth buying from?
2. What can I get from them?
3. How do I buy it?

This DB drives sourcing decisions — which roasters to rotate through, which to avoid, where to get decaf. It is not a review or ranking system.

---

## Scope

All roasters evaluated for sourcing: Malaga first, then Spain, then Canary Islands. A roaster is added when it is tried or seriously considered — not as a catalogue of every roaster in existence.

Not in scope:

- Cafes that do not roast their own beans (separate DB or file)
- Individual bean entries (separate DB)
- Roasters outside Spain unless they ship reliably to Malaga

---

## Fields

### Identity

| Field | Type | Depth |
|---|---|---|
| Name | Title | Full trading name as used publicly |
| Address | Text | Street + neighborhood + city. Enough to find the physical location. |
| Location | URL | Google Maps link for navigation. Complements Address — Address for reading, Location for getting there. |
| Site | URL | Main website or online shop |
| Shop URL | URL | Direct link to the page listing all coffee offerings. Different from Site (homepage). Used by update-roaster skill. |
| Instagram | URL | Primary social account — useful for tracking new bean releases |

### Sourcing logistics

| Field | Type | Depth |
|---|---|---|
| Buy In Person | Checkbox | Can you walk in and buy? |
| Free Delivery From (€) | Number | Minimum order for free national shipping. Leave blank if no free delivery. |
| Delivery Organization | Text | Courier name (e.g. Correos, MRW, SEUR). Leave blank if unknown. |

### Quality signals

| Field | Type | Depth |
|---|---|---|
| Roast Date Provided | Checkbox | Is the roast date (not best-before) printed on the bag? |
| SCA Score Provided | Checkbox | Are SCA/Q Grader scores listed per coffee? |
| Roast Style | Select | Filter / Espresso / Omni. Primary style offered, not exhaustive. |
| Decaf Available | Checkbox | Is at least one decaf option in the current range? |

### Judgment

| Field | Type | Depth |
|---|---|---|
| Rating | Number (1–5) | Overall quality based on personal experience. Leave blank until tried. |
| Notes | Text | Personal observations: known strengths, known flaws, freshness reliability, value. Updated over time. |

### Connections

| Field | Type | Depth |
|---|---|---|
| Beans | Relation → Beans DB | Synced from Beans.Roaster (two-way). Shows all beans offered by this roaster. |

---

## Implementation reference

**Notion database URL:** https://www.notion.so/cd3460f960d246bf9fac4487644442c8
**Data source ID:** d38df7d9-d3b7-4a6b-8db2-dcc0398baad4

Column order and types as implemented (do not reorder):

| # | Field | Notion type | Values |
|---|---|---|---|
| 1 | Name | title | |
| 2 | Site | url | |
| 3 | Shop URL | url | |
| 4 | Instagram | url | |
| 5 | Free Delivery From (€) | number | blank = no free delivery |
| 6 | Delivery Organization | text | |
| 7 | Buy In Person | checkbox | `__YES__` / `__NO__` / blank |
| 8 | Location | place | Google Maps link |
| 9 | Address | text | |
| 10 | Rating | number | 1–5, blank until tried |
| 11 | Roast Date Provided | checkbox | `__YES__` / `__NO__` |
| 12 | SCA Score Provided | checkbox | `__YES__` / `__NO__` |
| 13 | Roast Style | select | Filter / Espresso / Omni |
| 14 | Decaf Available | checkbox | `__YES__` / `__NO__` |
| 15 | Notes | text | |
| 16 | Beans | relation | → Beans DB, synced two-way |

---

## Open questions

None.
