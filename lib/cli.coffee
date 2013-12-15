process.title = 'SocketProxy'

pkg = require '../package'
cli = require 'commander'
path = require 'path'
SocketProxy = require '../lib/SocketProxy'
logger = require '../lib/logger'

parseAddrPort = (val)->
  val = val.split ':'
  host: val[0], port: val[1]

cli.version pkg.version
cli.option '-c, --config <path>', 'Path to config. Defaults to ./socketproxy[.js/.json/.coffee]'
cli.option '-s, --source <host:port>', 'Source host and port. Example: 192.168.1.2:5000', parseAddrPort
cli.option '-d, --dest <host:port>', 'Destination host and port. Example: google.com:80', parseAddrPort
# cli.option '-l, --log <path>', "Path to logfile. Ignored if logger specified in config."
cli.option '-q, --quiet', "quiet (no output)."
cli.option '-v, --verbose', "be verbose (this is the default)."


# cli.command('setup').description('run remote setup commands').action ->
#   console.log('setup')

cli.parse process.argv

try
  if cli.source and cli.dest
    config = rules: [{source: cli.source, dest: cli.dest}]
  else
    configPath = path.resolve process.cwd(), cli.config or './socketproxy'
    config = require configPath
catch error
  console.log "Can't locate config file at #{configPath}. You need specify path to config file via -c option or use combination of -s and -d options."
  console.log "Run 'socketproxy -h' to see available argument options"
  process.exit 1

logger.addConsole() unless cli.quiet
logger.setTransports config.log if config.log?

new SocketProxy config, logger