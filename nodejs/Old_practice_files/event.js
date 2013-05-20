var events = require('events');
var net = require('net');

var server = net.createServer(function(socket){
	socket.write("Echo server\r\n");
	socket.pipe(socket);
	socket.on('data', function(data){
		socket.write(data + " is received");
		console.log(socket.listeners('data'));
	});
});

server.listen(8001, 'localhost');

