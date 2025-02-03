package stx.log.logger;

class Empty<T> implements LoggerApi<T>{

  public function new(?logic:Logic<T>,?format:Format){
    this.logic  = __.option(logic).defv(new stx.log.logic.term.Default());
    this.format = __.option(format).defv(Format.unit());
  }
  public var logic(get,null) : stx.log.Logic<T>;
  public function get_logic():stx.log.Logic<T>{
    return this.logic;
  }
  public function with_logic(f : CTR<stx.log.Logic<T>,stx.log.Logic<T>>,?pos:Pos):LoggerApi<T>{
    final res = f.apply(logic);
    return new Empty(res,this.format);
  }
  public var format(get,null): Format;
  public function get_format():Format{
    return this.format;
  }
  public function with_format(f : CTR<Format,Format>):LoggerApi<T>{
    return new Empty(logic,f.apply(this.format));
  }

  public function apply(v:Value<T>):Continuation<Upshot<String,LogFailure>,Value<T>>{
    return Continuation.unit();
  }
  private function do_apply(v:Value<T>):Continuation<Upshot<String,LogFailure>,Value<T>>{
    return Continuation.unit();
  }

  private var output(get,null) : OutputApi;
  private function get_output():OutputApi{
    return new stx.log.output.term.Nowhere();
  }

  public function with_output(output : OutputApi):LoggerApi<T>{
    throw "can't use output with logger: stx.log.logger.Empty";
    return this;
  }
  //public function configure(logic:APP<stx.log.Logic<T>,stx.log.Logic<T>>,format:APP<Format,Format>):LoggerApi<T>;

  public function copy():LoggerApi<T>{
    return new Empty(this.logic,this.format);
  }
}
