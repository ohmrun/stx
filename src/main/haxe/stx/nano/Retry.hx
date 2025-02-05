package stx.nano;

class Retry{
  public final attempts : Int;
  public final born     : Float;

  public function new(attempts,born){
    this.attempts = attempts;
    this.born     = born;
  }
  public function copy(?attempts,?born){
    return new Retry(
      Option.make(attempts).defv(this.attempts),
      Option.make(born).defv(this.born)
    );
  }
  @:noUsing static public function make(attempts,born){
    return new Retry(attempts,born);
  }
  @:noUsing static public function unit(){
    return make(0,haxe.Timer.stamp());
  }
  public var duration(get,never) : Float;
  public function get_duration(){
    return haxe.Timer.stamp() - this.born;
  }
  public function next(){
    return copy(this.attempts + 1);
  }
  // public function gt(that:Retry){
  //   return this.attempts > 
  // }
}