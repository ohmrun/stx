package stx.makro.type;

typedef HClassAndParamDef = TypeAppliedValue<HRef<ClassType>>;

@:forward abstract HClassAndParam(HClassAndParamDef) from HClassAndParamDef{
  public function new(self) this = self;
  
  @:noUsing static public function make(data:HRef<StdClassType>,params:StdArray<StdMacroType>){
    return new HClassAndParam({
      data    : data,
      params  : params
    });
  }
  @:from static inline public function fromDef(obj:{t:HRef<StdClassType>, params:StdArray<StdMacroType>}):HClassAndParam{
    return lift(obj);
  }
  @:noUsing @:from static public function lift(obj:{t:HRef<StdClassType>, params:StdArray<StdMacroType>}):HClassAndParam{
    var t = {
      get       : () -> (obj.t.get():ClassType),
      toString  : () -> obj.t.toString()
    };
    var p = obj.params.map(
      (x) -> (x:Type)
    );
    return TypeAppliedValue.make(t,p);
  }
  public var data(get,never):HClassType;
  public function get_data():HClassType{
    return HClassType.lift(this.data.get());
  }
  public function prj(){
    return this;
  }
}