#!/usr/bin/env bash
# Set one or more values on a Notion multi-select property.
# Usage: set-multi-select.sh <page-id> <property-name> <value1> [value2] ...
# Example: set-multi-select.sh 34df2b14-316c-8152-a7b4-d141138c0660 "Roast Style" Omni Filter
#
# Page ID must be in dashed UUID format.
# NOTION_ACCESS_KEY must be set in the environment (loaded from .env).

set -euo pipefail

PAGE_ID="$1"
PROPERTY="$2"
shift 2

if [[ -z "${NOTION_ACCESS_KEY:-}" ]]; then
  echo "Error: NOTION_ACCESS_KEY is not set" >&2
  exit 1
fi

# Build the multi_select array from remaining args
OPTIONS=$(printf '{"name": "%s"},' "$@" | sed 's/,$//')

curl -s -X PATCH "https://api.notion.com/v1/pages/${PAGE_ID}" \
  -H "Authorization: Bearer $NOTION_ACCESS_KEY" \
  -H "Notion-Version: 2022-06-28" \
  -H "Content-Type: application/json" \
  -d "{\"properties\": {\"${PROPERTY}\": {\"multi_select\": [${OPTIONS}]}}}"
