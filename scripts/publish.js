const readline = require("node:readline");
const { spawn } = require("node:child_process");

if (!process.stdin.isTTY || !process.stdout.isTTY) {
  throw new Error("Publishing requires an interactive terminal. Use npm run publish:only from a terminal.");
}

const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
rl.question("Type PUBLISH to publish this extension to the marketplace: ", (answer) => {
  rl.close();
  if (answer !== "PUBLISH") {
    console.error("Publish cancelled.");
    process.exitCode = 1;
    return;
  }

  const child = spawn("npx", ["--no-install", "vsce", "publish", "--no-dependencies"], {
    stdio: "inherit",
  });
  child.on("exit", (code, signal) => {
    process.exitCode = code ?? (signal ? 1 : 0);
  });
});
