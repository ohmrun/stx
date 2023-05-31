package stx.makro.expr;

final Expr = __.makro().expr;

class HVarCtr extends Clazz{
	public function Make(name:String,?type:CTR<HComplexTypeCtr,HComplexType>,?expr:CTR<HExprCtr,HExpr>,?meta:CTR<HMetadataEntryCtr,HMetadata>,?isFinal,?isStatic){
		return HVar.make(
			name,
			__.option(type).map(f -> f.apply(Expr.HComplexType)).defv(null),
			__.option(expr).map(f -> f.apply(Expr.HExpr).prj()).defv(null),
			__.option(meta).map(f -> f.apply(Expr.HMetadataEntry).map(x -> x)).defv(null),
			isFinal,
			isStatic
		);
	}
} 

typedef HVarDef = haxe.macro.Expr.Var;

@:using(stx.makro.expr.HVar.HVarLift)
@:forward abstract HVar(HVarDef) from HVarDef to HVarDef{
  static public var _(default,never) = HVarLift;
  public inline function new(self:HVarDef) this = self;
  @:noUsing static inline public function lift(self:HVarDef):HVar return new HVar(self);

	@:noUsing static public function make(name:String,?type:HComplexType,?expr,?meta:HMetadata,?isFinal = false,?isStatic = true){
		return lift({
			name 				: name,
			type 				: type,
			expr 				: expr,
			isFinal 		: isFinal,
			isStatic 		: isStatic,
			meta 				: meta
		});
	}
  public function prj():HVarDef return this;
  private var self(get,never):HVar;
  private function get_self():HVar return lift(this);
}
class HVarLift{
  static public inline function lift(self:HVarDef):HVar{
    return HVar.lift(self);
  }
}