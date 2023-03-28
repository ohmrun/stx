package stx.assert.g.ord;

import stx.g.lang.expr.GTypeDefinition as GTypeDefinitionT;

class GTypeDefinition extends OrdCls<GTypeDefinitionT> {
  public function new(){}
  public function comply(lhs:GTypeDefinitionT,rhs:GTypeDefinitionT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.Cluster(Ord.String()).comply(lhs.pack,rhs.pack);
    }
    if(ord.is_not_less_than()){
      ord = new GTypeDefKind().comply(lhs.kind,rhs.kind);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Cluster(new GField()).comply(lhs.fields,rhs.fields);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Cluster(new GTypeParamDecl())).comply(lhs.params,rhs.params);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(new GMetadata()).comply(lhs.meta,rhs.meta);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Bool()).comply(lhs.isExtern,rhs.isExtern);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.String()).comply(lhs.doc,rhs.doc);
    }
    return ord;
  }
}