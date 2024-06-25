package stx.schema.declare.term;

abstract SchemaFloat(DeclareNativeSchemaApi) from DeclareNativeSchemaApi to DeclareNativeSchemaApi{
  
  @:noUsing static public function make(){
    return new SchemaFloat(
      new DeclareNativeSchemaCls(
        Ident.make('Float',['std']),
        null,
        [].imm()
      )
    );
  }
  private function new(self){
    this = self;
  }
  @:to public function toDeclareSchema(){
    return DeclareNativeSchema.lift(this);
  }
}
class SchemaFloatLift{
  // static public function validate(){

  // }
}