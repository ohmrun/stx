
package stx.nano.lift;

using stx.nano.lift.LiftNano;

import stx.pico.Identifier;
import stx.alias.StdType;

import stx.nano.Chunk;
import stx.nano.Upshot;

class LiftNano{
  // static public function nano(wildcard:Wildcard):Module{
  //   return new stx.nano.Module();
  // }
  /**
    shortcut for creating a variadic array: `Array<Dynamic>`
  **/
  static public function arrd(wildcard:Wildcard,arr:Array<Dynamic>):Array<Dynamic>{
    return arr;
  }
  /**
    Useful for all sorts, 
    ```haxe
    (true).if_else(
      () -> {},//if true
      () -> {}//if false
    );
    ```
  **/
  static public function if_else<R>(b:Bool,_if:Void->R,_else:Void->R):R{
    return b ? _if() : _else();
  }
  /**
    Returns the posititon in the code at the site of it's use. 
  **/
  static public function here(wildcard:Wildcard,?pos:Pos):Pos{
    return pos;
  }
  #if hx3compat
  static public function test(wildcard:Wildcard,arr:Iterable<haxe.unit.TestCase>){
    var runner = new haxe.unit.TestRunner();
    for(t in arr){
      runner.add(t);
    }
    runner.run();
  }    
  #end
  /**
		Returns a unique identifier, each `x` replaced with a hex character.
	**/
  static public inline function uuid(v:Wildcard, ?value : String) : Uuid {
    return new Uuid();
  }
  /**
    Best guess at platform filesystem seperator string
  **/
  static public function sep(_:Wildcard):String{
    #if sys
      var out = new haxe.io.Path(std.Sys.getCwd()).backslash ? "\\" : "/";
    #else
      var out = "/";
    #end
    return out;
  }
  /**
    
  **/
  static public function accept<T,E>(wildcard:Wildcard,t:T):Upshot<T,E>{
    return Upshot.accept(t);
  }
  static public function reject<T,E>(wildcard:Wildcard,e:CTR<Fault,Error<E>>,?pos:Pos):Upshot<T,E>{
    return Upshot.reject(e.apply(pos));
  }
  /**
   * Wildcard static extension constructor for `stx.nano.Fault`
   * @param wildcard 
   * @param pos 
   * @return Fault
   */
  static public function fault(wildcard:Wildcard,?pos:Pos):Fault{
    return new Fault(pos);
  }
  static public function pair<Ti,Tii>(wildcard:Wildcard,tI:Ti,tII:Tii):Pair<Ti,Tii>{
    return new tink.core.Pair(tI,tII);
  }
  /**
    * create a function from `fn` that can be applied to a value of `Tup<L,R>`
    * @param self 
    * @return R
    */
   static public inline function detuple<L,R,Z>(wildcard:Wildcard,fn:L->R->Z):Tup2<L,R> -> Z{
     return (tp:Tup2<L,R>) -> {
       return switch(tp){
           case tuple2(l,r) : fn(l,r);
       }
     }
   }
  static public function triple<Ti,Tii,Tiii>(wildcard:Wildcard,tI:Ti,tII:Tii,tIII:Tiii):Triple<Ti,Tii,Tiii>{
    return (fn:Ti->Tii->Tiii->Void) -> {
      fn(tI,tII,tIII);
    }
  }
  static public function detriple<Ti,Tii,Tiii,Tiv>(wildcard:Wildcard,fn:Ti->Tii->Tiii->Tiv):Triple<Ti,Tii,Tiii> -> Tiv{
    return (tp:Triple<Ti,Tii,Tiii>) -> {
      tp.detriple(fn);
    }
  }
  static public function toCouple<Ti,Tii>(self:stx.pico.Couple.CoupleDef<Ti,Tii>):stx.pico.Couple<Ti,Tii>{
    return self;
  }

