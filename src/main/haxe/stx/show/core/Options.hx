package stx.show.core;

class Options{
  public final width : Int;
  public function new(width:Int){
    this.width = width;
  }
  static public function make(width:Int){
    return new Options(width);
  }
  static public function make0(?width:Int){
    return make(__.option(width).defv(100));
  }
  static public function unit(){
    return make0();
  }
}