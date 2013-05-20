var http = require('http');
var url = require('url');
var util = require('util');

exports.createServer = function(){
	var htserver = http.createServer(function(req, res){
		req.basicServer = {
			urlparsed: url.parse(req.url, true)
		};
		processHeaders(req, res);
		//console.dir(req);
		dispatchToContainer(htserver, req, res);
	});
	htserver.basicServer = {containers: []};
	htserver.addContainer = function(host, path, module, options){
		if(lookupContainer(htserver, host, path) !== undefined){
			util.error('Container Mapped');
			throw new Error('Already mapped ' + host + '/' + path);
		}
		htserver.basicServer.containers.push({
			host: host, 
			path: path,
			module: module, 
			options: options
		});
		//console.dir(htserver.basicServer.containers);
		return this;
	}
	htserver.useFavIcon = function(host, path){
		return this.addContainer(host, '/favicon.ico', require('./faviconHandler'),
				{iconPath: path});
	}
	htserver.docroot = function(host, path, rootPath){
		return this.addContainer(host, path, require('./staticHandler'),
				{docroot: rootPath});
	}
	
	return htserver;
}


var lookupContainer = function(htserver, host, path){
	console.log('all containers:')
	console.log(htserver.basicServer.containers);
	console.log('looking for container: host=' + host + ' path=' + path);
	for(var i = 0; i<htserver.basicServer.containers.length;i++){
		var container = htserver.basicServer.containers[i];
		var hostMatches = host.toLowerCase().match(container.host);
		var pathMatches = path.match(container.path);
		//console.log(pathMatches);
		if(hostMatches !== null && pathMatches !== null){
			console.log('Found!');
			return {
				container: container,
				host: hostMatches,
				path: pathMatches
			};
		}
	}
	return undefined;	//错误很严重!! leetom, 在循环外边返回,否则第一个不是就返回了.
}

var processHeaders = function(req, res){
	req.basicServer.cookies = [];
	var keys = Object.keys(req.headers);
	/*
	for(var i=0, l=keys.length; i<l; i++){	//1 => l
		var hname = keys[i];
		var hval = req.headers[hname];
		console.log("find header:")
		console.log(hname + hval);
		if(hname.toLowerCase() == 'host'){
			req.basicServer.host = hval;
		}
		if(hname.toLowerCase() === 'cookie'){
			req.basicServer.cookies.push(hval);
		}
	}
	*/

	for (var i in req.headers){
		if(i.toLowerCase() == 'host'){
			req.basicServer.host = req.headers[i];
		}
		if(i.toLowerCase() == 'cookie'){
			req.basicServer.cookies.push(req.headers[i]);
		}
	}
}

var dispatchToContainer = function(htserver, req, res){
	var container = lookupContainer(htserver, req.basicServer.host, req.basicServer.urlparsed.pathname);
	if(container !== undefined){
		req.basicServer.hostMatches = container.host;
		req.basicServer.pathMatches = container.path;
		req.basicServer.container = container.container;
		container.container.module.handle(req, res);
	}else{
		res.writeHead(404, {'Content-Type': 'text/plain'});
		res.end('No handler found for ' + req.basicServer.host + '/' + req.basicServer.urlparsed.path);
	}
}



