package stx.assert;

@:using(stx.assert.Ordered.OrderedLift)
enum abstract OrderedSum(Bool) from Bool{
  var LessThan    = true;
  var NotLessThan = false;

  public function is_ok():Bool{
    return this;
  }
}
@:using(stx.assert.Ordered.OrderedLift)
@:forward abstract Ordered(OrderedSum) from OrderedSum to OrderedSum{
  public function new(self){
    this = self;
  }
  @:from static public function fromBool(b:Bool):Ordered{
    return b  ? LessThan : NotLessThan;
  }
  public function toBool():Bool{
    return switch(this){
      case OrderedSum.LessThan    : true;
      case OrderedSum.NotLessThan : false;
    }
  }
  @:op(A || B)
  public function or(that:Ordered):Ordered{
    final l = toBool(); 
    final r = that.toBool();
    return switch ([l,r]){
      case [true,_] : true;
      case [_,true] : true;
      default :  false;
    }
  }
  @:op(!A)
  public function not():Ordered{
    return switch(this){
      case OrderedSum.LessThan    : OrderedSum.NotLessThan;
      case OrderedSum.NotLessThan : OrderedSum.LessThan;
    }
  }
  @:op(A && B)
  public function and(that:Ordered):Ordered{
    final l : Bool = OrderedLift.toBool(this);
    final r : Bool = OrderedLift.toBool(that); 
    return switch([l,r]){
      case [true,true] : true;
      default : false;
    }
  }
}
class OrderedLift{
  static public function is_not_less_than(self:OrderedSum){
    return switch(self){
      case NotLessThan : true;
      default          : false;
    }
  }
  static public function is_less_than(self:OrderedSum){
    return switch(self){
      case NotLessThan : false;
      default          : true;
    }
  }
  static public function toBool(self:OrderedSum):Bool{
    return switch(self){
      case OrderedSum.LessThan    : true;
      case OrderedSum.NotLessThan : false;
    }
  }
}