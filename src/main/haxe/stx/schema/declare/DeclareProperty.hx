package stx.schema.declare;

typedef DeclarePropertyDef = {
  public final type         : SchemaRef;
  public final validation   : Validations;
  public final ?meta        : PExpr<Primitive>;
}
@:transitive @:forward abstract DeclareProperty(DeclarePropertyDef) from DeclarePropertyDef to DeclarePropertyDef{
  //
  public function new(self) this = self;
  @:noUsing static public function lift(self:DeclarePropertyDef):DeclareProperty return new DeclareProperty(self);
  @:noUsing static public function make(type:SchemaRef,validation, meta){
    return lift({ type : type, validation : validation, meta : meta  });
  }
  public function prj():DeclarePropertyDef return this;
  private var self(get,never):DeclareProperty;
  private function get_self():DeclareProperty return lift(this);

  @:from static public function fromDeclareNativeSchemaApi(self:DeclareNativeSchemaApi){
    return make(
      SchemaRef.fromDeclareNativeSchema(self),
      Cluster.unit(),
      PEmpty
    );
  }
  @:from static public function fromSchema(self:stx.schema.Schema){
    return make(
      SchemaRef.fromSchema(self),
      Cluster.unit(),
      PEmpty 
    );
  }
  public function with_type(ref:SchemaRef){
    return lift({
      meta        : this.meta,
      validation  : this.validation,
      type        : ref
    });
  }
  public function procure(name:String):ProcureProperty{
    return ProcureProperty.make(name,this.type,this.meta);
  }
}