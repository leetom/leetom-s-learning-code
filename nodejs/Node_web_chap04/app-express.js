var htutil = require('./htutil'),
	math = require('./math'),
	ejs = require('ejs'),
	express = require('express');

//var app = express(express.logger());
var app = express.createServer( express.logger());

//app.register('.html', require('ejs'));
app.engine('html', require(ejs).renderFile);
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');

app.configure(function(){
	app.use(app.router);
	app.use(express.static(__dirname + 'filez'));
	app.use(express.errorHandler({
		dumpExeptions: true, showStack: true}));
});

app.get('/', function(req, res){
	res.render('home.html', {title: 'Math Wizard'});
});
app.get('/mult', htutil.loadParams, function(req, res){
	if(req.a && req.b) req.result = req.a * req.b;
	res.render('mult.html', {
		title: 'Math Wizard-Mutiplication',
		req: req});
});

app.listen(8000);
console.log('listening 8000');
