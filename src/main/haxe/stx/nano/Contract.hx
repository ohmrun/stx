package stx.nano;

import stx.nano.Chunk.ChunkSum;
import stx.nano.Chunk.ChunkLift;
#if tink_state
  import tink.state.Promised;
#end

typedef ContractDef<T,E> = Future<Chunk<T,E>>; 

@stx.lang.has('pure','unit','lift')
@:using(stx.nano.Contract.ContractLift)
@:expose abstract Contract<T,E>(ContractDef<T,E>) from ContractDef<T,E> to ContractDef<T,E>{
  

  public function new(v:Future<Chunk<T,E>>) this = v;

  @:noUsing static public function lift<T,E>(self:Future<Chunk<T,E>>){
    return new Contract(self);
  }
  @:noUsing static public function unit<T,E>():Contract<T,E>{
    return Contract.pure(Tap);
  }
  @:noUsing static public function sync<T,E>(ch:Chunk<T,E>):Contract<T,E>{
    return lift(Future.irreversible((cb) -> cb(ch)));
  } 
  @:noUsing static public function pure<T,E>(ch:Chunk<T,E>):Contract<T,E>{
    return Future.irreversible(
      (f) -> f(ch)
    ); 
  }
  @:noUsing static public function accept<T,E>(ch:T):Contract<T,E>{
    return Future.irreversible(
      (f) -> f(Val(ch))
    ); 
  }
  @:noUsing static public function reject<T,E>(ch:Error<E>):Contract<T,E>{
    return Future.irreversible(
      (f) -> f(End(ch))
    ); 
  }
  @:noUsing static public function bind_fold<T,Ti,E>(it:Array<T>,fm:T->Ti->Contract<Ti,E>,start:Ti):Contract<Ti,E>{
    return new Contract(new stx.nano.module.Future().bind_fold(
      it,
      function(next:T,memo:Chunk<Ti,E>):Future<Chunk<Ti,E>>{
        return switch (memo){
          case Tap      : unit().prj();
          case Val(v)   : fm(next,v).prj();
          case End(err) : end(err).prj();
        }
      },
      Val(start)
    ));
  }
  @:noUsing static public function lazy<T,E>(fn:Void->T):Contract<T,E>{
    return lift(Future.irreversible(
      (f) -> f(Val(fn()))
    ));
  }
  @:noUsing static public function fromLazyError<T,E>(fn:Void->Error<E>):Contract<T,E>{
    return fromLazyChunk(
      () -> End(fn())
    );
  }
  @:noUsing static public function fromLazyChunk<T,E>(fn:Void->Chunk<T,E>):Contract<T,E>{
    return Future.irreversible(
      (f) -> f(fn())
    );
  }

  @:noUsing static public function end<T,E>(?e:Error<E>):Contract<T,E>{
    return pure(End(e));
  }
  @:noUsing static public function tap<T,E>():Contract<T,E>{
    return unit();
  }
  @:noUsing static public function fromChunk<T,E>(chk:Chunk<T,E>):Contract<T,E>{
    return Future.irreversible(
      (cb) -> cb(
        chk
      )
    );
  }
  @:noUsing static public function fromOption<T,E>(m:Option<T>):Contract<T,E>{
    final val = m.fold((x)->Val(x),()->Tap);
    return fromChunk(val);
  }
  @:noUsing @:from static public function fromUpshot<T,E>(self:Upshot<T,E>):Contract<T,E>{
    return pure(self.fold(
      (ok) -> Val(ok),
      (no) -> End(no)
    ));
  }

  // @:noUsing public function toTinkSurprise():tink.core.Promise<T>{
  //   return ContractLift.fold(
  //     this,
  //     tink.core.Outcome.Success,
  //     e  -> 
  //     tink.core.Outcome.Failure(
  //       tink.core.Error.withData(
  //         500,
  //         e.toString(),
  //         e.data.defv(null),
  //         null
  //       )
  //     ),
  //     () -> tink.core.Outcome.Failure(new tink.core.Error(500,'empty'))  
  //   );
  // }
  #if js
  @:noUsing static public function fromJsPromise<T,E>(self:js.lib.Promise<T>,?pos:Pos):Contract<T,E>{
    return Contract.lift(Future.ofJsPromise(self).map(
      (outcome : tink.core.Outcome<T,tink.core.Error>) -> {
        return switch(outcome){
          case tink.core.Outcome.Success(v) : 
            Val(v);
          case tink.core.Outcome.Failure(e) :  
            switch(std.Type.typeof(e.data)){
              case TClass(js.lib.Error) :
                var er : js.lib.Error = e.data; 
                End(Fault.make(pos).digest((_:stx.fail.Digests) -> _.e_js_error(er)));
              default : 
                End(Fault.make(pos).digest((_:stx.fail.Digests) -> _.e_js_error(new js.lib.Error('${e.data}'))));
            }
        }
      }
    ));
  }
  #end
  public function prj():Future<Chunk<T,E>> return this;

  public function handle(fn){
    return this.handle(fn);
  }

  @:noUsing static public function seq<T,E>(iter:Array<Contract<T,E>>):Contract<Array<T>,E>{
    return bind_fold(
      iter,
      (next:Contract<T,E>,memo:Array<T>) -> 
        next.map(
          (a) -> memo.snoc(a)
        )
      ,
      []
    );
  }
}

