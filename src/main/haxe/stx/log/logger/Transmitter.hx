package stx.log.logger;

class Transmitter<T> implements LoggerApi<T> extends Base<T>{
  override public function apply(value:Value<T>){
    return Continuation.lift(
      (fn:Value<T>->Upshot<String,LogFailure>) -> {
        stx.log.Signal.instance.trigger(value);
        return __.accept("");
      }
    );
  }
}