###An encrypted, gzipped tar file will be piped in on process.stdin. To beat this
challenge, for each file in the tar input, print a hex-encoded md5 hash of the
file contents followed by a single space followed by the filename, then a
newline.

You will receive the cipher name as process.argv[2] and the cipher passphrase as
process.argv[3]. You can pass these arguments directly through to
`crypto.createDecipher()`.

The built-in zlib library you get when you `require('zlib')` has a
`zlib.createGunzip()` that returns a stream for gunzipping.

The `tar` module from npm has a `tar.Parse()` function that emits `'entry'`
events for each file in the tar input. Each `entry` object is a readable stream
of the file contents from the archive and:

`entry.type` is the kind of file ('File', 'Directory', etc)
`entry.path` is the file path

Using the tar module looks like:

var tar = require('tar');
var parser = tar.Parse();
parser.on('entry', function (e) {
console.dir(e);
});
var fs = require('fs');
fs.createReadStream('file.tar').pipe(parser);

Use `crypto.createHash('md5', { encoding: 'hex' })` to generate a stream that
outputs a hex md5 hash for the content written to it.
###
crypt = require 'crypto'
zlib = require 'zlib'
through = require 'through'
tar = require 'tar'
ctype = process.argv[2]
pw = process.argv[3]

# decrypt method
cipher = crypt.createDecipher ctype, pw

#create a parser
parser = tar.Parse()
# for each entry either return or run through, write is not needed as no modification is made hence null as arg[1]
parser.on 'entry', (e)->
  if e.type is 'Directory'
    return
  thr = through null, ()->
    @queue " #{e.path}\n"
#pipe each entry which matches file and make a md5 hash, output the correct format to stdout via through
  e.pipe crypt.createHash('md5', { encoding: 'hex' })
  .pipe thr
  .pipe process.stdout

zipper = zlib.createGunzip()
#process stdin through decipher, make a zip/tar buffer then parse  it
process.stdin
.pipe cipher
.pipe zipper
.pipe parser