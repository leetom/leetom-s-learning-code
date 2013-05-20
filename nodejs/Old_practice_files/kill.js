process.on('SIGHUP', function () {
  console.log('Got SIGHUP signal.');
});

setTimeout(function () {
  console.log('Exiting.');
  console.log("pid is: " + process.pid);
  console.log("title is: " + process.title);
  console.log("platform is: " + process.platform);
  process.exit(0);
}, 100);

setInterval(function(){
  process.kill(process.pid, 'SIGHUP')
  process.nextTick(function(){
    console.log("NextTick");
  });
},10);
