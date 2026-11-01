const fs = require("node:fs");
const path = require("node:path");
const { execFileSync } = require("node:child_process");

const root = path.resolve(__dirname, "..");
const packageJson = JSON.parse(fs.readFileSync(path.join(root, "package.json"), "utf8"));
const artifact = path.join(root, `${packageJson.name}-${packageJson.version}.vsix`);

if (!fs.existsSync(artifact)) {
  throw new Error(`VSIX artifact not found: ${path.basename(artifact)}`);
}

const entries = execFileSync("unzip", ["-Z1", artifact], { encoding: "utf8" })
  .split("\n")
  .filter(Boolean);
for (const required of ["extension/package.json", "extension/themes/Vapor Gleam-color-theme.json"]) {
  if (!entries.includes(required)) {
    throw new Error(`VSIX is missing required entry: ${required}`);
  }
}

console.log(`VSIX artifact is valid: ${path.basename(artifact)} (${entries.length} entries).`);
