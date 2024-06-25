package stx.log;

class Module extends Clazz{
  public function attach(logger){
    new stx.log.Signal().attach(logger);
  } 
  // public function config(){
  //   return new Config(); 
  // }
  public function global(){
    return new Global();
  }
  public function logic(){
    return new stx.log.Logic.LogicCtr();
  }
  public inline function blank<X>(v:Stringify<X>,?pos:Pos) stx.log.Log.ZERO.blank(v,pos);
  public inline function trace<X>(v:Stringify<X>,?pos:Pos) stx.log.Log.ZERO.trace(v,pos);
  public inline function debug<X>(v:Stringify<X>,?pos:Pos) stx.log.Log.ZERO.debug(v,pos);
  public inline function info<X>(v:Stringify<X>,?pos:Pos)  stx.log.Log.ZERO.info(v,pos);
  public inline function warn<X>(v:Stringify<X>,?pos:Pos)  stx.log.Log.ZERO.warn(v,pos);
  public inline function error<X>(v:Stringify<X>,?pos:Pos) stx.log.Log.ZERO.error(v,pos);
  public inline function fatal<X>(v:Stringify<X>,?pos:Pos) stx.log.Log.ZERO.fatal(v,pos);
}
private class Global extends Clazz{
  public function configure(f : CTR<LoggerApi<Dynamic>,LoggerApi<Dynamic>> ){
    stx.log.FrontController.configure(f);
  }
  public function reinstate(){
    new stx.log.global.config.ReinstateTagless().value = true;
  }
}
// private class Config extends Clazz{
  
// }
