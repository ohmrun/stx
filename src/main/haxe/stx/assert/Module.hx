package stx.assert;

class Module extends Clazz{
  var pos   : Pos;
  public function new(pos){
    super();
    this.pos = pos;
  }
  public function that(){
    return new stx.assert.module.Effect(pos);
  }
  public function expect(){
    return new stx.assert.module.Expect(pos);
  }
  /**
   * Constructor collection for `stx.assert.Ord`
   * @return STX<Ord<Dynamic>>
   */
  public function Ord():STX<Ord<Dynamic>>{
    return STX;
  }
  /**
   * Constructor collection for `stx.assert.Eq`
   * @return STX<Eq<Dynamic>>
   */
  public function Eq():STX<Eq<Dynamic>>{
    return STX;
  }

  /**
   * Constructor collection for `stx.assert.Comparable`
   * @return STX<Comparable<Dynamic>>
   */
  public function Comparable():STX<Comparable<Dynamic>>{
    return STX;
  }
}