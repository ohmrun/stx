package stx.makro.expr;

/**
 * TODO, most of these should be properties.
 */
class HBinopCtr extends Clazz{
  public function Add(){ return OpAdd;}
  public function Mult(){ return OpMult;}
  public function Div(){ return OpDiv;}
  public function Sub(){ return OpSub;}
  public function Assign(){ return OpAssign;}
  public function Eq(){ return OpEq;}
  public function NotEq(){ return OpNotEq;}
  public function Gt(){ return OpGt;}
  public function Gte(){ return OpGte;}
  public function Lt(){ return OpLt;}
  public function Lte(){ return OpLte;}
  public function And(){ return OpAnd;}
  public function Or(){ return OpOr;}
  public function Xor(){ return OpXor;}
  public function BoolAnd(){ return OpBoolAnd;}
  public function BoolOr(){ return OpBoolOr;}
  public function Shl(){ return OpShl;}
  public function Shr(){ return OpShr;}
  public function UShr(){ return OpUShr;}
  public function Mod(){ return OpMod;}
  public function AssignOp(op:CTR<HBinopCtr,HBinop>){ return OpAssignOp(op.apply(this));}
  public function Interval(){ return OpInterval;}
  public function Arrow(){ return OpArrow;}
  public function In(){ return OpIn;}

  #if (haxe_ver > 4.205) 
  public function NullCoal(){ return OpNullCoal;}
  #end
}
typedef HBinopDef = haxe.macro.Expr.Binop;

 @:using(stx.makro.expr.HBinop.HBinopLift)
 abstract HBinop(HBinopDef) from HBinopDef to HBinopDef{
   public function new(self) this = self;
   @:noUsing static public function lift(self:HBinopDef):HBinop return new HBinop(self);
 

   public function prj():HBinopDef return this;
   private var self(get,never):HBinop;
   private function get_self():HBinop return lift(this);

 }
 class HBinopLift{
 

}