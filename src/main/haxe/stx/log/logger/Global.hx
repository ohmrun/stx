package stx.log.logger;

@:forward abstract Global(stx.log.logger.Unit) to stx.log.logger.Unit from stx.log.logger.Unit{
  @:isVar static public var ZERO(get,null): stx.log.logger.Unit;
  static private function get_ZERO(){
    final result = ZERO == null ? {
      #if (sys || nodejs)
        #if macro
        ZERO = new stx.log.logger.Unit();
          // __.debug("stx.Log.global = stx.log.logger.Unit()\n");
          ZERO;
        #else
          ZERO = new stx.log.logger.ConsoleLogger();
          //ZERO = new stx.log.logger.Unit();
          // __.debug("stx.Log.global = stx.log.logger.ConsoleLogger()\n");
          ZERO;
        #end
      #else
        ZERO = new stx.log.logger.Unit();
        // __.debug("stx.Log.global = stx.log.logger.Unit()");
        ZERO;
      #end
     } : ZERO;
    return result;
  }
  public function new(){
    this = ZERO;
  }
  @:noUsing static public function unit(){
    return new Global();
  }
  @:to public function toLoggerApi():LoggerApi<Dynamic>{
    return this;
  }
  public function prj(){
    return this;
  }
}