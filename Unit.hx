import stx.test.Harness;
using Bake;
class Unit{
  static public function main(){
    final bake = Bake.pop();
    trace(bake.defines);
    trace(stx.test.Harness.instance);
  }
}