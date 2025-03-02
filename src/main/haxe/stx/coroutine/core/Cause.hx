package stx.coroutine.core;

enum CauseSum<E>{
  Stop;
  Exit(err:Error<E>);
  //Timeout();
}

/**
 *  Specifies the Cause of a Return if not a Production.
 */
@:using(stx.coroutine.core.Cause.CauseLift)
abstract Cause<E>(CauseSum<E>) from CauseSum<E> to CauseSum<E>{
  public function new(self){
    this = self;
  }
  @:from static public function fromErrorDigest<E>(e:Error<Digest>):Cause<E>{
    return Exit(Error.make(e.lapse.map((function(x:Lapse<Digest>):Lapse<E>{ return new LapseCtr().Make(null,x.value.label,null,x.value.canon,x.value.loc);} ))));
  }
  //   return Exit(Error.fromTinkError(e));
  // }
  @:from static public function fromError<E>(e:Error<E>):Cause<E>{
    return Exit(e);
  }
  static public function early<E>(e:Error<E>):Cause<E>{
    return Exit(e);
  }
} 
class CauseLift{
  static public function toOption<E>(self:Cause<E>):Option<Error<E>>{
    return switch(self){
      case Exit(err)      : Some(err);
      case Stop           : Some(__.fault().digest((_:Digests) -> _.e_coroutine_stop()));
    }
  }
  static public function next<E>(thiz:Cause<E>,that:Cause<E>):Cause<E>{
    return switch([thiz,that]){
      case [Stop,Stop]                  : Stop;
      case [Exit(e0),Exit(e1)]          : Exit(e0 == null ? e1 : e0.concat(e1));
      case [Exit(err),_]                : Exit(err);
      case [_,Exit(err)]                : Exit(err);
    }
  }
}