package stx.test;

using Bake;
using StringTools;
import haxe.ds.StringMap;

@:forward abstract Harness(StringMap<TestSuite>) from StringMap<TestSuite>{
  static public var instance(get,null) : Harness;
  static private function get_instance():Harness{
    return instance == null ? instance = new Harness() : instance;
  }
  public function new(){
    this = new StringMap();
  }
  public function set(name:String,data:TestSuite){
    if(this.exists(name)){
      throw 'duplicate TestSuite: ${__.definition(data)}';
    }else{
      this.set(name,data);
    }
  }
  static function __init__(){
    //trace('harness init');
    final bake = Bake.pop();
    //trace (bake.defines);
    //trace(bake.defines.filter(x -> x.key.startsWith("stx")));
  }
}