var express = require('express');
var usr = require('./dao/user');
var tools = require('./lib/tools');

//var app  = express.createServer();
var app  = express();

app.set('view engine','jade');
app.set('views',__dirname+'/views');
app.use(express.static(__dirname+'/public'));
app.use(express.bodyParser());
app.use(express.methodOverride());




app.get('/',function(req,res){
	res.render('index',{title:'欢迎使用收据管理系统',error:''});
	//res.send('fuck you');
});

app.post('/login',function(req,res){
	var user = req.body.username,
	pass = req.body.password,
	client = usr.connect(), //创建数据库连接
	result  = null;
	
	usr.selectFun(client,req.body.username,function(result){
		console.log('查询结果为'+result);
		
		
		if(result[0]===undefined){
		//	res.send('没有该用户！');
			res.render('index',{error:'没有该用户',title:'首页'});
			
			}else{
			if(result[0].pswd==tools.md5(req.body.password)){
				res.send('登录成功');
			//	res.redirect('home');
				}else{
			//	res.send('密码错误');
				res.render('index',{title:'首页',error:'您输入的密码有误！'});
			}
		}	
		
	});  //执行查询
	
	
	console.log('username==='+req.body.username);
	console.log('password==='+req.body.password);
	
	
	
});
app.listen(3000);
console.log('listen on 3000');
