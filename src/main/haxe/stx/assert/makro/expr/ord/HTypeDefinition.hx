package stx.assert.makro.expr.ord;

import stx.makro.expr.HTypeDefinition as HTypeDefinitionT;

final Ord = __.assert().Ord();

class HTypeDefinition extends OrdCls<HTypeDefinitionT> {
  public function new(){}
  public function comply(lhs:HTypeDefinitionT,rhs:HTypeDefinitionT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.String()).comply(lhs.pack,rhs.pack);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Makro().Expr().HTypeDefKind.comply(lhs.kind,rhs.kind);
    }
    if(ord.is_not_less_than()){
      ord = Ord.Array(Ord.Makro().Expr().HField).comply(lhs.fields,rhs.fields);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Array(Ord.Makro().Expr().HTypeParamDecl)).comply(lhs.params,rhs.params);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Makro().Expr().HMetadata).comply(lhs.meta,rhs.meta);
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