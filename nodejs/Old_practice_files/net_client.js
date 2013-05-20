var net = require('net');

var sock = net.Socket();

sock.connect(3000, 'localhost', function(){
	console.log('connect to localhost:3000 successfully!\n');
});

sock.setEncoding('utf8');
sock.write('hello Server!\n\r');

sock.on('data',function(data){
	console.log(data);
});


