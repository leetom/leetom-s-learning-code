/*全局（window）域下的一段代码*/
var i = 1, j = 2, k = 3;
function
a (o, p, x, q)
{
  var x = 4;
  console.log (i);
  function b (r, s)
  {
    var i = 11, y = 5;
    console.log (i);
    function c (t)
    {
      var z = 6;
      console.log (i);
    };
//函数表达式
var d = function(){
console.log(y);
};
c(60);
d();
};
b(40,50);
}
a(10,20,30);
