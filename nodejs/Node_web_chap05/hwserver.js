var http = require('http');
var sniffer = require('./httpsniffer');

var server = http.createServer();

sniffer.sniffOn(server);
server.on('request', function(req, res){
	res.writeHead(200, {"hello": ':world'});
	res.end('Good!');
});
server.listen(3000);