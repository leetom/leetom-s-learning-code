var net = require('net');

var ip1 = net.isIP('0.0.0.0');
var ip2 = net.isIP('FF::0');

console.log(ip1 + '\t' + ip2);
