package stx.makro.type;

final __type = __.makro().type;
final __expr = __.makro().expr;

class HEnumFieldCtr extends Clazz{
  public function Make(
    name:String,
    index:Int,
    type:CTR<HTypeCtr,HType>,
    params:CTR<HTypeParameterCtr,Cluster<HTypeParameter>>,
    doc:Null<String>,
    meta:CTR<HMetaAccessCtr,HMetaAccess>,
    pos:CTR<stx.makro.expr.HPosition.HPositionCtr,stx.makro.expr.HPosition>
  ){
    return HEnumField.make(
      name,
      index,
      type.apply(__type.HType),
      params.apply(__type.HTypeParameter).prj(),
      meta.apply(__type.HMetaAccess).prj(),
      doc,
      pos.apply(__expr.HPosition)
    );
  }
}
@:using(stx.makro.type.HEnumField.HEnumFieldLift)
@:forward abstract HEnumField(haxe.macro.Type.EnumField) from haxe.macro.Type.EnumField to haxe.macro.Type.EnumField{
  static public var _(default,never) = HEnumFieldLift;
  public inline function new(self:haxe.macro.Type.EnumField) this = self;
  @:noUsing static inline public function lift(self:haxe.macro.Type.EnumField):HEnumField return new HEnumField(self);
  @:noUsing static inline public function make(name,index,type,params,meta,doc,pos){
    return lift({
      name    : name,
      index   : index,
      type    : type,
      params  : params,
      meta    : meta,
      doc     : doc,
      pos     : pos
    });
  }
  public function prj():haxe.macro.Type.EnumField return this;
  private var self(get,never):HEnumField;
  private function get_self():HEnumField return lift(this);
}
class HEnumFieldLift{
  static public inline function lift(self:haxe.macro.Type.EnumField):HEnumField{
    return HEnumField.lift(self);
  }
}