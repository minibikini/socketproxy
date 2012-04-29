logger = require 'winston'
type = require('./helpers').type
path = require 'path'

logger.remove logger.transports.Console

logger.addFile = (config) ->
  config.filename = path.resolve process.cwd(), config.file
  @add @transports.File, config
    

logger.addConsole = ->
  @add @transports.Console, colorize: yes 
  @setLevels @config.cli.levels
  @addColors @config.cli.colors

logger.setTransports = (config) ->
  switch type config    
    when 'string' then @addFile file:config
    when 'array' then @setTransports conf for conf in config
    when 'object'
      @addFile config if config.file?

module.exports = logger