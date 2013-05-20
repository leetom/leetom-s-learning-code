var fs = require('fs');

fs.mkdir('node_mkdir_test','0755', function(err){
	if(err) throw err;
	fs.open('testfile', 'w+', function(err, fd){
		if(err) throw err;
		fs.write(fd, str,0,str.length, null,  function(err, written){
			console.log(written + " bytes was written\n");
		});
	});
});
