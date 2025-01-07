package stx.pico;

abstract Uuid(String) from String{
  public function new(?value:String = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'){
    var reg = ~/[xy]/g;
    this = reg.map(value, function(reg) {
        var r = std.Std.int(Math.random() * 16) | 0;
        var v = reg.matched(0) == 'x' ? r : (r & 0x3 | 0x8);
        return StringTools.hex(v);
    }).toLowerCase();
  }
  @:noUsing static public function unit(){
    return new Uuid();
  }
  public function toString(){
    return this;
  }
  static public function of(string:String):Uuid{
    return new Uuid(string);
  }
}