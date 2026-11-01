# Repository Guidance

## Scope

This repository contains the public Vapor Gleam VS Code color theme. Keep the
repository public, but never commit credentials, tokens, private keys, account
IDs, internal hostnames, or protected infrastructure identifiers.

## Development

- Use the Node.js version in `.tool-versions`.
- Install with `npm ci` so `package-lock.json` remains authoritative.
- Run `make check` before submitting changes.
- Treat `themes/Vapor Gleam-color-theme.json` as the product source.
- Keep generated `.vsix` files out of commits.

## Publishing

`make check` and `npm run package` never publish. Publishing is a separate,
interactive operation: run `make publish-only` and type `PUBLISH` at the
prompt. Marketplace credentials must be supplied by the VS Code tooling or
environment at publish time and must not be stored in this repository.

Do not publish from automated checks, editor build tasks, or scripts that run
as part of validation. Confirm the version in `package.json`, `CHANGELOG.md`,
and `README.md` before an intentional release.

## Documentation

Update `STYLE.md`, `RELEASE.md`, `TODO.md`, and the changelog when their facts
become stale. Keep examples and fixtures free of real credentials and private
infrastructure details.
