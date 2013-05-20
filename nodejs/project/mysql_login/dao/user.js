var mysql = require('mysql');

//连接mysql服务器
function connectServer(){
	
	
	//创建mysql连接
	var client = mysql.createClient({
		user:'root',
		password :''
	});
	client.host= '127.0.0.1';
	client.port=3306;
	client.database='express';
	return client;
}
//执行mysql查询操作。返回查询获取到的对象
 function  selectFun(client,username,callback){
	//client为一个mysql连接对象
	client.query('select pswd from user where username="'+username+'"',function(err,results,fields){
		if(err) throw err;
		
		callback(results);   //在获取结果之后由回调函数进行相关操作
	});
}

exports.connect = connectServer;
exports.selectFun  = selectFun;
