package stx.makro.type;

typedef HClassAndParamDef = { t : Ref<ClassType>, params:Array<Type> };

@:forward abstract HClassAndParam(HClassAndParamDef) from HClassAndParamDef{
  public function new(self) this = self;
  
  @:from static public function fromType(obj:{t:Ref<StdClassType>, params:StdArray<StdMacroType>}):HClassAndParam{
    var t = {
      get       : () -> (obj.t.get():ClassType),
      toString  : () -> obj.t.toString()
    };
    var p = obj.params.map(
      (x) -> (x:Type)
    );
    return new HClassAndParam({
      t       : t,
      params  : p
    });
  }
  public var t(get,never):HClassType;
  public function get_t():HClassType{
    return HClassType.lift(this.t.get());
  }
  public var params(get,never):Cluster<HType>;
  public function get_params():Cluster<HType>{
    return Cluster.lift(this.params);
  }
}