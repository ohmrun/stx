package stx.schema.declare.term;

abstract SchemaDate(DeclareNativeSchemaApi) from DeclareNativeSchemaApi to DeclareNativeSchemaApi{
  
  @:noUsing static public function make(){
    return new SchemaDate(
      new DeclareNativeSchemaCls(
        Ident.make('Date',['std']),
        null,
        null
      )
    );
  }
  @:to public function toDeclareSchema(){
    return DeclareNativeSchema.lift(this);
  }
  private function new(self){
    this = self;
  }
}
class SchemaDateLift{
  
}