FROM alpine:3.20
RUN apk add --no-cache nodejs npm
WORKDIR /app
RUN npm init -y && npm install express compression axios
RUN printf 'const express = require("express");\nconst compression = require("compression");\nconst axios = require("axios");\nconst app = express();\napp.use(compression({ level: 9, threshold: 0 }));\napp.get("/", (req, res) => res.send("CloudTurbo Engine Active"));\napp.get("/fetch", async (req, res) => {\n  try {\n    const target = req.query.url;\n    if (!target) return res.status(400).send("Missing url");\n    const response = await axios.get(target, {\n      responseType: "stream",\n      timeout: 15000,\n      headers: { "User-Agent": "Mozilla/5.0 (Linux; Android 15; Pixel 9 Pro XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36", "Accept-Encoding": "gzip, deflate, br" }\n    });\n    res.set("Content-Type", response.headers["content-type"] || "text/html");\n    res.set("Cache-Control", "public, max-age=300");\n    response.data.pipe(res);\n  } catch (e) { res.status(502).send("Cloud Fetch Error: " + e.message); }\n});\napp.listen(5800, "0.0.0.0", () => console.log("CloudTurbo Ready on 5800"));\n' > server.js
EXPOSE 5800
CMD ["node", "server.js"]
