package stx.makro.type;

class HClassFieldCtr extends Clazz{

}
@:using(stx.makro.type.HClassField.HClassFieldLift)
@:forward abstract HClassField(StdClassField) from StdClassField to StdClassField{
  public function new(self) this = self;
  @:noUsing static public function lift(self:StdClassField):HClassField return new HClassField(self);

  public function prj():StdClassField return this;
  private var self(get,never):HClassField;
  private function get_self():HClassField return lift(this);
}
class HClassFieldLift{
  static public function copy(self:HClassField,
    ?name:String,
    ?type:Type,
    ?isPublic:Bool,
    ?isExtern:Bool,
    ?isFinal:Bool,
    ?isAbstract:Bool,
    ?params:Array<TypeParameter>,
    ?meta:MetaAccess,
    ?kind:FieldKind,
    ?expr:Void->Null<TypedExpr>,
    ?pos:haxe.macro.Expr.Position,
    ?doc:Null<String>,
    ?overloads:HRef<Array<ClassField>>):HClassField{
      return {
        name        : __.option(name).def(() -> self.name),
        type        : __.option(type).def(() -> self.type),
        isPublic    : __.option(isPublic).def(() -> self.isPublic),
        isExtern    : __.option(isExtern).def(() -> self.isExtern),
        isFinal     : __.option(isFinal).def(() -> self.isFinal),
        isAbstract  : __.option(isAbstract).def(() -> self.isAbstract),
        params      : __.option(params).def(() -> self.params),
        meta        : __.option(meta).def(() -> self.meta),
        kind        : __.option(kind).def(() -> self.kind),
        expr        : __.option(expr).def(() -> self.expr),
        pos         : __.option(pos).def(() -> self.pos),
        doc         : __.option(doc).def(() -> self.doc),
        overloads   : __.option(overloads).def(() -> self.overloads)
      }
  }
  static public function is_function(self:HClassField){
    return (self.kind:HFieldKind).is_method();
  }
  static public function is_writeable(self:HClassField){
    return switch(self.kind){
      case FVar(_, AccResolve)  : true;
      case FVar(_, AccNormal)   : true;
      default                   : false;
    }
  }
}
