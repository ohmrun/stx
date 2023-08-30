package stx.makro.type;

final type = __.makro().type;

class HAbstractTypeUnopCtr extends Clazz{
  public function Make(op:haxe.macro.Expr.Unop,postFix:Bool,field:CTR<HClassFieldCtr,HClassField>){
    return HAbstractTypeUnop.make(op,postFix,field.apply(type.HClassField));
  }
}
typedef HAbstractTypeUnopDef = {op:haxe.macro.Expr.Unop, postFix: Bool, field:HClassField};

@:using(stx.makro.type.HAbstractTypeUnop.HAbstractTypeUnopLift)
@:forward abstract HAbstractTypeUnop(HAbstractTypeUnopDef) from HAbstractTypeUnopDef to HAbstractTypeUnopDef{
  static public var _(default,never) = HAbstractTypeUnopLift;
  public inline function new(self:HAbstractTypeUnopDef) this = self;
  @:noUsing static inline public function lift(self:HAbstractTypeUnopDef):HAbstractTypeUnop return new HAbstractTypeUnop(self);

  @:noUsing static inline public function make(op:haxe.macro.Expr.Unop,postFix:Bool,field:HClassField){
    return lift({
      op        : op,
      postFix   : postFix,
      field     : field
    });
  }
  public function prj():HAbstractTypeUnopDef return this;
  private var self(get,never):HAbstractTypeUnop;
  private function get_self():HAbstractTypeUnop return lift(this);
}
class HAbstractTypeUnopLift{
  static public inline function lift(self:HAbstractTypeUnopDef):HAbstractTypeUnop{
    return HAbstractTypeUnop.lift(self);
  }
}