var aa = [];
for(var i=0; i < 1000000; i++){
	aa[i] = 'h';
}

var start = new Date();
for(var i in aa){
	//console.log(aa[i]);
	aa[i] = 'o';
}

var end = new Date();


console.log("start at: " + start.getTime()); 
console.log('end at: ' + end.getTime());
console.log(end.getTime() - start.getTime());
