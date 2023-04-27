package stx.assert.glot.eq;

import eu.ohmrun.glot.expr.GTypeParamDecl as GTypeParamDeclT;

class GTypeParamDecl extends stx.assert.eq.term.Base<GTypeParamDeclT> {
  public function comply(lhs:GTypeParamDeclT,rhs:GTypeParamDeclT){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Cluster(new GComplexType())).comply(lhs.constraints,rhs.constraints);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Cluster(new GTypeParamDecl())).comply(lhs.params,rhs.params);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new GMetadata()).comply(lhs.meta,rhs.meta);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new GComplexType()).comply(lhs.defaultType,rhs.defaultType);
    }
    return eq;
  }
}