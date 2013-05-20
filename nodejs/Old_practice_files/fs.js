
var fs = require('fs');
var util = require('util');

fs.stat('/tmp/world', function(err, stats){
	if(err) throw err;
	console.log(util.inspect(stats));
	console.log('stats:' + JSON.stringify(stats));
});

/*


fs.unlink('/tmp/hello', function(err){
	if(err) throw err;
	console.log('Successfully deleted /tmp/hello');
});
*/
