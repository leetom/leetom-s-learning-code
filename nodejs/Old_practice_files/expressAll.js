var express = require('express')
var app = express.createServer();

var users = [{ name: 'tj' },
			 { name: 'leetom'},
			 { name: 'Tom'}];

app.all('/user/:id/:op?', function(req, res, next){
	    req.user = users[req.params.id];
		  if (req.user) {
			      next();
		  }else{
			//next(new Error('cannot find user ' + req.params.id + "\n"));
			res.send("Error: Cannot find user" + req.params.id + "\n");
		  }
  });

app.get('/user/:id', function(req, res){
	  res.send('viewing ' + req.user.name);
});

app.get('/user/:id/edit', function(req, res){
	  res.send('editing ' + req.user.name);
});

app.put('/user/:id/update', function(req, res){
	  res.send('updating ' + req.user.name);
});

app.get('*', function(req, res){
	  res.send('what are you looking for?\n', 404);
});

app.listen(3000); 
