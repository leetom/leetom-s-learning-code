var net = require('net');

var server = net.createServer(function(c){
	c.write('hello\r\n');
	c.setEncoding('utf8');
	c.pipe(c);
	c.on('data',function(data){
		console.log(data);
	});
});

//server.listen(3000);
//server.listen('/tmp/echo.sock');
server.maxConnections = 3;

server.listen(3000);
