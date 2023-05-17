package stx.assert.module;

class Effect extends Clazz{
  var module  : Expect;
  public function new(pos){
    super();
    this.module = new Expect(pos);
  }
  public inline function equals<T>(lhs:T,rhs:T)                              this.module.equals().comply(lhs,rhs).crunch();
  public inline function alike<E:StdEnumValue>(lhs:E,rhs:E)                  this.module.alike().comply(lhs,rhs).crunch();
  public inline function gt<T>(lhs:T,rhs:T)                                  this.module.gt().comply(lhs,rhs).crunch();
  public inline function gt_eq<T>(lhs:T,rhs:T)                               this.module.gt_eq().comply(lhs,rhs).crunch();
  public inline function lt<T>(lhs:T,rhs:T)                                  this.module.lt().comply(lhs,rhs).crunch();
  public inline function lt_eq<T>(lhs:T,rhs:T)                               this.module.lt_eq().comply(lhs,rhs).crunch();

  public inline function always<T>(t:T)                                      this.module.always().crunch(t);
  public inline function never<T,E>(t:T)                                     this.module.never().crunch(t);
  public inline function iz<A>(a:A,clazz:Class<A>)                           this.module.iz(clazz).crunch(a);
  public inline function throws<E>(fn:Block)                                 this.module.throws().crunch(fn);
  public inline function void<T>(t:T)                                        this.module.void().crunch(t);
  public inline function exists<T>(t:T)                                      this.module.exists().crunch(t);
  public inline function matches<E>(string:String,reg:String,opt:String)     this.module.matches(reg,opt).crunch(string);
} 