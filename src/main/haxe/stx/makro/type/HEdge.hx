package stx.makro.type;

enum HEdgeSum{
  HEClassField(f:HClassField);
  HEEnumField(f:HEnumField);
  HEMethodField(f:HTFunArg);
}

@:using(stx.makro.type.HEdge.HEdgeLift)
abstract HEdge(HEdgeSum) from HEdgeSum to HEdgeSum{
  static public var _(default,never) = HEdgeLift;
  public inline function new(self:HEdgeSum) this = self;
  @:noUsing static inline public function lift(self:HEdgeSum):HEdge return new HEdge(self);

  @:from static public function fromClassField(self:ClassField){
    return lift(HEClassField(self));
  }
  @:from static public function fromHEnumField(self:EnumField){
    return lift(HEEnumField(self));
  }
  @:from static public function fromHTFunArg(self:HTFunArg){
    return lift(HEMethodField(self));
  }
  public function prj():HEdgeSum return this;
  private var self(get,never):HEdge;
  private function get_self():HEdge return lift(this);

  
  public var name(get,never):String;
  private function get_name():String{
    return self.fold(
      (f) -> f.name,
      (f) -> f.name,
      (f) -> f.name
    );
  }
  public var type(get,never):HType;
  private function get_type():HType{
    return self.fold(
      (f) -> f.type,
      (f) -> f.type,
      (f) -> f.t
    );
  }
  public var params(get,never):Cluster<TypeParameter>;
  private function get_params():Cluster<TypeParameter>{
    return self.fold(
      (f) -> f.params,
      (f) -> f.params,
      (f) -> []
    );
  }
  public var doc(get,never):Null<String>;
  private function get_doc():Null<String>{
    return self.fold(
      (f) -> f.doc,
      (f) -> f.doc,
      (_) -> null
    );
  }
  public var meta(get,never):Option<HMetaAccess>;
  private function get_meta():Option<HMetaAccess>{
    return self.fold(
      (f) -> Some(f.meta),
      (f) -> Some(f.meta),
      (_) -> None
    );
  }
}
class HEdgeLift{
  static public inline function lift(self:HEdgeSum):HEdge{
    return HEdge.lift(self);
  }
  static public function fold<Z>(self:HEdge,class_field:HClassField -> Z, enum_field:HEnumField -> Z, method_field:HTFunArg -> Z):Z{
    return switch(self){
      case HEClassField(f)  : class_field(f);
      case HEEnumField(f)   : enum_field(f);
      case HEMethodField(f) : method_field(f);
    }
  }
}