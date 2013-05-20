var htutil = require('./htutil');
var math = require('./math');


exports.get = function(req, res){
	res.writeHead(200, {
		'Content-Type': 'text/html'
	});
	res.end(
		htutil.page('Factorial', htutil.navbar(), [
			(!isNaN(req.a) ?
			 ("<p class='result'>{a} factorial = {result}</p>"
			 .replace("{a}", req.a)
			 .replace("{result}", math.factorial(Math.floor(req.a))))
			: ""),
			"<p>Enter a number to see its factorial:</p>",
			"<form name='factorial' action='/factorial' method='get'>",
			"A: <input type='text' name='a' /><br />",
			"<input type='submit' value='submit' />",
			"</form>"
		].join('\n'))
	);
}