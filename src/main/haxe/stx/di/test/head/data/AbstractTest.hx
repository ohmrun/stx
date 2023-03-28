package stx.di.test.head.data;

@:callable abstract AbstractTest(Void->String){
  public function new(){
    this = () -> 'hello';
  };
	public function prj():Void->String{
		return this;
	}
}