package stx.nano;

import stx.nano.Upshot.UpshotLift;

typedef PledgeDef<T,E> = Future<Upshot<T,E>>;

@:using(stx.nano.Pledge.PledgeLift)
@:forward abstract Pledge<T,E>(PledgeDef<T,E>) from PledgeDef<T,E> to PledgeDef<T,E>{
  
  public function new(self) this = self;
  @:noUsing static public function lift<T,E>(self:PledgeDef<T,E>):Pledge<T,E> return new Pledge(self);

  @:noUsing static public function make<T,E>(ch:Upshot<T,E>):Pledge<T,E>{
    return new Future(
      (f) -> {
        f(ch);
        return null;
      }
    ); 
  }
  @:noUsing static public function pure<T,E>(self:T):Pledge<T,E>{
    return make(stx.nano.Upshot.UpshotSum.Accept(self));
  }
  @:noUsing static public inline function accept<T,E>(ch:T):Pledge<T,E>         return make(stx.nano.Upshot.UpshotSum.Accept(ch));
  @:noUsing static public inline function reject<T,E>(e:Error<E>):Pledge<T,E>   return make(stx.nano.Upshot.UpshotSum.Reject(e));

  @:noUsing static public function bind_fold<T,Ti,E>(it:Iter<T>,fm:T->Ti->Pledge<Ti,E>,start:Ti):Pledge<Ti,E>{
    return new Pledge(new stx.nano.module.Future().bind_fold(
      it,
      function(next:T,memo:Upshot<Ti,E>):Future<Upshot<Ti,E>>{
        return memo.fold(
          (v) -> fm(next,v).prj(),
          (e) -> stx.nano.Upshot.UpshotSum.Reject(e)
        );
      },
      stx.nano.Upshot.UpshotSum.Accept(start)
    ));
  }
  @:noUsing static public function seq<T,E>(iter:Array<Pledge<T,E>>):Pledge<Array<T>,E>{
    return bind_fold(
      iter,
                        (next:Pledge<T,E>,memo:Array<T>) -> 
        next.map(
          (a) -> memo.snoc(a)
        )
      ,
      []
    );
  }
  @:noUsing static public function lazy<T,E>(fn:Void->T):Pledge<T,E>{
    return lift(Future.irreversible(
      (f) -> f(stx.nano.Upshot.UpshotSum.Accept(fn()))
    ));
  }
  @:noUsing static public function fromLazyError<T,E>(fn:Void->Error<E>):Pledge<T,E>{
    return fromLazyUpshot(
      () -> stx.nano.Upshot.UpshotSum.Reject(fn())
    );
  }
  // #if tink_core
  // @:noUsing static public function fromTinkPromise<T,E>(promise:Promise<T>):Pledge<T,E>{
  //   return lift(
  //     promise.map(
  //       (outcome) -> switch(outcome){
  //         case tink.core.Outcome.Success(s) : stx.nano.Upshot.UpshotSum.Accept(s);
  //         case tink.core.Outcome.Failure(f) : stx.nano.Upshot.UpshotSum.Reject(stx.nano.lift.LiftTinkErrorToError.toError(f));
  //       }
  //     )
  //   );
  // }
  // @:noUsing static public inline function fromTinkFuture<T,E>(future:Future<T>):Pledge<T,E>{
  //   return lift(future.map(stx.nano.Upshot.UpshotSum.Accept));
  // }
  //#end
  @:noUsing static public function fromLazyUpshot<T,E>(fn:Void->Upshot<T,E>):Pledge<T,E>{
    return Future.irreversible(
      (f) -> f(fn())
    );
  }

  @:noUsing static public function err<T,E>(e:Error<E>):Pledge<T,E>{
    return make(stx.nano.Upshot.UpshotSum.Reject(e));
  }
  @:noUsing static public function fromUpshot<T,E>(chk:Upshot<T,E>):Pledge<T,E>{
    return Future.irreversible(
      (cb) -> cb(
        chk
      )
    );
  }
  @:noUsing static public function fromOption<T,E>(m:Option<T>):Pledge<T,E>{
    final val = m.fold(
      (x)->stx.nano.Upshot.UpshotSum.Accept(x),
      ()-> stx.nano.Upshot.UpshotSum.Reject(
        Fault.make()
             .digest((_:Digests) -> _.e_undefined())
      )
    );
    return fromUpshot(val);
  } 
  #if stx_arw
    public function toProduce(){
      return stx.arw.Produce.fromPledge(this);
    }
  #end
  public function prj():PledgeDef<T,E> return this;
  private var self(get,never):Pledge<T,E>;
  private function get_self():Pledge<T,E> return lift(this);

  public function map<Ti>(fn:T->Ti):Pledge<Ti,E>{
    return PledgeLift.map(this,fn);
  }
  public function flat_map<Ti>(fn:T->Pledge<Ti,E>):Pledge<Ti,E>{
    return PledgeLift.flat_map(this,fn);
  }
  static public function trigger<T,E>():PledgeTrigger<T,E>{
    return new PledgeTrigger();
  }
  #if js
  @:noUsing static public function fromJsPromise<T,E>(self:js.lib.Promise<T>,?pos:Pos):Pledge<T,E>{
    return Pledge.lift(Future.ofJsPromise(self).map(
      (outcome : tink.core.Outcome<T,tink.core.Error>) -> {
        return switch(outcome){
          case tink.core.Outcome.Success(v) : 
            stx.nano.Upshot.UpshotSum.Accept(v);
          case tink.core.Outcome.Failure(e) :  
            switch(std.Type.typeof(e.data)){
              case TClass(js.lib.Error) :
                var er : js.lib.Error = e.data; 
                stx.nano.Upshot.UpshotSum.Reject(Fault.make(pos).digest((_:stx.fail.Digests) -> _.e_js_error(er)));
              case x : 
                stx.nano.Upshot.UpshotSum.Reject(Fault.make(pos).digest((_:stx.fail.Digests) -> _.e_js_error(new js.lib.Error('${e.data}'))));
            }
        }
      }
    ));
  }
  #end
  
}
// @:allow(stx.nano.Pledge) private class PledgeCls<T,E>{
//   private final forward : Future<Upshot<T,Error<E>>>;

