
duplexer = require 'duplexer'
through = require 'through'


module.exports = (counter)->
  #create an object to store counts
  counts = {}

  #set up transform
  write = (line)->
    #check the country exists and add 1 or make a new line and add 1
    counts[line.country] = (counts[line.country] or 0) + 1

  end = ()->
    #on end of stream call required function
    counter.setCounts(counts)
  #set up transform
  check = through write,end
  #return duplex stream
  duplexer check, counter


