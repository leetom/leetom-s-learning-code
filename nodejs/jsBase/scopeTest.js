function a(i) {
	console.log(i);
	console.log(arguments[0]); //arguments[0]应该就是形参 i
	var i;
	console.log(i === arguments[0]);
	console.log(i);
	console.log(arguments);
	i = 2;
	console.log(i);
	console.log(arguments);
};
a(10);
