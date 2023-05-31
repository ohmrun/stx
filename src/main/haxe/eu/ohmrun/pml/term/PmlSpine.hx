package eu.ohmrun.pml.term;

import stx.om.spine.Spine in TSpine;

typedef PmlSpine    = eu.ohmrun.pml.term.spine.PmlSpine;
typedef PmlSpineDef = eu.ohmrun.pml.term.spine.PmlSpine.PmlSpineDef;

function toSpine(expr:PExpr<Atom>):PmlSpine{
  return new eu.ohmrun.pml.term.spine.Decode().apply(expr);
}
function toPml(expr:Spine):PExpr<Atom>{
  return new eu.ohmrun.pml.term.spine.Encode().apply(expr);
}

typedef PmlSpineEqTagCtr          = eu.ohmrun.pml.term.spine.PmlSpineEqTagCtr;
typedef PmlSpineOrdTagCtr         = eu.ohmrun.pml.term.spine.PmlSpineOrdTagCtr;
typedef PmlSpineComparableTagCtr  = eu.ohmrun.pml.term.spine.PmlSpineComparableTagCtr;