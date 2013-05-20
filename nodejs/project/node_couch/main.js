var sys = require('sys'),
    fs = require('fs'),
    http = require('http');
var haml = require('./libs/haml-js/lib/haml'); 
// Node-CouchDB: http://github.com/felixge/node-couchdb
var couchdb = require('./libs/node-couchdb/lib/couchdb'),
    client = couchdb.createClient(5984, 'localhost'),
    db = client.db('erdnodeflips');
 
// Haml-js: http://github.com/creationix/haml-js
var haml = require('./libs/haml-js/lib/haml');
 
var doc_id = 'a86ac8a9afa1b4e73dfb237dc2000a58';
 
http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/html'});
    db.getDoc(doc_id, function(error, doc) {
	if(error) {
	    res.write(JSON.stringify(error));
	}
	else {
		fs.readFile('./templates/doc.haml', function(e, c){
			var data = {
				title: "erdnodeflip document" + doc.name,
				message: "your Ernusflip document was found!",
				items: doc.items
			};
			var html = haml.render(c.toString(), {locals:data});
			res.end(html);
		});
	}
     //res.end("-= Fin =-");

    });
 
}).listen(8000);
sys.puts('Server running at http://127.0.0.1:8000/');
