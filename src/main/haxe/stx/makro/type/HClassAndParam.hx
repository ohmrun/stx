package stx.makro.type;

typedef HClassAndParamDef = TypeAppliedValue<Ref<ClassType>>;

@:forward abstract HClassAndParam(HClassAndParamDef) from HClassAndParamDef{
  public function new(self) this = self;
  
  @:noUsing static public function make(data:Ref<StdClassType>,params:StdArray<StdMacroType>){
    return new HClassAndParam({
      data    : data,
      params  : params
    });
  }
  @:from static inline public function fromDef(obj:{t:Ref<StdClassType>, params:StdArray<StdMacroType>}):HClassAndParam{
    return lift(obj);
  }
  @:noUsing @:from static public function lift(obj:{t:Ref<StdClassType>, params:StdArray<StdMacroType>}):HClassAndParam{
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