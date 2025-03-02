package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GVarCtr extends Clazz{
	public function Make(name:String,?type:CTR<GComplexTypeCtr,GComplexType>,?expr:CTR<GExprCtr,GExpr>,?meta:CTR<GMetadataEntryCtr,GMetadata>,?isFinal,?isStatic){
		return GVar.make(
			name,
			__.option(type).map(f -> f.apply(Expr.GComplexType)).defv(null),
			__.option(expr).map(f -> f.apply(Expr.GExpr)).defv(null),
			__.option(meta).map(f -> f.apply(Expr.GMetadataEntry)).defv(null),
			isFinal,
			isStatic
		);
	}
} 
typedef GVarDef = {
	final name:String;
	final ?type:GComplexType;
	final ?expr:GExpr;
	final ?meta:GMetadata;
	final ?isFinal:Bool;
	final ?isStatic:Bool;
}
@:using(eu.ohmrun.glot.expr.GVar.GVarLift)
@:forward abstract GVar(GVarDef) from GVarDef to GVarDef{
	static public var _(default,never) = GVarLift;
	  public function new(self) this = self;
  @:noUsing static public function lift(self:GVarDef):GVar return new GVar(self);
	@:noUsing static public function make(name:String,?type:GComplexType,?expr,?meta:GMetadata,?isFinal = false,?isStatic = true){
		return lift({
			name 				: name,
			type 				: type,
			expr 				: expr,
			isFinal 		: isFinal,
			isStatic 		: isStatic,
			meta 				: meta
		});
	}
  public function prj():GVarDef return this;
  private var self(get,never):GVar;
  private function get_self():GVar return lift(this);

	public function toSource():GSource{
		return Printer.ZERO.printVar(this);
	}
}
class GVarLift{
	#if macro
	static public function to_macro_at(self:GVar,pos:Position):Var{
		return {
			name 				: self.name,
			type 				: __.option(self.type).map(x -> x.to_macro_at(pos)).defv(null),
			expr 				: __.option(self.expr).map(x -> x.to_macro_at(pos)).defv(null),
			isFinal 		: self.isFinal,
			isStatic 		: self.isStatic,
			meta 				: __.option(self.meta).map(x -> x.to_macro_at(pos)).defv(null)
		}		
	}
	#end
}