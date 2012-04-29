net = require 'net'

server = net.createServer (conn) ->
  clientName = "#{conn.remoteAddress}:#{conn.remotePort}"
  console.log "#{clientName} connected"
  conn.once 'end', -> console.log "#{clientName} disconnected"
  conn.pipe conn
  conn.on 'data', (data) -> console.log "#{clientName}: #{data}"


port = 4001
server.listen port, -> console.log "Test Server listening at #{port}"
