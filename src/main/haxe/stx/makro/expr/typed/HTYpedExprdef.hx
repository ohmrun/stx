package stx.makro.expr.typed;

final Expr = __.makro().expr;

class HTypedExprdefCtr extends Clazz{
  
}
typedef HTypedExprdefDef = haxe.macro.Type.TypedExprDef;

@:forward abstract HTypedExprdef(HTypedExprdefDef){
  
  public function new(self){
    this = self;
  }
  
  @:noUsing static public function lift(self:HTypedExprdefDef):HTypedExprdef{
    return new HTypedExprdef(self);
  }
  public function prj(){
    return this;
  }

}
class HTypedExprdefLift{

}