// Generated by CoffeeScript 1.8.0
(function() {
  var concat;

  concat = require('concat-stream');

  process.stdin.pipe(concat(function(buffer) {
    var data;
    data = buffer.toString().split('').reverse().join('');
    return console.log(data);
  }));

}).call(this);

//# sourceMappingURL=concat.js.map
