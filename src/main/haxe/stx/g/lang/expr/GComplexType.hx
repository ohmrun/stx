package stx.g.lang.expr;

class GComplexTypeCtr extends Clazz{
	static public function unit(){
		return new GComplexTypeCtr();
	}
	private function lift(self:GComplexTypeSum){
		return GComplexType.lift(self);
	}
	public function Path(p:CTR<GTypePathCtr,GTypePath>):GComplexType{
		return lift(GTPath(p(GTypePath.__)));
	}
	public function Function(args:CTR<GComplexTypeCtr,Cluster<GComplexType>>, ret : CTR<GComplexTypeCtr,GComplexType>){
		return lift(GTFunction(args(unit()),ret(unit()))); 
	}
	public function Anonymous(fields:CTR<GFieldCtr,Cluster<GField>>){
		return lift(GTAnonymous(fields(GField.__)));
	}
	public function Parent(t:CTR<GComplexTypeCtr,GComplexType>){
		return lift(GTParent(t(this)));
	}
	public function Extend(p:CTR<GTypePathCtr,Cluster<GTypePath>>,fields:CTR<GFieldCtr,Cluster<GField>>){
		return lift(GTExtend(
			p(GTypePath.__),
			fields(GField.__)
		));
	}
	public function Optional(t:CTR<GComplexTypeCtr,GComplexType>){
		return lift(GTOptional(t(this)));
	}
	public function Named(n:String,t:CTR<GComplexTypeCtr,GComplexType>){
		return lift(GTNamed(n,t(this)));
	}
	public function Intersection(t:CTR<GComplexTypeCtr,Cluster<GComplexType>>){
		return lift(GTIntersection(t(this)));
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
	GTAnonymous( fields : Cluster<GField> );
	GTParent( t : GComplexType );
	GTExtend( p : Cluster<GTypePath>, fields : Cluster<GField> );
	GTOptional( t : GComplexType );
	GTNamed( n : String, t : GComplexType );
	GTIntersection(tl:Cluster<GComplexType>);
}
@:using(stx.g.lang.expr.GComplexType.GComplexTypeLift)
abstract GComplexType(GComplexTypeSum) from GComplexTypeSum to GComplexTypeSum{
	static public var __(default,never) = new GComplexTypeCtr();
  public function new(self) this = self;
  @:noUsing static public function lift(self:GComplexTypeSum):GComplexType return new GComplexType(self);

  public function prj():GComplexTypeSum return this;
  private var self(get,never):GComplexType;
  private function get_self():GComplexType return lift(this);

	public function toSource():GSource{
		return Printer.ZERO.printComplexType(this);
	}
	public function toTypeParam(){
		return GTPType(this);
	}
}
class GComplexTypeLift{
	static public function to_macro_at(self:GComplexType,pos:Position){
		return switch(self){
			case GTPath( p )             : TPath( p.to_macro_at(pos) );
			case GTFunction( args , ret ): TFunction( args.map(arg -> to_macro_at(arg,pos)).prj() , to_macro_at(ret,pos) );
			case GTAnonymous( fields  )  : TAnonymous( fields.map(x -> x.to_macro_at(pos)).prj()  );
			case GTParent( t )           : TParent( t.to_macro_at(pos) );
			case GTExtend( p , fields  ) : TExtend( p.map(x -> x.to_macro_at(pos)).prj() , fields.map(x -> x.to_macro_at(pos)).prj()  );
			case GTOptional( t )         : TOptional( t.to_macro_at(pos) );
			case GTNamed( n , t )        : TNamed( n , t.to_macro_at(pos) );
			case GTIntersection(tl)      : TIntersection(tl.map(x -> x.to_macro_at(pos)).prj());
		}		
	}
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