class ContractLift extends Clazz{
  static private function lift<T,E>(self:Future<Chunk<T,E>>):Contract<T,E>{
    return Contract.lift(self);
  }
  #if js
  static public function toJsPromise<T,E>(self:Contract<T,E>):js.lib.Promise<Upshot<Option<T>,Dynamic>>{
    var promise = new js.lib.Promise(
      (resolve,reject) -> {
        try{
          self.handle(
            (res) -> {
              res.fold(
                (v) -> {
                  resolve(Accept(Some(v)));
                },
                (e) -> {
                  reject(Reject(e));
                },
                ()  -> {
                  //trace('empty');
                  resolve(Accept(None));
                }
              );
            }
          );
        }catch(e:Error<Dynamic>){
          reject(e);
        }catch(e:js.lib.Error){
          reject(Reject(Fault.make().digest((_:stx.fail.Digests) -> _.e_js_error(e))));
        }
      }
    );
    return promise;
  }
  #end
  static public function zip<Ti,Tii,E>(self:ContractDef<Ti,E>,that:ContractDef<Tii,E>):Contract<Couple<Ti,Tii>,E>{
    var out = new stx.nano.module.Future().zip(self,that).map(
      (tp) -> tp.fst().zip(tp.snd())
    );
    return out;
  }
  
  static public function map<T,Ti,E>(self:ContractDef<T,E>,fn:T->Ti):Contract<Ti,E>{
    return lift(self.map(
      function(x){
        return switch (x){
          case Tap      : Tap;
          case Val(v)   : Val(fn(v));
          case End(err) : End(err);
    }}));
  }
  static public function flat_map<T,Ti,E>(self:Contract<T,E>,fn:T->Contract<Ti,E>):Contract<Ti,E>{
    var ft : Future<Chunk<T,E>> = self.prj();
    return ft.flatMap(
      function(x:Chunk<T,E>):ContractDef<Ti,E>{
        return switch (x){
          case Tap      : new Contract(Future.irreversible((cb) -> cb(Tap))).prj();
          case Val(v)   : fn(v).prj();
          case End(err) : Contract.fromChunk(End(err)).prj();
    }});
  }
  static public function flat_fold<T,Ti,E>(self:ContractDef<T,E>,val:T->Future<Ti>,ers:Error<E>->Future<Ti>,nil:Void->Future<Ti>):Future<Ti>{
    return self.flatMap(
      (chunk:Chunk<T,E>) -> chunk.fold(val,ers,nil)
    );
  }
  static public function fold<T,Ti,E>(self:Contract<T,E>,val:T->Ti,ers:Null<Error<E>>->Ti,nil:Void->Ti):Future<Ti>{
    return self.prj().map(ChunkLift.fold.bind(_,val,ers,nil));
  }
  static public function recover<T,E>(self:Contract<T,E>,fn:Error<E>->Chunk<T,E>):Contract<T,E>{
    return lift(fold(
      self,
      (x) -> Val(x),
      (e) -> fn(e),
      ()  -> Tap
    ));
  }
  static public function adjust<T,Ti,E,U>(self:Contract<T,E>,fn:T->Chunk<Ti,E>):Contract<Ti,E>{
    return lift(fold(
      self,
      (x) -> fn(x),
      (v) -> End(v),
      ()->Tap
    ));
  }
  static public function receive<T,E>(self:Contract<T,E>,fn:T->Void):Future<Option<Error<E>>>{
    return self.prj().map(
      (chk) -> switch chk {
        case End(e)   : Option.make(e);
        case Val(v)   : fn(v); None;
        case Tap      : None;
      }
    );
  }
  static public function now<T,E>(self:Contract<T,E>):Chunk<T,E>{
    var out = null;
    self.prj().handle(
      (v) -> out = v
    );
    if(out == null){
      out = Tap;
    }
    return out;
  }
  static public function blame<T,E>(self:ContractDef<T,E>,error:Null<Error<E>>){
    return self.map(
      chunk -> chunk.blame(error)
    );
  }
  static public function errata<T,E,EE>(self:Contract<T,E>,fn:E->EE):Contract<T,EE>{
    return self.prj().map(
      (chk) -> chk.errata(fn)
    );
  }
  static public function tap<T,E>(self:Contract<T,E>,fn:Chunk<T,E>->?Pos->Void,?pos:Pos):Contract<T,E>{
    return lift(self.prj().map(
      (x:Chunk<T,E>) -> {
        fn(x,pos);
        return x;
      }
    ));
  } 
}