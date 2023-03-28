package eu.ohmrun.halva.ds.map.term;

class StringRegisterMap extends eu.ohmrun.halva.ds.Map<String,Register>{
  static public function make(){
    final satisfies = new StringRegisterMapSatisfies();
    final unit      = RedBlackMap.make(Comparable.String());
    final accretion = Accretion.makeI(satisfies);
    return eu.ohmrun.halva.ds.Map.make(
      accretion,
      unit
    );
  }
}
private class StringRegisterMapSatisfies extends SatisfiesCls<RedBlackMap<String,Register>>{
  public function new(){}
  public function lub(){
    return new eu.ohmrun.halva.ds.map.Lub(
      new stx.assert.halva.comparable.LVar(
        new stx.assert.ds.comparable.RedBlackMap(Comparable.String(),Comparable.Register())
      ),
      Comparable.Register()
    );
  }
  public function eq(){
    return new stx.assert.halva.comparable.LVar(new stx.assert.ds.comparable.RedBlackMap(Comparable.String(),Comparable.Register())).eq();
  }
  public function lt(){
    return new stx.assert.halva.comparable.LVar(new stx.assert.ds.comparable.RedBlackMap(Comparable.String(),Comparable.Register())).lt();
  }
}