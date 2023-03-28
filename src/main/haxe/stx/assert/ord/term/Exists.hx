package stx.assert.ord.term;

class Exists extends OrdCls<Null<Dynamic>>{
  public function new(){}
  public function comply(lhs:Null<Dynamic>,rhs:Null<Dynamic>){
    return switch([lhs,rhs]){
      case [null,null]  : NotLessThan;
      case [null,x]     : LessThan;
      default           : NotLessThan;
    }
  }
}