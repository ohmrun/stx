package stx.test;

using Bake;
using StringTools;
import haxe.ds.StringMap;

typedef HarnessDef = Array<Tup2<String,TestSuite>>;

@:forward abstract Harness(HarnessDef) from HarnessDef{
  static public var instance(get,null) : Harness;
  static private function get_instance():Harness{
    return instance == null ? instance = new Harness() : instance;
  }
  public function new(){
    this = [];
  }
  public function set(name:String,data:TestSuite){
    if(this.search((x) -> x.fst() == name).is_defined()){
      throw 'duplicate TestSuite: ${__.definition(data)}';
    }else{
      this.push(tuple2(name,data));
    }
  }
  static function __init__(){
    //trace('harness init');
    final bake = Bake.pop();
    //trace (bake.defines);
    //trace(bake.defines.filter(x -> x.key.startsWith("stx")));
  }
}