package stx.show.showable.term;

class DynamicShow extends ShowableCls<Any>{
  public function show(self:Any,state:State):Upshot<Response,ShowFailure>{
    return switch(std.Type.typeof(self)){
      case TNull            : new stx.show.showable.term.String().show('null',state);
      // case TInt             : new stx.show.showable.term.Int().show(self,state);
      // case TFloat           : new stx.show.showable.term.Float().show(self,state);
      // case TBool            : new stx.show.showable.term.Bool().show(self,state);
//      case TObject          : new stx.show.showable.term.Object().show(self,state);
//      case TFunction        : new stx.show.showable.term.String().show('<function>',state);
//       case TClass(c)        : new stx.show.showable.term.Class(c).show(self,state);
//       case TEnum(e)         : new stx.show.showable.term.Enum(e).show(self,state);
      default               : new stx.show.showable.term.String().show('<unknown>',state);
    }
  }
}