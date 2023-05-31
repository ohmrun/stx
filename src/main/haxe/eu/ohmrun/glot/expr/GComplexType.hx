package eu.ohmrun.glot.expr;

final Expr = __.glot().Expr;

class GComplexTypeCtr extends Clazz{
	public function Path(p:CTR<GTypePathCtr,GTypePath>):GComplexType{
		return GComplexType.lift(GTPath(p(Expr.GTypePath)));
	}
	public function Function(args:CTR<GComplexTypeCtr,Cluster<GComplexType>>, ret : CTR<GComplexTypeCtr,GComplexType>){
		return GComplexType.lift(GTFunction(args(this),ret(this))); 
	}
	public function Anonymous(fields:CTR<GEFieldCtr,Cluster<GEField>>){
		return GComplexType.lift(GTAnonymous(fields(Expr.GEField)));
	}
	public function Parent(t:CTR<GComplexTypeCtr,GComplexType>){
		return GComplexType.lift(GTParent(t(this)));
	}
	public function Extend(p:CTR<GTypePathCtr,Cluster<GTypePath>>,fields:CTR<GEFieldCtr,Cluster<GEField>>){
		return GComplexType.lift(GTExtend(
			p(Expr.GTypePath),
			fields(Expr.GEField)
		));
	}
	public function Optional(t:CTR<GComplexTypeCtr,GComplexType>){
		return GComplexType.lift(GTOptional(t(this)));
	}
	public function Named(n:String,t:CTR<GComplexTypeCtr,GComplexType>){
		return GComplexType.lift(GTNamed(n,t(this)));
	}
	public function Intersection(t:CTR<GComplexTypeCtr,Cluster<GComplexType>>){
		return GComplexType.lift(GTIntersection(t(this)));
	}
	public function string(string:String){
		return Path( p -> p.fromString(string));
	} 
	public function fromString(string:String){
		return Path( p -> p.fromString(string));
	} 
}
enum GComplexTypeSum{
	GTPath( p : GTypePath );
	GTFunction( args : Cluster<GComplexType>, ret : GComplexType );
	GTAnonymous( fields : Cluster<GEField> );
	GTParent( t : GComplexType );
	GTExtend( p : Cluster<GTypePath>, fields : Cluster<GEField> );
	GTOptional( t : GComplexType );
	GTNamed( n : String, t : GComplexType );
	GTIntersection(tl:Cluster<GComplexType>);
}
@:using(eu.ohmrun.glot.expr.GComplexType.GComplexTypeLift)
abstract GComplexType(GComplexTypeSum) from GComplexTypeSum to GComplexTypeSum{
	  public function new(self) this = self;
  @:noUsing static public function lift(self:GComplexTypeSum):GComplexType return new GComplexType(self);

  public function prj():GComplexTypeSum return this;
  private var self(get,never):GComplexType;
  private function get_self():GComplexType return GComplexType.lift(this);

	public function toSource():GSource{
		return Printer.ZERO.printComplexType(this);
	}
	public function toTypeParam(){
		return GTPType(this);
	}
}
class GComplexTypeLift{
	#if macro
	static public function to_macro_at(self:GComplexType,pos:Position):ComplexType{
		return @:privateAccess switch(self){
			case GComplexTypeSum.GTPath( p )             : TPath( p.to_macro_at(pos) );
			case GComplexTypeSum.GTFunction( args , ret ): TFunction( args.map(arg -> to_macro_at(arg,pos)).prj() , to_macro_at(ret,pos) );
			case GComplexTypeSum.GTAnonymous( fields  )  : TAnonymous( fields.map(x -> x.to_macro_at(pos)).prj()  );
			case GComplexTypeSum.GTParent( t )           : TParent( t.to_macro_at(pos) );
			case GComplexTypeSum.GTExtend( p , fields  ) : TExtend( p.map(x -> x.to_macro_at(pos)).prj() , fields.map(x -> x.to_macro_at(pos)).prj()  );
			case GComplexTypeSum.GTOptional( t )         : TOptional( t.to_macro_at(pos) );
			case GComplexTypeSum.GTNamed( n , t )        : TNamed( n , t.to_macro_at(pos) );
			case GComplexTypeSum.GTIntersection(tl)      : TIntersection(tl.map(x -> x.to_macro_at(pos)).prj());
		}		
	}
	#end
}
/**
	return switch(self){
			case GTPath(p) : 
			case GTFunction(args,ret) : 
			case GTAnonymous(fields) : 
			case GTParent(t) : 
			case GTExtend(p,fields) : 
			case GTOptional(t) : 
			case GTNamed(n,t) : 
			case GTIntersection(tl) : 
	}
**/