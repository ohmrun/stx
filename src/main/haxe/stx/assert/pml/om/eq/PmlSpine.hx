package stx.assert.pml.om.eq;

import stx.assert.Eq.EqCls;
import eu.ohmrun.pml.term.spine.PmlSpine in TPmlSpine;

final Eq  = __.assert().Eq();

/**
 * `stx.assert.Eq` for `eu.ohmrun.pml.term.spine.PmlSpine`
 */
class PmlSpine extends EqCls<TPmlSpine>{
  public function new(){}
  public function comply(lhs:TPmlSpine,rhs:TPmlSpine){
    final t2_eq = Eq.Tup2(this,this);
    return switch([lhs,rhs]){
        case [Predate(vI)  , Predate(vII)     ] : 
          t2_eq.comply(vI,vII);
        default : 
          Eq.Spine(t2_eq).comply(lhs,rhs);
    }
  }
}