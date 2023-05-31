package stx.assert.makro.expr;

class OrdCtr{
  /**
   * @see stx.assert.makro.Ord;
   * @param tag 
   */
   static public function Expr(tag:STX<stx.assert.Ord<stx.makro.Module>>){
    return new stx.assert.makro.expr.Ord();
  }
}