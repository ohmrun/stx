package stx.assert.g.ord;

import stx.g.lang.expr.GTypeParamDecl as GTypeParamDeclT;

class GTypeParamDecl extends OrdCls<GTypeParamDeclT>{
  public function new(){}
  public function comply(lhs:GTypeParamDeclT,rhs:GTypeParamDeclT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Cluster(new GComplexType())).comply(lhs.constraints,rhs.constraints);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Cluster(new GTypeParamDecl())).comply(lhs.params,rhs.params);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GMetadata()).comply(lhs.meta,rhs.meta);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GComplexType()).comply(lhs.defaultType,rhs.defaultType);
    }
    return ord;
  }
}