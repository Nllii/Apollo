// // this is used to ping the xmmp servers with a message of any type (text, image, etc) for the server to send to the client
// find the path to the xmpp folder and load modules
// var concat = require('./services/workflow_ping/node_modules/concat-stream');
// var toml = require('./services/workflow_ping/node_modules/toml');
// var fs = require('fs');
// var path = require('path');
const { client, xml } = require("./services/workflow_ping/node_modules/@xmpp/client");
// const debug = require("./services/workflow_ping/node_modules/@xmpp/debug");
const xmpp = client({
  service: "xmpp://",
  domain: "",
  username: "",
  password: "",
});

// debug(xmpp, false);

xmpp.on("error", (err) => {
  console.error(err);
});

xmpp.on("offline", () => {
  console.log("offline");
});

xmpp.on("stanza", async (stanza) => {
  if (stanza.is("message")) {
    await xmpp.send(xml("presence", { type: "unavailable" }));
    await xmpp.stop();
  }
});

xmpp.on("online", async (address) => {
  // Makes itself available
  await xmpp.send(xml("presence"));

  // Sends a chat message to itself
  const message = xml(
    "message",
    { type: "chat", to: address },
    xml("body", {}, "server is online!."),
  );
  await xmpp.send(message);
});

xmpp.start().catch(console.error);