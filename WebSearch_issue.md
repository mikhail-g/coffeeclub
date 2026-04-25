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

## Attempted local-proxy fix — why it cannot work

A `BedrockSchemaNormalizerPlugin` was added to the local SSO proxy (priority 17, `codemie-claude` agent only) to recursively convert `"type": "<scalar>"` → `"type": ["<scalar>"]` in all tool `input_schema` objects before forwarding to the CodeMie API.

This caused a new regression on **every** request (not just WebSearch):

```
tools.0.custom.input_schema.type: Input should be 'object'
Received Model Group=claude-sonnet-4-6
```

The CodeMie API validates the incoming request body against the **Anthropic API schema** before passing it to litellm. That schema requires `input_schema.type` to be the literal string `"object"`. Normalizing it to `["object"]` in the local proxy violates that upstream validation.

**Conclusion**: The normalization window that would satisfy both validators (after Anthropic validation, before Bedrock conversion) is inside litellm on the CodeMie server. It cannot be applied from the client side. The fix must be made server-side by the CodeMie proxy maintainers.