//   public function new(forward){
//     this.forward = forward;
//   }
//   public function prj():PledgeCls<T,E> return this;
  
//   public function map<Ti>(fn:T->Ti):Pledge<Ti,E>{
//     return _.map(this.forward,fn);
//   }
//   public function flat_map<Ti>(fn:T->Pledge<Ti,E>):Pledge<Ti,E>{
//     return _.flat_map(this.forward,fn);
//   }
//   public function zip<Tii>(that:Pledge<Tii,E>):Pledge<Couple<T,Tii>,E>{
//     return _.zip(this,that);
//   }
//   public function fold<Ti,E>(val:T->Ti,ers:Null<Error<E>>->Ti):Future<Ti>{
//     return _.fold(this,val,ers);
//   }
// }
class PledgeLift{
  #if js
  static public function toJsPromise<T,E>(self:Pledge<T,E>):js.lib.Promise<Upshot<T,Dynamic>>{
    var promise = new js.lib.Promise(
      (resolve,reject) -> {
        try{
          self.handle(
            (res) -> {
              res.fold(
                (v) -> {
                  resolve(stx.nano.Upshot.UpshotSum.Accept(v));
                },
                (e) -> {
                  reject(stx.nano.Upshot.UpshotSum.Reject(e));
                }
              );
            }
          );
        }catch(e:Error<Dynamic>){
          reject(e);
        }catch(e:js.lib.Error){
          reject(stx.nano.Upshot.UpshotSum.Reject(Fault.make().digest((_:stx.fail.Digests) -> _.e_js_error(e))));
        }
      }
    );
    return promise;
  }
  static public function toJsPromiseError<T,E>(self:Pledge<T,E>):js.lib.Promise<T>{
    return toJsPromise(self).then(
      (res) -> new js.lib.Promise(
        (resolve,reject) -> res.fold(
          resolve,
          reject
        )
      ) 
    );
  }
  #end
  static private function lift<T,E>(self:Future<Upshot<T,E>>):Pledge<T,E>{
    return Pledge.lift(self);
  }
  static public function zip<Ti,Tii,E>(self:Pledge<Ti,E>,that:Pledge<Tii,E>):Pledge<Couple<Ti,Tii>,E>{
    var out = new stx.nano.module.Future().zip(self.prj(),that.prj()).map(
      (tp) -> tp.fst().zip(tp.snd())
    );
    return out;
  }
  
