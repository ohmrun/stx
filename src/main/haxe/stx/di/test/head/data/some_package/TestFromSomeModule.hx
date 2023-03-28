package stx.di.test.head.data.some_package;


class TestFromSomeAssemblyAssembly{
  public function new(){}
  public function run(){
    //var a = Assembly.here();
    //trace(a);
    //trace(a.isSubmodule());
  }
  /*
  public function act(v:Context){
    var di = new DI();
        di.add(function():String{ return "hello";});
        di.add(function():Int{ return 123;});
    v.set(Assembly.here(),di);
  }
  public function use(r:Release){
    var di = r.get(Assembly.here());
        di.run(function(str:String,int:Int){
          trace(ok);
        });
  }
  */
}