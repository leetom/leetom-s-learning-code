
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('index', { title: 'Express', layout: 'layout' });
};

exports.hello = function(req, res){
  res.send('in index.js route file!');
  res.send('The time is ' + new Date().toString() );
};
