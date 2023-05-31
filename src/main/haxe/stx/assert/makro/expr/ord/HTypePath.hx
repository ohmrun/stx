package stx.assert.makro.expr.ord;

import stx.makro.expr.HTypePath as HTypePathT;

final Ord = __.assert().Ord();

class HTypePath extends OrdCls<HTypePathT>{
  public function new(){}
  public function comply(lhs:HTypePathT,rhs:HTypePathT){
    var ord = Ord.String().comply(lhs.name,rhs.name);
    if(ord.is_not_less_than()){
      if(lhs.name == "DirectType" && lhs.pack[0] == "tink"){
        return NotLessThan;
      }
      ord = Ord.Array(Ord.String()).comply(lhs.pack,rhs.pack);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.String()).comply(lhs.sub,rhs.sub);
    }
    if(ord.is_not_less_than()){
      ord = Ord.NullOr(Ord.Array(Ord.Makro().Expr().HTypeParam)).comply(lhs.params,rhs.params);
    }
    return ord;
  }
}