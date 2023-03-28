package stx.makro.type;

@:using(stx.makro.type.HClassType.HClassTypeLift)
@:forward abstract HClassType(ClassType) from ClassType to ClassType{
  static public var _(default,never) = HClassTypeLift;
  public function new(self)this = self;
  static public inline function lift(self) return new HClassType(self);
  
  public function prj():ClassType{
    return this;
  }
  @:to public function toBaseType():BaseType{
    return this;
  }
  public function interfaces(?ancestors:Bool):Array<HClassAndParam>{ return _.interfaces(this,ancestors); }

  public var fields(get,never):Cluster<HClassField>;
  public function get_fields():Cluster<HClassField>{
    return this.fields.get();
  }
}
class HClassTypeLift{
  @:noUsing static public function interfaces(ct:HClassType,?ancestors:Bool=false):Array<HClassAndParam>{
    return switch(ancestors){
      case true   : 
        ct.prj().interfaces
          .map((x) -> (x:HClassAndParam))
          .concat(
            HClassType._.ancestors(ct)
              .flat_map(
                (x) -> {
                  return x.t.interfaces(ancestors).map((x) -> (x:HClassAndParam));
                }
              )
          );
      case false  : ct.prj().interfaces.map((x) -> (x:HClassAndParam));
    }
  }
  static public function ancestors(c:HClassType):Array<HClassAndParam>{
    var out = __.option(c.superClass).map(
      function rec(x:{t:Ref<ClassType>, params:StdArray<StdMacroType>}):Array<HClassAndParam>{
        var next : HClassType = x.t.get();
        if(c.name == "NotherConfig"){
          //trace(next);
        }
        return __.option(next.superClass).map(rec).map(
          (y) -> [(x:HClassAndParam)].concat(y)
        ).defv([(x:HClassAndParam)]);
      }
    ).defv([]);
    return out;
  }
}