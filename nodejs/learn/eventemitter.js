var events = require('events');

var emitter = new events.EventEmitter();

emitter.on('my_event', function(arg1, arg2){
  console.log('listener1: ', arg1, arg2);
});

emitter.on('my_event', function(arg1, arg2){
  console.log('listener2: ', arg1, arg2);
});
emitter.on('error', function(){
  console.log('error captured!');
});

emitter.emit('my_event', 'haha', 'arg211');

emitter.emit('error');
