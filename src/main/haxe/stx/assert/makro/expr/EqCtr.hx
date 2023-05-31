package stx.assert.makro.expr;

class EqCtr{
  /**
   * @see stx.assert.makro.Eq;
   * @param tag 
   */
   static public function Expr(tag:STX<stx.assert.Eq<stx.makro.Module>>){
    return new stx.assert.makro.expr.Eq();
  }
}