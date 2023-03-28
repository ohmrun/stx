package eu.ohmrun.halva;

@:using(eu.ohmrun.halva.LVar.LVarLift)
enum LVarSum<T>{
  BOT;
  HAS(v:T,frozen:Bool);
  TOP;
} 
@:using(eu.ohmrun.halva.LVar.LVarLift)
abstract LVar<T>(LVarSum<T>) from LVarSum<T> to LVarSum<T>{
  static public var _(default,never) = LVarLift;
  public inline function new(self:LVarSum<T>) this = self;
  @:noUsing static inline public function lift<T>(self:LVarSum<T>):LVar<T> return new LVar(self);
  @:noUsing static inline public function unit<T>():LVar<T>{ return lift(BOT); }
  @:noUsing static inline public function pure<T>(v:T):LVar<T>{ return lift(HAS(v,false)); }
  public function prj():LVarSum<T> return this;
  public var self(get,never):LVar<T>;
  private function get_self():LVar<T> return lift(this);

  public var frozen(get,never):Bool;
  private function get_frozen():Bool{
    return switch(this){
      case BOT      : false;
      case HAS(_,b) : b;
      case TOP      : true;
    }
  }
}
class LVarLift{
  static public inline function lift<T>(self:LVarSum<T>):LVar<T>{
    return LVar.lift(self);
  }
  static public function fold<T,Z>(self:LVarSum<T>,bot:Void->Z,has:T->Bool->Z,top:Void->Z):Z{
    return switch(self){
      case BOT          : bot();
      case HAS(x,f)     : has(x,f);
      case TOP          : top();
    }
  }
  static public function flat_map<Ti,Tii>(self:LVarSum<Ti>,f:Ti->LVar<Tii>){
    return fold(self,
      ()    -> BOT,
      (x,b) -> {
        final result = f(x);
        return switch([b,result]){
          case [_,BOT]                    : TOP;
          case [_,TOP]                    : result;
          case [false,HAS(_,false)]       : result;
          case [false,HAS(_,true)]        : result;
          case [true,HAS(_,false)]        : TOP;
          case [true,HAS(_,true)]         : result;
        }
      },
      ()    -> TOP
    );
  }
  static public function zip<Ti,Tii>(self:LVarSum<Ti>,that:LVar<Tii>):LVar<Couple<Ti,Tii>>{
    return switch([self,that]){
      case [BOT,BOT]                    : BOT;
      case [HAS(l,false),HAS(r,false)]  : HAS(__.couple(l,r),false);
      case [HAS(l,false),HAS(r,true)]   : HAS(__.couple(l,r),true);
      case [HAS(l,true),HAS(r,true)]    : HAS(__.couple(l,r),true);
      case [HAS(_,true),HAS(_,false)]   : TOP;
      case [TOP,TOP]                    : TOP;
      default                           : TOP;
    }
  }
  static public function map<Ti,Tii>(self:LVarSum<Ti>,fn:Ti->Tii):LVar<Tii>{
    return switch(self){
      case HAS(s,false) : HAS(fn(s),false);
      case HAS(s,true)  : TOP;
      case BOT          : TOP;
      case TOP          : TOP;
    }
  }
  static public function freeze<T>(self:LVarSum<T>){
    return switch(self){
      case HAS(s,_)     : HAS(s,true);
      case BOT          : TOP;
      case TOP          : TOP;
    }
  }
  static public function is_defined<T>(self:LVarSum<T>){
    return fold(
      self,
      ()    -> false,
      (_,_) -> true,
      ()    -> false
    );
  }
} 