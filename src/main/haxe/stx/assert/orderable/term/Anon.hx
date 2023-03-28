package stx.assert.orderable.term;


class Anon<T> implements OrderableApi<T>{
  public function new(delegate:Ord<T>){

  }
  private var delegate : Ord<T>;

  public function lt():Ord<T>{
    return delegate;
  }
}