package stx.assert.comparable.term;

class String extends ComparableCls<StdString>{
  public function new(){}
  public function eq() : Eq<StdString>{
    return Eq.String();
  }
  public function lt() : Ord<StdString>{
    return Ord.String();
  }
}