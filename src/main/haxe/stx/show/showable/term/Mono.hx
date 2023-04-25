package stx.show.showable.term;

private typedef TAny = Any;

class Mono<T> extends ShowableCls<T>{
  public function show(self:T,state:State):Upshot<Response,ShowFailure>{
    final thiz : Dynamic = self;
    return new stx.show.showable.term.Dynamic().show(thiz,state);
  }
}