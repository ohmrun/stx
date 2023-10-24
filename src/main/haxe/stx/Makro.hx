package stx;

using stx.Pico;
using stx.Nano;

import haxe.ds.StringMap;
import stx.makro.alias.StdMetadataEntry;

typedef MakroFailure            = stx.fail.MakroFailure;

@:allow(stx.makro)class Makro{
  static public function makro(self:Wildcard):stx.makro.Module{
    return new stx.makro.Module();
  }
  static public var anons(default,null) : AnonsMap = new AnonsMap();
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
  // static public function toMoniker(str:String):Option<stx.makro.type.core.Moniker>{
  //   var arr             = str.split(".");
  //   var name : String   = arr.pop();
  //   return Some(new stx.makro.type.core.Moniker({
  //     name : name,
  //     pack  : Way.lift(arr),
  //     module : None
  //   }));
  // }
  #if macro
  static public function here(stx:Wildcard){
    return haxe.macro.Context.currentPos();
  }
  #end
}