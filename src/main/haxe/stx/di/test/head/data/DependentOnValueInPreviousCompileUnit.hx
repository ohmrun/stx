package stx.di.test.head.data;

class DependentOnValueInPreviousCompileUnit{
  var sub   : ConcreteGenericClass;
  var other : DependentOnChildUnitFromParent;
  public function new(sub:ConcreteGenericClass,other){
    this.other = other;
    this.sub = sub;
  }
}