var mysql = require('mysql');

//����mysql������
function connectServer(){
	
	
	//����mysql����
	var client = mysql.createClient({
		user:'root',
		password :''
	});
	client.host= '127.0.0.1';
	client.port=3306;
	client.database='express';
	return client;
}
//ִ��mysql��ѯ���������ز�ѯ��ȡ���Ķ���
 function  selectFun(client,username,callback){
	//clientΪһ��mysql���Ӷ���
	client.query('select pswd from user where username="'+username+'"',function(err,results,fields){
		if(err) throw err;
		
		callback(results);   //�ڻ�ȡ���֮���ɻص�����������ز���
	});
}

exports.connect = connectServer;
exports.selectFun  = selectFun;
