package stx.assert.comparable.term;

class String extends ComparableCls<std.String>{
  public function new(){}
  public function eq() : Eq<std.String>{
    return Eq.String();
  }
  public function lt() : Ord<std.String>{
    return Ord.String();
  }
}