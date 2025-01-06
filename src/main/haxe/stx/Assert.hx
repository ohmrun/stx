package stx;

using stx.Pico;
using stx.Fail;
using stx.Nano;

typedef AssertFailure           = stx.fail.AssertFailure;

typedef AssertionApi<P,E>       = stx.assert.Assertion.AssertionApi<P,E>;
typedef Assertion<P,E>          = stx.assert.Assertion<P,E>;

typedef ComparableTagCtr        = stx.assert.ComparableTagCtr;
typedef ComparableCls<P>        = stx.assert.Comparable.ComparableCls<P>;
typedef ComparableApi<P>        = stx.assert.Comparable.ComparableApi<P>;
typedef Comparable<P>           = stx.assert.Comparable<P>;

typedef Equal                   = stx.assert.Equal;

typedef EqTagCtr                = stx.assert.EqTagCtr;
typedef EqCtr                   = stx.assert.Eq.EqCtr;
typedef EqCls<T>                = stx.assert.Eq.EqCls<T>;
typedef EqApi<T>                = stx.assert.Eq.EqApi<T>;
typedef Eq<T>                   = stx.assert.Eq<T>;

typedef EqualableApi<T>         = stx.assert.Equalable.EqualableApi<T>;
typedef Equalable<T>            = stx.assert.Equalable<T>;

typedef EqualedSum              = stx.assert.Equaled.EqualedSum;
typedef Equaled                 = stx.assert.Equaled;

typedef OrdTagCtr               = stx.assert.OrdTagCtr;
typedef OrdCls<T>               = stx.assert.Ord.OrdCls<T>;
typedef OrdApi<T>               = stx.assert.Ord.OrdApi<T>;
typedef Ord<T>                  = stx.assert.Ord<T>;


typedef OrderableApi<T>         = stx.assert.Orderable.OrderableApi<T>;
typedef Orderable<T>            = stx.assert.Orderable<T>;

typedef OrderedSum              = stx.assert.Ordered.OrderedSum;
typedef Ordered                 = stx.assert.Ordered;

typedef PredicateApi<T,E>       = stx.assert.Predicate.PredicateApi<T,E>;
typedef Predicate<T,E>          = stx.assert.Predicate<T,E>;

//typedef AssertError             = stx.assert.AssertError;

typedef Comparative             = stx.assert.Comparative;
typedef ComparativeSum          = stx.assert.Comparative.ComparativeSum;

typedef Compare<T>              = stx.assert.Compare<T>;

class LiftAssert{
  /**
   * `stx.nano.Wildcard` entry point for `stx_assert`
   * @param __ 
   * @param pos 
   * @return return new stx.assert.Module()
   */
  static public inline function assert(__:Wildcard) return stx.assert.Module.instance;

  static public function expect<E>(b:Bool,err:Error<E>){
    return b ? Report.unit() : Report.pure(err);
  }
}

typedef PartialOrderedDef             = stx.assert.PartialOrder.PartialOrderedDef;
typedef PartialOrdered                = stx.assert.PartialOrder.PartialOrdered;
typedef PartialOrdApi<T>              = stx.assert.PartialOrder.PartialOrdApi<T>;
typedef PartialOrderableApi<T>        = stx.assert.PartialOrder.PartialOrderableApi<T>;
typedef PartialComparableApi<T>       = stx.assert.PartialOrder.PartialComparableApi<T>;

class AssertCtr{
  static public function Assert(wildcard:Wildcard):STX<stx.stub.Assert>{
    return __.stx();
  }
  static public function Comparable(stub:stx.stub.Assert){
    return new stx.assert.stub.Comparable();
  }
}