const fs = require("node:fs");
const path = require("node:path");

const root = path.resolve(__dirname, "..");
const packageJson = JSON.parse(fs.readFileSync(path.join(root, "package.json"), "utf8"));
const themePath = path.join(root, "themes", "Vapor Gleam-color-theme.json");
const changelog = fs.readFileSync(path.join(root, "CHANGELOG.md"), "utf8");

JSON.parse(fs.readFileSync(themePath, "utf8"));
if (!/^\d+\.\d+\.\d+$/.test(packageJson.version)) {
  throw new Error(`Invalid extension version: ${packageJson.version}`);
}
if (!changelog.includes(`## [${packageJson.version}]`)) {
  throw new Error(`CHANGELOG.md has no entry for ${packageJson.version}`);
}
if (!packageJson.contributes?.themes?.some((theme) => theme.path === "./themes/Vapor Gleam-color-theme.json")) {
  throw new Error("package.json does not reference the Vapor Gleam theme");
}

console.log(`Metadata and theme JSON are valid for v${packageJson.version}.`);
