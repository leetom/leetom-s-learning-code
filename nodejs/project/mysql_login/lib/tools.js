function md5(str){
	var hash = require('crypto').createHash('md5');
	return hash.update(str + '').digest('hex');
}

exports.md5 = md5;
