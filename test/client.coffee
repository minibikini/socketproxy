net = require 'net'

dest = net.createConnection 1051
dest.write 'hui'