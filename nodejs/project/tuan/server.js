var http = require('http'),
    eyes = require('eyes'),
    path = require('path'),
    mongoconfig = require('./libs/mongoconfig'),
    mongodb = require('mongodb'),
    serverOptions = {'auto_reconnect': true, 'poolSize': 5},
    Server = require('mongodb').Server,
    fs = require('fs'),
    contentArray = {'.html' : 'text/html', '.css' : 'text/css', '.js' : 'application/x-javascript', '.png' : 'image/png'};
    
var iNowtime = Date.parse(new Date()) / 1000;
http.createServer(function (req, res) {
    if(req.url == '/') {
        req.url = '/index.html';
    }
    fs.readFile('.' + req.url, function (err, buffer) {
        if(err) {
            res.writeHead(404);
            res.end('file not found');
            return false;
        }
        if(req.url == '/index.html') {
            var repstr = '';
            var db = new mongodb.Db(mongoconfig.getValues('database'), new Server(mongoconfig.getValues('host'), mongoconfig.getValues('port'), serverOptions), {});
            db.open(function(err, db) {
                db.collection('team', function(err, collection) {
                    var cursor = collection.find({'data.endTime':{'$gt':iNowtime+''}},{limit:3});
                    cursor.toArray(function(err, results){
                        var repstr = '';
                        for(var i=0;i < results.length;i++) {
                            repstr += '<div class="imgbox"><a href="'+results[i].url+'"><img src="'+results[i].data.image+'" alt="image" /></a><span>'+results[i].data.title+'</span></div>';
                        }
                        var htmlstr = buffer.toString('UTF-8');
                        var repstr = htmlstr.replace(/{\*imglist\*}/g, repstr);
                        res.writeHead(200, {'Content-Type': contentArray[fileExt]});
                        res.end(repstr);
                    });
                });
                db.close();
            });
        } else {
            var fileExt = path.extname('.' + req.url);
            if(typeof contentArray[fileExt] === undefined) {
                contentArray[fileExt] = '.html';
            }
            res.writeHead(200, {'Content-Type': contentArray[fileExt]});
            res.end(buffer);
        }
    });
}).listen(80);