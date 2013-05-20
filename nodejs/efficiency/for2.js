var aa = [];
for(var i=0; i < 1000000; i++){
	aa[i] = 'h';
}

var start = new Date().getTime();
for(var i=0;i<aa.length; i++){
	//console.log(aa[i]);
	aa[i] = 'o';
}

var end = new Date().getTime();

console.log("start at: " + start);
console.log('end at: ' + end);
console.log(end - start);