  /**
    make Some(Couple<L,R>) if Option<L> is defined;
  **/
  static public function lbump<L,R>(wildcard:Wildcard,tp:Couple<Option<L>,R>):Option<Couple<L,R>>{
    return tp.decouple(
      (lhs,rhs) -> lhs.fold(
        (l) -> Some(Couple.make(l,rhs)),
        ()  -> None
      )
    );
  }
  /**
    make Some(Couple<L,R>) if Option<R> is defined;
  **/
  static public function rbump<L,R>(wildcard:Wildcard,tp:Couple<L,Option<R>>):Option<Couple<L,R>>{
    return tp.decouple(
      (lhs,rhs) -> rhs.fold(
        r   -> (Some(Couple.make(lhs,r))),
        ()  -> None
      )
    );
  }
  @:noUsing static public function fromPos(pos:Pos):Position{
    return Position.fromPos(pos);
  }
  #if tink_core
  static public function future<T>(wildcard:Wildcard):Couple<tink.core.Future.FutureTrigger<T>,tink.core.Future<T>>{
    var trigger = tink.core.Future.trigger();
    var future  = trigger.asFuture();
    return Couple.make(trigger,future);
  }
  static public function squeeze<T>(self:Future<T>):Option<T>{
    return new stx.nano.module.Future().tryAndThenCancelIfNotAvailable(self);
  }
  #end
  static public inline function tracer<T>(v:Wildcard,?pos:haxe.PosInfos):T->T{
    return function(t:T):T{
      haxe.Log.trace(t,pos);
      return t;
    }
  }
  static public function trace<T>(v:Wildcard,?pos:Pos):T->Void{
    #if !macro
      var infos :haxe.PosInfos = pos;
    #else
      var infos = null;
    #end
    return function(d:T):Void{
      haxe.Log.trace(d,infos);
    }
  }
  static public function perform<T>(__:Wildcard,fn:Void->Void):T->T{
    return (v:T) -> {
      fn();
      return v;
    }
  }
  static public function execute<T,E>(__:Wildcard,fn:Void->Option<Error<E>>):T->Upshot<T,E>{
    return (v:T) -> switch(fn()){
      case Some(e)  : Reject(e);
      default       : Accept(v);
    }
  }
  static public function left<Ti,Tii>(__:Wildcard,tI:Ti):Either<Ti,Tii>{
    return Left(tI);
  }
  static public function right<Ti,Tii>(__:Wildcard,tII:Tii):Either<Ti,Tii>{
    return Right(tII);
  }
  static public function either<T>(either:Either<T,T>):T{
    return either.fold(
      l -> l,
      r -> r 
    );
  }
  static public inline function crack<E>(wildcard:Wildcard,e:E){
    throw e;
  }
  static public inline function report<E>(wildcard:Wildcard,?f:Fault -> Error<E>,?pos:Pos):Report<E>{
    return f == null ? Report.unit() : Report.pure(f(Fault.make(pos)));
  }
  
  // static public inline function pos<P,R>(fn:Binary<P,Null<Pos>,R>,?pos:Pos):Unary<P,R>{
  //   return fn.bind(_,pos);
  // }
  static public function definition<T>(wildcard:Wildcard,t:T):Class<T>{
    return std.Type.getClass(t);
  }
  static public function identifier<T>(self:Class<T>):Identifier{
    return new Identifier(StdType.getClassName(self));
  }
  static public function locals<T>(self:Class<T>){
    return StdType.getInstanceFields(self);
  }
  static public function vblock<T>(wildcard:Wildcard,t:T):VBlock<T>{
    return ()->{};
  }
  static public function not(bool:Bool){
    return !bool;
  } 
  static public function toPosition(pos:Pos):Position{
    return Position.lift(pos);
  }
  static public function chunk<T>(_:Wildcard,v:Null<T>):Chunk<T,Dynamic>{
    return switch(v){
      case null : Tap;
      default   : Val(v);
    }
  }
  static public function way(wildcard:Wildcard,?str:String):Way{
    return str == null ? Way.unit() :  Way.fromStringDotted(str);
  }
  static public function toIdentifier(pos:Pos):Identifier{
    return Identifier.lift(Position.lift(pos).className);
  }
  static public function toIdent(self:Identifier){
    return Ident.fromIdentifier(self);
  }
  static public function toAlert<E>(ft:Future<Report<E>>):Alert<E>{
    return Alert.lift(ft);
  }
  static public function toString(pos:Pos):String{
    var id = toIdentifier(pos);
    var fn = pos.toPosition().methodName;
    return '${id}.${fn}';
  }
  @:note('#0b1kn00b: depends upon `until` actually being part of the hierarchy')
  @stx.unsafe
  static public function ancestors<A>(type:Class<A>,?until:Class<Dynamic>):Cluster<Class<Dynamic>>{
    var o : Cluster<Class<Dynamic>> = [];
    var t : Class<Dynamic> = type;

    while(t!=null){
      o = o.snoc(t);
      t = Type.getSuperClass(t);
    }
    if(until!=null){
      o = o.whilst(
        (x:Class<Dynamic>) -> definition(__,x).identifier() != definition(__,until).identifier()
      );
      o = o.snoc(until);
    }
    return o;
  }
  static public inline function toChars(self:String):Chars{
    return self;
  }
}
class StringToIdentifier{
  static public function identifier(wildcard:Wildcard,str:String):Identifier{
    return new Identifier(str);
  }
}
class LiftIdentifierToIdent{
  
} 