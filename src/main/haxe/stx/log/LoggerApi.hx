package stx.log;

interface LoggerApi<T=Any>{
  public var logic(get,null) : stx.log.Logic<T>;
  public function get_logic():stx.log.Logic<T>;
  public function with_logic(f : CTR<stx.log.Logic<T>,stx.log.Logic<T>>,?pos:Pos):LoggerApi<T>;

  public var format(get,null): Format;
  public function get_format():Format;
  public function with_format(f : CTR<Format,Format>):LoggerApi<T>;

  public function apply(v:Value<T>):Continuation<Upshot<String,LogFailure>,Value<T>>;
  private function do_apply(v:Value<T>):Continuation<Upshot<String,LogFailure>,Value<T>>;

  private var output(get,null) : OutputApi;
  private function get_output():OutputApi;

  public function with_output(output : OutputApi):LoggerApi<T>;
  //public function configure(logic:APP<stx.log.Logic<T>,stx.log.Logic<T>>,format:APP<Format,Format>):LoggerApi<T>;

  public function copy():LoggerApi<T>;
}