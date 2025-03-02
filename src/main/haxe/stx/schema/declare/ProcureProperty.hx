package stx.schema.declare;

typedef ProcurePropertyDef = {
  final name        : std.String;
  final type        : SchemaRef;
  final ?opt        : Bool;
  final validation  : Validations;
  final meta        : PExpr<Primitive>;
}
@:using(stx.schema.declare.ProcureProperty.ProcurePropertyLift)
@:forward abstract ProcureProperty(ProcurePropertyDef) from ProcurePropertyDef to ProcurePropertyDef{
  
  public function new(self) this = self;
  @:noUsing static public function lift(self:ProcurePropertyDef):ProcureProperty return new ProcureProperty(self);
  @:noUsing static public function make(name,type,?opt,?validation,?meta){
    return lift({
      name : name,
      type : type,
      opt  : opt,
      validation : __.option(validation).defv(Cluster.unit()),
      meta : meta
    });
  }
  public function prj():ProcurePropertyDef return this;
  private var self(get,never):ProcureProperty;
  private function get_self():ProcureProperty return lift(this);

  public function with_type(type:SchemaRef){
    return make(this.name,type,this.validation,this.meta);
  }
  public function toString(){
    return __.show({ name : this.name, type : this.type.toString() , meta : this.meta});
  }
  @:to public function toProcure(){
    return Property(this);
  }
}
class ProcurePropertyLift{
  static public function denote(self:ProcureProperty){
    // final e = __.glot().expr();
    // return e.Call(
    //   e.Path('stx.schema.ProcureProperty.make'),
    //   [
    //     e.Const(c -> c.String(self.name)),
    //     self.type.denote()   
    //   ]
    // );
    return throw UNIMPLEMENTED;
  }
}