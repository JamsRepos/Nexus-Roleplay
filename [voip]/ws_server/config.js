module.exports = {
  //-- [REQUIRED] IPv4 Address of your teamspeak 3 server
  TSServer: "185.141.207.151",

  //-- [REQUIRED] Port of the ws_server
  WSServerPort: 3000,

  //-- [OPTIONAL] IPv4 Address of the ws_server
  //-- Set by autoconfig
  WSServerIP: "185.141.207.151",

  //-- [OPTIONAL] IPv4 Adress of your FiveM server
  //-- Set by autoconfig if you run ws_server as FXServer resource or standalone on the same machine
  FivemServerIP: "185.141.207.151",

  //-- [OPTIONAL] Port of your FiveM Server
  //-- Set by autoconfig if you run ws_server as FXServer resource
  FivemServerPort: 30120,

  //-- [OPTIONAL] Enable connection/disconnection logs
  enableLogs: false,
};
