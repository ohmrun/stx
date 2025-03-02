package stx.log.logger;

class Base<T> implements LoggerApi<T> extends Debugging{
  
  public function new(?logic:Logic<T>,?format:Format,?output:OutputApi){
    note(logic);
    this.logic  = __.option(logic).defv(new stx.log.logic.term.Default());
    this.format = __.option(format).defv(Format.unit());
    this.output = __.option(output).defv(new stx.log.output.term.Full());
  }
  private var output(get,null) : OutputApi;
  private function get_output(){
    return this.output;
  }
  public function with_output(output){
    final next = this.copy(null,null,output);
    return next;
  }
  public var logic(get,null)  : stx.log.Logic<T>;
  public function get_logic():stx.log.Logic<T>{
    return this.logic;
  }
  public function with_logic(f : CTR<stx.log.Logic<T>,stx.log.Logic<T>>,?pos:Pos):LoggerApi<T>{
    final res = f.apply(logic);
    stx.log.Logging.log(__).info('${res.toString()} at ${pos.toPosition()}');
    return copy(res);
  }
  public var format(get,null) : Format;
  public function get_format():Format{
    return this.format;
  }
  public function with_format(f : CTR<Format,Format>):LoggerApi<T>{
    return copy(null,f.apply(this.format));
  }

  public function apply(value:Value<T>):Continuation<Upshot<String,LogFailure>,Value<T>>{
    note('apply: ${value.source}');
    return do_apply(value).mod(
      (res) -> {
        note('applied: $res');
        return res.map(
          (
            (string:String) -> { 
              note('about to render: ${value.stamp}');
              if(!value.stamp.hidden){
                #if macro
                  output.render(string,value.source,value.stamp);
                  // if(value.stamp.level != BLANK){
                  // }
                #else
                  output.render(string,value.source,value.stamp);
                #end
              }
            }
          ).promote()
        );
      }
    );
  }

  private function do_apply(value:Value<T>):Continuation<Upshot<String,LogFailure>,Value<T>>{
    note('do_apply');
    return Continuation.lift(
      (fn:Value<T>->Upshot<String,LogFailure>) -> {
        note(logic);
        final proceed = logic.apply(value);
        note(proceed);
        var result    = proceed.resolve(() -> this.format.print(value));
        note(result);
        return result;
      }
    );
  }
  public function copy(?logic,?format,?output){
    return new Base(logic ?? this.logic,format ?? this.format,output ?? this.output);  
  }
} 