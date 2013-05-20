var fs = require('fs');

var ws = fs.createWriteStream('node_mkdir_test/write_file.txt',
		{flags:'w+',
		 encoding:'utf8',
		 mode:0666});
ws.write("hello the second world\n");
ws.end("Last Line\n");

