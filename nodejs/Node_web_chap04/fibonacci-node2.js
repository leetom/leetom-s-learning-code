var htutil = require('./htutil');
var math = require('./math');

function sendResult(req, res, a, fiboval){
	res.writeHead(200, {
		'Content-Type': 'text/html'
	});
	res.end(
		htutil.page('Factorial', htutil.navbar(), [
			(!isNaN(req.a) ?
			 ("<p class='result'>{a} fibonacci = {result}</p>"
			 .replace("{a}", req.a)
			 .replace("{result}", fiboval))
			: ""),
			"<p>Enter a number to see its factorial:</p>",
			"<form name='fibonacci' action='/fibonacci' method='get'>",
			"A: <input type='text' name='a' /><br />",
			"<input type='submit' value='submit' />",
			"</form>"
		].join('\n'))
	);
}

exports.get = function(req, res){
	if(!isNaN(req.a)){
		math.fibonacciAsync(Math.floor(req.a), function(val){
			sendResult(req, res, Math.floor(req.a), val);
		});
	}else{
		sendResult(req, res, NaN, NaN);
	}
}