package stx.schema.declare.term;

abstract SchemaBool(DeclareNativeSchemaApi) from DeclareNativeSchemaApi to DeclareNativeSchemaApi{
  
  @:noUsing static public function make(){
    return new SchemaBool(
      new DeclareNativeSchemaCls(
        Ident.make('Bool',['std']),
        null,
        Cluster.unit()
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
class SchemaBoolLift{
  static public function validate(){
    
  }
}