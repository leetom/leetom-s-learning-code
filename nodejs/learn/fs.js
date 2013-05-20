var fs = require('fs');


fs.readFile('/etc/passwd','utf-8', function(error, data){
  if(error){
    console.error(error);
  }else{
    console.log(data);
  }
});
