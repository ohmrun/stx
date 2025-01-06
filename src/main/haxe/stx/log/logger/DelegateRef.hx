package stx.log.logger;

class DelegateRef<T> implements LoggerApi<T>{
  public final delegate : Ref<LoggerApi<T>>;
  public function new(delegate){
    this.delegate = delegate;
  }
  public var format(get,default): Format;
  public function get_format(){
    return this.delegate.value.format;
  }
  public function with_format(f : CTR<Format,Format>):LoggerApi<T>{
    return new DelegateRef(this.delegate.value.with_format(f.apply(this.format)));
  }

  public var logic(get,null) : stx.log.Logic<T>;
  public function get_logic(){
    return this.delegate.value.logic;
  }
  public function with_logic(f : CTR<stx.log.Logic<T>,stx.log.Logic<T>>,?pos:Pos):LoggerApi<T>{
    return new DelegateRef(this.delegate.value.with_logic(f.apply(this.logic),pos));
  }

  public function apply(v:Value<T>):Continuation<Upshot<String,LogFailure>,Value<T>>{
    return delegate.value.apply(v);
  }
  private function do_apply(v:Value<T>):Continuation<Upshot<String,LogFailure>,Value<T>>{
    return delegate.value.do_apply(v);
  }
 
  private var output(get,null) : OutputApi;
  private function get_output(){
    return delegate.value.output;
  }
  public function copy(){
    return new DelegateRef(this.delegate.value.copy());
  }
  public function with_output(output){
    final next = this.delegate.value.with_output(output);
    return new DelegateRef(next);
  }
}