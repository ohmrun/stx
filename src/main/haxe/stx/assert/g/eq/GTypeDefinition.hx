package stx.assert.g.eq;

import stx.g.lang.expr.GTypeDefinition as GTypeDefinitionT;

class GTypeDefinition implements EqApi<GTypeDefinitionT> extends Clazz{
  public function comply(lhs:GTypeDefinitionT,rhs:GTypeDefinitionT){
    var eq = Eq.String().comply(lhs.name,rhs.name);
    if(eq.is_ok()){
      eq = Eq.Cluster(Eq.String()).comply(lhs.pack,rhs.pack);
    }
    if(eq.is_ok()){
      eq = new GTypeDefKind().comply(lhs.kind,rhs.kind);
    }
    if(eq.is_ok()){
      eq = Eq.Cluster(new GField()).comply(lhs.fields,rhs.fields);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Cluster(new GTypeParamDecl())).comply(lhs.params,rhs.params);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(new GMetadata()).comply(lhs.meta,rhs.meta);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.Bool()).comply(lhs.isExtern,rhs.isExtern);
    }
    if(eq.is_ok()){
      eq = Eq.NullOr(Eq.String()).comply(lhs.doc,rhs.doc);
    }
    return eq;
  }
} 