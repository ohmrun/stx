package stx;

import haxe.CallStack;
import haxe.Exception;

class Pico{
  /**
    Best guess at platform filesystem seperator string
  **/
  static public function sep():String{
    #if sys
      var out = new haxe.io.Path(std.Sys.getCwd()).backslash ? "\\" : "/";
    #else
      var out = "/";
    #end
    return out;
  }
}
interface StxMemberApi{
  public var stx_tag(get,null) : Int;
  public function get_stx_tag() : Int;
}
abstract class StxMemberCls extends Clazz{
  public var stx_tag(get,null) : Int;
  abstract public function get_stx_tag() : Int;
}
//@back2dos haxetink
@:pure typedef PosDef = 
  #if macro
    haxe.macro.Expr.Position;
  #else
    haxe.PosInfos;
  #end
typedef Pos                     = PosDef;
class PosLift{
  static public function toString(pos:Pos){
    if (pos == null) return '<no_pos>';
    #if !macro
      var f   = pos.fileName;
      var cls = pos.className;
      var fn  = pos.methodName;
      var ln  = pos.lineNumber;
      return '$f:$ln';
    #else
      return '$pos';
    #end
  }
  static public function toLoc(self:Pos,index=0){
    return #if macro Loc.make(index,self); #else Loc.make(index,null,self); #end
  }
}
typedef LocDef  = stx.pico.Loc.LocDef;
typedef LocCtr  = stx.pico.Loc.LocCtr;
typedef Loc     = stx.pico.Loc;

#if tink_core
@:dox(hide) @:noCompletion typedef Future<T>                      = tink.core.Future<T>;
#end
@:dox(hide) @:noCompletion typedef Nada                           = stx.pico.Nada;
@:dox(hide) @:noCompletion typedef StdArray<T>                    = std.Array<T>;
@:dox(hide) @:noCompletion typedef StdInt                         = Int;
@:dox(hide) @:noCompletion typedef StdFloat                       = Float;
@:dox(hide) @:noCompletion typedef StdBool                        = Bool;
@:dox(hide) @:noCompletion typedef StdOption<T>                   = haxe.ds.Option<T>;
@:dox(hide) @:noCompletion typedef StdDynamic                     = Dynamic;

@:dox(hide) @:noCompletion typedef OptionSum<T>                   = stx.pico.Option.OptionSum<T>;//Publish Constructors.
@:dox(hide) @:noCompletion typedef Option<T>                      = stx.pico.Option<T>;
@:dox(hide) @:noCompletion typedef OptionLift                     = stx.pico.Option.OptionLift;

@:dox(hide) @:noCompletion typedef EitherSum<Ti,Tii>              = stx.pico.Either.EitherSum<Ti,Tii>;
@:dox(hide) @:noCompletion typedef Either<Ti,Tii>                 = stx.pico.Either<Ti,Tii>;
@:dox(hide) @:noCompletion typedef EitherLift                     = stx.pico.Either.EitherLift;

@:dox(hide) @:noCompletion typedef OutcomeSum<T,E>                = stx.pico.Outcome.OutcomeSum<T,E>;
@:dox(hide) @:noCompletion typedef Outcome<T,E>                   = stx.pico.Outcome<T,E>;

@:dox(hide) @:noCompletion typedef Clazz                          = stx.pico.Clazz;
@:dox(hide) @:noCompletion typedef IFaze                          = stx.pico.IFaze;
@:dox(hide) @:noCompletion typedef Identifier                     = stx.pico.Identifier;

@:dox(hide) @:noCompletion typedef Apply<P,R>                     = stx.pico.Apply<P,R>;
@:dox(hide) @:noCompletion typedef ApplyCls<P,R>                  = stx.pico.Apply.ApplyCls<P,R>;
@:dox(hide) @:noCompletion typedef ApplyApi<P,R>                  = stx.pico.Apply.ApplyApi<P,R>;

