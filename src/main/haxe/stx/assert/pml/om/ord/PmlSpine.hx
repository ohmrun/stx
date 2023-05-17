package stx.assert.pml.om.ord;

import eu.ohmrun.pml.term.spine.PmlSpine in TPmlSpine;

final Ord  = __.assert().Ord();

class PmlSpine extends OrdCls<TPmlSpine>{
  public function new(){}
  public function comply(lhs:TPmlSpine,rhs:TPmlSpine){
    final t2_ord = Ord.Tup2(this,this);
    return switch([lhs,rhs]){
        case [Predate(vI)  , Predate(vII)     ] : 
          t2_ord.comply(vI,vII);
        default : 
          Ord.Spine(t2_ord).comply(lhs,rhs);
    }
  }
}
