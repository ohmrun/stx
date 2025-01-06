package stx.nano;

class Introspectable extends Clazz{
  public function locals(){
    return std.Type.getInstanceFields(std.Type.getClass(this));
  }
}