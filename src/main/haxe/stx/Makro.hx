package stx;

using stx.Pico;
using stx.Nano;

import haxe.ds.StringMap;
import stx.makro.alias.StdMetadataEntry;

typedef MakroFailure            = stx.fail.MakroFailure;


@:allow(stx.makro)class Makro{
  static public var anons(default,null) : AnonsMap = new AnonsMap();
  static public var printer(default,null):haxe.macro.Printer = new haxe.macro.Printer();
}
abstract AnonsMap(StringMap<String>){
  public function new(){
    this = new StringMap();
  }
  public function get(str:String){
    return if(!this.exists(str)){
      var unique  = __.uuid("xxxxx");
      var anon    = 'Type_$unique';
      this.set(str,anon);
      anon;
    }else{
      this.get(str);
    }
  }
}
class LiftMakro{
  static public function toModule(str:String):Option<stx.makro.core.Module>{
    var arr             = str.split(".");
    var name : String   = arr.pop();
    return Some(new stx.makro.core.Module({
      name : name,
      pack : Way.lift(arr),
      module : None
    }));
  }
  #if macro
  static public function here(stx:Wildcard){
    return haxe.macro.Context.currentPos();
  }
  #end
}