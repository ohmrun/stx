package stx.log.logger;

class Unit extends stx.log.logger.Base<Any>{
  @:noUsing static public function make(?logic:Logic<Any>,?format:Format,?output:OutputApi):Unit{
    return new Unit(logic,format,output);
  }
  public function new(?logic:Logic<Any>,?format:Format,?output:OutputApi){
    super(logic,format,output);
  }
  override private function do_apply(data:Value<Any>):Continuation<Upshot<String,LogFailure>,Value<Any>>{
    return super.do_apply(data);
  }
}