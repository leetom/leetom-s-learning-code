var htutil = require('./htutil');

exports.get = function(req, res){
	res.writeHead(200, {
		'Content-Type': 'text/html'
	});
	
	res.end(
		htutil.page('Square', htutil.navbar(), [
			(!isNaN(req.a) ?
			 ("<p class='result'>{a} squared = {result}</p>"
			 .replace("{a}", req.a)
			 .replace("{result}", req.a * req.a))
			: ""),
			"<p>Enter a number to see its square:</p>",
			"<form name='square' action='/square' method='get'>",
			"A: <input type='text' name='a' /><br />",
			"<input type='submit' value='submit' />",
			"</form>"
		].join('\n'))
	);
}