package stx.makro.type;

typedef HEnumValueConstructorDef = {
  var type  : EnumType;
  var ref   : MethodRef;
  var args  : HTFunArgArray;
}
@:forward abstract HEnumValueConstructor(HEnumValueConstructorDef) from HEnumValueConstructorDef{
  public function new(self:HEnumValueConstructorDef){
    this = self;
  }
  @:noUsing static public function make(e:HEnumType,ref:MethodRef,args:HTFunArgArray):HEnumValueConstructor{
    return new HEnumValueConstructor({
      type  : e.prj(),
      ref   : ref,
      args  : args
    });
  }
}