package stx.assert.makro.type;

class EqCtr{
  /**
   * @see stx.assert.makro.Eq;
   * @param tag 
   */
   static public function Type(tag:STX<stx.assert.Eq<stx.makro.Module>>){
    return new stx.assert.makro.type.Eq();
  }
}