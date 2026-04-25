# WebSearch Broken — Bedrock Schema Incompatibility

## Summary

WebSearch calls fail with a `400 Bad Request` when routed through the CodeMie proxy to AWS Bedrock.

## Error

```
litellm.BadRequestError: BedrockException
The json schema definition at toolConfig.tools.0.toolSpec.inputSchema is invalid.
$.type: does not have a value in the enumeration [array, boolean, integer, null, number, object, string]
$.type: string found, array expected
Received Model Group=claude-haiku-4-5-20251001
Available Model Group Fallbacks=None
```

## Root cause

The WebSearch tool's `inputSchema` passes `type` as a plain string (`"type": "string"`), but AWS Bedrock's tool spec validator requires it as an array (`"type": ["string"]`). The CodeMie litellm proxy does not normalize the schema before forwarding to Bedrock.

## Config involved

**`~/.codemie/codemie-cli.config.json`**

```json
{
  "activeProfile": "work-coding",
  "profiles": {
    "work-coding": {
      "provider": "ai-run-sso",
      "codeMieUrl": "https://codemie.lab.epam.com",
      "baseUrl": "https://codemie.lab.epam.com/code-assistant-api",
      "model": "claude-sonnet-4-6",
      "haikuModel": "claude-haiku-4-5-20251001"
    }
  }
}
```

WebSearch internally uses a "small, fast model" — CodeMie maps this to `claude-haiku-4-5-20251001` on Bedrock via litellm.

## Where the fix needs to happen

Either:
- The **litellm proxy** at `codemie.lab.epam.com` should normalize `"type": "string"` → `"type": ["string"]` before forwarding to Bedrock
- Or the **Claude Code WebSearch tool schema** should use the array format natively

Both are outside local control. Report to the CodeMie proxy maintainers at EPAM.

## Workaround

Use `playwright-cli` (browser automation) or `WebFetch` with a known URL instead of WebSearch for research tasks.
