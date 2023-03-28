package stx.assert;

abstract Compare<T>(CompareSum<T>) from CompareSum<T> to CompareSum<T>{
  public function new(self){
    this = self;
  }
  @:noUsing static public function pure<T>(v:T):Compare<T>{
    return Value(v);
  }
  @:op(A && A)
  public function and(that:Compare<T>):Compare<T>{
    return And(this,that);
  }
  @:op(A || A)
  public function or(that:Compare<T>):Compare<T>{
    return Or(this,that);
  }
  @:op(~A)
  public function not():Compare<T>{
    return Not(this);
  }
  @:op(A>A)
  public function gt(that:Compare<T>):Compare<T>{
    return Binop(this,GT,that);
  }
  @:op(A>=A)
  public function gtEq(that:Compare<T>):Compare<T>{
    return Binop(this,GTEQ,that);
  }
  @:op(A<A)
  public function lt(that:Compare<T>):Compare<T>{
    return Binop(this,LT,that);
  }
  @:op(A<=A)
  public function ltEq(that:Compare<T>):Compare<T>{
    return Binop(this,LTEQ,that);
  }
  @:op(A==A)
  public function eq(that:Compare<T>):Compare<T>{
    return Binop(this,EQ,that);
  }
  @:op(A!=A)
  public function nEq(that:Compare<T>):Compare<T>{
    return Not(Binop(this,GTEQ,that));
  }
  public var self(get,never): Compare<T>;
  private function get_self():Compare<T>{
    return this;
  }
}
private enum CompareSum<T>{
  Value(v:T);
  And(l:Compare<T>,r:Compare<T>);
  Or(l:Compare<T>,r:Compare<T>);
  Not(e:Compare<T>);
  Binop(l:Compare<T>,op:Comparative,r:Compare<T>);
}