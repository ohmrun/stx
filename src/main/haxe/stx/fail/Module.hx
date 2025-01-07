package stx.fail;

class Module extends ErrorCtr{
  public function new(){
    super();
  }

  @:isVar public var Lapse(get,null):LapseCtr;
  private function get_Lapse():LapseCtr{
    return this.Lapse == null ? this.Lapse = new LapseCtr() : this.Lapse;
  } 
  @:isVar public var Error(get,null):ErrorCtr;
  private function get_Error():ErrorCtr{
    return this.Error == null ? this.Error = new ErrorCtr() : this.Error;
  } 
}