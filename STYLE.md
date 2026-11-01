# Style Guide

Vapor Gleam uses a dark, neon vaporwave visual language inspired by Gleam.
The base surfaces are deep indigo and near-black, with cyan and pale magenta
accents and muted lavender comments.

## Theme Editing

- Keep related UI colors grouped in the `colors` section.
- Keep syntax scopes specific and readable before adding broad fallbacks.
- Preserve the existing two-space JSON indentation.
- Check both contrast and visual hierarchy for text, selections, diagnostics,
  brackets, and terminal colors.
- Use `test/syntax/` fixtures for representative language checks without
  modifying those fixtures as part of unrelated work.
