var fs = require('fs');

var fh = fs.createReadStream('node_mkdir_test/write_file.txt', 
		{
		flags:'r',
		encoding:'utf8',
		fd:null,
		mode:0666,
		bufferSize:2
		});
fh.on('data',function(data){
	console.log(data);
});
process.nextTick(function(){
	console.log('another Tick');
});
														
