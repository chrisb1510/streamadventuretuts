split = require 'split'
through = require 'through'
lineNum = 1

process.stdin.pipe split()
.pipe through (line)->
  if lineNum % 2 is 0
    lineNum++
    console.log line.toString().toUpperCase()
  else
    lineNum++
    console.log line.toString().toLowerCase()
.pipe process.stdout