# Agent templates

Starter files for AI coding agents working on a project that uses
lean-manifests. **These are not active configuration for this repo.**
Copy what you need to your project root and customize the marked
sections.

## What's here

| File | For |
|------|-----|
| `CLAUDE.md` | Claude / Anthropic-shaped agents (Kiro CLI, Claude Code, etc.) |
| `AGENTS.md` | Generic agent config; format-agnostic |

If your tool uses a different convention (`gemini.md`,
`.cursorrules`, `.aiderconfig`, …), copy `AGENTS.md` and rename it
to whatever your tool reads.

## How to use

1. Copy the template to your project root:
   ```
   cp lean-manifests/templates/CLAUDE.md /path/to/your-project/CLAUDE.md
   ```

2. Look for `<!-- BEGIN: project-specific -->` and
   `<!-- END: project-specific -->` markers. The content between them
   needs to be filled in for your project (build commands, file
   paths, etc.).

3. The content marked `<!-- BEGIN: lean-manifests -->` is generic
   workflow guidance for using the manifest discipline. Keep it
   unless you're not using lean-manifests.

4. Delete the marker comments themselves once you're done
   customizing — they're just guides.

## Why these exist

lean-manifests' value proposition rests on a workflow: agents (and
humans) consult theorems before modifying functions, treating the
manifest as a design specification, not just a build-time tripwire.

Without a starter document like this, every project that adopts
lean-manifests has to invent the workflow from scratch. The agent
shows up with no guidance, modifies code, and finds out at build
time whether anything broke. That's the failure mode.

These templates are the seed: copy them, customize, get a working
manifest-aware agent on day one.

## Contributing

If your project ends up with a useful `CLAUDE.md` or `AGENTS.md`
specialization (e.g., for a domain-specific Lean library), consider
contributing it back here as `templates/CLAUDE.<domain>.md`.
