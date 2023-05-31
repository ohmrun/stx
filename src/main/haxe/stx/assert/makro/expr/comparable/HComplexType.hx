package stx.assert.makro.expr.comparable;

using stx.assert.makro.expr.EqCtr;
using stx.assert.makro.expr.OrdCtr;

import stx.makro.expr.HComplexType in TComplexType;

class HComplexType extends ComparableCls<TComplexType>{
  public function new(){}
  public function eq(){
    return __.assert().Eq().Makro().Expr().HComplexType;
  }
  public function lt(){
    return __.assert().Ord().Makro().Expr().HComplexType;
  }
}