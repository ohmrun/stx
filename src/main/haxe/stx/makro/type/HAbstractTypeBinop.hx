package stx.makro.type;

final type = __.makro().type;

class HAbstractTypeBinopCtr extends Clazz{
  public function Make(op:haxe.macro.Expr.Binop,field:CTR<HClassFieldCtr,HClassField>){
    return HAbstractTypeBinop.make(op,field.apply(type.HClassField));
  }
}
typedef HAbstractTypeBinopDef = {op:haxe.macro.Expr.Binop, field:HClassField};

@:using(stx.makro.type.HAbstractTypeBinop.HAbstractTypeBinopLift)
@:forward abstract HAbstractTypeBinop(HAbstractTypeBinopDef) from HAbstractTypeBinopDef to HAbstractTypeBinopDef{
  static public var _(default,never) = HAbstractTypeBinopLift;
  public inline function new(self:HAbstractTypeBinopDef) this = self;
  @:noUsing static inline public function lift(self:HAbstractTypeBinopDef):HAbstractTypeBinop return new HAbstractTypeBinop(self);

  @:noUsing static inline public function make(op:haxe.macro.Expr.Binop,field:HClassField){
    return lift({
      op    : op,
      field : field
    });
  }
  public function prj():HAbstractTypeBinopDef return this;
  private var self(get,never):HAbstractTypeBinop;
  private function get_self():HAbstractTypeBinop return lift(this);
}
class HAbstractTypeBinopLift{
  static public inline function lift(self:HAbstractTypeBinopDef):HAbstractTypeBinop{
    return HAbstractTypeBinop.lift(self);
  }
}