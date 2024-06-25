package stx.schema.declare.term;

abstract SchemaString(DeclareNativeSchemaApi) from DeclareNativeSchemaApi to DeclareNativeSchemaApi{
  
  @:noUsing static public function make(){
    return new SchemaString(
      new DeclareNativeSchemaCls(
        Ident.make('String',['std']),
        null,
        [],
        PEmpty
      )
    );
  }
  private function new(self){
    this = self;
  }
  @:to public function toDeclareNativeSchema(){
    return DeclareNativeSchema.lift(this);
  }
}
class SchemaStringLift{
  static public function validate(){
  }
}