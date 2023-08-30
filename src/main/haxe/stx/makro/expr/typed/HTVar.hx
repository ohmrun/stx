package stx.makro.expr.typed;

//final Expr = __.makro().expr;

class HTVarCtr extends Clazz{
	// public function Make(name:String,?type:CTR<HComplexTypeCtr,HComplexType>,?expr:CTR<HExprCtr,HExpr>,?meta:CTR<HMetadataEntryCtr,HMetadata>,?isFinal,?isStatic){
	// 	return HTVar.make(
	// 		name,
	// 		__.option(type).map(f -> f.apply(Expr.HComplexType)).defv(null),
	// 		__.option(expr).map(f -> f.apply(Expr.HExpr).prj()).defv(null),
	// 		__.option(meta).map(f -> f.apply(Expr.HMetadataEntry).map(x -> x)).defv(null),
	// 		isFinal,
	// 		isStatic
	// 	);
	// }
} 

typedef HTVarDef = haxe.macro.Type.TVar;

@:using(stx.makro.expr.typed.HTVar.HTVarLift)
@:forward abstract HTVar(HTVarDef) from HTVarDef to HTVarDef{
  static public var _(default,never) = HTVarLift;
  public inline function new(self:HTVarDef) this = self;
  @:noUsing static inline public function lift(self:HTVarDef):HTVar return new HTVar(self);

  public function prj():HTVarDef return this;
  private var self(get,never):HTVar;
  private function get_self():HTVar return lift(this);
}
class HTVarLift{
  static public inline function lift(self:HTVarDef):HTVar{
    return HTVar.lift(self);
  }
}
/*
typedef TVar = {
	public var id(default, never):Int;
	public var name(default, never):String;
	public var t(default, never):Type;
	public var capture(default, never):Bool;
	public var extra(default, never):Null<{params:Array<TypeParameter>, expr:Null<TypedExpr>}>;
	public var meta(default, never):Null<MetaAccess>;
}
*/