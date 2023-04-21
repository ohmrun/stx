package stx.ds.xset.tree;

class Counter{
  @:isVar static public var instance(get,null) : Counter;
  static private function get_instance(){
    return __.option(instance).def(
      () -> {
        instance = new Counter();
        return instance;
      }
    );
  }
  public function new(){
    this.data = -2147483648;
  }
  var data : Int;
  public function next(){
    var result = this.data;
    this.data = this.data + 1;
    return result;
  }
}