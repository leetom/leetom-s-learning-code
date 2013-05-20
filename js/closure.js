(function(){

  var hello = "hello";

  f = function(){
    console.log(hello);
  };

  function f2(){
    console.log(hello);
  }
})();

console.log(f2);

console.log('call f2');
f();
