package stx.log.logger;

class Unit extends stx.log.logger.Base<Any>{
  public function new(?logic:Logic<Any>,?format:Format,?output:OutputApi){
    super(logic,format,output);
  }
  override private function do_apply(data:Value<Any>):Continuation<Upshot<String,LogFailure>,Value<Any>>{
    return super.do_apply(data);
  }
}