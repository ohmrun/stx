package stx.makro.expr;

final Expr = __.makro().expr;

class HTypeParamDeclCtr extends Clazz{
  public function Make(
    name:String,
    ?constraints:Null<CTR<HComplexTypeCtr,Array<HComplexType>>>,
    ?params:Null<CTR<HTypeParamDeclCtr,Array<HTypeParamDecl>>>,
    ?meta:Null<CTR<HMetadataEntryCtr,HMetadata>>,
    ?defaultType:Null<CTR<HComplexTypeCtr,HComplexType>>){
    return HTypeParamDecl.make(
      name,
      __.option(constraints).map(f -> f(Expr.HComplexType)).defv(null),
      __.option(params).map(f -> f(Expr.HTypeParamDecl)).defv(null),   
      __.option(meta).map(f -> f(Expr.HMetadataEntry)).defv(null),
      __.option(defaultType).map(f -> f(Expr.HComplexType)).defv(null)    
    );
  }
}

typedef HTypeParamDeclDef = StdTypeParamDecl;

@:using(stx.makro.expr.HTypeParamDecl.HTypeParamDeclLift)
@:forward abstract HTypeParamDecl(StdTypeParamDecl) from StdTypeParamDecl to StdTypeParamDecl{
  static public var _(default,never) = HTypeParamDeclLift;
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdTypeParamDecl):HTypeParamDecl return new HTypeParamDecl(self);

  @:noUsing static public function make(name:String,?constraints:Array<HComplexType>,?params:Array<HTypeParamDecl>,?meta,defaultType){
    return lift({
      name        : name,
      constraints : constraints,
      params      : params,
      meta        : meta,
      defaultType : defaultType 
    });
  }

  public function prj():StdTypeParamDecl return this;
  private var self(get,never):HTypeParamDecl;
  private function get_self():HTypeParamDecl return lift(this);
}
class HTypeParamDeclLift{
  @:noUsing static public function lift(self:StdTypeParamDecl){
    return HTypeParamDecl.lift(self);
  }

}