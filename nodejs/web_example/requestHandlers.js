var exec = require('child_process').exec;
var querystring = require('querystring');
var fs = require('fs');
var formidable = require('formidable');

function start(response, request){
	console.log("start called");
	/*
	exec("find / -name 'nodejs'",
		{timeout: 10000, maxBuffer:2000*1024},
		function(error, stdout, stderr){
			response.writeHead(200, {"Content-type": "text/plain;"});
			response.write(stdout);
			response.end();
		});
	*/ // 使用子进程处理内容
	var body = '<!doctype html><html>'+
	    '<head>'+
	    '<meta http-equiv="Content-Type" content="text/html; '+
	    'charset=UTF-8" />'+
	    '</head>'+
	    '<body>'+
	    '<form action="/upload" method="post" enctype="multipart/form-data">'+
		'<input type="file" name="uploadPic" />' +
	    '<input type="submit" value="upload pic" />'+
	    '</form>'+
	    '</body>'+
	    '</html>';
	response.writeHead(200, {"Content-type": "text/html;"});
	response.write(body);
	response.end();
}

function upload(response, request){
	console.log("upload called");
	form = new formidable.IncomingForm();
	form.parse(request, function(err, fields, files){
		console.log('parsing form data done!');
		fs.renameSync(files.uploadPic.path, '/tmp/test.png');
		response.writeHead(200, {'Content-type':'text/html'});
		response.write('received image: <br />');
		response.write('<img src="/show" />');
		response.end();
	});


	/*
	response.writeHead(200, {"Content-type": "text/plain"});
	response.write("Upload?\n");
	response.write("You've sent: " + querystring.parse(request).text);
	response.end();
	*/
}

function show(response){
	console.log('Call show!');
	fs.readFile('/tmp/test.png', 'binary', function(err, file){
		if(err){
			response.writeHead(500, {'Content-type' : 'text/plain'});
			response.write(err + '\n');
			response.end();
		}else{
			response.writeHead(200, {'Content-type' : 'image/png'});
			response.write(file, 'binary');
			response.end();
		}
	});
}

exports.start = start;
exports.upload = upload;
exports.show = show;
