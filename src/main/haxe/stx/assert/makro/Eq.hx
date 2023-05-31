package stx.assert.makro;

class Eq{
  /**
   * Static extension for `Eq` constructors in the `stx.makro` namespace.
   * @param tag 
   * @return STX<stx.assert.Eq<stx.makro.Moniker>>
   */
  static public inline function Makro(tag:STX<stx.assert.Eq<Dynamic>>):STX<stx.assert.Eq<stx.makro.Module>>{
    return STX;
  }
}