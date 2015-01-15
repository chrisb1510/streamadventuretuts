spawn = require('child_process').spawn
duplexer = require 'duplexer'

module.exports = (cmd, args)->
  child = spawn cmd,args
  duplexer(child.stdin,child.stdout)