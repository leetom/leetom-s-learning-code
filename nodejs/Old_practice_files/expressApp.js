var app = require('express').createServer();

app.get('/', function(req, res){
	res.send("hello world");
});

app.get('/user/:id',function(req, res){
	res.send('user' + req.params.id + '\n');
	res.send('goodbye!\n');
});

app.listen(3000);
