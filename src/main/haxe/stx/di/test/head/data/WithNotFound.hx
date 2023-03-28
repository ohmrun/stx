package stx.di.test.head.data;


class WithNotFound extends DependentOnValueInPreviousCompileUnit{
  public function new(sub:ConcreteGenericClass,other,notfound:NotFound){
    super(sub,other);
  }
}