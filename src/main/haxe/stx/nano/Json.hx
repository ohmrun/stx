package stx.nano;

class Json{
  /**
   * Alias for `haxe.Json.stringify` with captured error.
   * @param v 
   * @param replacer 
   * @return -> Dynamic, ?space:String):Upshot<String,Dynamic>
   */
  @:noUsing static public function encode(v:Dynamic,replacer: (key:Dynamic, value:Dynamic) -> Dynamic, ?space:String):Upshot<String,Dynamic>{
    var out = null;
    var err = null;
    try{
      out = haxe.Json.stringify(v,replacer,space);
    }catch(e:Dynamic){
      err = ErrorCtr.instance.Make(
        _ -> new LapseCtr().Value(e,
          _ -> Loc.fromPos(Position.here())
        ).enlist()
      );
    }
    return err == null ? Upshot.UpshotSum.Accept(out) : Upshot.UpshotSum.Reject(err);
  }
  /**
   * Alias for `haxe.Json.parse` with captured error.
   * @param str 
   * @return Upshot<Dynamic,Dynamic>
   */
  @:noUsing static public function decode(str:String):Upshot<Dynamic,Dynamic>{
    var out = null;
    var err = null;
    try{
      out = haxe.Json.parse(str);
    }catch(e:Dynamic){
      err = ErrorCtr.instance.Label('$e',_ -> Loc.fromPos(Position.here()));
    }
    return err == null ? Upshot.UpshotSum.Accept(out) : Upshot.UpshotSum.Reject(err);
  }
}