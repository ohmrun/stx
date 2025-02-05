package stx.parse.parser.term;

class CoupleWith<I,T,U> extends With<I,T,U,Couple<T,U>>{
  override function transform(l:Null<T>,r:Null<U>):Option<Couple<T,U>>{
    #if debug 
    __.log().debug(_ -> _.thunk(() -> '$l,$r'));
    #end
    return __.option(__.couple(l,r));
  }
}