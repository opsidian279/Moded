import { readFileSync } from "fs";
import { join } from "path";

export default function handler(req, res) {
  const ua = req.headers["user-agent"] || "";
  const isRoblox =
    req.headers["roblox-id"] ||
    req.headers["roblox-game-id"] ||
    ua.includes("Roblox");

  if (isRoblox) {
    const lua = readFileSync(join(process.cwd(), "code.lua"), "utf8");
    res.setHeader("Content-Type", "text/plain");
    return res.status(200).send(lua);
  }

  res.setHeader("Content-Type", "text/html");
  return res.status(404).send(`<!DOCTYPE html>
<html>
<head><title>404 Not Found</title></head>
<body>
<h1>Not Found</h1>
<p>The requested URL was not found on this server.</p>
<hr>
<address>Apache/2.4.41 (Ubuntu) Server</address>
</body>
</html>`);
}
