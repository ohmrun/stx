package eu.ohmrun.halva.ds.map.term;

class RegisterStringMap extends eu.ohmrun.halva.ds.Map<Register,String>{
  static public function make(){
    final satisfies = new RegisterStringMapSatisfies();
    final unit      = RedBlackMap.make(Comparable.Register());
    final accretion = Accretion.makeI(satisfies);
    return eu.ohmrun.halva.ds.Map.make(
      accretion,
      unit
    );
  }
}
private class RegisterStringMapSatisfies extends SatisfiesCls<RedBlackMap<Register,String>>{
  public function new(){}
  public function lub(){
    return new eu.ohmrun.halva.ds.map.Lub(
      new stx.assert.halva.comparable.LVar(
        new stx.assert.ds.comparable.RedBlackMap(Comparable.Register(),Comparable.String())
      ),
      Comparable.String()
    );
  }
  public function eq(){
    return new stx.assert.halva.comparable.LVar(new stx.assert.ds.comparable.RedBlackMap(Comparable.Register(),Comparable.String())).eq();
  }
  public function lt(){
    return new stx.assert.halva.comparable.LVar(new stx.assert.ds.comparable.RedBlackMap(Comparable.Register(),Comparable.String())).lt();
  }
}