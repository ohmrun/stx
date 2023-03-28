package eu.ohmrun.halva.core;

interface SatisfiesApi<T> extends ComparableApi<LVar<T>>{
  public function lub():SemiGroup<LVar<T>>;
}
abstract class SatisfiesCls<T> extends ComparableCls<LVar<T>> implements SatisfiesApi<T>{
  abstract public function lub():SemiGroup<LVar<T>>;
} 