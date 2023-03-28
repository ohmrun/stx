package stx.assert;

enum abstract EqualedSum(Bool) from Bool{
  var AreEqual = true;
  var NotEqual = false;

  public function is_ok():Bool{
    return this;
  }
  public function is_equal():Bool{
    return this;
  }
  public function are_equal():Bool{
    return this;
  }
  public function is_not_equal():Bool{
    return !this;
  }
  @:op(A && B)
  public function and(that:Equaled):Equaled{
    return ((this && that.is_ok()):Equaled);
  }
}

@:forward @:allow(stx.assert.Equaled) abstract Equaled(EqualedSum) from EqualedSum to EqualedSum{
  @:from static public function fromBool(b:Bool):Equaled{
    return b  ? AreEqual : NotEqual;
  }
  @:op(A && B)
  public function and(that:Equaled):Equaled{
    return toBool() && that.toBool();
  }
  public function toBool():Bool{
    return switch(this){
      case EqualedSum.AreEqual : true;
      case EqualedSum.NotEqual : false;
    }
  }
  @:op(A || B)
  public function or(that:Equaled):Equaled{
    return toBool() || that.toBool();
  }
  @:op(!A)
  public function not():Equaled{
    return switch(this){
      case EqualedSum.AreEqual : EqualedSum.NotEqual;
      case EqualedSum.NotEqual : EqualedSum.AreEqual;
    }
  }
  static public var AreEqual : Equaled = EqualedSum.AreEqual; 
  static public var NotEqual : Equaled = EqualedSum.NotEqual;
}