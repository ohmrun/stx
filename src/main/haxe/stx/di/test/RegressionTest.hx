package stx.di.test;


import haxe.macro.Expr;


class RegressionTest extends haxe.unit.TestCase{
  public function testMacroClass(){
    #if regression
    var di = new DI();
        di.tootksy();
    #end
    var regression = new Regression();
        regression.scoot();
        regression.toot();
       //di.add((x:Int) -> 'WOOT$x');
       //di.add(di,()-> 0);
        //DI.add(di,  (x:Int) -> 'WOOT$x');
        //DI.add(di,()-> 0);
    //var injector = di.injector();
      //  Injector.run(
        //  injector,
          //(str:String) -> {
            //trace(str);
          //}
        //);
  }
}
