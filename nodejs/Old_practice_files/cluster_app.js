#!/usr/bin/env node

var http = require('http');
var cluster = require('cluster');

var server = http.createServer(function(req, res){
	res.writeHead(200, {'Content-Type': 'text/plain'});
	res.end('hello world\n');
});

cluster(server).set('workders', 3).use(cluseter.reload()).listen(1337);
