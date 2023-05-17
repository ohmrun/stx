package eu.ohmrun.pml.term;

import stx.om.spine.Spine in TSpine;

typedef PmlSpine = TSpine<Tup2<PmlSpine,PmlSpine>>;

function decode(expr:PExpr<Atom>):PmlSpine{
  return new eu.ohmrun.pml.term.spine.Decode().apply(expr);
}
typedef PmlSpineEqTagCtr          = eu.ohmrun.pml.term.spine.PmlSpineEqTagCtr;
typedef PmlSpineOrdTagCtr         = eu.ohmrun.pml.term.spine.PmlSpineOrdTagCtr;
typedef PmlSpineComparableTagCtr  = eu.ohmrun.pml.term.spine.PmlSpineComparableTagCtr;