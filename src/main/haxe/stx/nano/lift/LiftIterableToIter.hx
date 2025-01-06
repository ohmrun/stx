package stx.nano.lift;
class LiftIterableToIter{
  /**
   * Creates `stx.nano.Iter` instance from `Iterable` 
   * @param it `Iterable<T>`
   * @return `Iter<T>`
   */
  static public function toIter<T>(it:Iterable<T>):Iter<T>{
    return it;
  }
}