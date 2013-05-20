var http = require('http');

http.createServer(function(request, response){
	response.writeHead(200,{'Content-type':'text/html;charset=utf-8',
				 'Server':'leetom\'s nodejs server'});
	response.write("<h1>你好</h1>");
	response.end('hello world\n');
}).listen(8124);

process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function(d){
	process.stdout.write('data in: ' + d);
});

process.on('SIGINT',function(){
	console.log("Signal Captured");
});

console.log('server running at http://localhost:8124');
