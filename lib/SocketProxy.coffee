net = require 'net'

logger = null

module.exports = class SocketProxy
  constructor: (@config, loggerInstanse = console)->
    logger = loggerInstanse
    # logger.debug 'Config: ', @config
    @proxy rule for rule in @config.rules

  proxy: (rule) ->
    sourceName = "#{rule.source.host}:#{rule.source.port}"
    destName = "#{rule.dest.host}:#{rule.dest.port}"
    
    server = net.createServer (conn)->
      conn.pause()
      clientName = "#{conn.remoteAddress}:#{conn.remotePort}"
      
      logger.info "#{clientName} connected to #{sourceName}"
      
      dest = net.connect rule.dest.port, rule.dest.host, ->
        conn.pipe dest
        dest.pipe conn
        conn.resume()
      
      conn.on 'end', -> logger.info "#{clientName} disconnected from #{sourceName}"
      
      dest.on 'error', (err)-> 
        conn.end()
        switch err.code 
          when 'ETIMEDOUT'
            logger.error "Connection timeout: #{clientName} to #{destName} via #{sourceName}"
          when 'ECONNREFUSED'
            logger.error "Connection refused: #{clientName} to #{destName} via #{sourceName}"
          else logger.error "Unknown error: ", err        
      
    server.listen rule.source.port, rule.source.host, ->
      logger.info "Forwading #{sourceName} to #{destName}"