  static public function map<T,Ti,E>(self:Pledge<T,E>,fn:T->Ti):Pledge<Ti,E>{
    return lift(self.prj().map(
      (x) -> x.fold(
        (s) -> stx.nano.Upshot.UpshotSum.Accept(fn(s)),
        e -> stx.nano.Upshot.UpshotSum.Reject(e)
      )
    ));
  }
  static public function flat_map<T,Ti,E>(self:Pledge<T,E>,fn:T->Pledge<Ti,E>):Pledge<Ti,E>{
    var ft : Future<Upshot<T,E>> = self.prj();
    return ft.flatMap(
      function(x:Upshot<T,E>):PledgeDef<Ti,E>{
        // /trace(x);
        return x.fold(
          (v)   -> fn(v).prj(),
          (err) -> Pledge.fromUpshot(stx.nano.Upshot.UpshotSum.Reject(err)).prj()
        );
      }
    );
  }
  static public function flat_fold<T,Ti,E>(self:PledgeDef<T,E>,val:T->Future<Ti>,ers:Error<E>->Future<Ti>):Future<Ti>{
    return self.flatMap(
      (res:Upshot<T,E>) -> res.fold(val,ers)
    );
  }
  static public function fold<T,Ti,E>(self:Pledge<T,E>,val:T->Ti,ers:Null<Error<E>>->Ti):Future<Ti>{
    return self.prj().map(UpshotLift.fold.bind(_,val,ers));
  }
  static public function recover<T,E>(self:Pledge<T,E>,fn:Error<E>->Upshot<T,E>):Pledge<T,E>{
    return lift(fold(
      self,
      (x) -> stx.nano.Upshot.UpshotSum.Accept(x),
      (e) -> fn(e)
    ));
  }
  static public function adjust<T,Ti,E,U>(self:Pledge<T,E>,fn:T->Upshot<Ti,E>):Pledge<Ti,E>{
    return lift(fold(
      self,
      (x) -> fn(x),
      (v) -> stx.nano.Upshot.UpshotSum.Reject(v)
    ));
  }
  static public function rectify<T,Ti,E,U>(self:Pledge<T,E>,fn:Error<E>->Upshot<T,E>):Pledge<T,E>{
    return lift(self.prj().map(
      (res:Upshot<T,E>) -> res.rectify(fn)
    ));
  }
  static public function receive<T,E>(self:Pledge<T,E>,fn:T->Void):Future<Option<Error<E>>>{
    return self.prj().map(
      (res) -> res.fold(
        (v) -> {
          fn(v);
          return None;
        },
        Option.make
      )
    );
  }
  static public function fudge<T,E>(self:Pledge<T,E>):Upshot<T,E>{
    var out = null;
    self.prj().handle(
      (v) -> {
        out = v;
      }
    );
    if(out == null){
      Fault.make().digest((_:Digests) -> _.e_undefined()).crack();
    }
    return out;
  }
  static public function point<T,E>(self:PledgeDef<T,E>,fn:T->Report<E>):Alert<E>{
    return Alert.lift(
      self.map(
        (res:Upshot<T,E>) -> res.fold(
          (x) -> fn(x),
          (e) -> ReportSum.Reported(e)
      )
    ));
  }
  static public function errata<T,E,EE>(self:Pledge<T,E>,fn:E->EE):Pledge<T,EE>{
    return self.prj().map(
      (chk) -> chk.errata(fn)
    );
  }
  static public function each<T,E>(self:Pledge<T,E>,fn:T->Void,?err:Error<E>->Void){
    self.prj().handle(
      (res) -> res.fold(
        fn,
        (e)  -> {
          Option.make(err).fold(
            (f) -> f(e),
            ()  ->  e.crack()
          );
        }
      )
    );
  }
  static public function tap<T,E>(self:Pledge<T,E>,fn:Upshot<T,E>->?Pos->Void,?pos:Pos):Pledge<T,E>{
    return lift(self.prj().map(
      (x:Upshot<T,E>) -> {
        fn(x,pos);
        return x;
      }
    ));
  }
  static public function command<T,E>(self:Pledge<T,E>,fn:T->Alert<E>):Pledge<T,E>{
    return self.flat_map(
      (t:T) -> fn(t).resolve(t)
    );
  }
  static public function execute<T,E>(self:Pledge<T,E>,fn:Void->Alert<E>):Pledge<T,E>{
    return self.flat_map(
      (t:T) -> fn().resolve(t)
    );
  }
  static public function anyway<T,E>(self:PledgeDef<T,E>,fn:Report<E>->Alert<E>):Pledge<T,E>{
    return self.flatMap(
      (res) -> res.fold(
        (ok)  -> fn(Report.make()).flat_fold(
          (err) -> stx.nano.Upshot.UpshotSum.Reject(err),
          ()    -> stx.nano.Upshot.UpshotSum.Accept(ok)
        ),
        (err) -> fn(ReportSum.Reported(err)).flat_fold(
          (err0) -> stx.nano.Upshot.UpshotSum.Reject(err.concat(err0)),
          ()     -> stx.nano.Upshot.UpshotSum.Reject(err)
        ) 
      )
    );
  }
  #if tink_core
  // static public function toTinkPromise<T,E>(self:Pledge<T,E>):tink.core.Promise<T>{
  //   return fold(
  //     self,
  //     ok -> tink.core.Outcome.Success(ok),
  //     no -> tink.core.Outcome.Failure(no.toTinkError())
  //   );
  // }
  #end 
}
typedef PledgeTriggerDef<R,E> = FutureTrigger<Upshot<R,E>>;

@:forward(trigger) abstract PledgeTrigger<R,E>(PledgeTriggerDef<R,E>) from PledgeTriggerDef<R,E> to PledgeTriggerDef<R,E>{
  public function new() this = new FutureTrigger();

  @:to public function toPledge(){
    return Pledge.lift(this.asFuture());
  }
  public function prj():PledgeTriggerDef<R,E> return this;
}