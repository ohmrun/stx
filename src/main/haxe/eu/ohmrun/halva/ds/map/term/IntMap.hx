package eu.ohmrun.halva.ds.map.term;

class IntMap<V> extends eu.ohmrun.halva.ds.Map<Int,V>{
  static public function make<V>(comparable:Comparable<V>){
    final satisfies = new IntMapSatisfies(comparable);
    final unit      = RedBlackMap.make(Comparable.Int());
    final accretion = Accretion.makeI(satisfies);
    return eu.ohmrun.halva.ds.Map.make(
      accretion,
      unit
    );
  }
}
private class IntMapSatisfies<V> extends SatisfiesCls<RedBlackMap<Int,V>>{
  final V : Comparable<V>;
  public function new(V){
    this.V = V;
  }
  public function lub(){
    return new eu.ohmrun.halva.ds.map.Lub(
      new stx.assert.halva.comparable.LVar(
        new stx.assert.ds.comparable.RedBlackMap(Comparable.Int(),V)
      ),
      V
    );
  }
  public function eq(){
    return new stx.assert.halva.comparable.LVar(new stx.assert.ds.comparable.RedBlackMap(Comparable.Int(),V)).eq();
  }
  public function lt(){
    return new stx.assert.halva.comparable.LVar(new stx.assert.ds.comparable.RedBlackMap(Comparable.Int(),V)).lt();
  }
}