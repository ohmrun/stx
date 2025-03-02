package stx.pico;

typedef CoupleDef<Ti,Tii> = (Ti -> Tii -> Void) -> Void;
typedef CoupleCat<Ti,Tii> = Array<Either<Ti,Tii>>;//[Left(tI),Right(tII)]

/**
 * Lazy 2ary tuple by using a handler. Doesn't currently play to well with `trace`. 
 * @see stx.Tup2
 * 
 * ```haxe    
 * using stx.Nano;
 * function test_couple(){
 *  final cp    = Couple.make(1,2);//Couple<Int,Int>
 *  final f     = (l,r) -> l + r
 *  final val   = __.decouple(f);//creates a Couple<Int,Int> -> Int from Int->Int->Int
 *  cp(val);//use Couple as a function
 *  final valI  = cp.decouple(f)//apply Int->Int->Int to Couple<Int,Int>
 * }
 * ```
 */
@:using(stx.pico.Couple.CoupleLift)
@:callable abstract Couple<Ti,Tii>(CoupleDef<Ti,Tii>) from CoupleDef<Ti,Tii> to CoupleDef<Ti,Tii>{
  
  
  @stx.make
  @:noUsing static public function make<Ti,Tii>(lhs:Ti,rhs:Tii):Couple<Ti,Tii>{
    return (cb) -> cb(lhs,rhs);
  }
  #if thx_core
    public function fromThxTuple<Pi,Pii>(tup:ThxTuple<Pi,Pii>):Couple<Pi,Pii>{
      return (cb) -> cb(tup._0,tup._1);
    }

    public function toThxTuple<Pi,Pii>(tup:Couple<Pi,Pii>):ThxTuple<Pi,Pii>{
      return new ThxTuple(fst(tup),snd(tup));
    }
  #end
  public function toString(){
    return CoupleLift.toString(this);
  }
}
class CoupleLift{
  static public function map<Ti,Tii,TT>(self: Couple<Ti,Tii>,fn:Tii->TT): Couple<Ti,TT>{
    return (tp:Ti->TT->Void) -> self(
      (ti,tii) -> tp(ti,fn(tii))
    );
  }
  static public function mapl<Ti,Tii,TT>(self: Couple<Ti,Tii>,fn:Ti->TT):Couple<TT,Tii>{
    return (tp) -> self(
      (ti,tii) -> tp(fn(ti),tii)
    );
  }
  static public function mapr<Ti,Tii,TT>(self: Couple<Ti,Tii>,fn:Tii->TT):Couple<Ti,TT>{
    return map(self,fn);
  }
  static public function fst<Ti, Tii>(self : Couple<Ti, Tii>) : Ti{
    return decouple(self,(tI,_) -> tI);
  }
  static public function snd<Ti, Tii>(self : Couple<Ti, Tii>) : Tii{
    return decouple(self,(_,tII) -> tII);
  }
  static public function swap<Ti, Tii>(self : Couple<Ti, Tii>) : Couple<Tii, Ti>{
    return (tp) -> self((ti,tii) -> tp(tii,ti));
  }
  static public function equals<Ti, Tii>(lhs : Couple<Ti, Tii>,rhs : Couple<Ti, Tii>) : Bool{
    return decouple(lhs,
      (t0l, t0r) -> decouple(rhs,(t1l, t1r) -> 
        (t0l == t1l) && (t0r == t1r)
    ));
  }
  static public function reduce<Ti,Tii,TT>(self: Couple<Ti,Tii>,flhs:Ti->TT,frhs:Tii->TT,plus:TT->TT->TT):TT{
    return decouple(self,(tI,tII) -> plus(flhs(tI),frhs(tII)));
  }
  static public function decouple<Ti,Tii,Tiii>(self:Couple<Ti,Tii>,fn:Ti->Tii->Tiii):Tiii{
    var out = null;
    self(
      (ti,tii) -> {
        out = fn(ti,tii);
      }
    );
    return out;
  }
  static public function toString<Ti,Tii>(self:Couple<Ti,Tii>):String{
    return decouple(self,
      (l,r) -> '($l $r)'
    );
  }
}