package stx.assert;

class Module extends Clazz{
  static public var instance(get,null) : Module;
  static private function get_instance(){
    return instance == null ? instance = new Module() : instance;
  }
  public function new(){
    super();
  }
  public function that(?pos:Pos){
    return new stx.assert.module.Effect(pos);
  }
  public function expect(?pos:Pos){
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