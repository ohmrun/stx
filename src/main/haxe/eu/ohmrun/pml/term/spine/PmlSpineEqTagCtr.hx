package eu.ohmrun.pml.term.spine;

class PmlSpineEqTagCtr{
  static public function PmlSpine(tag:STX<Eq<Dynamic>>){
    return new stx.assert.pml.om.eq.PmlSpine();
  }
}