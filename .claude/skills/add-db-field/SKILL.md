---
description: Add a new property/column to any Notion database in the project
allowed-tools: mcp__notion__notion-update-data-source, mcp__notion__notion-fetch, mcp__notion__notion-search, Bash
---

Add a new field to a Notion database: $ARGUMENTS

## Input format

```
/add-db-field <DB name> | <field name> | <field type> [| <options>]
```

Examples:
- `/add-db-field Beans | Roast Date | date`
- `/add-db-field Roasters | Country | text`
- `/add-db-field Tries | Mood | select | Great:green, Okay:yellow, Bad:red`
- `/add-db-field Beans | Decaf | checkbox`

Supported field types: `text`, `number`, `date`, `checkbox`, `url`, `select`, `multi_select`

## Process

### 1. Parse arguments

Split `$ARGUMENTS` on `|` and trim each part:
- `db_name` — database to add the field to
- `field_name` — name of the new column
- `field_type` — type of the new column (see supported types above)
- `options` — required for `select` / `multi_select`: comma-separated `label:color` pairs (e.g. `Yes:green, No:red`). If type is select or multi_select and options are missing, ask the user before continuing.

### 2. Look up the database by name

Use `notion-search` to find the database matching `db_name` (case-insensitive). Extract its data source ID.
If no match is found, stop and report — do not guess.

### 3. Check the field doesn't already exist

Fetch the DB schema with `notion-fetch` on the data source ID.
If a property with the same name already exists, stop and inform the user.

### 4. Build the ADD COLUMN SQL

| Type | SQL fragment |
|---|---|
| text | `TEXT` |
| number | `NUMBER` |
| date | `DATE` |
| checkbox | `CHECKBOX` |
| url | `URL` |
| select | `SELECT('option1':color, 'option2':color, ...)` |
| multi_select | `MULTI_SELECT('option1':color, 'option2':color, ...)` |

Full statement: `ADD COLUMN "<field_name>" <type_fragment>`

For options without an explicit color, use `default`.

### 5. Apply the change

Call `notion-update-data-source` with:
- `data_source_id`: the DB's data source ID from step 2
- `operation`: the `ADD COLUMN` SQL from step 4

### 6. Update the spec file

Look for `specs/<db_name_lowercase>-db.md` in the project (e.g. `Beans` → `specs/beans-db.md`).
If it exists, append a row to the fields table:
`| <field name> | <type> | <description if clear from context, else blank> |`
If no spec file exists, skip and note it in the report.

### 7. Report

- Field name and type added
- DB name and Notion URL
- Whether the spec file was updated

## Rules

- Do not add relation fields — they require a target data source ID and are out of scope for this skill
- Never overwrite an existing field — if the name already exists, stop
