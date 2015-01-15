combine = require 'stream-combiner'
split = require 'split'
through = require 'through'
zlib = require 'zlib'

module.exports = ->
  result = undefined
  lineJson = undefined
  tr = through((line) ->
    return  if line.length is 0
    lineJson = JSON.parse(line)
    if lineJson.type is "genre"
      @queue JSON.stringify(result) + "\n"  if result
      result =
        name: lineJson.name
        books: []
    else if lineJson.type is "book"
      result.books.push lineJson.name
    else
      console.warn "Unknown type."
    return
  , ->
    @queue JSON.stringify(result) + "\n"  if result
    @queue null
    return
  )

  # read newline-separated json,
  # group books into genres,
  # then gzip the output
  combine split(), tr, zlib.createGzip()