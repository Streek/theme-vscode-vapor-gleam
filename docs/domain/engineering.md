# Engineering

The project uses Node.js with the committed npm lockfile and `@vscode/vsce`. `make check` runs metadata validation, creates a local VSIX, and checks the package. `npm run check:metadata`, `npm run package`, and `npm run check:vsix` are the component scripts.

The theme JSON is the product source. VSIX files are generated local artifacts and must not be committed.
