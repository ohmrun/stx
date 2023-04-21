package stx.g.lang.expr;

@:using(stx.g.lang.expr.GMetadata.GMetadataLift)
@:forward abstract GMetadata(Cluster<GMetadataEntry>) from Cluster<GMetadataEntry> to Cluster<GMetadataEntry>{
  public function new(self) this = self;
  @:noUsing static public function lift(self:Cluster<GMetadataEntry>):GMetadata return new GMetadata(self);
  static public function unit(){
    return lift(Cluster.unit());
  }
  public function prj():Cluster<GMetadataEntry> return this;
  private var self(get,never):GMetadata;
  private function get_self():GMetadata return lift(this);

  @:from static public function fromArray(self:Array<GMetadataEntry>){
    return lift(Cluster.lift(self));
  }
  // public function toSource(){
  //   return this.map(x -> x.toSource()).join(' ');
  // }
}
class GMetadataLift{
  static public function to_macro_at(self:GMetadata,pos:Position):Metadata{
    return self.map(e -> e.to_macro_at(pos)).prj();
  }
  // static public function denote(self:GMetadata){
  //   final e = __.g().expr();
  //   return e.ArrayDecl(
  //     self.map()
  //   );
  // }
}