package stx.assert.comparable.term;

class Int extends ComparableCls<StdInt>{
  public function new(){}
  public function eq() : Eq<StdInt>{
    return Eq.Int();
  }
  public function lt() : Ord<StdInt>{
    return Ord.Int();
  }
}