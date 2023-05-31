package stx.makro.expr;

final Expr = __.makro().expr;

class HComplexTypeCtr extends Clazz{
	public function Path(p:CTR<HTypePathCtr,HTypePath>):HComplexType{
		return HComplexType.lift(TPath(p(Expr.HTypePath)));
	}
	public function Function(args:CTR<HComplexTypeCtr,Array<HComplexType>>, ret : CTR<HComplexTypeCtr,HComplexType>){
		return HComplexType.lift(TFunction(args(this),ret(this))); 
	}
	public function Anonymous(fields:CTR<HFieldCtr,Array<HField>>){
		return HComplexType.lift(TAnonymous(fields(Expr.HField)));
	}
	public function Parent(t:CTR<HComplexTypeCtr,HComplexType>){
		return HComplexType.lift(TParent(t(this)));
	}
	public function Extend(p:CTR<HTypePathCtr,Array<HTypePath>>,fields:CTR<HFieldCtr,Array<HField>>){
		return HComplexType.lift(TExtend(
			p(Expr.HTypePath),
			fields(Expr.HField)
		));
	}
	public function Optional(t:CTR<HComplexTypeCtr,HComplexType>){
		return HComplexType.lift(TOptional(t(this)));
	}
	public function Named(n:String,t:CTR<HComplexTypeCtr,HComplexType>){
		return HComplexType.lift(TNamed(n,t(this)));
	}
	public function Intersection(t:CTR<HComplexTypeCtr,Array<HComplexType>>){
		return HComplexType.lift(TIntersection(t(this)));
	}
	public function string(string:String){
		return Path( p -> p.fromString(string));
	} 
	public function fromString(string:String){
		return Path( p -> p.fromString(string));
	} 
}

typedef HComplexTypeDef = StdComplexType;

@:using(stx.makro.expr.HComplexType.HComplexTypeLift)
@:forward abstract HComplexType(StdComplexType) from StdComplexType to StdComplexType{
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdComplexType):HComplexType return new HComplexType(self);

  public function prj():StdComplexType return this;
  private var self(get,never):HComplexType;
  private function get_self():HComplexType return HComplexType.lift(this);

  @:from static public function fromStdTypePath(self:StdTypePath):HComplexType{
    return lift(TPath(self));
  }
  @:from static public function fromHTypePath(self:HTypePath):HComplexType{
    return lift(TPath(self.prj()));
  }
  @:noUsing static public function TPath(self:HTypePath){
    return fromHTypePath(self);
  }
  @:noUsing static public function TFunction(args:Array<HComplexType>,ret:HComplexType){
    return lift(StdComplexType.TFunction(args.prj(),ret.prj()));
  }
  @:noUsing static public function TAnonymous(args:Array<HField>){
    return lift(StdComplexType.TAnonymous(args.prj()));
  }
  @:noUsing static public function TParent(t:HComplexType){
    return lift(StdComplexType.TParent(t.prj()));
  }
  @:noUsing static public function TExtend(a:Array<HTypePath>,fields:Array<HField>){
    return lift(StdComplexType.TExtend(a.prj(),fields.prj()));
  }
  @:noUsing static public function TOptional(t:HComplexType){
    return lift(StdComplexType.TOptional(t.prj()));
  }
  @:noUsing static public function TNamed(n:String,t:HComplexType){
    return lift(StdComplexType.TNamed(n,t.prj()));
  }
  @:noUsing static public function TIntersection(tl:Array<HComplexType>){
    return lift(StdComplexType.TIntersection(tl.prj()));
  }
  public function toTypeParam(){
    return HTypeParam.fromStdComplexType(this);
  }
}
class HComplexTypeLift{

}