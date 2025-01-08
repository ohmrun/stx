package stx.test.core;

class Digests{
  static public function e_dependency_not_found(digests:stx.fail.Digests,name):CTR<Pos,Digest>{
    return EDependencyNotFound.make.bind(name);
  }
  static public function e_suite_failed(digests:stx.fail.Digests):CTR<Pos,Digest>{
    return ESuiteFailed.make.bind();
  }
}
class EDependencyNotFound extends DigestCls{
  @:noUsing static public function make(name:String,pos:Pos){
    return new EDependencyNotFound(name,pos);
  }
  public function new(name,?pos:Pos){
    super(
        "01FRQ8G5NCTBY7YV908Y41NZPP",
        'Dependency $name not found',
        LocCtr.instance.Available(pos)
    );
  }
}
class ESuiteFailed extends DigestCls{
  @:noUsing static public function make(pos:Pos){
    return new ESuiteFailed(pos);
  }
  public function new(?pos:Pos){
    super(
      "01FRQ8KHEHGBBSTN89XC492A0E",
      "TestResultAccumulator failed",
      LocCtr.instance.Available(pos)
    );
  }
}