process.stdin.resume();

process.stdin.pipe(process.stdout, { end: false });

process.stdin.on("end", function() {
	  process.stdout.write("Goodbye\n");
	  process.stdout.end("Stdin is closed\n");

});
