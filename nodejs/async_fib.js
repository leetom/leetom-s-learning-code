var fibAsync = function(n, done){
	console.log(n);
	if(n === 1 || n === 2){
		whatthefuck();
		done(1);
	}else{
		process.nextTick(function(){
			fibAsync(n-1, function(val1){
				process.nextTick(function(){
					fibAsync(n-2, function(val2){
						done(val1 + val2);
					});
				});
			});
		});
	}
}

fibAsync(12, function(val){
	console.log('calc is finished');
	console.log(val);
});
