package eu.ohmrun.pml.term.glot;

class Encode{
  static public function apply(self:GExpr){
    return new eu.ohmrun.pml.term.glot.encode.GExpr().apply(self);
  }
}