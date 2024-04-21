package eu.ohmrun.pml.encode;

class Dyn extends Clazz{
  dynamic public function correct(self:Dynamic){
    return None;
  }
  public function apply(self:Dynamic):PExpr<Atom>{
    return switch(std.Type.typeof(self)){
      case TNull                                      : PEmpty;
      case TInt                                       : PValue(N(NInt(self)));
      case TFloat                                     : PValue(N(NFloat(self)));
      case TBool                                      : PValue(B(self));
      case TObject                                    : new Object().apply(self);
      case TFunction                                  : throw 'any value of type function has not been handled in this context';
      case TClass(x) if (Std.isOfType(self,Array))    : PArray((self:Array<Dynamic>).map(apply));
      case TClass(x) if (Std.isOfType(self,String))   : PValue(Sym(self));
      case TClass(c)                                  : correct(self).fold(
        ok -> ok,
        () -> throw 'class $c has not been handled in this context'
      );
      case TEnum(e)                                   : new eu.ohmrun.pml.encode.EnumValue().apply(self);
      case TUnknown                                   : correct(self).fold(
        ok -> ok,
        () -> throw 'value of unknown type $self unhandled'
      );
    }
  }
}
