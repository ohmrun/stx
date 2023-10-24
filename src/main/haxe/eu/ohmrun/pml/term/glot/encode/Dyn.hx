package eu.ohmrun.pml.term.glot.encode;

final encode = __.pml().glot().encode;

class Dyn extends Clazz{
  public function apply(self:Dynamic):PExpr<Atom>{
    return switch(std.Type.typeof(self)){
      case TNull                                      : PEmpty;
      case TInt                                       : PValue(N(NInt(self)));
      case TFloat                                     : PValue(N(NFloat(self)));
      case TBool                                      : PValue(B(self));
      case TObject                                    : encode.Object.apply(self);
      case TFunction                                  : throw 'any value of type function has not been handled in this context';
      case TClass(x) if (Std.isOfType(self,Array))    : PArray((self:Array<Dynamic>).map(apply));
      case TClass(x) if (Std.isOfType(self,String))   : PValue(Sym(self));
      case TClass(c)                                  : throw 'class $c has not been handled in this context';
      case TEnum(e)                                   : encode.EnumValue.apply(self);
      case TUnknown                                   : throw 'value of unknown type $self encountered';
    }
  }
}
