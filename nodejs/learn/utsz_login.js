var http = require('http');
var querystring = require('querystring');

var contents = querystring.stringify({
  userName: '1201213729',
  userPwd: 'MTk5MW4wNDA1',
  userip: '10.7.107.24',
});

var options = {
  host: '219.223.254.55',
  path: '/portal/login.jsp',
  method: 'POST',
  headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Content-Length' : contents.length
  },
};

var request = http.request(options, function(res){
  res.setEncoding('utf8');
  console.log(res.statusCode);
  console.log(res.headers);
  res.on('data', function(data){
    console.log(data);
  });

});

request.write(contents);
request.end();

