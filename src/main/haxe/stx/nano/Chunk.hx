package stx.nano;

using stx.lift.ArrayLift;

import tink.core.Outcome in TinkOutcome;

@:using(stx.nano.Chunk.ChunkLift)
enum ChunkSum<V,E>{
  Val(v:V);
  Tap;
  End(?err:Error<E>);
}

@:using(stx.nano.Chunk.ChunkLift)
abstract Chunk<T,E>(ChunkSum<T,E>) from ChunkSum<T,E> to ChunkSum<T,E>{
  
  public function new(self:ChunkSum<T,E>) this = self;

  @:from @:noUsing static public function fromError<T,E>(e:Error<E>):Chunk<T,E>           return End(e);
  
  @:noUsing static inline public function fromNull_T<T,E>(v:Null<T>):Chunk<T,E>                   return pure(v);

  @:noUsing static public function lift<T,E>(v:ChunkSum<T,E>):Chunk<T,E>                          return new Chunk(v);

  @:noUsing static public function pure<T,E>(c:Null<T>):Chunk<T,E>{
    return switch(c){
      case null : Tap;
      default   : Val(c);
    }
  }
  @:noUsing static public function unit<T,E>():Chunk<T,E>{
    return Tap;
  }

  @:noUsing static public function fromTinkOutcome<T,E>(outcome:TinkOutcome<T,Error<E>>):Chunk<T,E>{
    return new Chunk(switch(outcome){
      case TinkOutcome.Success(v) : pure(v);
      case TinkOutcome.Failure(e) : End(e);
    });
  }
  @:noUsing static public function fromOption<T,E>(opt:Option<T>):Chunk<T,E>{
    return switch(opt){
      case Some(v)  : Val(v);
      case None     : Tap; 
    }
  }
  @:noUsing static public function fromOptionError<E>(opt:Option<Error<E>>):Chunk<Nada,E>{
    return switch(opt){
      case Some(v)  : End(v);
      case None     : Tap; 
    }
  }
  /**
		Produces a `Chunk` of `Array<A>` only if all chunks are defined.
	**/
  @:noUsing static public function all<T,E>(arr:Array<Chunk<T,E>>,?TapFail:Error<E>):Chunk<Array<T>,E>{
    return arr.lfold(
      function(next,memo:Chunk<Array<T>,E>){
        return switch ([memo,next]) {
          case [Val(memo),Val(next)]  :
            memo.push(next);
            Val(memo);
          case [Val(memo),End(e)]     : End(e);
          case [Val(v),Tap]           : TapFail == null ? Tap : End(TapFail);
          case [End(e),End(e0)]       : 
              var err = 
                Option.make(e).toArray()
                  .concat(Option.make(e0).toArray())
                  .lfold(
                    (nx,mm:Error<E>) -> mm.concat(nx),
                    TapFail
                  );
              End(err);
          case [End(e),Tap]           : 
              var err = Option.make(e).map(e->e.concat(TapFail)).defv(TapFail);
              End(err);
          case [End(e),_]             : End(e);
          case _                      : TapFail == null ? Tap : End(TapFail);
        }
      },
      Val([])
    );
  }
  @:noUsing static public function available<T,E>(rest:Array<Chunk<T,E>>):Chunk<Array<T>,E>{
    return rest.lfold(
      function(next,memo:Chunk<Array<T>,E>){
        return switch (memo) {
          case Val(xs) : switch (next) {
            case Val(x) :
            xs.push(x);
            Val(xs);
            case Tap    : Val(xs);
            case End(e) : End(e);
          }
          default       : memo;
        }
      }
      ,Val([])
    );
  }
  private var self(get,never):Chunk<T,E>;
  private function get_self():Chunk<T,E> return this;
}
class ChunkLift{
  static public function def<T,E>(self:Chunk<T,E>,fn:Void->T):T{
    return switch(self){
      case Val(v)      : v;
      case End(e)      : throw e;
      case Tap         : fn();
    }
  }
 static public function defv<T,E>(self:Chunk<T,E>,t:T):T{
   return switch(self){
     case Val(v)      : v;
     case End(e)      : throw e;
     case Tap         : t;
   }
 }
 static inline public function fold<T,E,Ti>(chk:Chunk<T,E>,val:T->Ti,ers:Null<Error<E>>->Ti,tap:Void->Ti):Ti{
   return switch (chk) {
     case Val(v) : val(v);
     case End(e) : ers(e);
     case Tap    : tap();
   }
 }
 static public function map<T,Ti,E>(self:Chunk<T,E>,fn:T->Ti):Chunk<Ti,E>{
   return switch (self){
     case Tap      : Tap;
     case Val(v)   :
       var o = fn(v);
       Chunk.pure(o);
     case End(err) : End(err);
   }
 }
 static public function flatten<T,E>(self:Chunk<Chunk<T,E>,E>):Chunk<T,E>{
   return flat_map(
    self,
    function(x:Chunk<T,E>){
      return x;
    }
   );
 }
 /**
   Run a function with the content of the Chunk that produces another self,
   then flatten the result.
 */
 static public function flat_map<T,Ti,E>(self:Chunk<T,E>,fn:T->Chunk<Ti,E>):Chunk<Ti,E>{
   return switch (self){
     case Tap      : Tap;
     case Val(v)   : fn(v);
     case End(err) : End(err);
   }
 }
 /*
   If the Chunk is in an Error state, recover using the handler `fn`
 */
 static public function recover<T,E,EE>(self:Chunk<T,E>,fn:Error<E> -> Chunk<T,EE>):Chunk<T,EE>{
   return switch (self){
     case Tap      : Tap;
     case Val(v)   : Val(v);
     case End(err) : fn(err);
   }
 }
 static public function blame<T,E>(self:Chunk<T,E>,error:Null<Error<E>>){
  return fold(
    self,
    Val,
    (e) -> End(e == null ? error : e.concat(error)),
    () -> Tap
  );
 }
 static public function errata<T,E,EE>(self:Chunk<T,E>,fn:E -> EE):Chunk<T,EE>{
   return recover(
    self,
    (x:Error<E>) -> return End(x.errata(fn))
   );
  }
 static public function zip<T,Ti,E>(self:Chunk<T,E>,that:Chunk<Ti,E>):Chunk<Couple<T,Ti>,E>{
   return switch (self){
     case Tap      : Tap;
     case Val(v)   :
       switch (that){
         case Tap      : Tap;
         case Val(v0)  : Val(Couple.make(v,v0));
         case End(err) : End(err);
       }
     case End(err) :
       switch (that){
         case End(err0)  : End(
           err.concat(err0)
         );
         default         : Tap;
       }
   }
 }
 static public function option<T,E>(chk:Chunk<T,E>):Option<T>{
   return switch (chk){
     case Tap      : None;
     case Val(v)   : Some(v);
     case End(_)   : None;
   }
 }
 static public function is_defined<T,E>(self:Chunk<T,E>):Bool{
   return fold(
    self,
     (_) -> true,
     (_) -> false,
     ()  -> false
   );
 }
 static public function opt_else<T,Ti,E>(self:Chunk<T,E>,_if:T->Ti,_else:Option<Error<E>>->Ti):Ti{
   return fold(
    self,
     _if,
     (e) -> _else(Option.make(e)),
     ()  -> _else(None)
   );
 }
 static public function fudge<T,E>(self:Chunk<T,E>,?pos:Pos):Null<T>{
   return switch self{
     case End(null)  : throw "Value not found on force";null;
     case End(err)   : throw err;
     case Tap        : throw "Value not found on force";null;
     case Val(v)     : v;
     case null       : throw "no self to push on";
   }
 }
 static public function iterator<T,E>(self:Chunk<T,E>):Iterator<T>{
   var done = false;
   return {
     hasNext : function(){
      return switch(self){
        case Val(_) : !done;
        case End(e) : if(e!=null) e.crack(); false;
        case Tap    : Fault.make().digest((_:Digests)  -> _.e_undefined()).crack(); false;
      }
     },
     next    : function(){
       done = true;
       return switch(self){
         case Val(v)   : v;
         default       : null;
       }
     }
   };
 }
  static public function secure<O,E>(self:Chunk<O,E>):Chunk<O,E>{
    return self.fold(
      (v) -> v == null ? Tap : Val(v),
      End,
      () -> Tap
    );
  }
  static public function toUpshot<O,E>(self:Chunk<O,E>){
    return self.fold(
      ok  -> stx.nano.Upshot.UpshotSum.Accept(ok),
      (e) -> stx.nano.Upshot.UpshotSum.Reject(e),
      ()  -> stx.nano.Upshot.UpshotSum.Reject(Fault.make().digest((d:Digests)  -> d.e_undefined()))
    );
  }
  static public function toResOpt<O,E>(self:Chunk<O,E>){
    return self.fold(
      ok  -> stx.nano.Upshot.UpshotSum.Accept(Some(ok)),
      (e) -> stx.nano.Upshot.UpshotSum.Reject(e),
      ()  -> stx.nano.Upshot.UpshotSum.Accept(None)
    );
  }
  static public function toError<O,E>(self:Chunk<O,E>):Option<Error<E>>{
    return switch(self){
      case End(null) : None;
      case End(e)    : Some(e);
      default        : None;
    }
  }
  /**
	 * Produces `self` if it is `Val(x)`, the result of `thunk` otherwise.
	**/
  static public function or<T,E>(self: ChunkSum<T,E>, thunk: Void -> Chunk<T,E>): Chunk<T,E> {
    return fold(self,
      Val,
      e   -> End(e),  
      ()  -> thunk()
    );
  }
}