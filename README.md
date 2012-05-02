# SocketProxy
## WTF?
SocketProxy - is a simple (for the moment) port mapper software. 

## Install
 1. [Install Node.js](http://nodejs.org/#download)
 2. `$ npm install -g socketproxy`

## Fetures
 * Easy configuration
 * Cross-platform (works on Windows too!)

## Quick Start
`$ socketproxy -c path/to/config[.json/.js/.coffee]` 

See `$ socketproxy --help` for all available options.

## Config Example
```json
{
  "rules": [
    {
      "source": {
        "host": "192.168.1.2",
        "port": 5000},
      "dest": {
        "host": "127.0.0.1",
        "port": 5000}
    },{
      "source": {
        "host": "192.168.1.2",
        "port": 5001},
      "dest": {
        "host": "google.com",
        "port": 80}        
    },{
      "source": {
        "host": "0.0.0.0",
        "port": 1022},
      "dest": {
        "host": "192.168.1.3",
        "port": 22}        
    }
  ]
}
```
## TODO
 * More docs
 * More tests
 * Unix file sockets support
 * Middleware support
 	* Compression
 	* RoundRobin

## License

Copyright (c) 2012 Egor Kislitsyn

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.