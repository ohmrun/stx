package eu.ohmrun.halva;

typedef ThresholdSet<T> = RedBlackSet<LVar<T>>;

class ThresholdSets{
  static public function pure<T>(comparable:Comparable<T>){
    return RedBlackSet.make(new stx.assert.halva.comparable.LVar(comparable));
  }
  static public function once<T>(comparable:Comparable<T>){
    return pure(comparable).put(BOT);
  }
}