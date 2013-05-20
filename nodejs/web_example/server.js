var http = require('http');
var url = require('url');

function start(route, handle){
	http.createServer(function(request, response){
		var pathname = url.parse(request.url).pathname;
		/*
		var postData = '';
		console.log("Request for " + pathname + " received.");

		request.setEncoding('utf8');

		request.addListener('data', function(postDataChunk){
			postData += postDataChunk;
			console.log("receive POST data: " + postDataChunk);
		});

		request.addListener('end', function(){
			route(handle, pathname, response, postData);
		});
		*/ // 在requestHandlers 里边处理request和response

		route(handle, pathname, response, request);
		/*使用路由，将response对象交给路由处理器使用
		response.writeHead(200, {"content-Type": "text/plain"});
		response.write("Hello world!");
		response.end();
		*/
	}).listen(3000);
	console.log("Server started at port: 3000");
};

exports.start = start;

