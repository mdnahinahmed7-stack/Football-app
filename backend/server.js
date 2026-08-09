require("dotenv").config();
const express = require("express");
const cors = require("cors");
const http = require("http");
const { Server } = require("socket.io");
const cron = require("node-cron");

const matchesRouter = require("./routes/matches");
const { matches } = require("./data/mockMatches");

const app = express();
app.use(cors());
app.use(express.json());

app.use("/api/matches", matchesRouter);

app.get("/", (req, res) => {
  res.json({ status: "ok", message: "Live Football Score API running" });
});

const server = http.createServer(app);
const io = new Server(server, { cors: { origin: "*" } });

io.on("connection", (socket) => {
  console.log("Client connected:", socket.id);
  socket.emit("matches:init", matches);

  socket.on("disconnect", () => {
    console.log("Client disconnected:", socket.id);
  });
});

cron.schedule("*/60 * * * * *", () => {
  const live = matches.filter((m) => m.status === "LIVE");
  if (live.length) {
    io.emit("matches:update", live);
  }
});

const PORT = process.env.PORT || 4000;
server.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
