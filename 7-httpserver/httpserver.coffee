through = require 'through'
http = require 'http'
port = 8000

server =->
  write = (buffer)->
    @queue buffer.toString().toUpperCase()

  end = ()->
    @queue null

  server = http.createServer (request,response)->
    if request.method is 'POST'
      request.pipe( through(write,end))
      .pipe response
  .listen port

module.exports = {Server:server}
