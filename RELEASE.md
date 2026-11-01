# Release and Credential Guidance

## Release Path

1. Update `package.json`, `CHANGELOG.md`, and the version statement in
   `README.md` together.
2. Run `npm ci` and `make check`.
3. Inspect the generated local VSIX and test it in VS Code.
4. Publish only through `make publish-only`, which requires a terminal prompt
   confirmation.

Checks and packaging use `vsce package --no-dependencies` and do not publish.
There is no CI or editor task that should invoke marketplace publication.

## Credentials

Marketplace authentication is an operator responsibility. Use the supported
VS Code or `vsce` login mechanism at release time. Do not put access tokens,
PATs, private keys, account IDs, credential files, or login output in this
repository, issue reports, logs, or release notes.

Before release, verify the marketplace publisher and extension name
interactively. This project has no AWS, cloud, backend, signing, or protected
infrastructure credentials.

## Dependency Audit

The current locked development toolchain was audited with
`npm audit --omit=optional`. It reports 13 transitive advisories. The available
complete automatic fix requires the breaking `@vscode/vsce` 3.x upgrade, so it
was not applied without compatibility testing. Revisit this before the next
release and validate the new packaging toolchain independently.
