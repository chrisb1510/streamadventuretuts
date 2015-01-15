concat = require 'concat-stream'

process.stdin.pipe( concat (buffer)->
  data =  buffer.toString().split('').reverse().join('')
  console.log data
)

#this doesn't need to pipe to stdout because of concat according to github