@:dox(hide) @:noCompletion typedef Comply<Pi,Pii,R>               = stx.pico.Comply<Pi,Pii,R>;
@:dox(hide) @:noCompletion typedef ComplyCls<Pi,Pii,R>            = stx.pico.Comply.ComplyCls<Pi,Pii,R>;
@:dox(hide) @:noCompletion typedef ComplyApi<Pi,Pii,R>            = stx.pico.Comply.ComplyApi<Pi,Pii,R>;

@:dox(hide) @:noCompletion typedef React                          = stx.pico.React;
@:dox(hide) @:noCompletion typedef ReactCls                       = stx.pico.React.ReactCls;
@:dox(hide) @:noCompletion typedef ReactApi                       = stx.pico.React.ReactApi;

@:dox(hide) @:noCompletion typedef Spend<P>                       = stx.pico.Spend<P>;
@:dox(hide) @:noCompletion typedef SpendCls<P>                    = stx.pico.Spend.SpendCls<P>;
@:dox(hide) @:noCompletion typedef SpendApi<P>                    = stx.pico.Spend.SpendApi<P>;

@:dox(hide) @:noCompletion typedef Reply<R>                       = stx.pico.Reply<R>;
@:dox(hide) @:noCompletion typedef ReplyCls<R>                    = stx.pico.Reply.ReplyCls<R>;
@:dox(hide) @:noCompletion typedef ReplyApi<R>                    = stx.pico.Reply.ReplyApi<R>;

typedef Embed<T>                = stx.pico.Embed<T>;


@:dox(hide) @:noCompletion typedef ArrayLift                      = stx.lift.ArrayLift;
@:dox(hide) @:noCompletion typedef IteratorLift                   = stx.lift.IteratorLift;
@:dox(hide) @:noCompletion typedef IterableLift                   = stx.lift.IterableLift;

typedef Uuid = stx.pico.Uuid;
typedef Stash<T> = stx.pico.Stash<T>;

enum abstract Tag(Null<Dynamic>){
  var Tag = null;
  @:from static function ofAny<T>(t:Null<T>):Tag
    return Tag;
}

// typedef EdictDef              = stx.pico.Edict.EdictDef;
// typedef EdictApi              = stx.pico.Edict.EdictApi;
// typedef PoireDef<P,O,I,R,E>   = stx.pico.Poire.PoireDef<P,O,I,R,E>;

typedef ExceptionDef            = {
  public var message(get,never):String;
	public var stack(get,never):CallStack;
	//public var previous(get,never):Null<Exception>;
	public var native(get,never):Any;
  function details():String;
}
interface ExceptionApi {
  public var message(get,never):String;
	public var stack(get,never):CallStack;
	//public var previous(get,never):Null<Exception>;
	public var native(get,never):Any;
  function details():String;
}


typedef CTRDef<P,R>         = stx.pico.CTR.CTRDef<P,R>;
typedef CTR<P,R>            = stx.pico.CTR<P,R>;
typedef Wildcard            = stx.pico.Wildcard;
typedef Couple<L,R>         = stx.pico.Couple<L,R>;
typedef Twin<T>             = Couple<T,T>;

typedef CoupleDef<L,R>      = stx.pico.Couple.CoupleDef<L,R>;
class LiftPico {
  static public function couple<Ti,Tii>(wildcard:Wildcard,tI:Ti,tII:Tii):Couple<Ti,Tii>{
    return (fn:Ti->Tii->Void) -> {
      fn(tI,tII);
    }
  }
  static public function decouple<Ti,Tii,Tiii>(wildcard:Wildcard,fn:Ti->Tii->Tiii):Couple<Ti,Tii> -> Tiii{
    return (tp:Couple<Ti,Tii>) -> {
      tp.decouple(fn);
    } 
  }
  /**
    Most used wildcard, creates an option, often used like: `Option.make(value).defv(fallback)`
  **/
  static public function option<T>(wildcard:Wildcard,?v:Null<T>):Option<T>{
    return switch(v){
      case null : None;
      default   : Some(v);
    }
  } 
  static public function debug(wildcard:Wildcard,str:String){
    #if sys
      sys.Debug.apply('$str\n');
    #else
      haxe.Log.trace(str,null);
    #end
  }
}        