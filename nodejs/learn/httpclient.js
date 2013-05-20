var http = require('http');
var querystring = require('querystring');

var contents = querystring.stringify({
  name: 'leetom',
  email: 'leetom@qq.com',
});

var options = {
  host: 'localhost',
  port: 3000,
  method: 'POST',
  headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Content-Length': contents.length
  },
};

console.log(contents);
var req = http.request(options, function(res){
  res.setEncoding('utf8');
  res.on('data', function(data){
    console.log(data);
  });
});

req.write(contents);
req.end();
