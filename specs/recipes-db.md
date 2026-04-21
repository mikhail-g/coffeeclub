# Spec: Recipes Database (Notion)

## Intent

A library of reusable brew recipes — one entry per distinct parameter set. The goal is to answer:

1. Which recipe did I use for a given tasting session, and would I use it again?
2. Does this recipe consistently produce better results on certain bean types?
3. How has my recipe approach evolved over time?

The Tries DB links to a Recipe entry rather than restating brew parameters in full every time. Per-session deviations (grind one step coarser, waited longer after boil) are captured in a separate Adjustments field on the Try, keeping recipes reusable without being rigid.

---

## Scope

One entry per distinct, intentional recipe — a defined parameter set that could be reproduced. Recipes are device-specific but not bean-specific: the same recipe can be used across many different beans.

Not in scope:

- Per-session flavor observations (Tries DB)
- Brewing theory or technique guides (pages/brewing/)
- Equipment reviews or comparisons

---

## Fields

### Identity

| Field | Type | Depth |
|---|---|---|
| Name | Title | Short descriptive label, e.g. "AeroPress Upright – 1:15 Bypass". Should be self-explanatory at a glance. |
| Device | Select | AeroPress / Clever Dripper |
| Variant | Select | Upright / Inverted. AeroPress-specific; leave blank for Clever Dripper. |

### Dose and water

| Field | Type | Depth |
|---|---|---|
| Dose (g) | Number | Coffee dose in grams |
| Brew Water (g) | Number | Water used during the brew itself |
| Bypass Water (g) | Number | Water added to the cup after pressing, if any. Leave blank if not used. |
| Ratio | Text | Total water : coffee, e.g. "1:15". Calculated from Dose + Brew Water + Bypass Water, recorded explicitly for readability. |

### Grind

| Field | Type | Depth |
|---|---|---|
| Grind | Text | Grinder model and setting in one field, e.g. "KINGrinder K6 · 60 clicks". Grinder model is recorded because the same click count means different particle sizes on a different grinder. |

### Temperature

| Field | Type | Depth |
|---|---|---|
| Temperature | Text | Water temperature as it can be described without a thermometer. Record whatever is known: kettle model, seconds after boil, volume boiled, or an estimated °C. E.g. "90s after boil, 500ml in IKEA gooseneck" or "~95°C (assumed)". |

### Timing

| Field | Type | Depth |
|---|---|---|
| Total Brew Time | Text | Duration from first pour to end of press, e.g. "2 min". Prose is fine; no need for a strict format. |

### Procedure

| Field | Type | Depth |
|---|---|---|
| Procedure | Page content | Full step-by-step instructions as body text. Not a property. Captures the parts that don't reduce to numbers: stir direction and count, when to insert the plunger, how to time the press. |

Example step sequence (AeroPress Upright – 1:15 Bypass):

1. Wet grounds with a small splash of water, stir.
2. Add water to 250g.
3. Insert plunger immediately (stops drip — classic upright trick).
4. Wait 90s.
5. Remove plunger, stir N → S → E → W.
6. Reinsert plunger, wait to 2 min total.
7. Press slowly over 1 min.
8. Remove AeroPress from cup. Add 50g bypass water.

---

## Changes to Tries DB

The current `Recipe` text field in Tries DB will be replaced by:

| Field | Change | Notes |
|---|---|---|
| Recipe | text → relation → Recipes DB | References the base recipe used |
| Adjustments | new text field | Per-session deviations from the base recipe, e.g. "coarser grind, +10s after boil". Leave blank when recipe was followed exactly. |

The existing Recipe text value in the one current Tries entry ("Kenia - Mchana 20-04-2026") will be migrated: create a Recipe entry from its content, link it, and clear the old text.

---

## Implementation reference

**Notion database URL:** https://www.notion.so/8dc99dad6d7f432e850c8a76cc724805
**Data source ID:** 9c068ef8-6a96-456c-8d24-05b221062482

| # | Field | Notion type | Values |
|---|---|---|---|
| 1 | Name | title | |
| 2 | Device | select | AeroPress / Clever Dripper |
| 3 | Variant | select | Upright / Inverted |
| 4 | Dose (g) | number | |
| 5 | Brew Water (g) | number | |
| 6 | Bypass Water (g) | number | blank if no bypass |
| 7 | Ratio | text | e.g. "1:15" |
| 8 | Grind | text | grinder model + setting |
| 9 | Temperature | text | free-form proxy, e.g. "90s after boil, 500ml in IKEA gooseneck" |
| 10 | Total Brew Time | text | |
| 12 | Tries | relation | → Tries DB, two-way (synced from Tries side) |

---

## Open questions

None. Bloom details (amount, timing) stay in the Procedure body.
