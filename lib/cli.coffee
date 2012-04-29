pkg = require '../package'
cli = require 'commander'
path = require 'path'
SocketProxy = require '../lib/SocketProxy'
logger = require '../lib/logger'

cli.version pkg.version
cli.option '-c, --config <path>', 'Path to config. Defaults to ./socketproxy[.js/.json/.coffee]'
# cli.option '-l, --log <path>', "Path to logfile. Ignored if logger specified in config."
cli.option '-q, --quiet', "quiet (no output)."
cli.option '-v, --verbose', "be verbose (this is the default)."


# cli.command('setup').description('run remote setup commands').action ->
#   console.log('setup')

cli.parse process.argv

try
  configPath = path.resolve process.cwd(), cli.config or './socketproxy'  
  config = require configPath
catch error
  console.log "Can't locate config file at #{configPath}"
  process.exit 1

logger.addConsole() unless cli.quiet
logger.setTransports config.log if config.log?

new SocketProxy config, logger