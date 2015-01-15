


`function write(buffer) {var data = buffer.toString();this.queue(data.toUpperCase());}`
end = ()->
  @queue null

through = require 'through'
tr = through(write,end)

process.stdin.pipe(tr).pipe(process.stdout)