package stx.nano.module;

import tink.core.Future as TFuture;

class Future extends Clazz{
  static public var instance(get,null) : stx.nano.module.Future;
  static private function get_instance(){
    return instance == null ? instance = new stx.nano.module.Future() : instance;
  }
  public function bind_fold<T,TT>(arr:Iter<T>,fn:T->TT->TFuture<TT>,init:TT):TFuture<TT>{
    //trace("bind_fold");
    return arr.lfold(
      (next:T,memo:TFuture<TT>) -> {
        trace(next);
        return memo.flatMap(
          (tt) -> {
            //trace(tt);
            final result = fn(next,tt);
            return result;
          }
        );
      },
      TFuture.irreversible((cb) -> cb(init))
    );
  }
  public function zip<Ti,Tii>(self:TFuture<Ti>,that:TFuture<Tii>):TFuture<Couple<Ti,Tii>>{
    
    var left    = None;
    var right   = None;
    var trigger = TFuture.trigger();
    var on_done = function(){
      switch([left,right]){
        case [Some(l),Some(r)]  : trigger.trigger(Couple.make(l,r));
        default                 :
      }
    }
    var l_handler = function(l){
      left = Some(l);
      on_done();
    }
    var r_handler = function(r){
      right = Some(r);
      on_done();
    }

    self.handle(l_handler);
    that.handle(r_handler);

    return trigger.asFuture();
  }
  public function tryAndThenCancelIfNotAvailable<T>(ft:TFuture<T>):Option<T>{
    var output : Option<T>   = None;
 
    var canceller = ft.handle(
      (x) -> output = Some(x)
    );
    if(!output.is_defined()){
      canceller.cancel();
    }
    return output;
  }
  public function squeeze<T>(ft:TFuture<T>):Option<T>{
    return tryAndThenCancelIfNotAvailable(ft);
  }
  public function option<T>(ft:TFuture<T>):Option<T>{
    var output    : Option<T>   = None;
    var finished  : Bool        = false;
    ft.handle(
      (x) -> {
        if (!finished) {
          output = Some(x);
        }
      }
    );
    finished = true;
    return output;
  }
}