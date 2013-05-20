var http = require('http');
var util = require('util');

var server = http.createServer();

server.on('connection', function(){
  console.log('connected!');
});

server.on('request', function(req, res){
  console.log('requested!');
  res.writeHead(200, {'Content-Type': 'text/plain'});
  //res.write(util.inspect(req));
  res.write('Hello world!');
  res.end('Over!');
});

server.listen(3000);
