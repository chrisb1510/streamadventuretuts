crypt = require 'crypto'
cipher = crypt.createDecipher 'aes256', process.argv[2]
process.stdin.pipe(cipher).pipe process.stdout