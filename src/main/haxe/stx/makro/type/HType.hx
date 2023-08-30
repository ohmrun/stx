package stx.makro.type;

@:using(stx.makro.type.HType.HTypeLift)
@:forward abstract HType(StdMacroType) from StdMacroType to StdMacroType{
  static public var _(default,never) = HTypeLift;
  public function new(self) this = self;

  @:noUsing static public function lift(self:StdMacroType):HType return new HType(self);

  #if macro
  public function followWithAbstracts(){
    return Context.followWithAbstracts(this);
  }
  public function follow(){
    return Context.follow(this);
  }
  #end
  public function getIdentity(){
    return Identity._.getTypeIdentity(this);
  }
  public function getMoniker(){
    return _.getMoniker(this);
  }
  public function getBaseType(){
    return _.getBaseType(this);
  }
  #if macro
  @:noUsing static public function getHType(ident:Ident):Option<HType>{
    return try{
      Some(haxe.macro.Context.getType(ident.toIdentifier().toString()));
    }catch(e:Exception){
      __.log().debug(_ -> _.pure(e));
      None;
    }
  }
  #end
  public var fields(get,never):HClassFieldCluster;
  public function get_fields():HClassFieldCluster{
    return _.get_fields(this);
  }
  public function prj(){
    return this;
  }
}
class HTypeLift{
  @:noUsing static private function lift(self:StdMacroType):HType return HType.lift(self);

  static public function arity(type:HType):Int{
    return switch (type) {
      case TInst(ref,params) :
        var constructor_ref = ref.get().constructor;
        if(constructor_ref == null){
          return -1;
        }
        var constructor = constructor_ref.get().type;
        return switch (constructor) {
          case TFun(args,_) : args.length;
          default : -1;
        }
      default :
        return -1;
    }
    return -1;
  }
  static public function makro(t:StdMacroType):HType{
    return new stx.makro.HType(t);
  }
  static public function getMeta(t:HType){
    return (getBaseType(t):stx.pico.Option<HBaseType>).map(
      (bt) -> bt.meta.get()
    ).def(()->[]);
  }
  static public function getTypeVars(type:HType):Cluster<{id:HSimpleTypeIdentifier,type:HType}>{
    var implementations    = get_params_applied(type);
    var params             = getBaseType(type).params;
    var fields             = get_fields(type);
    var out                = [];
    for (i in 0...params.length){
      var param = params[i];
      var p     = HSimpleTypeIdentifier.fromType(param.t);
      __.log().trace('$p');
      var impl  = implementations[i];
      out.push({
        id    : p,
        type  : impl
      });
    }
    return out.imm();
  }
  static public function get_fields(type:Type):Array<ClassField>{
    return switch(type){
      case TAnonymous( a ) : a.get().fields;
      case TInst(v,_)      : v.get().fields.get();
      default               : [];
    }
  }
  public static function isNativeArray(type:Type):Bool{
    return switch type {
      case getPath(type) => Some("Array"): true;
      default: false;
    }
  }
  public static function isTInst(type:Type):Bool{
    return switch type {
      case TInst(_,_): true;
      default : false;
    }
  }
  public static function isString(type:Type):Bool{
    return switch type {
      case getPath(type) => Some("String") : true;
      default : false;
    }
  }
  public static function isInt(type:Type):Bool{
    return switch(type){
      case getPath(type) => Some("StdMacroTypes.Int"): true;
      default : false;
    }
  }
  static public function isInStdMacroType(type:Type):Bool{
    return switch(type){
      case TAbstract(a,_) : 
        a.get().module == "StdMacroTypes";
        default : false; 
    }
  }
  public static function isNativeList(type:Type):Bool{
    return switch type {
      case getPath(type) => Some("List"): true;
      default: false;
    }
  }
  static public function getPath(t:HType):Option<String>{
    var bt : HBaseType = getBaseType(t);
    return switch(bt == null){
      case true   : None;
      case false :
        Some(if(!HBaseType._.is_module_name_consistent(bt)){
          '${bt.module}.${bt.name}';
        }else{
          if(bt.hasPack()){
            '${bt.module}';
          }else{
            bt.name;
          }
        });
    }
  }
  static public function getMoniker(t:Type):Option<Moniker>{
    return if(is_anonymous(t)){
      None;
    }else{
      var base = getBaseType(t);
      Some(stx.makro.type.core.Moniker.lift({
        name    : base.name,
        pack    : Way.lift(base.pack),
        module  : __.option(new haxe.io.Path(base.module))
      }));
    } 
  }
  static public function is_anonymous(t:Type):Bool{
    return getBaseType(t) == null;
  }
  static public function getBaseType(t:Type):Null<BaseType>{
    return switch (t) {
      case TEnum( t , params )      : t.get();
      case TInst( t , params )      : t.get();
      case TType( t , params )      : t.get();
      case TAbstract( t , params )  : t.get();
      default                       : null;
    }
  }
  static public function get_params_applied(t:Type):Array<Type>{
    return switch (t) {
      case TEnum( t , params )      : params;
      case TInst( t , params )      : params;
      case TType( t , params )      : params;
      case TAbstract( t , params )  : params;
      default                       : [];
    }
  }
  // static public function is_direct_type(t:Type){
    
  // }
  static public function get_params(self:Type):Cluster<HTypeParameter>{
    return __.option(getBaseType(self)).map(
      x -> x.params
    ).defv([]);
  }
  #if macro
  static public function materialize(self:Type){
    final app     = haxe.macro.TypeTools.applyTypeParameters;
    final cparams = get_params(self);

    // return switch(self){
    //   case TEnum( t , params )      : 
    //   case TInst( t , params )      : params;
    //   case TType( t , params )      : params;
    //   case TAbstract( t , params )  : params;     
    // }
  }
  static public function canonical(self:HType){
    return tink.macro.Types.toString(self.toComplexType());
  }
  #end
  static public function get_all_fields(self:Type){
    return switch(self){
      case TInst(ref,params) : 
        final type    = ref.get();
        final rest    = (type:HClassType);
        final uppers  = rest.get_ancestors();
        final fields  = uppers.flat_map(x -> x.data.fields.get());
        // trace(fields.join("\n"));
        fields;
      default                 : [];
    }
  }
  static public function get_construtor(){
    
  }
}