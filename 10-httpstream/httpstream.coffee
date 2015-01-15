trumpet = require 'trumpet'
through = require 'through'

#set up through callbacks
write = (buffer)->
  @queue buffer.toString().toUpperCase()

end = ()->
  @queue null
#set up through
transform = through write,end
#init trumpet
trump = trumpet()

#create stream from trumpet
loud = trump.select('.loud').createStream()
#adjust the relevant html
loud.pipe transform
.pipe loud

#process from in to out
process.stdin.pipe(trump).pipe(process.stdout)