var fib = function(n){
	if(n == 1 || n == 2){
		return 1;
	}else{
		process.nextTick(function(n){
			console.log('computing');
			console.log(n);
			return fib(n-1) + fib(n-2);
		});
	}
}

fib(12);