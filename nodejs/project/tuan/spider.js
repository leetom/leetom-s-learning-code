var request = require('request'),
    eyes = require('eyes'),
    xml2js = require('xml2js'),
    xmlopt = {trim:false,normalize:false},
    mongoconfig = require('./libs/mongoconfig'),
    urlconfig = require('./libs/urlconfig'),
    mongodb = require('mongodb'),
    serverOptions = {
      'auto_reconnect': true,
      'poolSize': 5
    };
    Server = require('mongodb').Server;
var urllist = urlconfig.getLists();
for(var i = 0;i < urllist.length;i++) {
    request({ uri:urllist[i] }, function (error, response, body) {
        if(error) {
            console.log('request error:'+urllist[i]);
            return;
        }
        if(response.statusCode != 200) {
            console.log('request status error:'+urllist[i]);
            return;
        }
        var parser = new xml2js.Parser(xmlopt);
        parser.on('end', function(result) {
            var db = new mongodb.Db(mongoconfig.getValues('database'), new Server(mongoconfig.getValues('host'), mongoconfig.getValues('port'), serverOptions), {});
            db.open(function(err, db) {
                db.collection('team', function(err, collection) {
                    for(var j = 0;j < result.url.length;j++) {
                        var saveData = {'url' : result.url[j].loc, 'data' : result.url[j].data.display};
                        collection.update({'url' : result.url[j].loc}, saveData, {upsert: true}, function(errs) {
                            if(errs) {
                                console.log('upsert error:'+errs);
                            }
                        });
                    }
                });
                db.close();
            });
        });
        parser.parseString(body);
    });
}