# Lessons Learned — Working with AI on a Real Project

Notes for a presentation on what actually works (and what doesn't) when building with Claude Code on a non-trivial personal project.

---

## Structuring the work

## Prompting and instruction

## Skills and automation

## Data and integrations (Notion)

- **`notion-search` treats keywords as OR, not AND.** Searching for "Kima Coffee" returns Kima Coffee first — but also Artisan Coffee, Mountain Coffee, Santa Coffee, and Bertani Café, because each of them contains the word "coffee". Any keyword match is enough to include a result; both words matching just scores higher. This means multi-word queries intended to narrow results actually broaden them. Searching for a specific roaster by name when other roasters share common words (like "coffee" or "café") will reliably return the wrong pages. Wrapping the query in quotes (`"Kima Coffee"`) narrows results to pages that *contain* the exact phrase — it returned only Kima Coffee because no other roaster name contains the substring "Kima Coffee". But it is still a *contains* match, not an *is* match: `"Mountain Water"` returns "Descafeinado Mountain Water – Chiapas" because the title contains those words, not because the title equals the query. This means quoted search only works reliably when the phrase is unique enough to not appear as a substring of something else. The reliable fix: store the Notion page URL in a local reference file the first time a roaster is added, then read it directly on every subsequent call — no search needed.

- **`notion-update-page` (and `notion-create-pages`) cannot set multiple values on a multi-select property in a single call.** Passing `"Filter, Espresso, Omni"`, `"Filter,Espresso,Omni"`, or `"Filter | Espresso | Omni"` all fail with a validation error — the MCP treats the entire string as a single option name and rejects it. Only single-value strings work (e.g. `"Omni"`). For properties that genuinely need multiple values, the remaining values must be added manually in the Notion UI. Document this in GAPS.md so it is not forgotten.

- **Relation fields are invisible to `notion-search`.** Searching the Beans DB for "Mountain Coffee" returns zero Mountain Coffee beans — because "Mountain Coffee" only exists in each bean's Roaster relation field, which points to the roaster page but is not indexed as text. Instead it returned a bean called "Descafeinado Mountain Water" (the word "mountain" appeared in the title for unrelated reasons) and other fuzzy noise. To get all beans for a roaster, you must: fetch the roaster's own Notion page and follow the `Beans` relation links. There is no shortcut through search.

## MCP and tool availability

- **When an MCP tool suddenly returns "No such tool available", the first suspect is an expired auth session — not a code or prompt issue.** Mid-session, all Notion MCP tools stopped responding. The natural reaction was to look for something wrong in the skill instructions or the tool call format. It wasn't — the Notion MCP had simply lost its authentication session. Running `/mcp` to reconnect restored everything instantly. Time spent debugging the wrong thing. The lesson: if a tool that was working stops being available without any code change, check the connection and auth state first. A hook can be configured to detect this automatically and alert immediately instead of letting Claude spiral into prompt debugging.

## What surprised me

## What I'd do differently
