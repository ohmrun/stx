package eu.ohmrun.halva.ds.map.term;

class RegisterMap<V> extends eu.ohmrun.halva.ds.Map<Register,V>{
  static public function make<V>(comparable:Comparable<V>){
    final satisfies = new RegisterMapSatisfies(comparable);
    final unit      = RedBlackMap.make(Comparable.Register());
    final accretion = Accretion.makeI(satisfies);
    return eu.ohmrun.halva.ds.Map.make(
      accretion,
      unit
    );
  }
}
private class RegisterMapSatisfies<V> extends SatisfiesCls<RedBlackMap<Register,V>>{
  final V : Comparable<V>;
  public function new(V){
    this.V = V;
  }
  public function lub(){
    return new eu.ohmrun.halva.ds.map.Lub(
      new stx.assert.halva.comparable.LVar(
        new stx.assert.ds.comparable.RedBlackMap(Comparable.Register(),V)
      ),
      V
    );
  }
  public function eq(){
    return new stx.assert.halva.comparable.LVar(new stx.assert.ds.comparable.RedBlackMap(Comparable.Register(),V)).eq();
  }
  public function lt(){
    return new stx.assert.halva.comparable.LVar(new stx.assert.ds.comparable.RedBlackMap(Comparable.Register(),V)).lt();
  }
}