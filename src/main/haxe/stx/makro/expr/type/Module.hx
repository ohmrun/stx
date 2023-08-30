package stx.makro.expr.type;

class Module extends Clazz{
  public function AbstractType(){
    return new stx.makro.expr.type.AbstractType();
  }
  public function AnonType(){
    return new stx.makro.expr.type.AnonType();
  }
  public function ClassType(){
    return new stx.makro.expr.type.ClassType();
  }
  public function DefType(){
    return new stx.makro.expr.type.DefType();
  }
  public function EnumType(){
    return new stx.makro.expr.type.EnumType();
  }
  public function FunctionType(){
    return new stx.makro.expr.type.FunctionType();
  }
}