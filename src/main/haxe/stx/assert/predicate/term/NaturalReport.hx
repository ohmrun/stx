package stx.assert.predicate.term;

class NaturalReport<P,E> implements PredicateApi<P,E>{
  public var pos(default,null):Pos;
  public var report(default,null):E;
  public var delegate(default,null):P->Bool;
  public function new(delegate,report,?pos){
    this.delegate = delegate;
    this.report   = report;
    this.pos      = pos;
  }
  public function apply(p:P):Report<E>{
    return delegate(p).if_else(
      Report.unit,
      ()-> __.fault(pos).of(report).report()
    );
  }
}