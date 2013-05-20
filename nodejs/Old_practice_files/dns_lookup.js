var dns = require('dns');

/*
dns.lookup('google.com', 4, function(err, addr, familly){
	console.log(err, addr, familly);
});

*/

//resolve

dns.resolve('google.com', rrtype='A', function(err, addr){
	console.log('resolve gg: ', err, addr);
});

dns.resolve6('bt.neu6.edu.cn', function(err, addr){
	console.log('resole6 bt ', err, addr);
});

dns.resolveSrv('www.google.com', function(err, addr){
	console.log('resolveSrv gg: ', err, addr);
});
dns.reverse('208.101.62.194', function(err, domains){
	console.log('reverse spareip: ', err, domains);
});
