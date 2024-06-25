package stx.coroutine.pack;

import stx.coroutine.core.Coroutine.CoroutineLift;

typedef SecureDef<I,E> = CoroutineSum<I,Nada,Nada,E>;

@:using(stx.coroutine.pack.Secure.SecureLift)
@:forward abstract Secure<I,E>(SecureDef<I,E>) from SecureDef<I,E> to SecureDef<I,E>{
    
    @:noUsing static public function lift<I,E>(self:SecureDef<I,E>):Secure<I,E> return new Secure(self);
    public function new(self) this = self;
    
    @:noUsing static public function handler<O,E>(fn:O->Void):Secure<O,E>{
      return lift(__.wait(
          Transmission.fromFun1R(
            function rec(o){
              fn(o);
              return __.wait(Transmission.fromFun1R(rec));
            }
          )
      ));
    }
    @:noUsing static public function nowhere(){
        return handler((x)-> {});
    }
    public function provide(v:I):Secure<I,E>{
      return lift(CoroutineLift.provide(this,v));
    }
    @:from static public function fromHandler<I,E>(fn:I->Void):Secure<I,E>{
        return handler(fn);
    }
    @:to public function toCoroutine():Coroutine<I,Nada,Nada,E>{
      return this;
    } 
    @:from static public function fromCoroutine<I,E>(self:Coroutine<I,Nada,Nada,E>):Secure<I,E>{
      return lift(self);
    }
}
class SecureLift{
  static public function close<I,E>(self:SecureDef<I,E>):Effect<E>{
    function f(self:SecureDef<I,E>):EffectDef<E>{
      return switch(self){
        case Emit(o,next) : __.emit(o,f(next));
        case Wait(tran)   : __.stop();
        case Hold(held)   : __.hold(held.mod(f));
        case Halt(r)      : __.halt(r);
      }
    }
    return Effect.lift(f(self));
  }
}