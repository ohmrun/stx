package stx.test;

class TestSuite{
  public function new(){
    stx.test.Harness.instance.set(Type.getClassName(Type.getClass(this)),this);
  }
  public function cases():Array<TestCase>{
    return [];
  }
  public function run(){
    final signal = new Runner().apply(this.cases());
    new Reporter(signal).enact();
  }
}