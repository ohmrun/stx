package stx.di.test;

@:stx.test.Register
class TestComponent extends haxe.unit.TestCase{
	// public function _testCreate() {
	// 	var a = new DI();
	// }

	// public function _testAdd() {
	// 	var di = new DI();
	// 	di.add(() -> (0 : Int));
	// }

	public function testRun() {
		var di = new DI();
				di.add(() -> (0 : Int));
		var injector = di.injector();
				//injector.run((int:Int) -> {
			//equals(0,int);
	}
  public function testAbstract(){
    var di = new DI();
    //di.add(new AbstractTest());
    // di.run(
    //   function(v:AbstractTest){
    //     trace(v);
    //   }
    // );
  }
}